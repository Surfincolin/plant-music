import processing.serial.*;

private static final boolean DEBUG = false;
private static final boolean TEST_MODE = false;
private static final int TEST_PLANT = 1; // 1, 2, 3, 4

// Serial Port Selection
// MacBookPro: 3 / Windows: 0 (Typically)
int PortSelected=3;

// TODO: Clean and move to Touch_State
// Nested Array for storing latest touch data
float[][] Touches = {{0,0},{0,0},{0,0},{0,0}};

Serial myPort;
OSC_Controller osc;
Touch_State state;

// For testing idividual plants
Test_Sound testSound;

void setup() {
  
  // If the PortSelected doesn't work, look through the list and find the matching port.
  println(Serial.list());
  
  // Serial Port Setup
  String portName = Serial.list()[PortSelected];
  myPort = new Serial(this, portName, 19200); // Setup port with baudrate
  delay(50);
  myPort.clear(); // Clear out any old buffer data
  
  // OSC Setup - OSC is read by pure-data app
  osc = new OSC_Controller();
  
  // Touch Data Setup
  state = new Touch_State();
  
  if (TEST_MODE) {
    // Test Sound Setup, passing in the app PApplet
    testSound = new Test_Sound(this);
  }
  
}

void monitorSerialPort() {
  String serialValue = null;
  
  if ( myPort.available() > 0) {  // If data is available, 
    serialValue = myPort.readStringUntil('\n');  // read it and store it in val   
  } 
  
  if (serialValue != null) {
    handleSerialMessage(serialValue);
  }
  
}

void handleSerialMessage(String message) { 
  String[] touchString = split(message, "  |  ");
  
  for (int i = 0; i < touchString.length;i++) {
    String curTouch = touchString[i];
    
    String[] tStr = split(curTouch, "\t");
    
    if (tStr.length > 1) {
      float[] values = { float(tStr[0]), float(tStr[1]) };
      updateTouchValue(i, values );
    }
  }
  
}

void updateTouchValue(int touchNum,float[] touchValues) {
  if (touchNum < Touches.length) {
    Touches[touchNum][0] = touchValues[0]; // touch top value position
    Touches[touchNum][1] = touchValues[1]; // touch top value
  }
}

float[] getControlTouch(int touch) {
    return Touches[touch];
}

void printControl(int touch) {
  float[] data = getControlTouch(touch);
  String s = "Touch " + touch + ": " + data[0] + " - " + data[1];
  println(s);    
}

void printAllControls() {
  String s = "";
  for (float[] t : Touches) {
    s = s + "t: " + t[0] + ", " + t[1] + " | ";
  }
  println(s);
}

void onActive() {
  println("touch is active");
  osc.toState(1);
}

void onIdle() {
  println("touch is idle");
  osc.toState(0);
}

void draw() {
  
  monitorSerialPort();
  state.monitorTouches(Touches);
  
  if (DEBUG) {
    printAllControls();
  } else if (TEST_MODE) {
    printControl(TEST_PLANT - 1);
    // Play test sound limiting the filter frequency with a low and high.
    testSound.playSound(getControlTouch(TEST_PLANT-1)[1], 590, 650); 
  }   
  
  osc.toPD(0, getControlTouch(0) );
  osc.toPD(1, getControlTouch(1) );
  osc.toPD(2, getControlTouch(2) );
  osc.toPD(3, getControlTouch(3) );

}

void stop()
{
  myPort.stop();
  myPort = null;
  super.stop();
}
