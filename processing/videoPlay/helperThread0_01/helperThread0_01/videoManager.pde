void updateVideo() {
  // Capturing time 0 for frame rate calculation..
  if(captureTime){
    timeCapture0 = millis();
  }
  img = client0.receiveTexture(img);
  image(img, 0, 0, width, height);
  loadPixels();
}
