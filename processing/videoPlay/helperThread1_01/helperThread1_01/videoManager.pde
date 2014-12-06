void updateVideo() {
  // Capturing time 0 for frame rate calculation..
  if(captureTime){
    timeCapture0 = millis();
  }
  img = receiver.receiveTexture(img);
  image(img, 0, 0, width, height);
  loadPixels();
}

void exit() {
  // CLOSE THE SPOUT RECEIVER HERE
  receiver.closeReceiver();
  super.exit();
} 
