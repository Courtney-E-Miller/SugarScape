import java.util.LinkedList;

class SquareTester {
  void test() {
    Square s = new Square(5, 9, 50, 50); // square with sugarLevel 5, maxSugarLevel 9, position (x, y) = (50, 50)
    assert (s.getSugar() > s.getMaxSugar());
    assert (s.getSugar() == 5);
  }
}