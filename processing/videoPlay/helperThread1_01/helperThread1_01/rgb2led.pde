void writeToLeds(int t0, int t1, int t2, int t3, int t4, int t5, int t6, int t7, int t8) {
  
  // Capturing time 1 for frame rate calculation..
  if(captureTime){
    timeCapture1 = millis();
  }
  
  // iterate through all pixels in pixel array
  for(int pix = 0; pix < (width*height); pix++){
   
   // grab pixel color from array and assign to c - color variable.
    color c = pixels[pix];
    
    // Using bit shifting, split values into rgb 0-255 
    int r = (int) (((c >> 16) & 0xFF) * maxBright);
    int g = (int) (((c >> 8) & 0xFF) * maxBright);
    int b = (int) ((c & 0xFF) * maxBright);
    
    // teensyIterator rounds down to the teensy number currently being worked on. this is generated by dividing by 1200, the total number of led's per teensy.
    teensyIterator = pix / 1200;
    
    // Based on teensyIterator, we assign r/g/b values from the pixel array to the corresponding rgb values array.
    // (1200 * teensyIterator) keeps the value array from going out of bounds, while the parent for loop is pulling the appropriate color values from the pixel array.
    if(teensyIterator == 0){
      vals_0[(pix - (1200 * teensyIterator))*dataChunkSize] = (byte) r;
      vals_0[(pix - (1200 * teensyIterator))*dataChunkSize+1] = (byte) g;
      vals_0[(pix - (1200 * teensyIterator))*dataChunkSize+2] = (byte) b;
    }
    else if(teensyIterator == 1){
      vals_1[(pix - (1200 * teensyIterator))*dataChunkSize] = (byte) r;
      vals_1[(pix - (1200 * teensyIterator))*dataChunkSize+1] = (byte) g;
      vals_1[(pix - (1200 * teensyIterator))*dataChunkSize+2] = (byte) b;
    }
    else if(teensyIterator == 2){
      vals_2[(pix - (1200 * teensyIterator))*dataChunkSize] = (byte) r;
      vals_2[(pix - (1200 * teensyIterator))*dataChunkSize+1] = (byte) g;
      vals_2[(pix - (1200 * teensyIterator))*dataChunkSize+2] = (byte) b;
    }
    else if(teensyIterator == 3){
      vals_3[(pix - (1200 * teensyIterator))*dataChunkSize] = (byte) r;
      vals_3[(pix - (1200 * teensyIterator))*dataChunkSize+1] = (byte) g;
      vals_3[(pix - (1200 * teensyIterator))*dataChunkSize+2] = (byte) b;
    }
    else if(teensyIterator == 4){
      vals_4[(pix - (1200 * teensyIterator))*dataChunkSize] = (byte) r;
      vals_4[(pix - (1200 * teensyIterator))*dataChunkSize+1] = (byte) g;
      vals_4[(pix - (1200 * teensyIterator))*dataChunkSize+2] = (byte) b;
    }
    if(teensyIterator == 5){
      vals_5[(pix - (1200 * teensyIterator))*dataChunkSize] = (byte) r;
      vals_5[(pix - (1200 * teensyIterator))*dataChunkSize+1] = (byte) g;
      vals_5[(pix - (1200 * teensyIterator))*dataChunkSize+2] = (byte) b;
    }
    else if(teensyIterator == 6){
      vals_6[(pix - (1200 * teensyIterator))*dataChunkSize] = (byte) r;
      vals_6[(pix - (1200 * teensyIterator))*dataChunkSize+1] = (byte) g;
      vals_6[(pix - (1200 * teensyIterator))*dataChunkSize+2] = (byte) b;
    }
    else if(teensyIterator == 7){
      vals_7[(pix - (1200 * teensyIterator))*dataChunkSize] = (byte) r;
      vals_7[(pix - (1200 * teensyIterator))*dataChunkSize+1] = (byte) g;
      vals_7[(pix - (1200 * teensyIterator))*dataChunkSize+2] = (byte) b;
    }
    else if(teensyIterator == 8){
      vals_8[(pix - (1200 * teensyIterator))*dataChunkSize] = (byte) r;
      vals_8[(pix - (1200 * teensyIterator))*dataChunkSize+1] = (byte) g;
      vals_8[(pix - (1200 * teensyIterator))*dataChunkSize+2] = (byte) b;
    }
  }
  
  // Capturing time 2 for frame rate calculation..
  if(captureTime){
    timeCapture2 = millis();
  }
 
   // Write rgb value arrays to all teensy ports. If/else statement checks arguments to see which thread will process the serial sendin
   if(t0 == 1){ teensy_0.write(vals_0); }
   //else if(t0 == 1) { println("Delegate teensy_0 to helper thread"); }
   
   if(t1 == 1){ teensy_1.write(vals_1); }
   //else if(t1 == 1) { println("Delegate teensy_1 to helper thread"); }
   
   if(t2 == 1){ teensy_2.write(vals_2); }
   //else if(t2 == 1) { println("Delegate teensy_2 to helper thread"); }
   
   if(t3 == 1){ teensy_3.write(vals_3); }
   //else if(t3 == 1) { println("Delegate teensy_3 to helper thread"); }
   
   if(t4 == 1){ teensy_4.write(vals_4); }
   //else if(t4 == 1) { println("Delegate teensy_4 to helper thread"); }
   
   if(t5 == 1){ teensy_5.write(vals_5); }
   //else if(t5 == 1) { println("Delegate teensy_5 to helper thread"); }
   
   if(t6 == 1){ teensy_6.write(vals_6); }
   //else if(t6 == 1) { println("Delegate teensy_6 to helper thread"); }
   
   if(t7 == 1){ teensy_7.write(vals_7); }
   //else if(t7 == 1) { println("Delegate teensy_7 to helper thread"); }
   
   if(t8 == 1){ teensy_8.write(vals_8); }
   //else if(t8 == 1) { println("Delegate teensy_8 to helper thread"); }
   
 if(captureTime){
  timeCapture3 = millis();
  }
   
}


