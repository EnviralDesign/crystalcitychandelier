import processing.video.*;
import processing.serial.*;

//// --- USER EDITABLE VARIABLES: ---
// Data variables:
String[] ports = {"COM8","COM10","COM14","COM15","COM16","COM17","COM18","COM19","COM20"};
String spout_helperThread0 = "helperThread_0";

int rows = 150;
int columns = 72;
int dataChunkSize = 3;

// Art variables:
float maxBright = .5;
//// ------------------------------------------------------------------------------------------------------

//// --- INITIALIZATION VARIABLES: ---

int totalLedCount = rows*columns;
Movie myMovie;

boolean captureTime = true;
int frameTimeReportIters = 60;
int frameTimeReportCounter = 0;
int frameTimeCumulativeHolder = 0;
int frameTime_first = 0;
int frameTime_second = 0;
int frameTime_third = 0;
int obligatoryDelay = 2;
int timeCapture0;
int timeCapture1;
int timeCapture2;
int timeCapture3;

int teensyIterator = 0;

// Serial Objects - Per Teensy
Serial teensy_0;
Serial teensy_1;
Serial teensy_2;
Serial teensy_3;
Serial teensy_4;
Serial teensy_5;
Serial teensy_6;
Serial teensy_7;
Serial teensy_8;

// Teensy rgb byte arrays - per teensy
byte[] vals_0 = new byte[(totalLedCount/9) * dataChunkSize];
byte[] vals_1 = new byte[(totalLedCount/9) * dataChunkSize];
byte[] vals_2 = new byte[(totalLedCount/9) * dataChunkSize];
byte[] vals_3 = new byte[(totalLedCount/9) * dataChunkSize];
byte[] vals_4 = new byte[(totalLedCount/9) * dataChunkSize];
byte[] vals_5 = new byte[(totalLedCount/9) * dataChunkSize];
byte[] vals_6 = new byte[(totalLedCount/9) * dataChunkSize];
byte[] vals_7 = new byte[(totalLedCount/9) * dataChunkSize];
byte[] vals_8 = new byte[(totalLedCount/9) * dataChunkSize];

// date and time init vars:
int s = second();  // Values from 0 - 59
int mi = minute();  // Values from 0 - 59
int h = hour();    // Values from 0 - 23
int d = day();    // Values from 1 - 31
int mo = month();  // Values from 1 - 12
int y = year();   // 2003, 2004, 2005, etc.

long epoch = 0;

//// -----------------------------------------------------------------------------------------------------

public void setup() {
  
  // size and frame rate
  size(rows, columns);
  frameRate(30);
  
  // Print out all available serial ports
  println(Serial.list());
  
  // Instantiate serial ports per teensy
  teensy_0 = new Serial(this, ports[0], 115200);
  teensy_1 = new Serial(this, ports[1], 115200);
  teensy_2 = new Serial(this, ports[2], 115200);
  teensy_3 = new Serial(this, ports[3], 115200);
  teensy_4 = new Serial(this, ports[4], 115200);
  teensy_5 = new Serial(this, ports[5], 115200);
  teensy_6 = new Serial(this, ports[6], 115200);
  teensy_7 = new Serial(this, ports[7], 115200);
  teensy_8 = new Serial(this, ports[8], 115200);
  
  delay(500);

  // Initiate the the video sequence 
  myMovie = new Movie(this, "simpleRamp.mov");
  myMovie.loop();
  
}

//// -----------------------------------------------------------------------------------------------------

void draw() {
  
  updateVideo();

  writeToLeds();

  printDebug();
}


