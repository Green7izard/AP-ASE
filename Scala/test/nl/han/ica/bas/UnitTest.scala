package nl.han.ica.bas

/**
 * Created by Bas on 22-9-2015.
 * http://www.scalatest.org/quick_start
 */

import org.scalatest._

abstract class UnitTest extends FlatSpec with Matchers with OptionValues with Inside with Inspectors  {
  "True" should "Be true" in{
    true shouldBe(true);
  }
}

import Fill._
class BoardTest extends UnitTest{
  val board = new Board(2);
  "Board" should "have Empty winner if created" in {
    board.getWinner() shouldBe(Empty);
  }
  it should "Allow Setting a value once" in {
    board.setValue(0,0, Cross) shouldBe(true);
  }

  it should "Now Allow Setting a value twice" in {
    board.setValue(0,0, Circle) shouldBe(false);
  }

  it should "Have no winner with a circle and a cross" in{
    board.setValue(0,1, Circle) shouldBe(true);
    board.getWinner() shouldBe(Empty);
  }
  it should "Have Cross as a winner if it has 2 squares" in{
    board setValue(0, 0, Cross);
    board setValue(1,1, Cross);
    board.getWinner() shouldBe(Cross);
  }
  it should "Have Circle as a winner if it has 2 squares" in{
    board.reset();
    board setValue(0, 1, Circle);
    board setValue(1,0, Circle);
    board.getWinner() shouldBe(Circle);
  }

}