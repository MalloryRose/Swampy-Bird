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

  PImage croppedBackground; //resizes background image to fit in screen

  PImage toggleOff;
  PImage toggleOn;
  PImage toggleOffHover;
  PImage toggleOnHover;

  PFont titleFont;
  PFont paragraphFont;
  
  boolean gamePlaying; //true if game has started
  boolean gameLost; //true if tree has been hit
  boolean settingsOpen; //true if settings menu is open
  boolean aboutOpen; //true if about menu is open
  int aboutTab; //0 for how to play, 1 for credits
  
  int lightMode; //0 for light mode, 1 for dark mode
  boolean soundMode; //true if sound is on
  boolean musicMode; //true if music is on
  boolean difficultyMode; //true if difficulty is hard

  int xTracker; //tracks position of background image
  int speedFactor; //speed at which the background moves

  // Constructor initializes UI components to default and loads assets.
  UIManager() {
    gamePlaying = false;
    gameLost = false;

    settingsOpen = false;
    aboutOpen = false;
    aboutTab = 0;
    lightMode = 0;
    soundMode = true;
    musicMode = true;
    difficultyMode = false;

    //load relevant backgrounds and sprites
    lightMenuBackground = loadImage("data/sprites/menuBackgroundLight.JPG");
    darkMenuBackground = loadImage("data/sprites/menuBackgroundDark.JPG");
    lightGameBackground = loadImage("data/sprites/backgroundDay.jpeg");
    darkGameBackground = loadImage("data/sprites/backgroundNight.JPG");

    toggleOff = loadImage("data/sprites/toggleOff.PNG");
    toggleOn = loadImage("data/sprites/toggleOn.PNG");
    toggleOffHover = loadImage("data/sprites/toggleOffHover.PNG");
    toggleOnHover = loadImage("data/sprites/toggleOnHover.PNG");

    titleFont = createFont("data/fonts/TitleFont.TTF", 32);
    paragraphFont = createFont("data/fonts/ParagraphFont.ttf", 32);
    
    xTracker = 0;
    speedFactor = 5;

    updateMenuBackground();
  }

  // Setter function for light mode.
  void updateLightMode() {
    lightMode = 1 - lightMode; //toggle mode
    updateMenuBackground();
  }

  // Setter function for sound mode.
  void updateSoundMode() {
    soundMode = !soundMode;
  }

  // Setter function for music mode.
  void updateMusicMode() {
    musicMode = !musicMode;
  }

  // Setter function for difficulty mode.
  void updateDifficultyMode() {
    difficultyMode = !difficultyMode;
  }

  // Function to "open" settings.
  void openSettings() {
    settingsOpen = true;
  }

  // Function to "close" settings.
  void closeSettings() {
    settingsOpen = false;
  }
  
  // Function to "open" about screen.
  void openAbout() {
    aboutOpen = true;
  }

  // Function to "close" about screen.
  void closeAbout() {
    aboutOpen = false;
    aboutTab = 0;
  }
  
  // Updates menu background. Checks for light mode, 
  // adds background and text to menu, displays settings or about menu.
  void updateMenuBackground() {
    background(0);

    if (lightMode == 0) {
      image(lightMenuBackground, 0, 0);
    } 
    else {
      image(darkMenuBackground, 0, 0);
    }
    textFont(titleFont, 50);
    textAlign(LEFT);
    fill(0, 33, 91);
    text("Swampy \nBird", 273, 153);
    fill(245, 120, 66);
    text("Swampy \nBird", 270, 150);

    if (mouseX < 388 && mouseX > 268 && mouseY < 248 && mouseY > 208) {
      fill(0, 15, 41);
    } 
    else {
      fill(0, 33, 91);
    }

    textFont(titleFont, 30);
    rect(268, 208, 128, 40, 10);
    fill(255);
    text("PLAY", 280, 240);

    if (mouseX < 396 && mouseX > 268 && mouseY < 283 && mouseY > 258) {
      fill(0, 15, 41);
    } 
    else {
      fill(0, 33, 91);
    }

    textFont(titleFont, 15);
    rect(268, 258, 128, 25, 8);
    fill(255);
    text("SETTINGS", 280, 278); 
    
    if (mouseX < 396 && mouseX > 268 && mouseY < 313 && mouseY > 288) {
      fill(0, 15, 41);
    } 
    else {
      fill(0, 33, 91);
    }

    rect(268, 288, 128, 25, 8);
    fill(255);
    text("ABOUT", 280, 308); 

    //if settings are open, display
    if (settingsOpen) {
      rectMode(CENTER);
      fill(0, 0, 0, 230);
      rect(width/2, height/2, width - 75, height - 75, 20);
      rectMode(CORNER);
     
      textFont(titleFont, 40);
      if (mouseX < width - 55 && mouseX > width - 95 && mouseY > 55 && mouseY < 95) {
        fill(125, 125, 125);
      }
      else {
        fill(255);
      }
      text("X", width - 90, 90);
      
      fill(255);
      textFont(titleFont, 25);
      text("Music", 100, 150);
      text("Sound FX", 100, 190);
      text("Light", 100, 230);
      text("Difficulty", 100, 270);
      
      textFont(titleFont, 15);
      text("ON", 460, 150);
      text("ON", 460, 190);
      text("LIGHT", 460, 230);
      text("HARD", 460, 270);
      

      text("OFF", 354, 150);
      text("OFF", 354, 190);
      text("DARK", 340, 230);
      text("EASY", 340, 270);
      
      if (musicMode) {
        if (mouseX > 400 && mouseX < 450 && mouseY > 125 && mouseY < 150){
          image(toggleOnHover, 400, 125);
        } else {
          image(toggleOn, 400, 125);
        }
      } else {
        if (mouseX > 400 && mouseX < 450 && mouseY > 125 && mouseY < 150){
          image(toggleOffHover, 400, 125);
        } else {
          image(toggleOff, 400, 125);
        }
      }
      
      if (soundMode) {
        if (mouseX > 400 && mouseX < 450 && mouseY > 165 && mouseY < 190){
          image(toggleOnHover, 400, 165);
        } else {
          image(toggleOn, 400, 165);
        }
      } else {
        if (mouseX > 400 && mouseX < 450 && mouseY > 165 && mouseY < 190){
          image(toggleOffHover, 400, 165);
        } else {
          image(toggleOff, 400, 165);
        }
      }
      
      if (lightMode == 0) {
        if (mouseX > 400 && mouseX < 450 && mouseY > 205 && mouseY < 230){
          image(toggleOnHover, 400, 205);
        } else {
          image(toggleOn, 400, 205);
        }
      } else {
        if (mouseX > 400 && mouseX < 450 && mouseY > 205 && mouseY < 230){
          image(toggleOffHover, 400, 205);
        } else {
          image(toggleOff, 400, 205);
        }
      }
      
      if (difficultyMode) {
        if (mouseX > 400 && mouseX < 450 && mouseY > 245 && mouseY < 270){
          image(toggleOnHover, 400, 245);
        } else {
          image(toggleOn, 400, 245);
        }
      } else {
        if (mouseX > 400 && mouseX < 450 && mouseY > 245 && mouseY < 270){
          image(toggleOffHover, 400, 245);
        } else {
          image(toggleOff, 400, 245);
        }
      }
    }
    //if about is open, display
    if (aboutOpen) {
      rectMode(CENTER);
      fill(0, 0, 0, 230);
      rect(width/2, height/2, width - 75, height - 75, 20);
      
      fill(50, 50, 50);
      if (aboutTab == 0) {
        if(mouseX < 370 && mouseX > 210 && mouseY > 70 && mouseY < 100){
          fill(60, 60, 60);
        }
        rect(290, 100, 160, 60, 10);
        fill(75, 75, 75);
        rect(width/2, height/2 + 32, width - 75, height - 75 - 64, 20);
        noStroke();
        rect(123, 100, 170, 60, 10);
      }
      else if (aboutTab == 1) {
        if(mouseX < 208 && mouseX > 38 && mouseY > 70 && mouseY < 100){
          fill(60, 60, 60);
        }
        rect(123, 100, 170, 60, 10);
        fill(75, 75, 75);
        rect(width/2, height/2 + 32, width - 75, height - 75 - 64, 20);
        noStroke();
        rect(290, 100, 160, 60, 10);
      }
      rectMode(CORNER);
      stroke(0);
     
      fill(255);
      textFont(titleFont, 20);
      text("GAMEPLAY", 50, 95);
      text("CREDITS", 220, 95);
      
      textFont(paragraphFont, 15);
      if (aboutTab == 0) {
        textAlign(CENTER);
        text("Help the Sandhill Crane navigate the swamp!\n\n", width/2, 150);
           
        textFont(paragraphFont, 14);
        textLeading(24);
        textAlign(LEFT);
        text("Use the spacebar, up arrow, or left click to fly.\n" + 
             "Navigate through the tree gaps and watch out for \n" +
             "gators!\n" +
             "Want an challenge? Increase game difficulty in\n" +
             "settings or switch to night mode!", 65, 200);
      }
      else if (aboutTab == 1) {
        textFont(paragraphFont, 14);
        textLeading(24);
        text("Created by Mallory Silva and Alexandra Seelig at\n"+
             "the University of Florida.\n\n" +
             "Original art by Alexandra Seelig.\n\n" +
             "Music from freesound.org.\nSound effects from 101soundboards.com.", 62, 150);
      }
      textFont(titleFont, 40);
      if (mouseX < width - 55 && mouseX > width - 95 && mouseY > 55 && mouseY < 95) {
        fill(125, 125, 125);
      }
      else {
        fill(255);
      }
      text("X", width - 90, 90);
    }
  }
  
  // Sets game status and updates game background.
  void startGame() {
    gameLost = false;
    gamePlaying = true;
    updateGameBackground();
  }

  // Updates score to display on screen.
  void updateScore(int score) {
    textSize(36);
    textAlign(CENTER);
    fill(0, 33, 91);
    text(score, width/2+3, 53);
    text(score, width/2-3, 53);
    text(score, width/2+3, 47);
    text(score, width/2-3, 47);
    fill(255);
    text(score, width/2, 50);
  }

  // Updates game background based on position of background.
  void updateGameBackground() {
    if (speedFactor == 5) {
      xTracker += 1;
      if (xTracker >= 1200) {
        xTracker = 0;
      }
      speedFactor = 0;
    } else {
      speedFactor += 1;
    }

    if (lightMode == 0) {
      if (xTracker <= 600) {
        croppedBackground = lightGameBackground.get(xTracker, 0, 600, 400);
        image(croppedBackground, 0, 0);
      } else {
        // wrap around background
        int width1 = 1200 - xTracker;
        int width2 = 600 - width1;

        PImage firstPart = lightGameBackground.get(xTracker, 0, width1, 400);
        PImage secondPart = lightGameBackground.get(0, 0, width2, 400);

        image(firstPart, 0, 0);
        image(secondPart, width1, 0);
      }
    } else {
      if (xTracker <= 600) {
        croppedBackground = darkGameBackground.get(xTracker, 0, 600, 400);
        image(croppedBackground, 0, 0);
      } else {
        // wrap around background
        int width1 = 1200 - xTracker;
        int width2 = 600 - width1;

        PImage firstPart = darkGameBackground.get(xTracker, 0, width1, 400);
        PImage secondPart = darkGameBackground.get(0, 0, width2, 400);

        image(firstPart, 0, 0);
        image(secondPart, width1, 0);
      }
    }
  }

  // Shows game lost background, score and top score, and options to continue.
  void gameLostBackground() {
    background(0);
    if (lightMode == 0) {
      if (xTracker <= 600) {
        croppedBackground = lightGameBackground.get(xTracker, 0, 600, 400);
        image(croppedBackground, 0, 0);
      } else {
        // wrap around background
        int width1 = 1200 - xTracker;
        int width2 = 600 - width1;

        PImage firstPart = lightGameBackground.get(xTracker, 0, width1, 400);
        PImage secondPart = lightGameBackground.get(0, 0, width2, 400);

        image(firstPart, 0, 0);
        image(secondPart, width1, 0);
      }
    } else {
      if (xTracker <= 600) {
        croppedBackground = darkGameBackground.get(xTracker, 0, 600, 400);
        image(croppedBackground, 0, 0);
      } else {
        // wrap around background
        int width1 = 1200 - xTracker;
        int width2 = 600 - width1;

        PImage firstPart = darkGameBackground.get(xTracker, 0, width1, 400);
        PImage secondPart = darkGameBackground.get(0, 0, width2, 400);

        image(firstPart, 0, 0);
        image(secondPart, width1, 0);
      }
    }
    fill(0, 0, 0, 150);
    rect(0, 0, width, height);

    textSize(48);
    textAlign(CENTER);
    fill(0, 33, 91);
    text("GAME OVER", width/2 + 3, 100 + 3);
    fill(245, 120, 66);
    text("GAME OVER", width/2, 100);

    fill(255);
    textSize(24);
    text("Score: " + score, width/2, 160);
    text("High Score: " + highScore, width/2, 190);

    if (mouseX < 390 && mouseX > 210 && mouseY < 270 && mouseY > 230) {
      fill(0, 15, 41);
    } else {
      fill(0, 33, 91);
    }
    rect(210, 230, 180, 40, 10);
    fill(255);
    textSize(20);
    text("TRY AGAIN", 300, 258);

    if (mouseX < 370 && mouseX > 230 && mouseY < 320 && mouseY > 290) {
      fill(0, 15, 41);
    } else {
      fill(0, 33, 91);
    }
    rect(230, 290, 140, 40, 10);
    fill(255);
    text("MENU", 300, 320);
    
  
  }
}
