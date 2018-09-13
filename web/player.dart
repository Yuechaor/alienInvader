part of main;

class Player extends Sprite {
  static const int WIDTH = 73, HEIGHT = 80;
  static const String IMAGE_NAME = "images/ship.png";

  Player(int x, int y) : super(WIDTH, HEIGHT, x, y, IMAGE_NAME);

  @override
  void update() {
    return;
  }
}
