import processing.video.*;

Capture vid;
PImage frame;
PImage img;
int[] oddField;
int[] evenField;
int totalFrames = 0;
int j, k = 0;
int numLines;
boolean odd, nextFrame;
int endFrame = 0;
void setup() {
  size(640, 480); 
  noCursor();
  numLines = (height/2)*width;
  oddField = new int[numLines];
  evenField = new int[numLines];
  odd = true;
  nextFrame = false;
  vid = new Capture(this, width, height);
  vid.start();

  frame = createImage(width, height, RGB);
  img = loadImage("img.JPG");
  img.loadPixels();
  frameRate(50);

     for (int y = 0; y < height; y++){
       for(int x = 0; x < width; x++){
         if(y%2==0){
           evenField[j] = x + y*width;
           j++;
         } else {
           oddField[k] = x + y*width;
           k++;
         }
       }
     }
  nextFrame = true;
}

void draw() {

  loadPixels();
  
  if (nextFrame && vid.available()) {
    vid.read();
    vid.loadPixels();

    frame.loadPixels();
    for (int i = 0; i < vid.pixels.length; i++) {
      frame.pixels[i] = vid.pixels[i];
    }
    frame.updatePixels();
  }
  nextFrame = false;

  // Black background
  for (int i = 0; i < pixels.length; i++) {
    pixels[i] = color(0);
  }
  float n = sq(mouseX);

  for (int i = 0; i < n; i++) {

    if ( index < numLines) {
      if (odd) {
        pixels[oddField[index]] = frame.pixels[oddField[index]];
        if(keyPressed){
          pixels[oddField[index]] = img.pixels[oddField[index]];
        }
      } else if (!odd) {
        pixels[evenField[index]] = frame.pixels[evenField[index]];
        if(keyPressed){
          pixels[evenField[index]] = img.pixels[evenField[index]];
        }
      }
      //println(index);
      index++;
    } else {

      index = 0;
      odd = !odd;
      endFrame ++;
      if (endFrame >1) {
        endFrame = 0;
        nextFrame = true;
        totalFrames++;
      }
    }
  }

  //updatePixels();
  vid.updatePixels();
  updatePixels();

  fill(0);
  for (int x = -1; x < 2; x++) {  
    text(n, 20+x, height-20);
    text(n, 20, height-20+x);
  }
  fill(255);
  text("HZ: "+n, 20, height-20);
  text("Frames: "+totalFrames, 20, height-40);
  text("Even: "+!odd, 20, height-60);
  text("Odd: "+odd, 20, height-80);
  text("Index: "+index, 20, height-100);
}
