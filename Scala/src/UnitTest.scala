/**
 * Created by Bas on 22-9-2015.
 * http://www.scalatest.org/quick_start
 */

import collection.mutable.Stack
import org.scalatest._

/**
 * Created by Bas on 22-9-2015.
 * http://www.scalatest.org/quick_start
 * http://www.scalatest.org/getting_started_with_fun_suite
 */

import org.scalatest._

import Fill._
class BoardTest extends FunSuite{
  val board = new Board(2);
  test("Board should have a Empty winner if new")  {
    assert(board.getWinner() === Empty);
  }
  test("Board should allow setting a value once") {
    assert(board.setValue(0,0, Cross));
  }

  test("Board should not allow setting a value twice") {
    assert(!board.setValue(0,0, Circle));
  }

  test("Board should have a Empty winner if no squares align"){
    assert(board.setValue(0,1, Circle));
    assert(board.getWinner() ===Empty);
  }
  test("Board should have Cross as a winner if it has 2 Diagonal squares" ){
    board.reset();
    board setValue(0, 0, Cross);
    board setValue(1,1, Cross);
    assert(board.getWinnerDiagonalTopLeftBotRight()===Cross);
    assert(board.getWinner() === Cross);
  }
  test( "Have Circle as a winner if it has 2 Diagonal squares" ){
    board.reset();
    board setValue(0, 1, Circle);
    board setValue(1,0, Circle);
    assert(board.getWinnerDiagonalBotLeftTopRight() === Circle);
    assert( board.getWinner() === Circle);
  }


  test( "Board with everything as Circle will have CIrcle for horizontal and Vertical alignment" ){
    board.reset();
    board setValue(1, 0, Circle);
    board setValue(0,0, Circle);
    board setValue(0,1, Circle);
    board setValue(1,1, Circle);
    assert(board.getWinnerHorizontally() === Circle);
    assert(board.getWinnerVertically()===Circle);
  }
  test( "Have Circle as a winner if it has 2 Horizontal squares" ){
    board.reset();
    board setValue(0, 0, Circle);
    board setValue(0,1, Circle);
    assert(board.getWinnerHorizontally()===Circle)
    assert( board.getWinner() === Circle);
  }

  test( "Have Circle as a winner if it has 2 Vertical squares" ){
    board.reset();
    board setValue(1, 0, Circle);
    board setValue(0,0, Circle);
    assert(board.getWinnerVertically()===Circle)
    assert( board.getWinner() === Circle);
  }

}

