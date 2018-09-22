import processing.sound.*;  // install Sound library

class Test_Sound {
  
  Sound s;

  Test_Sound(PApplet parent) {
    
    // Play two sine oscillators with slightly different frequencies for a nice "beat".
    SinOsc sin = new SinOsc(parent);
    sin.play(360, 0.3);
    sin = new SinOsc(parent);
    sin.play(365, 0.3);
  
    // Create a Sound object for globally controlling the output volume.
    s = new Sound(parent);
    
  }
  
  // Plays a test sound wave based on the value and the high and low limits.
  void playSound( float value, float filterLow, float filterHigh) {
    float amplitude = map(value, filterLow, filterHigh, 0.0, 1.0);
    
    amplitude = min(1.0, amplitude);
    amplitude = max(0.0, amplitude);

    println("Test Sound: " + value + " -> " + amplitude);
    
    // Instead of setting the volume for every oscillator individually, we can just
    // control the overall output volume of the whole Sound library.
    s.volume(amplitude);

  }
  
}
