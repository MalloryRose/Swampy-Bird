/**
 * Swampy Bird Game - Main File
 * Initializes the game, handles game states, and manages all game objects.
 */
UIManager UI;
Bird bird;
TreeManager treeManager; // Replaced ArrayList<SwampTree>
int difficulty = 0;
int score = 0;
int highScore = 0;

void setup() {
  size(600, 400);
  frameRate(60);

  UI = new UIManager();
  bird = new Bird(width/3, height/2, difficulty);
  treeManager = new TreeManager();
}

void draw() {
  if (!UI.gamePlaying) {
    UI.updateMenuBackground();
  } else {
    UI.updateGameBackground();

    if (!UI.gameLost) {
      bird.update();

      // Update trees via TreeManager
      treeManager.update();

      // Check collisions
      if (treeManager.checkCollisions(bird.getHitbox())) {
        gameOver();
      }

      // Check scoring
      int points = treeManager.checkScoring(bird.x);
      if (points > 0) {
        addScore(points);
      }

      if (bird.hitGround()) {
        gameOver();
      }

      bird.display();
      treeManager.display();
      displayScore();
    } else {
      bird.display();
      treeManager.display();
      displayGameOver();
    }
  }
}

void mouseClicked() {
  if (!UI.gamePlaying) {
    if (mouseX < 80 && mouseX > 5 && mouseY < 395 && mouseY > 345) {
      UI.updateGameMode();
    }
    if (mouseX > 230 && mouseX < 370 && mouseY > 230 && mouseY < 300) {
      startGame();
    }
  } else if (!UI.gameLost) {
    bird.flap();
.ConcurrentModificationException
  } else {
    if (mouseX > 230 && mouseX < 370 && mouseY > 230 && mouseY < 270) {
      resetGame();
    }
    if (mouseX > 230 && mouseX < 370 && mouseY > 290 && mouseY < 330) {
      UI.gamePlaying = false;
      UI.gameLost = false;
    }
  }
}

void keyPressed() {
  if (UI.gamePlaying && !UI.gameLost && (key == ' ' || keyCode == UP)) {
    bird.flap();
  }
}

void startGame() {
  score = 0;
  UI.gamePlaying = true;
  UI.gameLost = false;
  bird.reset(width/3, height/2);
  bird.setDifficulty(difficulty);
  treeManager.reset();
}

void resetGame() {
  score = 0;
  UI.gameLost = false;
  bird.reset(width/3, height/2);
  treeManager.reset();
}

void gameOver() {
  UI.gameLost = true;
  if (score > highScore) {
    highScore = score;
  }
}

void displayScore() {
  fill(255);
  textSize(36);
  textAlign(CENTER);
  text(score, width/2, 50);
}

void displayGameOver() {
  fill(0, 0, 0, 150);
  rect(0, 0, width, height);

  fill(245, 120, 66);
  textSize(48);
  textAlign(CENTER);
  text("GAME OVER", width/2, 150);

  fill(255);
  textSize(24);
  text("Score: " + score, width/2, 200);
  text("High Score: " + highScore, width/2, 230);

  fill(0, 33, 91);
  rect(230, 230, 140, 40, 10);
  fill(255);
  textSize(20);
  text("TRY AGAIN", 300, 255);

  fill(0, 33, 91);
  rect(230, 290, 140, 40, 10);
  fill(255);
  text("MENU", 300, 315);
}

void addScore(int points) {
  score += points;
}
