

void printDebug() {

  // If capture time is true, we print out our debug info. set captureTime to false above once script is ready to go into performance mode.
  if (captureTime) { // we capture time before and after some of the more intensive actions in the sketch so that they can be analyzed.
   

    frameTimeCumulativeHolder += (timeCapture3 - timeCapture0);
    frameTime_first += (timeCapture1 - timeCapture0);
    
    frameTime_second += (timeCapture2 - timeCapture1);
    frameTime_third += (timeCapture3 - timeCapture2);
    
    if (frameTimeReportCounter <= 0) { // we iterate this var down 1 value each loop and when it reaches 0 or less we print. This reduces the load from continuous print statements.
      frameTimeReportCounter = frameTimeReportIters;
      println("");
      println(""); // make some space from the last update.
      println("");
      println("-----------Video timing info-----------");
      print("     Cooktime: ");
      print(frameTimeCumulativeHolder / frameTimeReportIters);
      if ((frameTimeCumulativeHolder / frameTimeReportIters) != 0) { // if this if statement is not here, we might get a divide by 0 error which is bad. we check for this first.
        print("             --  FPS: ");
        println(1000/(frameTimeCumulativeHolder / frameTimeReportIters));
      }
      print("Video Processing: ");
      print(String.format("%.1f", ((float)frameTime_first / (float)frameTimeCumulativeHolder) * 100));
      println(" %");
      print("    Pixel Access: ");
      print(String.format("%.1f", ((float)frameTime_second / (float)frameTimeCumulativeHolder) * 100));
      println(" %");
      print("     Serial Send: ");
      print(String.format("%.1f", ((float)frameTime_third / (float)frameTimeCumulativeHolder) * 100));
      print(" %      --  Serial time in ms:"); 
      println(timeCapture3 - timeCapture2);
      println("");
      println("----------Simulated Date Info----------");
      print("Time since Epoch: ");
      print(epoch);
      print("  --  ");
      println(new Date( epoch * 1000 ));
      println("");
      println("-----------Clip transition info-----------");
      print("   Next End Time: ");
      print(endTimeMaster[currentClipNum]);
      print("  --  seconds till next: ");
      println(timeLeftCurrent);
      print("Clip: ");
      print(currentClipNum);
      print("  - Tween: ");
      print((int)tweenerValue);
      print("  ");
      print("            Tweener normalized: ");
      println(t_normalized);
      print("Clip A: ");
      println(vidA);
      print("Clip B: ");
      println(vidB);




      frameTimeCumulativeHolder = 0;
      frameTime_first = 0;
      frameTime_second = 0;
      frameTime_third = 0;
    }
    
    
    frameTimeReportCounter -= 1;
    
  }
}

