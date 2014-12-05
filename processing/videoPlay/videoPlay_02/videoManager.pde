void updateVideo() {
  // Capturing time 0 for frame rate calculation..
  if(captureTime){
    timeCapture0 = millis();
  }
  // place movie file on canvas (must happen every frame, small method below controls playback)
  image(myMovie, 0, 0);
  loadPixels(); // Load canvas pixels into pixel array / memory.
}


// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

