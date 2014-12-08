void updateVideo() {
  // Capturing time 0 for frame rate calculation..
  //if(captureTime){
    timeCapture0 = millis();
  //}

  //videoTween();
  
  loadPixels(); // Load canvas pixels into pixel array / memory.
  
  client.sendTexture();
  

}

void loadNextClip (String movieFolder) {
  print("LOADED anim from folder: ");
  println(movieFolder);
  movie_B = movie_A;
  movie_A = new Movie(this, "disturbingPlanes.mov");
  
  movie_B.loop();
  movie_A.loop();
  
//println(list[0]);
  
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

void videoTween() {
  // place movie file on canvas (must happen every frame, small method below controls playback)
  image(movie_A, 0, 0);
  tint(255, 128);
  image(movie_B, 0, 0);
}
/*
void generateNewPlaylist(String dir) {
  long seed = System.nanoTime();
  println(testAnimCollection.length);
  for(int path = 0; path < testAnimCollection.length; path++){
    testAnimCollection[path] = testMediaFolder + testAnimCollection[path];
    println(testAnimCollection[path]);
  }
  println("");
  shuffleArray(testAnimCollection);
  for(int path = 0; path < testAnimCollection.length; path++){
    println(testAnimCollection[path]);
  }
}
*/


void generatePlaylist(String dir) {
  
  testAnimCollection = new String[0];
  pathList = new String[0];
  startTime = new int[0];
  endTime = new int[0];
  
  testAnimCollection = loadStrings(dir);
  //println(testAnimCollection);
  for (int i = 0; i < testAnimCollection.length; i++){
    //println((String)split(testAnimCollection[i],',')[2]);
    //tmpStr = (String)split(testAnimCollection[i],',')[2];
    pathList = append(pathList, (String)split(testAnimCollection[i],',')[2]);
    startTime = append(startTime, Integer.parseInt(split(testAnimCollection[i],',')[1]));
    endTime = append(endTime, Integer.parseInt(split(testAnimCollection[i],',')[0]));
  }
  /*
  println(pathList);
  println("");
  println(startTime);
  println("");
  println(endTime);
  */
}

/*
// Implementing Fisher–Yates shuffle
static void shuffleArray(String[] ar)
{
  Random rnd = new Random();
  for (int i = ar.length - 1; i > 0; i--)
  {
    int index = rnd.nextInt(i + 1);
    // Simple swap
    String a = ar[index];
    ar[index] = ar[i];
    ar[i] = a;
  }
}
*/
// over-ride exit to release sharing
void exit() {
  // CLOSE THE SPOUT SENDER HERE
  client.closeSender();
  super.exit();
} 
