/**
 * TreeManager Class
 * 
 * Manages the collection of tree obstacles.
 * Handles creation, movement, and removal of trees.
 */
class TreeManager {
  ArrayList<SwampyTree> trees;
  int spawnCounter;
  int spawnInterval; // Frames between tree spawns
  int difficulty;

  TreeManager(int diff) {
    trees = new ArrayList<SwampyTree>();
    spawnCounter = 0;
   
    difficulty = diff;
     
      
  }

  void update() {
    // Spawn new trees
    spawnCounter++;
    if (spawnCounter >= spawnInterval) {
      trees.add(new SwampyTree(width, random(50, 200), 150, difficulty));
      spawnCounter = 0;
    }

    // Update and remove off-screen trees
    for (int i = trees.size() - 1; i >= 0; i--) {
      SwampyTree tree = trees.get(i);
      tree.update();
      if (tree.x < -tree.width) {
        trees.remove(i);
      }
    }
  }

  void display() {
    for (SwampyTree tree : trees) {
      tree.display();
    }
  }

  boolean checkCollisions(float[] birdHitbox) {
    for (SwampyTree tree : trees) {
      if (tree.checkCollision(birdHitbox)) {
        return true;
      }
    }
    return false;
  }

  int checkScoring(float birdX) {
    int points = 0;
    for (SwampyTree tree : trees) {
      if (!tree.passed && tree.x + tree.width < birdX) {
        points++;
        tree.passed = true;
      }
    }
    return points;
  }

  void reset() {
    trees.clear();
    spawnCounter = 0;
  }
  
  void setDifficulty(int diff) {
    difficulty = diff;
      if (difficulty == 0){
        spawnInterval = 90; // Spawn every 1.5 seconds at 60 FPS
    }
     else{
         spawnInterval = 60;
     }
   
  }
}
