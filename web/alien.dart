part of main;

class Alien extends Sprite {
  static const int WIDTH = 80, HEIGHT = 40;
  static const String IMAGE_NAME = "images/ufo.png";
  int frameCount = 0;

  Alien(int x, int y) : super(WIDTH, HEIGHT, x, y, IMAGE_NAME);

  /// update alient every 1 seconds, 60 frames per second;
  @override
  void update() {
    frameCount++;
    if (frameCount % 60 == 0) {
      move(0, 1);
    }
  }
}
