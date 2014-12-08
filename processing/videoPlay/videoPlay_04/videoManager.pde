// updateVideo calls other functions. Manage clipTiming handles video scheduling.
// client.sendTexture() sends the data over Spout.
void updateVideo() {
  
  timeCapture0 = millis();

  manageClipTiming();
  
  client.sendTexture();
  

}

// Generate playlist - one time action that happens in setup()
void generatePlaylist(String dir) {
  
  testAnimCollection = new String[0]; // declare the array to hold the raw data read from the converted CSV file.
  testAnimCollection = loadStrings(dir); // load contents of file into array. 
  
  long[] startTime = new long[testAnimCollection.length]; // Declare animation clip start time array.
  long[] endTime = new long[testAnimCollection.length]; // Declare animation clip end time array.
  String[] pathList = new String[testAnimCollection.length]; // Declare animation clip PATH array.
  int[] transitions = new int[testAnimCollection.length]; // Declare transition length array
  
  // Iterate through test Anim collection and assign items to each slot.
  for (int i = 0; i < testAnimCollection.length; i++){
    println(testAnimCollection[i]);
    pathList[i] = (String)split(testAnimCollection[i],',')[2];
    startTime[i] = Long.parseLong(split(testAnimCollection[i],',')[0]);
    endTime[i] = Long.parseLong(split(testAnimCollection[i],',')[1]);
    transitions[i] = Integer.parseInt(split(testAnimCollection[i],',')[3]);
  
  // Since the above loop worked on local variables, scopy over contents to global variables below.
  pathListMaster = pathList;
  startTimeMaster = startTime;
  endTimeMaster = endTime;
  transitionsMaster = transitions;
  
  // Print all the parsed and ready data.
  println(pathList);
  println("");
  println(startTime);
  println("");
  println(endTime);
  }
}

// Called from videoUpdate
void manageClipTiming() {
  
  // Checks to see if epoch is larger than current clip's end time. If not, do the following...
  if(epoch <= endTimeMaster[currentClipNum]){

    timeLeftCurrent = ((endTimeMaster[currentClipNum]) - (epoch)); // Calcuates time left by subtracting epoch from current clip's end time.
    tweenerValue = constrain((int)timeLeftCurrent, 0, transitionLength); // Calculate tweener value in two steps. this step constrains it from 0, to transition length.
    tweenerValue = (int)map(tweenerValue, transitionLength, 0, 0, 255); // Remap tweener value from 0-255.
    t_normalized = map((float)tweenerValue, 0, 255.0, 0, 1.0); // calculate normalized tweener and assign to new variable. This is used to blend between the pixels.
    
    // Set both clips to Loop...
    if(reLoopVideo == true){
      movie_A.loop();
      movie_B.loop();
      reLoopVideo = false;
    }
  }
  
  // If epoch is larger, than we need to update the clip playing to the next one on the schedule, and doing so will load a new clip end time.
  // The new clip end time will cause the tweener and time left to reset by default, so we need to load video B into A, and load the next video into B.
  else {
    
    print("Clip ");
    print(pathListMaster[currentClipNum]);
    println(" has expired... Switching to new clip:");
    currentClipNum = constrain((currentClipNum+1), 0, testAnimCollection.length-1); // Iterate +1 clip number while keeping it constrained from 0 - maxAnims
    print("LOADED anim: ");
    println(pathListMaster[currentClipNum]);
    print("Set clip to: ");
    println(currentClipNum);
    
    // Shift Movie B into A, and load a new clip for B.
    //movie_A = movie_B;
    movie_A = new Movie(this, pathListMaster[currentClipNum]);
    vidA = pathListMaster[currentClipNum]; // string equivelant of the above, for debug only.
    movie_B = new Movie(this, pathListMaster[constrain(currentClipNum+1, 0, testAnimCollection.length-1)]);
    vidB = pathListMaster[constrain(currentClipNum+1, 0, testAnimCollection.length-1)];
    reLoopVideo = true;
    transitionLength = transitionsMaster[currentClipNum]; // set new transition length.
    
  }
}

// reads new frames of the video every iteration.
void movieEvent(Movie m) {
  if (frameCount > 1) { // this if statememte is neccesary to avoid the error in the beginning of the exeecution.
  m.read();
  }
}


// over-ride exit to release sharing
void exit() {
  // CLOSE THE SPOUT SENDER HERE
  client.closeSender();
  super.exit();
} 
