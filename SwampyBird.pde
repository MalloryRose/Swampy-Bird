import processing.sound.*;

/**
 * Swampy BirdClass Game - Main File
 * Initializes the game, handles game states, and manages all game objects.
 */
 
UIManager UI;
BirdClass BirdClass;
TreeManager treeManager;
SoundManager soundManager;

int difficulty = 0;
int score = 0;
int highScore = 0;

void setup() {
  size(600, 400);
  frameRate(60);

  UI = new UIManager();
  BirdClass = new BirdClass(width/3, height/2, difficulty);
  treeManager = new TreeManager(difficulty);
  // Initialize Sound Manager
  soundManager = new SoundManager(this);
  
  // Start playing background music
  soundManager.playBackgroundMusic();
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
    //settings buttons
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
        soundManager.toggleMusic();
      }
      if (mouseX > 400 && mouseX < 450 && mouseY > 165 && mouseY < 190){
        UI.updateSoundMode();
        soundManager.toggleSound();
      }
      if (mouseX > 400 && mouseX < 450 && mouseY > 205 && mouseY < 230){
        UI.updateLightMode();
      }
      if (mouseX > 400 && mouseX < 450 && mouseY > 245 && mouseY < 270){
        UI.updateDifficultyMode();
        difficulty = 1 - difficulty;
      }
    }
    else if (UI.aboutOpen) {
      //about menu buttons
      if (mouseX < 75/2 || mouseX > width - 75/2 || mouseY < 75/2 || mouseY > height - 75/2) {
        UI.closeAbout();
      }
      else if (mouseX < width - 55 && mouseX > width - 95 && mouseY > 55 && mouseY < 95) {
        UI.closeAbout();
      }
      else if (mouseX < 208 && mouseX > 38 && mouseY > 70 && mouseY < 100) {
        UI.aboutTab = 0;
      }
      else if (mouseX < 370 && mouseX > 210 && mouseY > 70 && mouseY < 100) {
        UI.aboutTab = 1;
      }
    }
    //main menu buttons
    else {
      if (mouseX > 280 && mouseX < 375 && mouseY > 215 && mouseY < 250) {
        startGame();
      }
      if (mouseX < 396 && mouseX > 268 && mouseY < 283 && mouseY > 258) {
        UI.openSettings();
      }
      if (mouseX < 396 && mouseX > 268 && mouseY < 313 && mouseY > 288) {
        UI.openAbout();
      }
    }
  } 
  else if (!UI.gameLost) {
    BirdClass.flap();
    soundManager.playFlap();
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
  // Key presses for gameplay
  if (UI.gamePlaying && !UI.gameLost && (key == ' ' || keyCode == UP)) {
    BirdClass.flap();
    soundManager.playFlap();
  }
}

void startGame() {
  UI.startGame();
  score = 0;
  BirdClass.reset(width/3, height/2);
  BirdClass.setDifficulty(difficulty);
  treeManager.setDifficulty(difficulty);
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
  soundManager.playHit();
}

void addScore(int points) {
  score += points;
  soundManager.playPoint();
}
