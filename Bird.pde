/**
 * Bird Class
 * 
 * Represents the player-controlled bird character.
 * Handles physics, animation, and rendering of the bird.
 */

class Bird {
  float x, y;
  float velocity;
  float gravity;
  float flapStrength;
  PImage[] birdFrames;
  int currentFrame;
  float rotation;
  int frameCounter;
  float width, height;
  int difficulty;

  Bird(float startX, float startY, int diff) {
    x = startX;
    y = startY;
    difficulty = diff;

  
    birdFrames = new PImage[3];
    birdFrames[0] = loadImage("data/sprites/bird1.png");
    birdFrames[1] = loadImage("data/sprites/bird2.png");
    birdFrames[2] = loadImage("data/sprites/bird3.png");
    for (int i = 0; i < 3; i++) {
      if (birdFrames[i] == null) {
        println("Error: Could not load bird" + (i+1) + ".png");
        exit();
      }
    }

    width = 50;
    height = 40;

    velocity = 0;
    if (difficulty == 0) { // Easy
      gravity = 0.5;
      flapStrength = -8;
    } else { // Hard
      gravity = 0.7;
      flapStrength = -10;
    }

    currentFrame = 0;
    frameCounter = 0;
    rotation = 0;
  }

  void update() {
    velocity += gravity;
    y += velocity;

    // Adjusted boundary to allow bird to go near top
    if (y < 20) {
      y = 20;
      velocity = 0;
    }

    // Adjusted rotation mapping for more natural feel
    rotation = map(velocity, -8, 12, -PI/6, PI/3);

    frameCounter++;
    if (frameCounter >= 5) {
      currentFrame = (currentFrame + 1) % 3;
      frameCounter = 0;
    }
  }

  void flap() {
    velocity = flapStrength;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    imageMode(CENTER);
    image(birdFrames[currentFrame], 0, 0, width, height);
    popMatrix();
  }

  boolean hitGround() {
    return y + height/2 > 400;
  }

  float[] getHitbox() {
    float hitboxRadius = (width + height) / 4 * 0.8;
    return new float[]{x, y, hitboxRadius};
  }

  void reset(float startX, float startY) {
    x = startX;
    y = startY;
    velocity = 0;
    rotation = 0;
  }

  void setDifficulty(int diff) {
    difficulty = diff;
    if (difficulty == 0) {
      gravity = 0.5;
      flapStrength = -8;
    } else {
      gravity = 0.7;
      flapStrength = -10;
    }
  }
}
