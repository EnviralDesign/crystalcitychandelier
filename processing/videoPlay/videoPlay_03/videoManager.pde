void updateVideo() {
  // Capturing time 0 for frame rate calculation..
  //if(captureTime){
    timeCapture0 = millis();
  //}
  // place movie file on canvas (must happen every frame, small method below controls playback)
  image(myMovie, 0, 0);
  loadPixels(); // Load canvas pixels into pixel array / memory.
  
  client.sendTexture();
  

}

void loadNextClip (String movieFolder) {
  print("LOADED anim from folder: ");
  println(movieFolder);
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
