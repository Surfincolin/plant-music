
import processing.serial.*;

// for port setup
int SerialPortNumber=2;
int PortSelected=1;

int midiMax = 127;
int midiMin = 0;

float[][] Touches = {{0,0},{0,0},{0,0},{0,0}};

Serial myPort;

OSC_Controller osc;

Touch_State state;
  
//JSONObject setting;

void setup() {
  
  //json = new JSONObject();
  
  //for (int i = 0; i < Touches.length; i++) {
    
  //}

  //json.setInt("id", 0);
  //json.setString("species", "Panthera leo");
  //json.setString("name", "Lion");

  //saveJSONObject(json, "data/new.json");
  
  String portName = Serial.list()[PortSelected];
  myPort = new Serial(this, portName, 19200); // Setup port with baudrate
  delay(50);
  myPort.clear();
  //myPort.buffer(20);
  
  osc = new OSC_Controller();
  state = new Touch_State();
  
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
    //Touches[touchNum] = (float(rawValue)-600)/220;
  }
}

float[] getControlTouch(int touch) {
    // limit to midi lows and highs
    //int val = min(int(Touches[touch][1]/1000*0.8 * midiMax), midiMax );
    //val = max(val, midiMin );
    //return val;
    return Touches[touch];
}

void printControl(int touch) {
  String s = "Touch " + touch + ": " + getControlTouch(touch);
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
  //printControl(0);
  //printAllControls();
  
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