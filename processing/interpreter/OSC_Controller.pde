
import oscP5.*;  // download library here: http://www.sojamo.de/libraries/oscP5/
import netP5.*;

int sendPort = 9000;
int note = 60;
int count = 0;

class OSC_Controller {

  OSC_Controller() {};
  
  //OscP5 oscP5;

  //NetAddress myRemoteLocation = new NetAddress("192.168.0.31", sendPort);
  NetAddress myLocalLocation = new NetAddress("127.0.0.1", sendPort);
  
  /* start oscP5, listening for incoming messages at port 13000; use this if you ever to listen for OSC messages */
  OscP5 oscP5 = new OscP5(this, 8000);

  float s = 0;

  void toPD(int touch, float[] touchValues) {  
    String path = "";
    
    switch(touch) {
      case 0:
        path = "/forPD/plant1";
        break;
      case 1:
        path = "/forPD/plant2";
        break;
      case 2:
        path = "/forPD/plant3";
        break;
      case 3:
        path = "/forPD/plant4";
        break;
    }
    
    sendOSC((int)touchValues[0], (int)touchValues[1], path);

  }
  
  void toState(int state) {
    sendOSC(0, state, "/forState");
  }

  void sendOSC(int i, int note, String path) {
    OscMessage myMessage = new OscMessage(path);
    myMessage.add(i);
    myMessage.add(note);
    
    //oscP5.send(myMessage, myRemoteLocation);
    oscP5.send(myMessage, myLocalLocation);
  }

}