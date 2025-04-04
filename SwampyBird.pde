/**
 * Swampy Bird Game - Main File
 * 
 * This is the main file for our Swampy Bird implementation.
 * It initializes the game, handles game states and manages all game objects.
 */
UIManager UI;
 
 void setup() {
  size(600, 400);
  
  UI = new UIManager();
}

void draw() {
  if (UI.gamePlaying) {
    UI.updateGameBackground();
  }
}

void mouseClicked() {
  //menu clicks
  if (!UI.gamePlaying){
    //check for toggle click
    if (mouseX < 80 && mouseX > 5 && mouseY < 395 && mouseY > 345){
      UI.updateGameMode();
    }
    if (mouseX > 280 && mouseX < 375 && mouseY > 215 && mouseY < 250){
      UI.startGame();
    }
    //TODO: difficulty level
  }
  //TODO: game clicks
}
