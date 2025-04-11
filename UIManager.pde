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
   
   PImage toggleLight;
   PImage toggleDark;
   
   PFont titleFont;
   
   boolean gamePlaying; //true if game has started
   int mode; //0 for light mode, 1 for dark mode
   boolean gameLost; //true if tree has been hit
   
   int xTracker; //tracks position of background image
   int speedFactor; //speed at which the background moves
   
   UIManager(){
     gamePlaying = false;
     mode = 0;
     gameLost = false;
     
     //load relevant backgrounds and sprites
     lightMenuBackground = loadImage("data/sprites/menuBackgroundLight.JPG");
     darkMenuBackground = loadImage("data/sprites/menuBackgroundDark.JPG");
     lightGameBackground = loadImage("data/sprites/backgroundDay.jpeg");
     darkGameBackground = loadImage("data/sprites/backgroundNight.JPG");
     
     toggleLight = loadImage("data/sprites/toggleLight.PNG");
     toggleDark = loadImage("data/sprites/toggleDark.PNG");
     
     titleFont = createFont("data/fonts/TitleFont.TTF", 32);
     
     xTracker = 0;
     speedFactor = 5;
     
     updateMenuBackground();
   }
   
   void updateGameMode() {
     mode = 1 - mode; //toggle mode
     updateMenuBackground();
   }
   
   void updateMenuBackground() {
     if (mode == 0) {
       image(lightMenuBackground, 0 , 0);
       image(toggleLight, 0, 340);
     }
     else {
       image(darkMenuBackground,0,0);
       image(toggleDark, 0, 340);
     }
     textFont(titleFont, 50);
     textAlign(LEFT);
     fill(0, 33, 91);
     text("Swampy \nBird", 273, 153);
     fill(245, 120, 66);
     text("Swampy \nBird", 270, 150);
     textFont(titleFont, 30);
     
     if (mouseX < 388 && mouseX > 268 && mouseY < 248 && mouseY > 208){
       fill(0, 15, 41);
     }
     else {
       fill(0, 33, 91);
     }
     rect(268, 208, 128, 40, 10);
     fill(255);
     text("PLAY", 280, 240);
   }
   
   void startGame() { //begins the game
     gamePlaying = true;
     updateGameBackground();
   }
   
   void updateGameBackground() {
     if (speedFactor == 5){
       xTracker += 1;
       if (xTracker >= 1200) {
         xTracker = 0;
       }
       speedFactor = 0;
     }
     else{
       speedFactor += 1;
     }
     if (mode == 0) {
       if (xTracker <= 600) {
          croppedBackground = lightGameBackground.get(xTracker, 0, 600, 400);
          image(croppedBackground, 0, 0);
        } 
        else {
          // wrap around background
          int width1 = 1200 - xTracker;
          int width2 = 600 - width1;
    
          PImage firstPart = lightGameBackground.get(xTracker, 0, width1, 400);
          PImage secondPart = lightGameBackground.get(0, 0, width2, 400);
    
          image(firstPart, 0, 0);
          image(secondPart, width1, 0);
        }
     }
     else {
      if (xTracker <= 600) {
        croppedBackground = darkGameBackground.get(xTracker, 0, 600, 400);
        image(croppedBackground, 0, 0);
      } 
      else {
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
   
   void gameLostBackground() {
     background(0);
     if (mode == 0) {
       if (xTracker <= 600) {
          croppedBackground = lightGameBackground.get(xTracker, 0, 600, 400);
          image(croppedBackground, 0, 0);
        } 
        else {
          // wrap around background
          int width1 = 1200 - xTracker;
          int width2 = 600 - width1;
    
          PImage firstPart = lightGameBackground.get(xTracker, 0, width1, 400);
          PImage secondPart = lightGameBackground.get(0, 0, width2, 400);
    
          image(firstPart, 0, 0);
          image(secondPart, width1, 0);
        }
     }
     else {
        if (xTracker <= 600) {
          croppedBackground = darkGameBackground.get(xTracker, 0, 600, 400);
          image(croppedBackground, 0, 0);
        } 
        else {
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
 }
