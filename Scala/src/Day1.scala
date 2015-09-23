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
    val game = new TicTacToe("Bas", "Peter", 3);
    game.play();
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
    var string: String = "x|";
    for (j <- 0 to size - 1) {
      string += j+"|"
    }
    string +="\n"
    for (i <- 0 to size - 1) {
      string += i+ "|"
      for (j <- 0 to size - 1) {
        string += board(i)(j).asString();
        string += "|"
      }
      string += "\n"
    }
    return string
  }

  def isFull():Boolean={
    for (i <- 0 to size - 1) {
      for (j <- 0 to size - 1) {
        if(board(i)(j).fill==Empty)return false;
      }
    }
    return true;
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
import scala.util.matching.Regex
class Player(val name :String, val playType:Fill)
{
  def getTurn():(Int, Int, Fill)={
    println("Player: "+ name +"'s Turn: Fill in 2 number seperated by a ',' (1,1)")
    //Read user input until it matches the regex: [0-9]+,[0-9]
    // http://hedleyproctor.com/2012/10/practical-scala-file-io-and-regular-expressions/
    val reg = new Regex("[0-9]*+,[0-9]*")
    reg.findFirstIn(scala.io.StdIn.readLine()) match{
      case Some(value) => {
        val split = value.split(",");
        return (split(0).toInt, split(1).toInt, playType)
      }
      case None =>{println("Invalid input"); return getTurn()}
    }
  }

}

class TicTacToe(val PlayerOneName:String, val PlayerTwoName:String, val boardSize:Int){
  val board = new Board(boardSize)
  val PlayerOne = new Player(PlayerOneName, Cross)
  val PlayerTwo = new Player(PlayerTwoName, Circle)
  var lastPlayer:Fill = Empty;

  def printBoard(): Unit ={
    println(board.asString());
  }

  def nextTurn(): Unit ={
    //Fugly manier om het op te lossen doordat val niet hetzelfde werkt als een final in Java
    var currentPlayer:Player = null;
    if(lastPlayer==Cross) { currentPlayer = PlayerTwo}
    else { currentPlayer = PlayerOne;}
    var input:(Int, Int, Fill) =null;
    var result = false;
    do{
      input= currentPlayer.getTurn();
      result = board.setValue(input._1 , input._2, input._3)
      if(!result) println("That square is already filled, or out of bounds! Try again:")
    }while(!result)
    lastPlayer=currentPlayer.playType
  }
  def checkWinner(): Player ={
    if(board.getWinner()==PlayerOne.playType)
      PlayerOne
    else if(board.getWinner()==PlayerTwo.playType)
      PlayerTwo
    else null
  }

  def playAgain(): Unit={
    println("Game is over! Play again?(y/n)")
    if(scala.io.StdIn.readLine().contains("y"))
      {
        board.reset();
        play();
      }
  }
  def play(): Unit ={
    println("Start Game: ")
    printBoard()
    do{
      nextTurn();
      printBoard()
    } while(checkWinner()==null&&board.isFull()==false)
    if(checkWinner()!=null)
    {
        println(checkWinner().name + " has won the game with: "+checkWinner().playType)
    }
    else{
      println("The game has ended in a draw!")
    }
  playAgain()
  }
}
