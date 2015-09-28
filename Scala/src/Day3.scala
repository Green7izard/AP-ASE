/**
 * Created by Bas on 24-9-2015.
 */

import scala.io._
import scala.actors._
import Actor._
import java.nio.charset._

class PageSizeReader(urlList: List[String]) {
//http://stackoverflow.com/questions/1757272/how-to-resolve-java-nio-charset-unmappablecharacterexception-in-scala-2-8-0
  implicit val codec = Codec("UTF-8")
  codec.onMalformedInput(CodingErrorAction.REPLACE)
  codec.onUnmappableCharacter(CodingErrorAction.REPLACE)

  def timeMethod(method: () => Unit) = {
    val start = System.nanoTime
    method()
    val end = System.nanoTime
    println("Method took " + (end - start) / 1000000000.0 + " seconds.")
  }



  def getPageSizeSequentially() = {
    sequentialGet(urlList)
    println("End Sequence")
  }
  def sequentialGet(urls: List[String]):Int={
    for (url <- urls) {
      val urlData= PageLoader.getPageSize(url)
      println("Size for " + url + ": " + urlData._1+ " With "+urlData._2.size+" Links")
      sequentialGet(urlData._2.filter(!urls.contains(_)))
    }
    0
  }

  def getPageSizeConcurrently() = {
    getConcurrently(urlList)
  }
  def getConcurrently(urls: List[String])={
    val caller = self
    for (url <- urls) {
      actor {
        caller !(url, PageLoader.getPageSize(url))
      }
    }
    for (i <- 1 to urls.size) {
      receive { case (url, (size:Int, subUrls:List[String])) => println("Size for "
        + url +
        ": "
        + size +" With "+ subUrls.size +" links")
        sequentialGet(subUrls.filter(!urls.contains(_)))
      }
    }
  }
  //http://www.mkyong.com/regular-expressions/how-to-extract-html-links-with-regular-expression/
  val linkReg = "\\s*(?i)href\\s*=\\s*\\\"(([^\"]*\\\")|'[^']*'|([^'\">\\s]+))\\\"".r

  object PageLoader {
    def getPageSize(url: String):(Int, List[String]) = {
      //Convert it to UTF-8 to prevent problems with conversion
      try {
        val source = Source.fromURL(url)(codec).mkString;
        val length = source.length
        val links: List[String] = (for (m <- linkReg findAllMatchIn source) yield m group 1).toList
        //val linlks = scala.xml.XML.loadString(source) \ "a";
        return (length, links.filter(_ != url).filter(_.startsWith("http")).toList.distinct)
      }
      catch{
        case e:Exception=> return (-1, List())
      }
    }
  }

}

object Day3 {
  def main(args: Array[String]): Unit = {
    //Google niet meegenomen met een circulaire referentie, Twitter is leeg
    //Systeem kan geen circel referenties verwerken
    val urls = List("http://www.amazon.com/", "http://www.dropbox.com/", "http://www.w3schools.com/")
    val reader = new PageSizeReader(urls)
    println("Sequential run:")
    reader.timeMethod {
      reader.getPageSizeSequentially
    }
    println("Concurrent run")
    reader.timeMethod {
      reader.getPageSizeConcurrently
    }
  }
}
