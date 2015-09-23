/**
 * Created by Bas on 22-9-2015.
 */
object Fill extends Enumeration {
  type Fill = Value
  val Empty, Cross, Circle = Value
}
import Fill._
object Day1 {
  def main(args: Array[String]) {
    val board = new Board(3)
    println(board.asString())
    println(board.getWinner())
    board.setValue(0,0, Cross)
    board.setValue(1,1, Cross)
    board.setValue(2,2, Cross)
    board.setValue(0,1, Cross)
    board.setValue(2,1, Cross)
    println(board.getWinner())
  }
}





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

  def getWinnerHorizontally(): Fill={
    var row:Fill = Empty
    for (x <- 0 to size - 1) {
      row = board(x)(0).fill
      if (row != Empty) {
        for (y <- 1 to size - 1) {
          if (board(x)(y).fill != row) return Empty;
          else if(y==size-1) return row;
        }
      }
    }
    return row;
  }

  def getWinnerVertically():Fill={
    var row = Empty
    for (y <- 0 to size - 1) {
      row = board(0)(y).fill
      if (row != Empty) {
        for (x <- 1 to size - 1) {
          if (board(x)(y).fill != row) return Empty
          else if(x==size-1) return row;
        }
      }
    }
    return row
  }

  def getWinnerDiagonalTopLeftBotRight():Fill ={
    var row = Empty
    if (board(0)(0).fill != Empty) {
      row = board(0)(0).fill
      for (i <- 1 to size - 1) {
        if (board(i)(i).fill != row) return Empty;
      }
    }
    return row
  }

  def getWinnerDiagonalBotLeftTopRight():Fill ={
    var row = Empty
    if (board(size - 1)(0).fill != Empty) {
      row = board(0)(size - 1).fill
      for (i <- 1 to size - 1) {
        if (board(i)((size - 1) - i).fill != row) return Empty;
      }
    }
    return row
  }

  def getWinner(): Fill = {
    var winner = Empty;
    winner=getWinnerHorizontally()
    if(winner!=Empty) return winner
    winner=getWinnerVertically()
    if(winner!=Empty) return winner
    winner=getWinnerDiagonalTopLeftBotRight()
    if(winner!=Empty) return winner
    winner=getWinnerDiagonalBotLeftTopRight()
    if(winner!=Empty) return winner
    return winner;
  }
}
