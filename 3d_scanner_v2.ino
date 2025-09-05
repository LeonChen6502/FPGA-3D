#include <Wire.h>
#include <VL6180X.h>
#include <AccelStepper.h>

// ---------- Pin Definitions ----------
#define ROT_STEP_PIN 3
#define ROT_DIR_PIN  4
#define Z_STEP_PIN   5
#define Z_DIR_PIN    6

// ---------- Constants ----------
const int   stepsPerRev   = 200;   // full-steps/rev (1.8° each)
const float stepAngle     = 1.8;   // deg per full-step
const int   zSteps        = 100;    // number of Z layers
const float zStepHeight   = 1.0;   // mm per Z layer
const int   z_steps       = 20;

const int step_delay = 10000;
// ---------- Globals ----------
VL6180X tof;
AccelStepper rotStepper(AccelStepper::DRIVER, ROT_STEP_PIN, ROT_DIR_PIN);
AccelStepper zStepper(AccelStepper::DRIVER, Z_STEP_PIN,   Z_DIR_PIN);

// ---------- Helpers ----------
void readAndPrint(int stepIndex, float height) {
  float angle    = stepIndex * stepAngle;
  float distance = tof.readRangeSingleMillimeters();
  if (tof.timeoutOccurred()) {
    Serial.println("TOF timeout!");
    return;
  }
  Serial.print(angle,   1);
  Serial.print(',');
  Serial.print(height,  1);
  Serial.print(',');
  Serial.println(distance, 1);
}

// ---------- Setup ----------
void setup() {
  Serial.begin(115200);
  Wire.begin();

  // TOF sensor
  tof.init();
  tof.configureDefault();
  tof.setTimeout(500);
digitalWrite(Z_DIR_PIN, HIGH);
//  // Steppers: tune these to your mechanics
//  rotStepper.setMaxSpeed(1000.0);
//  rotStepper.setAcceleration(1000.0);
//  zStepper.setMaxSpeed(1000.0);
//  zStepper.setAcceleration(1000.0);

  // CSV header
  Serial.println("angle_deg,height_mm,distance_mm");
  delay(500);
}

// ---------- Main Loop ----------
void loop() {
  int lastReadAt = 0;
    int time_n = 0, time_p = 0;
    int ff;
  for (int layer = 0; layer < zSteps; layer+=z_steps) {
    float height = layer * zStepHeight;

//    // Reset rotation position & schedule a full revolution
//    rotStepper.setCurrentPosition(0);
//    rotStepper.moveTo(stepsPerRev);

    // First reading at 0°
    readAndPrint(0, height);
    time_n = 0;
    ff =0;
    for(int pos = 0; pos<200; pos++){
//      digitalWrite(LED_BUILTIN, HIGH);
      digitalWrite(ROT_STEP_PIN,HIGH); 
//      delayMicroseconds(step_delay);    // by changing this time delay between the steps we can change the rotation speed
      digitalWrite(ROT_STEP_PIN,LOW); 
//      delayMicroseconds(step_delay);
      ff =0;
      time_p = micros();  
      readAndPrint(pos, height); 
      while(micros() - time_p < step_delay){ 
//        time_n = micros();
        if(ff == 0){
          ff++;
          
//          break;
        }
      }
      ff=0;
    }
//    digitalWrite(LED_BUILTIN, LOW);

    // Move up one Z-step
//    zStepper.moveTo(layer + 1);
//    while (zStepper.distanceToGo() != 0) {
//      zStepper.run();
//    }
    delay(300);
    int time_2;
    for(int i=0; i<z_steps; i++){
      digitalWrite(Z_STEP_PIN, HIGH);
//      delayMicroseconds(10);
      digitalWrite(Z_STEP_PIN, LOW);
//      time_2 = micros();
//      Serial.println(i);
//      while(millis()-time_2 < 10000){
//      int aaa=0;
//      }
      delay(10);
    }
//    digitalWrite(Z_STEP_PIN, LOW);
    delay(2000);
  }

  Serial.println("Scan complete.");
  
}
