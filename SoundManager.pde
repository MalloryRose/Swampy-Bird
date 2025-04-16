/**
 * SoundManager Class
 * 
 * Handles loading and playing all game sounds.
 * Manages audio settings like volume and mute.
 */
import processing.sound.*;

class SoundManager {
  // Sound objects
  SoundFile flapSound;
  SoundFile pointSound;
  SoundFile hitSound;
  SoundFile menuSound;
  SoundFile backgroundMusic;
  
  // Audio state
  boolean soundEnabled;
  boolean musicEnabled;
  float musicVolume;
  float soundVolume;
  
  /**
   * Constructor - initializes sound manager
   */
  SoundManager() {
    soundEnabled = true;
    musicEnabled = true;
    musicVolume = 0.3; // 30% volume for music
    soundVolume = 0.7; // 70% volume for sound effects
    
    loadSounds();
  }
  
  /**
   * Load all sound assets
   */
  void loadSounds() {
    // Load sound effects
    flapSound = new SoundFile(SwampyBird.this, "data/audio/wing.mp3");
    pointSound = new SoundFile(SwampyBird.this, "data/audio/point.mp3");
    hitSound = new SoundFile(SwampyBird.this, "data/audio/hit.mp3");
 //   menuSound = new SoundFile(SwampyBird.this, "data/audio/menu.mp3");
    
    // Load background music
    backgroundMusic = new SoundFile(SwampyBird.this, "data/audio/background.wav");
    
    // Set initial volumes
    setVolumes();
  }
  
  /**
   * Set volumes for all sound objects
   */
  void setVolumes() {
    flapSound.amp(soundVolume);
    pointSound.amp(soundVolume);
    hitSound.amp(soundVolume);
  //  menuSound.amp(soundVolume);
    backgroundMusic.amp(musicVolume);
  }
  
  /**
   * Play the flap sound effect
   */
  void playFlap() {
    if (soundEnabled && !flapSound.isPlaying()) {
      flapSound.play();
    }
  }
  
  /**
   * Play the point scoring sound effect
   */
  void playPoint() {
    if (soundEnabled && !pointSound.isPlaying()) {
      pointSound.play();
    }
  }
  
  /**
   * Play the hit/death sound effect
   */
  void playHit() {
    if (soundEnabled && !hitSound.isPlaying()) {
      hitSound.play();
    }
  }
  
  /**
   * Play the menu selection sound effect
   */
  //void playMenu() {
  //  if (soundEnabled && !menuSound.isPlaying()) {
  //    menuSound.play();
  //  }
  //}
  
  /**
   * Start playing background music on loop
   */
  void playBackgroundMusic() {
    if (musicEnabled && !backgroundMusic.isPlaying()) {
      backgroundMusic.loop();
    }
  }
  
  /**
   * Stop background music
   */
  void stopBackgroundMusic() {
    if (backgroundMusic.isPlaying()) {
      backgroundMusic.stop();
    }
  }
  
  /**
   * Pause background music
   */
  void pauseBackgroundMusic() {
    if (backgroundMusic.isPlaying()) {
      backgroundMusic.pause();
    }
  }
  
  /**
   * Toggle sound effects on/off
   */
  void toggleSound() {
    soundEnabled = !soundEnabled;
  }
  
  /**
   * Toggle background music on/off
   */
  void toggleMusic() {
    musicEnabled = !musicEnabled;
    
    if (musicEnabled) {
      playBackgroundMusic();
    } else {
      pauseBackgroundMusic();
    }
  }
  
  /**
   * Set music volume
   * @param volume value between 0.0 and 1.0
   */
  void setMusicVolume(float volume) {
    musicVolume = constrain(volume, 0.0, 1.0);
    backgroundMusic.amp(musicVolume);
  }
  
  /**
   * Set sound effects volume
   * @param volume value between 0.0 and 1.0
   */
  void setSoundVolume(float volume) {
    soundVolume = constrain(volume, 0.0, 1.0);
    flapSound.amp(soundVolume);
    pointSound.amp(soundVolume);
    hitSound.amp(soundVolume);
 //   menuSound.amp(soundVolume);
  }
}
