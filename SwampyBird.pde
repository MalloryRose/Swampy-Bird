/**
 * Swampy BirdClass Game - Main File
 * Initializes the game, handles game states, and manages all game objects.
 */
UIManager UI;
BirdClass BirdClass;
TreeManager treeManager;

int difficulty = 0;
int score = 0;
int highScore = 0;

void setup() {
  size(600, 400);
  frameRate(60);

  UI = new UIManager();
  BirdClass = new BirdClass(width/3, height/2, difficulty);
  treeManager = new TreeManager();
}

void draw() {
  if (UI.gamePlaying) {
    if (!UI.gameLost) {
      UI.updateGameBackground();
      updateGame();
    } 
    else {
      BirdClass.display();
      treeManager.display();
      UI.gameLostBackground();
    }
  }
  else {
    UI.updateMenuBackground();
  }
}

void mouseClicked() {
  if (!UI.gamePlaying) {
    if(UI.settingsOpen) {
      //check for different toggles or click outside of box/X to close
      if (mouseX < 75/2 || mouseX > width - 75/2 || mouseY < 75/2 || mouseY > height - 75/2) {
        UI.closeSettings();
      }
      else if (mouseX < width - 55 && mouseX > width - 95 && mouseY > 55 && mouseY < 95) {
        UI.closeSettings();
      }
      if (mouseX > 400 && mouseX < 450 && mouseY > 125 && mouseY < 150){
        UI.updateMusicMode();
      }
      if (mouseX > 400 && mouseX < 450 && mouseY > 165 && mouseY < 190){
        UI.updateSoundMode();
      }
      if (mouseX > 400 && mouseX < 450 && mouseY > 205 && mouseY < 230){
        UI.updateLightMode();
      }
      if (mouseX > 400 && mouseX < 450 && mouseY > 245 && mouseY < 270){
        UI.updateDifficultyMode();
        difficulty = 1 - difficulty;
      }
    }
    else {
      if (mouseX > 280 && mouseX < 375 && mouseY > 215 && mouseY < 250) {
        startGame();
      }
      if (mouseX < 396 && mouseX > 268 && mouseY < 283 && mouseY > 258) {
        UI.openSettings();
      }
    }
  } 
  else if (!UI.gameLost) {
    BirdClass.flap();
  } 
  else {
    if (mouseX > 230 && mouseX < 370 && mouseY > 230 && mouseY < 270) {
      resetGame();
    }
    if (mouseX > 230 && mouseX < 370 && mouseY > 290 && mouseY < 330) {
      UI.gamePlaying = false;
      UI.gameLost = false;
      UI.updateMenuBackground();
    }
  }
}

void keyPressed() {
  if (UI.gamePlaying && !UI.gameLost && (key == ' ' || keyCode == UP)) {
    BirdClass.flap();
  }
}

void startGame() {
  UI.startGame();
  score = 0;
  UI.gamePlaying = true;
  UI.gameLost = false;
  BirdClass.reset(width/3, height/2);
  BirdClass.setDifficulty(difficulty);
  treeManager.reset();
}

void updateGame() {
  BirdClass.update();
  treeManager.update();

  if (treeManager.checkCollisions(BirdClass.getHitbox())) {
    gameOver();
  }

  int points = treeManager.checkScoring(BirdClass.x);
  if (points > 0) {
    addScore(points);
  }

  if (BirdClass.hitGround()) {
    gameOver();
  }

  BirdClass.display();
  treeManager.display();
  UI.updateScore(score);
}

void resetGame() {
  score = 0;
  UI.gameLost = false;
  BirdClass.reset(width/3, height/2);
  treeManager.reset();
 
}

void gameOver() {
  UI.gameLost = true;
  if (score > highScore) {
    highScore = score;
  }
}

void addScore(int points) {
  score += points;
}
