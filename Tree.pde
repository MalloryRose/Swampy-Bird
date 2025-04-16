/**
 * SwampyTree Class
 * Represents obstacles in the game (UF-themed SwampyTrees instead of pipes).
 */
class SwampyTree {
  float x, yTop, gapHeight;
  float width = 50;
  boolean passed = false;
  int difficulty;
  int speedFactor = 3;

  PImage tree;
  
  SwampyTree(float x, float yTop, float gapHeight, int diff) {
    this.x = x;
    this.yTop = yTop;
    this.gapHeight = gapHeight;
    tree = loadImage("data/sprites/lightTree.png");
 
    difficulty = diff;
     if (difficulty == 0) {
      speedFactor = 3;
    } else {
      speedFactor = 5;
    }
    
  }

  void update() {
    x -= speedFactor;
  }

  void display() {
    fill(0, 100, 0);
    
    // upside down tree
    pushMatrix();
    translate(x + tree.width - 8, yTop);
    rotate(PI);
    image(tree, 0, 0);
    popMatrix();
    
    image(tree, x-5, yTop + gapHeight);
  }

  boolean checkCollision(float[] birdHitbox) {
    float birdX = birdHitbox[0];
    float birdY = birdHitbox[1];
    float birdRadius = birdHitbox[2];

    if (birdX + birdRadius > x && birdX - birdRadius < x + width) {
      if (birdY - birdRadius < yTop || birdY + birdRadius > yTop + gapHeight) {
        return true;
      }
    }
    return false;
  }
  
  
}
