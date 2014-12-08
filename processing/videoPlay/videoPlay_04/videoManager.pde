void updateVideo() {
    timeCapture0 = millis();

  manageClipTiming();
  
  //loadPixels(); // Load canvas pixels into pixel array / memory.
  
  client.sendTexture();

}


void generatePlaylist(String dir) {
  
  testAnimCollection = new String[0];
  //pathList = new String[0];
  //startTime = new long[0];
  //endTime = new long[0];
  testAnimCollection = loadStrings(dir);
  println(testAnimCollection);
  long[] startTime = new long[testAnimCollection.length];
  long[] endTime = new long[testAnimCollection.length];
  String[] pathList = new String[testAnimCollection.length];
  for (int i = 0; i < testAnimCollection.length; i++){
    pathList[i] = (String)split(testAnimCollection[i],',')[2];
    startTime[i] = Long.parseLong(split(testAnimCollection[i],',')[0]);
    endTime[i] = Long.parseLong(split(testAnimCollection[i],',')[1]);
  }
  pathListMaster = pathList;
  startTimeMaster = startTime;
  endTimeMaster = endTime;
  
  println(pathList);
  println("");
  println(startTime);
  println("");
  println(endTime);
  
}


void manageClipTiming() {
  
    //println(  (endTimeMaster[currentClipNum]) );
    //println(  (epoch) );
  
  if(epoch <= endTimeMaster[currentClipNum]){
    //println("Clip not expired...");
    
    //println( ((float)endTimeMaster[currentClipNum]) /1000 );
    //println( ((float)epoch)/1000 );

    timeLeftCurrent = ((endTimeMaster[currentClipNum]) - (epoch));
    tweenerValue = constrain((int)timeLeftCurrent, 0, transitionLength);
    tweenerValue = (int)map(tweenerValue, transitionLength, 0, 0, 255);
    t_normalized = map((float)tweenerValue, 0, 255.0, 0, 1.0);
  }
  
  else {
    print(endTimeMaster[currentClipNum]);
    print(" end time - was expired against epoch time: ");
    println(epoch);
    currentClipNum = constrain((currentClipNum+1), 0, testAnimCollection.length-1);
    print("LOADED anim: ");
    println(pathListMaster[currentClipNum]);
    movie_B = movie_A;
    movie_A = new Movie(this, pathListMaster[currentClipNum]);
    movie_B.loop();
    movie_A.loop();
    
  }
  
}


/*
void videoTween() {
  // place movie file on canvas (must happen every frame, small method below controls playback)
  //tint(255, 255, 255, 1);
  //background(movie_A);
  image(movie_A, 0, 0);
  
  //tweenerValue
  image(movie_B, 0, 0);
  
}
*/

long mylong(String a)
{
  return Long.parseLong(a);
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}


// over-ride exit to release sharing
void exit() {
  // CLOSE THE SPOUT SENDER HERE
  client.closeSender();
  super.exit();
} 
