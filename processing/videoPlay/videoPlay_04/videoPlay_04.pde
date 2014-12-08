import processing.video.*;
import processing.serial.*;
import java.util.Date;
import java.text.*;

//// ------------------------------- USER EDITABLE VARIABLES:---------------------------------------------
// DATA variables:
String[] ports = {"COM8","COM10","COM14","COM15","COM16","COM17","COM18","COM19","COM20"};
String testMediaFolder = "C:/crystalChandelier_code/crystalcitychandelier/processing/videoPlay/CONTENT/testingContent/crystalCityChandelier_testSchedule.txt";

// enabled ports - 1 sends on this sketch, 0 does not. used for "multi threading"
int[] ep = {1,1,1,0,0,0,0,0,0}; 

// specifies image dimensions. rows is pixels in x, columns is pixels in y
int rows = 150;
int columns = 72;
int dataChunkSize = 3;

// ART variables:
float maxBright = .75; // max brightness of the pixels. a 0-1 multiplier that happens after rgb data is gathered from the image.

// TIMING Variables;
//int transitionLength = 30; // In seconds

// integer multiplier to control passing of time in epoc mode. 
//Int's are accurate enough since epoc is measuring in absolute milliseconds.
// Set this back to 1 when ready to launch.
int sim_dt_speedMult = 1;

// to simulate a certain date or time set this offset to the appropriate offset in SECONDS. will be a big number. use epoc
// calculator online to calculate epoc for a certain date or refer to the following:
// 31536000 seconds = 1 year
// 2628000 seconds = 1 month
// 604800 seconds = 1 week
// 86400 seconds = 1 day
// 3600 seconds = 1 hour
// 60 seconds = 1 minute
long sim_dt_timeOffset = 694123 - 9000;
//// ---------------------------------------INITIALIZATION VARIABLES:---------------------------------------

// time debug printing init stuff.
boolean captureTime = true;
int frameTimeReportIters = 60;
int frameTimeReportCounter = 0;
int frameTimeCumulativeHolder = 0;
int frameTime_first = 0;
int frameTime_second = 0;
int frameTime_third = 0;
int timeCapture0 = 1;
int timeCapture1 = 2;
int timeCapture2 = 3;
int timeCapture3 = 4;

// This is used to control the flow of rgb data to each of the individual teensy arrays.
int teensyIterator = 0;

// Video / frame init stuff
int totalLedCount = rows*columns;
Movie movie_A;
Movie movie_B;
Spout client;
boolean reLoopVideo = false;
String vidA = "";
String vidB = "";

// animation content data holders
String[] testAnimCollection; // Holds each row from the converted CSV file. each row has start and end epoch times, as well as a media path. start time is currently unused.
String[] pathListMaster; // List of media paths only. derived from testAnimCollection
long[] startTimeMaster; // list of media start times. derived from testAnimCollection
long[] endTimeMaster; // list of media END times. derived from testAnimCollection
int[] transitionsMaster; // list of transition lengths per clip. So if a clip has a 10 second transition length, it will start fading 10 seconds before it's scheduled end time.

// Movie timing vars:
int currentClipNum = 0; // Int specifying which video is playing in the overall playlist.
long timeLeftCurrent = 30; // time left in current animation. Inits only, not set here.
int tweenerValue = 0; // Clamps between 0-255. is calculated from time left current combined with transition length.
float t_normalized = 0; // same as above, however this is a float whic his normalized between 0-1 which cross fades from one animation to another over the course of the transition period.
int transitionLength = 30; // In seconds


// Serial Port Objects - Per Teensy. Created here, instantiated in the setup() method.
Serial teensy_0;
Serial teensy_1;
Serial teensy_2;
Serial teensy_3;
Serial teensy_4;
Serial teensy_5;
Serial teensy_6;
Serial teensy_7;
Serial teensy_8;


// The raw Pixel info is loaded twice, once for each image through out the draw cycle. These arrays hold that raw data so that it can be iterated through later.
color[] pixelArray_A = new int[0];
color[] pixelArray_B = new int[0];

// These match the above arrays, however they hold finalized RGB bit data that will eventually be cross faded between and assigned to the final per teensy byte arrays below..
int[] vals_A = new int[(totalLedCount) * dataChunkSize];
int[] vals_B = new int[(totalLedCount) * dataChunkSize];

// These are the per teensy byte arrays. each teensy that is being used receives it's data over serial from the corresponding array below.
byte[] vals_0 = new byte[(totalLedCount/9) * dataChunkSize];
byte[] vals_1 = new byte[(totalLedCount/9) * dataChunkSize];
byte[] vals_2 = new byte[(totalLedCount/9) * dataChunkSize];
byte[] vals_3 = new byte[(totalLedCount/9) * dataChunkSize];
byte[] vals_4 = new byte[(totalLedCount/9) * dataChunkSize];
byte[] vals_5 = new byte[(totalLedCount/9) * dataChunkSize];
byte[] vals_6 = new byte[(totalLedCount/9) * dataChunkSize];
byte[] vals_7 = new byte[(totalLedCount/9) * dataChunkSize];
byte[] vals_8 = new byte[(totalLedCount/9) * dataChunkSize];

long epochMS = System.currentTimeMillis();
long epoch = System.currentTimeMillis()/1000; // this is set in debug manager - a sort of absolute time in seconds since jan 1970.
int simulatedElapsedMS = 0; 

// Epoc time will be converted back to date time, after a speed multiplier has been applied to quickly
// simulate changing of days / hours / months etc for animation swapping tests.
String simulatedDateTimeFormattedString = ""; // Use this to print date in another format. Easier to parse if needed.

//// ---------------------------------------SETUP:---------------------------------------

public void setup() {
  
  // size and frame rate
  size(rows, columns, P3D);
  frameRate(60);
  
  // Print out all available serial ports
  println(Serial.list());
  
  // Instantiate serial ports per teensy. Only instantiate the teensys which this processing sketch / thread is going to run.
  if(ep[0] == 1){ teensy_0 = new Serial(this, ports[0], 115200); }
  if(ep[1] == 1){ teensy_1 = new Serial(this, ports[1], 115200); }
  if(ep[2] == 1){ teensy_2 = new Serial(this, ports[2], 115200); }
  if(ep[3] == 1){ teensy_3 = new Serial(this, ports[3], 115200); }
  if(ep[4] == 1){ teensy_4 = new Serial(this, ports[4], 115200); }
  if(ep[5] == 1){ teensy_5 = new Serial(this, ports[5], 115200); }
  if(ep[6] == 1){ teensy_6 = new Serial(this, ports[6], 115200); }
  if(ep[7] == 1){ teensy_7 = new Serial(this, ports[7], 115200); }
  if(ep[8] == 1){ teensy_8 = new Serial(this, ports[8], 115200); }
  
  // 1 time function that generates the playlist from the converted csv file and stores data to arrays.
  generatePlaylist(testMediaFolder);
  
  // Obligatory delay. (can't hurt right?)
  delay(500);

  // Initiate the the video sequence objects and set them to loop. 
    movie_A = new Movie(this, pathListMaster[0]);
    movie_B = new Movie(this, pathListMaster[1]);
    movie_A.loop();
    movie_B.loop();
    vidA = pathListMaster[0];
    vidB = pathListMaster[1];
  
  // Initiate the spout video sender. this will be recieved by as many processing sketches as are running.
  client = new Spout();
  client.initSender("spout", width, height);
  
  
}

//// -----------------------------------DRAW-----------------------------------------------
// Draw is simple, since it calls external functions from other tabs.
// updateVideo() is derived from the sketch / tab : videoManager
// writeToLeds() is derived from the sketch / tab : rgb2led
// updateTiming() is derived from the sketch / tab : timingManager
// printDebug() is derived from the sketch / tab : DebugManager
void draw() {
  
  
  updateVideo();

  writeToLeds(ep[0],ep[1],ep[2],ep[3],ep[4],ep[5],ep[6],ep[7],ep[8]);

  updateTiming();

  printDebug();
   
}



