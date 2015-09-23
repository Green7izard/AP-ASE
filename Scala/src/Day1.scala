/**
 * Created by Bas on 22-9-2015.
 */
object Day1 {

  def main(args: Array[String]) {
    val board = new Board(3)
    println(board.asString())
  }
}

object Fill extends Enumeration {
  type Fill = Value
  val Empty, Cross, Circle = Value
}

import Fill._

class Square() {
  var fill = Empty

  def reset(): Unit = {
    fill = Empty
  }

  def setValue(newValue: Fill): Boolean = {
    if (fill == Empty) {
      fill = newValue;
      return true;
    }
    else return false;
  }

  def asString(): String = {
    if (fill == Empty) return " "
    else if (fill == Cross) return "X"
    else return "O"
  }
}

import Array._

//http://stackoverflow.com/questions/2742719/how-do-i-break-out-of-a-loop-in-scala

import scala.util.control.Breaks._

class Board(val size: Int) {
  //http://www.tutorialspoint.com/scala/scala_arrays.htm
  val board: Array[Array[Square]] = ofDim[Square](size, size)
  for (i <- 0 to size - 1) {
    for (j <- 0 to size - 1) {
      board(i)(j) = new Square;
    }
  }


  def reset(): Unit = {
    for (i <- 0 to size - 1) {
      for (j <- 0 to size - 1) {
        board(i)(j) reset
      }
    }
  }

  def asString(): String = {
    var string: String = "";
    for (i <- 0 to size - 1) {
      string += "|"
      for (j <- 0 to size - 1) {
        string += board(i)(j).asString();
        string += "|"
      }
      string += "\n"
    }
    return string
  }

  def setValue(x: Int, y: Int, newValue: Fill): Boolean = {
    if (x >= 0 && x < size && y >= 0 && y < size) board(x)(y) setValue (newValue);
    else return false
  }

  def getWinner(): Fill = {
    for (i <- 0 to size - 1) {
      val row = board(i)(0).fill
      if (row != Empty) {
        for (j <- 1 to size - 1) {
          if (board(i)(j) != row) break;
          else if (j == size - 1) return row;
        }
      }
    }

    for (j <- 0 to size - 1) {
      val row = board(0)(j).fill
      if (row != Empty) {
        for (i <- 1 to size - 1) {
          if (board(i)(j) != row) break;
          else if (i == size - 1) return row;
        }
      }
    }

    if (board(0)(0).fill != Empty) {
      val row = board(0)(0).fill
      for (i <- 1 to size - 1) {
        if (board(i)(i) != row) break;
        else if (i == size - 1) return row;
      }
    }
    if (board(size - 1)(0).fill != Empty) {
      val row = board(0)(size - 1).fill
      for (i <- 1 to size - 1) {
        if (board(i)((size - 1) - i) != row) break;
        else if (i == size - 1) return row;
      }
    }
    return Empty;
  }
}
