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
  
}

void mouseClicked() {
  //menu clicks
  if (!UI.gamePlaying){
    //check for toggle click
    if (mouseX < 80 && mouseX > 5 && mouseY < 395 && mouseY > 345){
      UI.updateGameMode();
    }
    //TODO: Check for press play, difficulty level
  }
  //TODO: game clicks
}
