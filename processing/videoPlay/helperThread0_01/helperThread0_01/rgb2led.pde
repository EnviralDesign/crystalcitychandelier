void writeToLeds(int z) {
  
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
 
   // Write rgb value arrays to all teensy ports.
   teensy_0.write(vals_0);
   teensy_1.write(vals_1);
   teensy_2.write(vals_2);
   teensy_3.write(vals_3);
   teensy_4.write(vals_4);
   //teensy_5.write(vals_5);
   //teensy_6.write(vals_6);
   //teensy_7.write(vals_7);
   //teensy_8.write(vals_8);
   
 if(captureTime){
  timeCapture3 = millis();
  }
   
}


