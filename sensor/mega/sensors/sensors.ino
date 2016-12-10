// Arduino Mega adaptation of Touche Arduino DIY...

// Bitwise functions
#define SET(x,y) (x |=(1<<y))        //-Bit set/clear macros
#define CLR(x,y) (x &= (~(1<<y)))           // |
#define CHK(x,y) (x & (1<<y))               // |
#define TOG(x,y) (x^=(1<<y))                //-+

#define N 160  //How many frequencies

// Only one result buffer can be keep due to size constraints.
float results[N];         //-Filtered result buffer
float resultsB[N];         //-Filtered result buffer
float freq[N];            //-Filtered result buffer
float freqB[N];            //-Filtered result buffer
int sizeOfArray = N;

void setup()
{

// Timers 1, 3,4,5 are 16bit on the Mega while Timer 1 is on the uno.
// Uno Timer 1 pins(9,10)
// Mega Timer 1 pins(11,12), Timer 3 pins(2,3,5), Timer 4 pins(6,7,8), Timer 5 pins(44,45,46)

// TCNTx - Timer/Counter Register. The actual timer value is stored here.
// OCRx - Output Compare Register
// ICRx - Input Capture Register (only for 16bit timer)
// TIMSKx - Timer/Counter Interrupt Mask Register. To enable/disable timer interrupts.
// TIFRx - Timer/Counter Interrupt Flag Register. Indicates a pending timer interrupt.

// TCCR 	7			 6		  5		   4		  3		  2		 1		 0
// 0x80	 COM1A1 COM1A0 COM1B1 COM1B0 -     -    WGM11 WGM10 : TCCRnA
// 0x81	 ICNC1  ICES1  -      WGM13  WGM12 CS12 CS11  CS10  : TCCRnB
// 				1			0				0			0				0			0			1			0
//				0			0				0			1				1			0			0			1 
// Fast PWM ICR1, Clear OC1 on compare match, no prescaler

  
  // PLANT SENSOR 1
  TCCR3A=0b10000010;        //-Set up frequency generator
  TCCR3B=0b00011001;        //-+
  ICR3=110; 
  OCR3A=55;

  pinMode(5,OUTPUT);        //-Signal generator pin
//  pinMode(7,OUTPUT);        //-Signal generator pin
//  pinMode(8,OUTPUT);        //-Signal generator pin
  // pinMode(8,OUTPUT);        //-Sync (test) pin

  // PLANT SENSOR 2
//  TCCR3A=0b10000010;        //-Set up frequency generator
//  TCCR3B=0b00011001;        //-+
//  ICR3=110;
//  OCR3A=55;

//  pinMode(2,OUTPUT);        //-Signal generator pin
//  pinMode(3,OUTPUT);        //-Signal generator pin
//  pinMode(5,OUTPUT);        //-Signal generator pin


  Serial.begin(115200);     // baudrate

  for(int i=0;i<N;i++) {      //-Preset results
    results[i]=0;        		 //-+
//    resultsB[i]=0;        		 //-+
  }
  
}

void loop()
{
  unsigned int d;

  // PLANT SENSOR 1
  for(unsigned int d=0;d<N;d++)
  {
    unsigned int dB = d;
    int v=analogRead(0);    //-Read response signal
//    Serial.println(d);
    CLR(TCCR3B,0);          //-Stop generator
    
    
    TCNT3=0;                //-Reload new frequency
    
    ICR3= d;                 // |
    
    OCR3A=d/2;              //-+
    
    SET(TCCR3B,0);          //-Restart generator
//    delayMicroseconds(500);
//    delay(50);

    results[d]=results[d]*0.5+(float)(v)*0.5; //Filter results
//  results[d] = (float)(v);
    
   
    freq[d] = d;

//    int vB=analogRead(4);    //-Read response signal
//    CLR(TCCR3B,0);          //-Stop generator
//    TCNT3=0;                //-Reload new frequency
//    ICR3=dB;                 // |
//    OCR3A=dB/2;              //-+
//    SET(TCCR3B,0);          //-Restart generator
//
//    resultsB[dB]=resultsB[dB]*0.5+(float)(vB)*0.5; //Filter results
//    
//    freqB[dB] = dB;
  }


PlottArray(1,freq,results);
//PlottArray(4,freqB,resultsB);

// TOG(PORTB,0);            //-Toggle pin 8 after each sweep (good for scope)

//// PLANT SENSOR 1
//  for(unsigned int d=0;d<N;d++)
//  {
//    int v=analogRead(0);    //-Read response signal
//    CLR(TCCR1B,0);          //-Stop generator
//    TCNT1=0;                //-Reload new frequency
//    ICR1=d;                 // |
//    OCR1A=d/2;              //-+
//    SET(TCCR1B,0);          //-Restart generator
//
//    results[d]=results[d]*0.5+(float)(v)*0.5; //Filter results
//   
//    freq[d] = d;
//  }
//
//
//PlottArray(1,freq,results);
//
//// PLANT SENSOR 2
//  for(unsigned int d=0;d<N;d++)
//  {
//    int v=analogRead(1);    //-Read response signal
//    CLR(TCCR3B,0);          //-Stop generator
//    TCNT3=0;                //-Reload new frequency
//    ICR3=d;                 // |
//    OCR3A=d/2;              //-+
//    SET(TCCR3B,0);          //-Restart generator
//
//    resultsB[d]=resultsB[d]*0.5+(float)(v)*0.5; //Filter results
//   
//     freqB[d] = d;
//  }
//
//
//PlottArray(4,freqB,resultsB);
//
//// TOG(PORTB,0);            //-Toggle pin 8 after each sweep (good for scope)

}
   

   
    
 
