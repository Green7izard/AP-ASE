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
      println("Size for " + url + ": "
        + PageLoader.getPageSize(url))
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
      receive { case (url, size) => println("Size for "
        + url +
        ": "
        + size)
      }
    }
  }

  object PageLoader {
    def getPageSize(url: String) = Source.fromURL(url).mkString.length
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
