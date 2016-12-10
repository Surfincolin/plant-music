/// Touch start continually monitors the touch inputs
/// checking differences in data and monitoring idle times.

class Touch_State {
  
  int indexBuffer = 5;
  int valueBuffer = 25; // depends on how sensitive you want it...
  
  Boolean active = true; // true represents activity
  
  // idle timeout in seconds
  int idleTimeout = 10;
  int idle = 0;
  int timeCheck;
  
  float[][] touchesCheck = {{0,0},{0,0},{0,0}, {0,0}};
  
  Touch_State() {
    timeCheck = millis();
  };
  
  void monitorTouches(float[][] touches) {
    // if activity on the sensors
    if ( activity(touches) ) {
      setTouchCheck(touches);
      timeCheck = millis();
      idle = 0;
      if (!active) {
        active = true;
        // message system of state change
        //println("system became active");
        onActive();
      }
    } else {
      idle = (millis() - timeCheck) / 1000;
      if (idle > idleTimeout && active ) {
        // switch to idle
        active = false;
        // message system of idle change
        //println("system became idle");
        onIdle();
      }
    }
    
  }
  
  boolean activity(float[][] newTouches) {
    boolean action = false;
    for (int i = 0; i < newTouches.length; i++) {
      if (abs(newTouches[i][0] - touchesCheck[i][0]) >= indexBuffer) {
        action = true;
        break;
      };
      if (abs(newTouches[i][1] - touchesCheck[i][1]) >= valueBuffer) {
        action = true;
        break;
      }; 
    }
    return action;    
  }
  
  void setTouchCheck(float[][] touches) {
    for (int i = 0; i < touches.length; i++) {
      System.arraycopy(touches[i], 0, touchesCheck[i], 0, touches[0].length);
    }
  }
}