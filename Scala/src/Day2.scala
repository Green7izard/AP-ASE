/**
 * Created by Bas on 24-9-2015.
 */
object Day2 {
  def main(args: Array[String]) {
    val text = "Its time for scale day 2! See this new day in its glory!"
    println("Getting the length of the string: '" +text +"' split at the ' '")
    println("Length = "+ getTotalLength(text.split(" ")))
    println("Going to clean string: ")
    val cursedText ="Darn it! Shoot me! For fucks sake please just damn it all"
    println(cursedText)
    println("After cleaning")
    println(new Censor("Curses.txt").clearString(cursedText))
  }

  def getTotalLength(list:Array[String]): Int= {
    return list.foldLeft(0)((value, text) =>value+text.length())
  }
}

import scala.io.Source
import scala.util.matching.Regex

class FileReader(val fileName:String)
{
  //http://www.tutorialspoint.com/scala/scala_file_io.htm
  def getDataAsMap(): scala.collection.mutable.HashMap[String, String] ={
    val returnVal = new scala.collection.mutable.HashMap[String, String]
    for (line<-Source.fromFile(fileName).getLines()) {
      if(line.contains("=>"))
        {
          val split = line.split("=>")
          returnVal.+=(split(0)->split(1))
        }
    }
    return returnVal
  }
}

class Censor(val curseLocation:String) extends FileReader(curseLocation){
  var wordsList =getDataAsMap();
  def clearString(text:String):String ={
    var cleanText=text;
    for((word, replacement)<-wordsList)
      {
        cleanText=cleanText.replaceAll(word, replacement);
        cleanText=cleanText.replaceAll(word.toLowerCase(), replacement.toLowerCase());
      }
    return cleanText
  }
}
