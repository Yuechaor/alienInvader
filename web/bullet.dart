part of main;

class Bullet extends Sprite {
  static const int WIDTH = 15, HEIGHT = 15;
  static const String IMAGE_NAME = "images/bullet.png";
  bool down;
  Bullet(int x, int y, this.down) : super(WIDTH, HEIGHT, x, y, IMAGE_NAME);

  @override
  void update() {
    if (down) {
      move(0, 1);
    } else {
      move(0, -1);
    }
  }

  ///check collision, check the bullet is inside the sprite or not
  bool checkCollision(Sprite s) {
    if (boundingBox.intersection(s.boundingBox) != null) {
      return true;
    } else {
      return false;
    }
  }
}
