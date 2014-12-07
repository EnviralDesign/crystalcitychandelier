

void printDebug() {
  
  // If capture time is true, we print out our debug info. set captureTime to false above once script is ready to go into performance mode.
  if(captureTime){
    frameTimeCumulativeHolder += (timeCapture3 - timeCapture0);
    frameTime_first += (timeCapture1 - timeCapture0);
    frameTime_second += (timeCapture2 - timeCapture1);
    frameTime_third += (timeCapture3 - timeCapture2);
    if(frameTimeReportCounter <= 0){
      frameTimeReportCounter = frameTimeReportIters;
      println("");
      println("");
      println("");
      print("Cooktime for 60 Frames: ");
      println(frameTimeCumulativeHolder);
      print("Cooktime for single Frame: ");
      println(frameTimeCumulativeHolder / frameTimeReportIters);
      if((frameTimeCumulativeHolder / frameTimeReportIters) != 0){
        print("--FPS--: ");
        println(1000/(frameTimeCumulativeHolder / frameTimeReportIters));        
      }
      println("-----------------");
      print("Video Processing: ");
      print(String.format("%.1f", ((float)frameTime_first / (float)frameTimeCumulativeHolder) * 100));
      println(" %");
      print("Pixel Access: ");
      print(String.format("%.1f", ((float)frameTime_second / (float)frameTimeCumulativeHolder) * 100));
      println(" %");
      print("Serial Send: ");
      print(String.format("%.1f", ((float)frameTime_third / (float)frameTimeCumulativeHolder) * 100));
      print(" % - Serial time in ms:"); 
      println(timeCapture3 - timeCapture2);
      println("----------------------------");
      println("--Realtime Date Info--");
      print("Year: ");
      print(y);
      print(", Month: ");
      print(mo);
      print(", Day: ");
      print(d);
      print(", Hour: ");
      print(h);
      print(", Minute: ");
      print(mi);
      print(", Second: ");
      println(s);
      println("--Simulated Date Info--");
      print("Time since Epoch: ");
      println(epoch);
      println(new Date( epoch * 1000 ));
      println(simulatedDateTimeFormattedString);
      println("---Video timing info---");
      print("Seconds left on current clip: ");
      println(currentClipDuration / 1000);
      
      
      
      frameTimeCumulativeHolder = 0;
      frameTime_first = 0;
      frameTime_second = 0;
      frameTime_third = 0;
    }
  frameTimeReportCounter -= 1;
  }
  
}

