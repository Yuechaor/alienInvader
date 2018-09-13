part of main;

abstract class Sprite {
  int width, height, x, y;
  ImageElement myImage;
  Rectangle boundingBox;

  Sprite(this.width, this.height, this.x, this.y, String imageName) {
    myImage = new ImageElement()..src = imageName;
    boundingBox = new Rectangle(x, y, width, height);
  }
  //draw myImage in the canvas
  void draw(CanvasRenderingContext2D c2D) {
    c2D.drawImageScaled(myImage, x, y, width, height);
  }

  // move function
  void move(int dx, int dy) {
    x = x + dx;
    y = y + dy;
    boundingBox = new Rectangle(x, y, width, height);
  }

  void update();
}
