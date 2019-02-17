import gab.opencv.*; 
import processing.video.*; 
import java.awt.Rectangle;
import processing.serial.*;
 
Serial port;                      // Create object from Serial class
Capture cam; 
OpenCV opencv; 
Rectangle[] faces;
 
void setup() { 
  size(640, 480); 
  surface.setResizable(true);
  background (0, 0, 0); 
  cam = new Capture( this, 640, 480, 30); 
  cam.start(); 
  opencv = new OpenCV(this, cam.width, cam.height); 
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  port = new Serial(this,Serial.list()[0], 9600); 
}
 
void draw() { 
  opencv.loadImage(cam); 
  faces = opencv.detect(); 
  image(cam, 0, 0); 
 
  if (faces!=null) { 
    for (int i=0; i< faces.length; i++) { 
      noFill(); 
      stroke(255, 255, 0); 
      strokeWeight(10); 
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
      int angle = int(map(faces[i].y, 0, 480, 180, 250));  // Scale the value to the range 0-180
      int up =int(map(faces[i].x, 640, 0, 0, 180));
      port.write(angle);                        // Write the angle to the serial port
      port.write(up);
    }
  } 
  if (faces.length<=0) { 
    textAlign(CENTER); 
    fill(255, 0, 0); 
    textSize(56); 
    println("no faces");
    text("UNDETECTED", 200, 100);
  }
}
 
void captureEvent(Capture cam) { 
  cam.read();
}
