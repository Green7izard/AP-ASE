package nl.han.ica.bas

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

  test("Board should have a Empty winner if new"){
    assert(board.setValue(0,1, Circle));
    assert(board.getWinner() ===Empty);
  }
  test("Board should have Cross as a winner if it has 2 squares" ){
    board setValue(0, 0, Cross);
    board setValue(1,1, Cross);
    assert(board.getWinner() ===Cross);
  }
  test( "Have Circle as a winner if it has 2 squares" ){
    board.reset();
    board setValue(0, 1, Circle);
    board setValue(1,0, Circle);
   assert( board.getWinner() === Circle);
  }

}
