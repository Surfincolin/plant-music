#include <SweepingCap.h>
#include <Touch.h>

//SweepingCap Object
//set the timer and number of frequencies to sweep
//timer 1 on mega controls DigitalPin 11 - but also affects Pin12
//SweepingCap cap(1, 120);
SweepingCap cap( 120); 

//Touch Object
Touch touch(0); //set the analog pin for reading
Touch touchB(1); //set the analog pin for reading
Touch touchC(2); //set the analog pin for reading
Touch touchD(3); //set the analog pin for reading

void setup()
{
//  Serial.begin(9600);
  Serial.begin(19200);
  cap.setup();
  
}

void loop()
{
  touch.reset();
  touchB.reset();
  touchC.reset();
//  touchD.reset();
  for(int i = 0; i < cap.getNumFrequencies(); i++)
  {
    touch.readPin();
    touchB.readPin();
    touchC.readPin();
//    touchD.readPin();
    cap.sweep(i);
    delayMicroseconds(1);
    
    touch.setResults(i, touch.getResults(i)*0.5+(float)(touch.getValue()*0.5));
    touchB.setResults(i, touchB.getResults(i)*0.5+(float)(touchB.getValue()*0.5));
    touchC.setResults(i, touchC.getResults(i)*0.5+(float)(touchC.getValue()*0.5));
//    touchD.setResults(i, touchD.getResults(i)*0.5+(float)(touchD.getValue()*0.5));
    
    if(touch.getTopValue() < touch.getResults(i))
    {
      touch.setTopValue(touch.getResults(i));
      touch.setTopPoint(i);  
    }
    if(touchB.getTopValue() < touchB.getResults(i))
    {
      touchB.setTopValue(touchB.getResults(i));
      touchB.setTopPoint(i);  
    }
    if(touchC.getTopValue() < touchC.getResults(i))
    {
      touchC.setTopValue(touchC.getResults(i));
      touchC.setTopPoint(i);  
    }
//    if(touchD.getTopValue() < touchD.getResults(i))
//    {
//      touchD.setTopValue(touchD.getResults(i));
//      touchD.setTopPoint(i);  
//    }
  }     
    Serial.print( touch.getTopPoint() );
    Serial.print( "\t" );
    Serial.print( touch.interpolate() );
    Serial.print( "  |  " );
    Serial.print( touchB.getTopPoint() );
    Serial.print( "\t" );
    Serial.print( touchB.interpolate() );
    Serial.print( "  |  " );
    Serial.print( touchC.getTopPoint() );
    Serial.print( "\t" );
    Serial.print( touchC.interpolate() );
//    Serial.print( "  |  " );
//    Serial.print( touchD.getTopPoint() );
//    Serial.print( "\t" );
//    Serial.print( touchD.interpolate() );
    Serial.print("\n");
}
