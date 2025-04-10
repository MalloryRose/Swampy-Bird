/**
 * UIManager Class
 * 
 * Handles all UI elements and interactions.
 * Manages menus, buttons, score display, and text.
 */

class UIManager {
  PImage lightMenuBackground;
  PImage darkMenuBackground;
  PImage lightGameBackground;
  PImage darkGameBackground;
  PImage toggleLight;
  PImage toggleDark;
  PFont titleFont;
  boolean gamePlaying;
  int mode;
  boolean gameLost;
  int xTracker;
  int speedFactor;

  UIManager() {
    gamePlaying = false;
    mode = 0;
    gameLost = false;

    lightMenuBackground = loadImage("data/sprites/menuBackgroundLight.JPG");
    darkMenuBackground = loadImage("data/sprites/menuBackgroundDark.JPG");
    lightGameBackground = loadImage("data/sprites/backgroundDay.jpeg");
    darkGameBackground = loadImage("data/sprites/backgroundNight.JPG");
    toggleLight = loadImage("data/sprites/toggleLight.PNG");
    toggleDark = loadImage("data/sprites/toggleDark.PNG");

    // Resize backgrounds to ensure correct dimensions
    lightGameBackground.resize(1200, 400);
    darkGameBackground.resize(1200, 400);

    titleFont = createFont("data/fonts/TitleFont.TTF", 32);

    xTracker = 0;
    speedFactor = 0;

    updateMenuBackground();
  }

  void updateGameMode() {
    mode = 1 - mode;
    updateMenuBackground();
  }

  void updateMenuBackground() {
    if (mode == 0) {
      image(lightMenuBackground, 0, 0);
      image(toggleLight, 0, 340);
      fill(245, 120, 66); // UF orange
    } else {
      image(darkMenuBackground, 0, 0);
      image(toggleDark, 0, 340);
      fill(163, 63, 21); // Darker UF orange
    }
    textFont(titleFont, 50);
    text("Swampy\nBird", 270, 150);

    // Play button
    fill(0, 33, 91); // UF blue
    rect(230, 230, 140, 70, 10);
    fill(255);
    textSize(30);
    textAlign(CENTER);
    text("PLAY", 300, 270);
  }

  void startGame() {
    gamePlaying = true;
    updateGameBackground();
  }

  void updateGameBackground() {
    // Smoother scrolling: move every frame
    if (mode == 0) {
      if (xTracker <= 600) {
        image(lightGameBackground.get(xTracker, 0, 600, 400), 0, 0);
      } else {
        int width1 = 1200 - xTracker;
        int width2 = 600 - width1;
        image(lightGameBackground.get(xTracker, 0, width1, 400), 0, 0);
        image(lightGameBackground.get(0, 0, width2, 400), width1, 0);
      }
    } else {
      if (xTracker <= 600) {
        image(darkGameBackground.get(xTracker, 0, 600, 400), 0, 0);
      } else {
        int width1 = 1200 - xTracker;
        int width2 = 600 - width1;
        image(darkGameBackground.get(xTracker, 0, width1, 400), 0, 0);
        image(darkGameBackground.get(0, 0, width2, 400), width1, 0);
      }
    }
    xTracker += 2; // Smoother movement
    if (xTracker >= 1200) {
      xTracker = 0;
    }
  }
}
