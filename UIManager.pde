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

    // Resize to match canvas width with continuous scrolling in mind
    lightGameBackground.resize(1200, 400); // Keep width > canvas for scrolling
    darkGameBackground.resize(1200, 400);

    // Debug sizes
    println("Light Game BG: " + lightGameBackground.width + "x" + lightGameBackground.height);
    println("Dark Game BG: " + darkGameBackground.width + "x" + darkGameBackground.height);

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
      image(lightMenuBackground, 0, 0, width, height); // Ensure full size
      image(toggleLight, 0, 340);
      fill(245, 120, 66);
    } else {
      image(darkMenuBackground, 0, 0, width, height); // Ensure full size
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
    updateGameBackground();
  }

  void updateGameBackground() {
    // Draw scrolling background to fill entire 600x400 canvas
    if (mode == 0) {
      // Draw first part of the background
      image(lightGameBackground, -xTracker, 0, 600, 400); // Scale to canvas size
      // Draw second part to wrap around seamlessly
      image(lightGameBackground, -xTracker + 600, 0, 600, 400); // Follows immediately
    } else {
      image(darkGameBackground, -xTracker, 0, 600, 400); // Scale to canvas size
      image(darkGameBackground, -xTracker + 600, 0, 600, 400); // Follows immediately
    }

    // Update scrolling position
    xTracker += 2;
    if (xTracker >= 600) { // Reset when one full canvas width has scrolled
      xTracker = 0;
    }
  }
} 
