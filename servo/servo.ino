// Read data from the serial port and set the position of a servomotor 
// according to the value
#include<Servo.h>
Servo myservo;                   // Create servo object to control a servo
Servo myservo2;                   // Create servo object to control a servo
int servoPin = 4;                // Connect yellow servo wire to digital I/O pin 4 
int servoPin2 = 3;  
int val = 0;                     // Data received from the serial port

void setup() {
  myservo.attach(servoPin);      // Attach the servo to the PWM pin
  myservo2.attach(servoPin2);      // Attach the servo to the PWM pin
  Serial.begin(9600);           // Start serial communication at 9600 bps
  pinMode(13, OUTPUT);
}

void loop() {
  if (Serial.available()) {      // If data is available to read,
    val = Serial.read();         // read it and store it in val 
  } 
  if(val<180){
  myservo.write(val);            // Set the servo position
  delay(15);                     // Wait for the servo to get there
  }
  if(val>180 && val<360){
    myservo2.write(val-180);            // Set the servo position
    delay(15);                     // Wait for the servo to get there
  }
  
  
}
