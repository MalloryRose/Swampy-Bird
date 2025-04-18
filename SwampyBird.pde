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

// Sets up game by creating board size, frame rate, 
// defining UIManager object, BirdClass object, 
// treeManager object, and soundManager object.
void setup() {
  size(600, 400);
  frameRate(60);

  UI = new UIManager();
  BirdClass = new BirdClass(width/3, height/2, difficulty);
  treeManager = new TreeManager(difficulty);
  soundManager = new SoundManager(this);
  
  // Start playing background music
  soundManager.playBackgroundMusic();
}

// Redraws game depending on conditions.
// If the game is playing, the game background is updated and the game is updated.
// If the game is lost, the game lost background is displayed.
// If the game is not playing, the menu background is displayed.
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

// Checks for mouse clicks depending on game state.
void mouseClicked() {
  if (!UI.gamePlaying) {
    // Settings buttons
    if(UI.settingsOpen) {
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
    // About menu buttons
    else if (UI.aboutOpen) {
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
    // Main menu buttons
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
  // Gameplay mouse click triggers bird flap
  else if (!UI.gameLost) {
    BirdClass.flap();
    soundManager.playFlap();
  } 
  // Game lost buttons
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

//Key presses used for gameplay. If space or up arrow, bird flaps
void keyPressed() {
  if (UI.gamePlaying && !UI.gameLost && (key == ' ' || keyCode == UP)) {
    BirdClass.flap();
    soundManager.playFlap();
  }
}

// General function to trigger game starting conditions in UI, BirdClass, and treeManager.
void startGame() {
  UI.startGame();
  score = 0;
  BirdClass.reset(width/3, height/2);
  BirdClass.setDifficulty(difficulty);
  treeManager.setDifficulty(difficulty);
  treeManager.reset();
}

// General function to trigger game updating conditions in UI, BirdClass, and treeManager.
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

// General function to trigger game reset in UI, BirdClass, and treeManager.
void resetGame() {
  score = 0;
  UI.gameLost = false;
  BirdClass.reset(width/3, height/2);
  treeManager.reset();
 
}

// General function to trigger game loss conditions in UI, BirdClass, and treeManager.
void gameOver() {
  UI.gameLost = true;
  if (score > highScore) {
    highScore = score;
  }
  soundManager.playHit();
}

// Function to update score.
void addScore(int points) {
  score += points;
  soundManager.playPoint();
}
