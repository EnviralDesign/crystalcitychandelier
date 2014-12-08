void updateTiming() {
  
  //if(captureTime){
    timeCapture3 = millis();
  //}
  
  s = second();  // Values from 0 - 59
  mi = minute();  // Values from 0 - 59
  h = hour();    // Values from 0 - 23
  d = day();    // Values from 1 - 31
  mo = month();  // Values from 1 - 12
  y = year();   // 2003, 2004, 2005, etc.
  
  //If epoch is used in the final script, be sure to use the following line rather than the below method for calculating epoch.
  //epoch = System.currentTimeMillis()/1000;
  
  
  // Here Epoch is being updated with the time it took the frame to complete. this isn't as accurate but allows
  // the speed to be adjusted to simulate faster passage of time as well as offfsets.
  //
  // Note : when the sketch is started simulated time will be the same as real time, but will move forwards
  // at the speed of the multiplier from there.
  simulatedElapsedMS = ((timeCapture3 - timeCapture0) * sim_dt_speedMult);
  epochMS += simulatedElapsedMS; // total frame time * speed multiplier. - in milliseconds
  epoch = (epochMS / 1000) + sim_dt_timeOffset; // epoch converted to seconds + time offset in seconds.
  
  
  DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss"); // create string format for printing date. could be parsed if needed.
  simulatedDateTimeFormattedString = df.format(new Date( epoch * 1000 )); // format new simulated date after converting back to milliseconds (how java needs epoch to calculate proper date/time)
  
  // ------------------------ anim clip timing and fade management --------------------------
  
  /*
  // if clip timer runs down to zero or less, randomly generate new timing for the next clip, and swap clips.
  if(currentClipDuration >= 0){
    currentClipDuration -= simulatedElapsedMS;
  }
  else {
    generateTimingForNextClip(minAnimDuration, maxAnimDuration);
    loadNextClip("asd random movie folder");
  }
  */
  
}


/*
void generateTimingForNextClip(int minTime, int maxTime) {
  currentClipDuration = (int) random(minTime, maxTime) * 60 * 1000;
}
*/

