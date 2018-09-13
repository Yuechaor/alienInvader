library main;

import 'dart:html';
import 'dart:math';
import 'dart:async';

part "sprite.dart";
part "player.dart";
part "alien.dart";
part "bullet.dart";

CanvasElement myCanvas;
Player player;
List<Alien> aliens;
List<Bullet> playerBullets;
List<Bullet> aliensBullets;
ImageElement background;
Timer t;

const int CANVAS_WIDTH = 500, CANVAS_HEIGHT = 500;
const String BACKGROUND_IMAGE = "images/background.png";

///called by a timer 60 times per second
///
void update(Timer t) {
  ///update everything
  player.update();
  for (Alien alien in aliens) {
    alien.update();

    ///randomly fire a bullet
    Random rand = new Random();
    int randomNumber = rand.nextInt(2000);
    if (randomNumber == 100) {
      aliensBullets.add(new Bullet(alien.x + Alien.WIDTH ~/ 2 - Bullet.WIDTH,
          alien.y + Alien.HEIGHT, true));
    }
  }

  ///delete bullet when go over the canvas or has a collision.
  List deleteBullets = new List();
  for (Bullet bullet in aliensBullets) {
    bullet.update();

    ///update alien bullets
    if (bullet.y > CANVAS_HEIGHT) {
      deleteBullets.add(bullet);

      ///DELETE bullet
      continue;
    }
    if (bullet.checkCollision(player)) {
      t.cancel();
      window.alert("Game Over!!!");
      deleteBullets.add(bullet);
    }
  }
  for (Bullet bullet in deleteBullets) {
    aliensBullets.remove(bullet);
  }

  deleteBullets.clear();

  /// delete an alien when player hit the target.

  List deleteAliens = new List();
  for (Bullet bullet in playerBullets) {
    bullet.update();
    if (bullet.y < 0) {
      deleteBullets.add(bullet);
      continue;
    }
    for (Alien alien in aliens) {
      if (bullet.checkCollision(alien)) {
        deleteBullets.add(bullet);
        deleteAliens.add(alien);
      }
    }
  }
  for (Bullet bullet in deleteBullets) {
    playerBullets.remove(bullet);
  }
  for (Alien alien in deleteAliens) {
    aliens.remove(alien);
    if (aliens.isEmpty) {
      t.cancel();
      window.alert("Congrants! you win!");
    }
  }

  ///draw everything.
  draw();
}

void draw() {
  CanvasRenderingContext2D c2D = myCanvas.context2D;

  /// 不明白什么意思
  c2D.drawImage(background, 0, 0);

  player.draw(c2D);

  for (Alien alien in aliens) {
    alien.draw(c2D);
  }
  for (Bullet bullet in aliensBullets) {
    bullet.draw(c2D);
  }
  for (Bullet bullet in playerBullets) {
    bullet.draw(c2D);
  }
}

/// Initialize all of the sprites
/// place the player and the aliens on the screen
///
///
///
void restart() {
  player = new Player(CANVAS_WIDTH ~/ 2, CANVAS_HEIGHT - Player.HEIGHT);
  aliens = new List();
  aliensBullets = new List();
  playerBullets = new List();

  const int ROWS = 3;
  const int COLS = 5;
  for (int i = 0; i < ROWS; i++) {
    int y = i * (Alien.HEIGHT + 10);
    for (int j = 0; j < COLS; j++) {
      int x = j * (CANVAS_WIDTH ~/ COLS) + 10;
      aliens.add(new Alien(x, y));
    }
  }
  background = new ImageElement()..src = BACKGROUND_IMAGE;
}

void main() {
  myCanvas = querySelector("#canvas");
  window.onKeyPress.listen((KeyboardEvent e) {
    String lastPressed = new String.fromCharCodes([e.charCode]);
    switch (lastPressed) {
      case 'z':
        if (player.x > 0) {
          player.move(-15, 0);
        }
        break;
      case 'x':
        if (player.x < CANVAS_WIDTH - Player.WIDTH) {
          player.move(15, 0);
        }
        break;
      case ' ':
        playerBullets.add(new Bullet(
            player.x + Player.WIDTH ~/ 2 - Bullet.WIDTH ~/ 2,
            player.y - Bullet.HEIGHT,
            false));
        break;
    }
  });
  restart();
  t = new Timer.periodic(const Duration(microseconds: 17), update);
}
