/**
 * UIManager Class
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
  float xTracker;

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

    
    if (lightGameBackground == null || darkGameBackground == null) {
      println("Error: Failed to load game background images.");
      exit();
    }

    // Resize to ensure proper dimensions
    lightGameBackground.resize(1200, 400);
    darkGameBackground.resize(1200, 400);

    // Debug dimensions after resize
    println("Light Game BG after resize: " + lightGameBackground.width + "x" + lightGameBackground.height);
    println("Dark Game BG after resize: " + darkGameBackground.width + "x" + darkGameBackground.height);

    titleFont = createFont("data/fonts/TitleFont.TTF", 32);

    xTracker = 0;

    updateMenuBackground();
  }

  void updateGameMode() {
    mode = 1 - mode;
    updateMenuBackground();
  }

  void updateMenuBackground() {
    if (mode == 0) {
      image(lightMenuBackground, 0, 0, width, height);
      image(toggleLight, 0, 340);
      fill(245, 120, 66);
    } else {
      image(darkMenuBackground, 0, 0, width, height);
      image(toggleDark, 0, 340);
      fill(163, 63, 21);
    }
    textFont(titleFont, 50);
    text("Swampy\nBird", 270, 150);

    fill(0, 33, 91);
    rect(230, 230, 140, 70, 10);
    fill(255);
    textSize(30);
    textAlign(CENTER);
    text("PLAY", 300, 270);
  }

  void startGame() {
    gamePlaying = true;
    xTracker = 0;
    updateGameBackground();
  }

  void updateGameBackground() {
    // Draw scrolling background 
    if (mode == 0) {
      // Draw first part of the background
      image(lightGameBackground, -xTracker, 0, width * 2, height * 2);
      // Draw second part to wrap around s
      image(lightGameBackground, -xTracker + 1200, 0, width * 2, height * 2);
    } else {
      image(darkGameBackground, -xTracker, 0, width * 2, height * 2);
      image(darkGameBackground, -xTracker + 1200, 0, width * 2, height * 2);
    }

    // Update scrolling position
    xTracker += 2;
    if (xTracker >= 1200) {
      xTracker = 0;
    }
  }
}
