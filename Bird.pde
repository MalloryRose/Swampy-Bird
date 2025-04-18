/**
 * BirdClass Class
 * 
 * Represents the player-controlled BirdClass character.
 * Handles physics, animation, and rendering of the BirdClass.
 */

  class BirdClass {
  float x, y;
  float velocity;
  float gravity;
  float flapStrength;
  PImage[] BirdClassFrames;
  int currentFrame;
  float rotation;
  int frameCounter;
  float width, height;
  int difficulty;

  // Constructor to initialize bird variables, including default position and difficulty factor
  BirdClass(float startX, float startY, int diff) {
    x = startX;
    y = startY;
    difficulty = diff;

  
    BirdClassFrames = new PImage[3];
    BirdClassFrames[0] = loadImage("data/sprites/bird1.png");
    BirdClassFrames[1] = loadImage("data/sprites/bird2.png");
    BirdClassFrames[2] = loadImage("data/sprites/bird3.png");
    for (int i = 0; i < 3; i++) {
      if (BirdClassFrames[i] == null) {
        println("Error: Could not load BirdClass" + (i+1) + ".png");
        exit();
      }
    }

    width = 50;
    height = 40;

    velocity = 0;
    if (difficulty == 0) { // Easy
      gravity = 0.7;
      flapStrength = -8;
    } else { // Hard
      gravity = 0.9;
      flapStrength = -10;
    }

    currentFrame = 0;
    frameCounter = 0;
    rotation = 0;
  }

  // Function to update position of bird on
  void update() {
    velocity += gravity;
    y += velocity;

    // Adjusted boundary to allow BirdClass to go near top
    if (y < 20) {
      y = 20;
      velocity = 0;
    }

    // Adjusted rotation mapping
    rotation = map(velocity, -8, 12, -PI/6, PI/3);

    frameCounter++;
    if (frameCounter >= 5) {
      currentFrame = (currentFrame + 1) % 3;
      frameCounter = 0;
    }
  }

  // Updates velocity when bird flaps
  void flap() {
    velocity = flapStrength;
  }

  // Displays bird on screen based on position and orientation.
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    imageMode(CENTER);
    image(BirdClassFrames[currentFrame], 0, 0, width, height);
    imageMode(CORNER);
    popMatrix();
  }

  // Checks if bird has hit the ground.
  boolean hitGround() {
    return y + height/2 > 400;
  }

  // Returns position of hitbox for game loss condition check.
  float[] getHitbox() {
    float hitboxRadius = (width + height) / 4 * 0.8;
    return new float[]{x, y, hitboxRadius};
  }

  //Resets bird position, velocity, and rotation.
  void reset(float startX, float startY) {
    x = startX;
    y = startY;
    velocity = 0;
    rotation = 0;
  }

  // Adjusts difficulty by setting gravity factor and flap strength.
  void setDifficulty(int diff) {
    difficulty = diff;
    if (difficulty == 0) {
      gravity = 0.7;
      flapStrength = -8;
    } else {
      gravity = 0.9;
      flapStrength = -10;
    }
  }
}
