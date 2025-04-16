/**
 * SoundManager Class
 * 
 * Handles loading and playing all game sounds using Minim.
 * Uses a sound pool approach for overlapping sounds.
 */
import ddf.minim.*;

class SoundManager {
  // Minim objects
  Minim minim;
  
  // Sound pools for frequently triggered sounds
  ArrayList<ddf.minim.AudioSample> flapSounds;
  int currentFlapSound = 0;
  final int FLAP_SOUND_COUNT = 5; // Pool size for flap sounds
  
  // Regular sound effects
  ddf.minim.AudioSample pointSound;
  ddf.minim.AudioSample hitSound;
  
  // Background music
  ddf.minim.AudioPlayer backgroundMusic;
  
  // Audio state
  boolean soundEnabled;
  boolean musicEnabled;
  float musicVolume;
  float soundVolume;
  
  /**
   * Constructor - initializes sound manager
   * @param parent PApplet reference (usually 'this' from main sketch)
   */
  SoundManager(PApplet parent) {
    // Initialize Minim
    minim = new Minim(parent);
    
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
    try {
      // Initialize flap sound pool
      flapSounds = new ArrayList<ddf.minim.AudioSample>();
      for (int i = 0; i < FLAP_SOUND_COUNT; i++) {
        // Load multiple instances of the flap sound
        ddf.minim.AudioSample flap = minim.loadSample("data/audio/wing.mp3", 512);
        flapSounds.add(flap);
      }
      
      // Load other sound effects
      pointSound = minim.loadSample("data/audio/point.mp3", 512);
      hitSound = minim.loadSample("data/audio/hit.mp3", 512);
      
      // Load background music as AudioPlayer for streaming
      backgroundMusic = minim.loadFile("data/audio/background.wav");
      
      // Set initial volumes
      setVolumes();
    } 
    catch (Exception e) {
      println("Error loading sounds: " + e.getMessage());
    }
  }
  
  /**
   * Set volumes for all sound objects
   */
  void setVolumes() {
    // Convert standard volume (0-1) to Minim gain (decibels)
    float fxGain = volumeToGain(soundVolume);
    float musicGain = volumeToGain(musicVolume);
    
    // Set volumes for flap sound pool
    for (ddf.minim.AudioSample flap : flapSounds) {
      flap.setGain(fxGain);
    }
    
    // Set volumes for other sounds
    if (pointSound != null) pointSound.setGain(fxGain);
    if (hitSound != null) hitSound.setGain(fxGain);
    if (backgroundMusic != null) backgroundMusic.setGain(musicGain);
  }
  
  /**
   * Convert volume (0-1) to gain (decibels)
   * Minim uses gain in decibels, where 0dB is full volume, -80dB is silent
   */
  float volumeToGain(float volume) {
    if (volume <= 0) return -80; // Effectively silent
    return (float)(20 * Math.log10(volume));
  }
  
  /**
   * Play the flap sound effect using sound pool for overlapping
   */
  void playFlap() {
    if (soundEnabled) {
      // Get the next sound in the pool and play it
      ddf.minim.AudioSample currentSound = flapSounds.get(currentFlapSound);
      if (currentSound != null) {
        currentSound.trigger(); // .trigger() is better than .play() for short sounds
      }
      
      // Move to next sound in pool
      currentFlapSound = (currentFlapSound + 1) % FLAP_SOUND_COUNT;
    }
  }
  
  /**
   * Play the point scoring sound effect
   */
  void playPoint() {
    if (soundEnabled && pointSound != null) {
      pointSound.trigger();
    }
  }
  
  /**
   * Play the hit/death sound effect
   */
  void playHit() {
    if (soundEnabled && hitSound != null) {
      hitSound.trigger();
    }
  }
  
  /**
   * Start playing background music on loop
   */
  void playBackgroundMusic() {
    if (musicEnabled && backgroundMusic != null && !backgroundMusic.isPlaying()) {
      backgroundMusic.loop();
    }
  }
  
  /**
   * Stop background music
   */
  void stopBackgroundMusic() {
    if (backgroundMusic != null && backgroundMusic.isPlaying()) {
      backgroundMusic.pause();
      backgroundMusic.rewind();
    }
  }
  
  /**
   * Pause background music
   */
  void pauseBackgroundMusic() {
    if (backgroundMusic != null && backgroundMusic.isPlaying()) {
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
    if (backgroundMusic != null) {
      backgroundMusic.setGain(volumeToGain(musicVolume));
    }
  }
  
  /**
   * Set sound effects volume
   * @param volume value between 0.0 and 1.0
   */
  void setSoundVolume(float volume) {
    soundVolume = constrain(volume, 0.0, 1.0);
    float gain = volumeToGain(soundVolume);
    
    // Update all flap sounds
    for (ddf.minim.AudioSample flap : flapSounds) {
      flap.setGain(gain);
    }
    
    // Update other sounds
    if (pointSound != null) pointSound.setGain(gain);
    if (hitSound != null) hitSound.setGain(gain);
  }
  
  /**
   * Clean up resources when the program exits
   */
  void close() {
    // Close all sound objects to free memory
    if (backgroundMusic != null) backgroundMusic.close();
    
    for (ddf.minim.AudioSample flap : flapSounds) {
      if (flap != null) flap.close();
    }
    
    if (pointSound != null) pointSound.close();
    if (hitSound != null) hitSound.close();
    
    // Stop Minim
    minim.stop();
  }
}
