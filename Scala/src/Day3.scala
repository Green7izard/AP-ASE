/**
 * Created by Bas on 24-9-2015.
 */

import scala.io._
import scala.actors._
import Actor._

class PageSizeReader(urls: List[String]) {

  def timeMethod(method: () => Unit) = {
    val start = System.nanoTime
    method()
    val end = System.nanoTime
    println("Method took " + (end - start) / 1000000000.0 + " seconds.")
  }

  def getPageSizeSequentially() = {
    for (url <- urls) {
      val urlData= PageLoader.getPageSize(url)
      println("Size for " + url + ": " + urlData._1+ " With "+urlData._2.size+" Links")
      urlData._2.foreach(print)
    }
  }

  def getPageSizeConcurrently() = {
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
      }
    }
  }
  //http://www.mkyong.com/regular-expressions/how-to-extract-html-links-with-regular-expression/
  val linkReg = "\\s*(?i)href\\s*=\\s*\\\"(([^\"]*\\\")|'[^']*'|([^'\">\\s]+))\\\"".r

  object PageLoader {
    def getPageSize(url: String):(Int, List[String]) = {
      val source = Source.fromURL(url)
      val links:List[String] = (for (m <- linkReg findAllMatchIn source.mkString) yield m group 1).toList
      //val links = scala.xml.XML.loadString(source) \ "a";
      (source.mkString.length, links.filter(_.startsWith("http")).toList)
    }
  }

}

object Day3 {
  def main(args: Array[String]): Unit = {
    val urls = List("http://www.amazon.com/", "http://www.twitter.com/", "http://www.google.com/", "http://www.cnn.com/")
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
