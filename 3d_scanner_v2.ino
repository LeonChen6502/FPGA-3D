#include <Wire.h>
#include <VL6180X.h>
#include <AccelStepper.h>

// ---------- Pin Definitions ----------
#define ROT_STEP_PIN 3
#define ROT_DIR_PIN  4
#define Z_STEP_PIN   5
#define Z_DIR_PIN    6

#define L_PIN       10
#define R_PIN       11
#define U_PIN       12
#define D_PIN       13


// ---------- Threshold ----------
#define LEFT_THRESHOLD  400
#define RIGHT_THRESHOLD 800
#define UP_THRESHOLD    400
#define DOWN_THRESHOLD  800

// ---------- Constants ----------
const int   stepsPerRev   = 200;   // full-steps/rev (1.8° each)
const float stepAngle     = 1.8;   // deg per full-step
const int pos_step = 5;
const int   zSteps        = 4000;    // number of Z layers
const int zStepHeight   = 1.0;   // mm per Z layer
const int   z_steps       = 40;

const int step_delay = 10000;

int tof_d         = 70;
const float scaler        = 1;
const float offset        = 0;  

//float point_cloud[201][3] = {{6,32,0},{7,30,0},{8,26,0},{7,22,0},{10,20,0},{11,16,0},{14,14,0},{15,8,0},{19,7,0},{23,4,0},{27,1,0},{32,2,0},{37,6,0},{44,1,0},{48,6,0},{51,10,0},{52,15,0},{53,19,0},{53,24,0},{52,28,0},{47,32,0},{46,35,0},{45,38,0},{48,42,0},{43,43,0},{42,46,0},{42,52,0},{39,54,0},{37,59,0},{33,62,0},{28,61,0},{24,60,0},{19,60,0},{14,61,0},{9,57,0},{5,54,0},{4,49,0},{3,44,0},{8,38,0},{5,35,0},{10,32,4},{11,30,4},{9,26,4},{7,21,4},{11,20,4},{13,17,4},{14,13,4},{17,10,4},{19,6,4},{24,4,4},{28,1,4},{33,2,4},{37,5,4},{43,4,4},{46,8,4},{48,12,4},{55,14,4},{51,22,4},{50,26,4},{49,30,4},{45,33,4},{46,36,4},{43,38,4},{45,41,4},{45,45,4},{42,47,4},{41,51,4},{38,54,4},{36,58,4},{32,60,4},{27,63,4},{22,64,4},{19,59,4},{11,63,4},{10,55,4},{6,53,4},{4,49,4},{4,44,4},{5,38,4},{8,34,4},{9,32,8},{8,28,8},{8,25,8},{8,21,8},{12,20,8},{14,18,8},{15,13,8},{17,8,8},{20,5,8},{25,4,8},{29,2,8},{34,3,8},{38,5,8},{45,2,8},{45,10,8},{50,12,8},{53,15,8},{53,20,8},{49,26,8},{50,29,8},{48,33,8},{46,36,8},{45,39,8},{48,44,8},{44,45,8},{41,47,8},{40,52,8},{38,55,8},{35,59,8},{31,62,8},{26,66,8},{22,60,8},{17,59,8},{11,61,8},{8,57,8},{4,53,8},{2,49,8},{5,42,8},{8,37,8},{8,34,8},{7,32,12},{7,28,12},{10,25,12},{8,20,12},{11,18,12},{13,15,12},{14,10,12},{18,9,12},{21,5,12},{25,2,12},{30,2,12},{35,2,12},{39,4,12},{45,3,12},{48,8,12},{51,12,12},{54,16,12},{53,21,12},{52,26,12},{50,30,12},{48,33,12},{48,37,12},{47,40,12},{50,45,12},{43,45,12},{42,48,12},{40,53,12},{38,56,12},{35,61,12},{30,62,12},{25,63,12},{20,62,12},{17,58,12},{10,61,12},{5,58,12},{4,52,12},{2,47,12},{4,42,12},{4,38,12},{6,34,12},{5,31,16},{9,28,16},{9,24,16},{7,19,16},{13,19,16},{13,15,16},{16,12,16},{17,5,16},{22,4,16},{26,0,16},{31,0,16},{36,3,16},{40,5,16},{46,4,16},{49,8,16},{51,13,16},{51,18,16},{49,24,16},{51,27,16},{49,31,16},{45,34,16},{46,37,16},{47,41,16},{46,43,16},{42,45,16},{42,49,16},{39,51,16},{37,55,16},{33,60,16},{29,64,16},{24,62,16},{20,61,16},{14,61,16},{10,59,16},{7,55,16},{4,51,16},{4,46,16},{3,41,16},{5,37,16},{7,33,16}};

// ---------- Globals ----------
VL6180X tof;
AccelStepper rotStepper(AccelStepper::DRIVER, ROT_STEP_PIN, ROT_DIR_PIN);
AccelStepper zStepper(AccelStepper::DRIVER, Z_STEP_PIN,   Z_DIR_PIN);

// ---------- Helpers ----------
void readAndPrint(int stepIndex, int height) {
  float angle    = (float)stepIndex * stepAngle;
  uint16_t h = (int)(((float)height));
  tof_d = analogRead(A3);
  tof_d = map(tof_d, 0, 1023, 0, 200);
  float distance = 210-tof.readRangeSingleMillimeters();//tof_d;

//  distance = 90;//sangle = 30;
  float x,y;
  x = (distance*cos(angle/180*6.28) + offset )* scaler ;
  y = (distance*sin(angle/180*6.28) + offset) * 0.6 ;

  uint16_t x_16 = x;
  uint16_t y_16 = y;
//  uint16_t z_16 = z;

  if (tof.timeoutOccurred()) {
//    Serial.println("TOF timeout!");
    return;
  }
//  uint32_t mes = ((uint32_t)((((uint16_t)x) << 8)+ (uint16_t)y) << 16) + (uint32_t)distance;
  char c0 = x_16, c1 = x_16 >> 8, c2 = y_16, c3 = y_16 >> 8, c4 = h, c5 = h >> 8;
  char cf= 0xff;
//  Serial.print(angle,   1);
//  Serial.print(',');
//  Serial.print(h,  1);
//  Serial.print(',');
//  Serial.println(distance, 1);
//  Serial.println(mes,HEX);
//
//  Serial.print(x,   1);
//  Serial.print(',');
//  Serial.print(y,  1);
//  Serial.print(',');
//  Serial.println(h, 1);
//  Serial.println(mes,HEX);

  Serial.print(cf);
  Serial.print(c5);
  Serial.print(c4);
   Serial.print(c3);
  Serial.print(c2);
  Serial.print(c1);
  Serial.print(c0);

}

void test_print(int x,int y, int z){
  uint16_t x_16 = x;
  uint16_t y_16 = y;
  uint16_t z_16 = z;

  char c0 = x_16, c1 = x_16 >> 8, c2 = y_16, c3 = y_16 >> 8, c4 = z, c5 = z >> 8;
  char cf= 0xff;
//  Serial.print(angle,   1);
//  Serial.print(',');
//  Serial.print(h,  1);
//  Serial.print(',');
//  Serial.println(distance, 1);
//  Serial.println(mes,HEX);
//  Serial.print(cf);
//  Serial.print(c5);
//  Serial.print(c4);
//   Serial.print(c3);
//  Serial.print(c2);
//  Serial.print(c1);
//  Serial.print(c0);
}

void test_print_c(float d,float theta, int z){
  float x,y;
  x = d*cos(theta/180*6.28) ;
  y = d*sin(theta/180*6.28) ;
  
  uint16_t x_16 = x;
  uint16_t y_16 = y;
  uint16_t z_16 = z;

  char c0 = x_16, c1 = x_16 >> 8, c2 = y_16, c3 = y_16 >> 8, c4 = z, c5 = z >> 8;
  char cf= 0xff;
//  Serial.print(angle,   1);
//  Serial.print(',');
//  Serial.print(h,  1);
//  Serial.print(',');
//  Serial.println(distance, 1);
//  Serial.println(mes,HEX);
  Serial.print(cf);
  Serial.print(c5);
  Serial.print(c4);
   Serial.print(c3);
  Serial.print(c2);
  Serial.print(c1);
  Serial.print(c0);
}

//----------Joy stick------
void joy_stick(){
  int x = analogRead(A0);
  int y = analogRead(A1);
//  Serial.print(x);  Serial.print(", ");

//  Serial.println(y);
    
  if (x > LEFT_THRESHOLD && x < RIGHT_THRESHOLD){
    digitalWrite(L_PIN, LOW);
    digitalWrite(R_PIN, LOW);
//    Serial.println("LR:0,0");
  }else{
    if (x < LEFT_THRESHOLD) {
      digitalWrite(L_PIN, HIGH);
//      Serial.println("L");

    }
    if (x > RIGHT_THRESHOLD) {
      digitalWrite(R_PIN, HIGH);
//      Serial.println("R");

    }
  }

  if (y > UP_THRESHOLD && y < DOWN_THRESHOLD){
    digitalWrite(U_PIN, LOW);
    digitalWrite(D_PIN, LOW);
//    Serial.println("UD:0,0");

  }else{
    if (y < UP_THRESHOLD) {
      digitalWrite(U_PIN, HIGH);
//            Serial.println("U");

    }
    if (y > DOWN_THRESHOLD) {
      digitalWrite(D_PIN, HIGH);
//      Serial.println("D");
    }
  }

  
}

// ---------- Setup ----------
void setup() {
  Serial.begin(115200);
  Wire.begin();

  // TOF sensor
  tof.init();
  tof.configureDefault();
  tof.setTimeout(500);
  test_print(0,0,200);
  test_print(0,0,0);
  test_print(200,0,0);
  test_print(200,200,0);
  test_print(200,0,200);
  test_print(0,0,200);
int d = 60;
//for(int j = 0; j<120; j+=10){
  for(int i = 0; i<360; i+=1){
     test_print_c(d,i,1);
//  }
//  d -= 5;
}



digitalWrite(Z_DIR_PIN, HIGH);
//  // Steppers: tune these to your mechanics
//  rotStepper.setMaxSpeed(1000.0);
//  rotStepper.setAcceleration(1000.0);
//  zStepper.setMaxSpeed(1000.0);
//  zStepper.setAcceleration(1000.0);

  // CSV header
//  Serial.println("angle_deg,height_mm,distance_mm");
//int pos = 100, height = 50;
//      readAndPrint(pos, height); 
//  digitalWrite(Z_DIR_PIN,LOW);
//  for(int i=0; i<10000; i++){
//      digitalWrite(Z_STEP_PIN, HIGH);
////      delayMicroseconds(10);
//      digitalWrite(Z_STEP_PIN, LOW);
////      time_2 = micros();
////      Serial.println(i);
////      while(millis()-time_2 < 10000){
////      int aaa=0;
////      }
//      delay(10);
//    }
//   digitalWrite(Z_DIR_PIN,HIGH);
//  digitalWrite(9,LOW);
  delay(500);
}

// ---------- Main Loop ----------
void loop() {
//  uint16_t point_cloud[200][3] ={{6,32,0},{7,30,0},{8,26,0},{7,22,0},{10,20,0},{11,16,0},{14,14,0},{15,8,0},{19,7,0},{23,4,0},{27,1,0},{32,2,0},{37,6,0},{44,1,0},{48,6,0},{51,10,0},{52,15,0},{53,19,0},{53,24,0},{52,28,0},{47,32,0},{46,35,0},{45,38,0},{48,42,0},{43,43,0},{42,46,0},{42,52,0},{39,54,0},{37,59,0},{33,62,0},{28,61,0},{24,60,0},{19,60,0},{14,61,0},{9,57,0},{5,54,0},{4,49,0},{3,44,0},{8,38,0},{5,35,0},{10,32,4},{11,30,4},{9,26,4},{7,21,4},{11,20,4},{13,17,4},{14,13,4},{17,10,4},{19,6,4},{24,4,4},{28,1,4},{33,2,4},{37,5,4},{43,4,4},{46,8,4},{48,12,4},{55,14,4},{51,22,4},{50,26,4},{49,30,4},{45,33,4},{46,36,4},{43,38,4},{45,41,4},{45,45,4},{42,47,4},{41,51,4},{38,54,4},{36,58,4},{32,60,4},{27,63,4},{22,64,4},{19,59,4},{11,63,4},{10,55,4},{6,53,4},{4,49,4},{4,44,4},{5,38,4},{8,34,4},{9,32,8},{8,28,8},{8,25,8},{8,21,8},{12,20,8},{14,18,8},{15,13,8},{17,8,8},{20,5,8},{25,4,8},{29,2,8},{34,3,8},{38,5,8},{45,2,8},{45,10,8},{50,12,8},{53,15,8},{53,20,8},{49,26,8},{50,29,8},{48,33,8},{46,36,8},{45,39,8},{48,44,8},{44,45,8},{41,47,8},{40,52,8},{38,55,8},{35,59,8},{31,62,8},{26,66,8},{22,60,8},{17,59,8},{11,61,8},{8,57,8},{4,53,8},{2,49,8},{5,42,8},{8,37,8},{8,34,8},{7,32,12},{7,28,12},{10,25,12},{8,20,12},{11,18,12},{13,15,12},{14,10,12},{18,9,12},{21,5,12},{25,2,12},{30,2,12},{35,2,12},{39,4,12},{45,3,12},{48,8,12},{51,12,12},{54,16,12},{53,21,12},{52,26,12},{50,30,12},{48,33,12},{48,37,12},{47,40,12},{50,45,12},{43,45,12},{42,48,12},{40,53,12},{38,56,12},{35,61,12},{30,62,12},{25,63,12},{20,62,12},{17,58,12},{10,61,12},{5,58,12},{4,52,12},{2,47,12},{4,42,12},{4,38,12},{6,34,12},{5,31,16},{9,28,16},{9,24,16},{7,19,16},{13,19,16},{13,15,16},{16,12,16},{17,5,16},{22,4,16},{26,0,16},{31,0,16},{36,3,16},{40,5,16},{46,4,16},{49,8,16},{51,13,16},{51,18,16},{49,24,16},{51,27,16},{49,31,16},{45,34,16},{46,37,16},{47,41,16},{46,43,16},{42,45,16},{42,49,16},{39,51,16},{37,55,16},{33,60,16},{29,64,16},{24,62,16},{20,61,16},{14,61,16},{10,59,16},{7,55,16},{4,51,16},{4,46,16},{3,41,16},{5,37,16},{7,33,16}};

  int lastReadAt = 0;
    int time_p = 0;
    int ff;
    int height =0;//= layer * zStepHeight;
    int ii = -1;

  for (int layer = 0; layer < zSteps; layer+=z_steps) {
      joy_stick();

//    // Reset rotation position & schedule a full revolution
//    rotStepper.setCurrentPosition(0);
//    rotStepper.moveTo(stepsPerRev);

    // First reading at 0°
//    readAndPrint(0, height);
    for(int pos = 0; pos<200; pos ++){
//      for (int j = 0; j< pos_step; j++){
        digitalWrite(ROT_STEP_PIN,HIGH); 
        digitalWrite(ROT_STEP_PIN,LOW); 
        time_p = micros();  
//        if(j ==  pos_step-1) 
      joy_stick();
//        uint16_t x_p,y_p,z_p;
//        x_p = point_cloud[pos/4 +ii][0];
//        y_p = point_cloud[pos/4 +ii][1];
//        z_p = point_cloud[pos/4 +ii][3];
//        
//        test_print(x_p,y_p,z_p);
        readAndPrint(pos, height); 
        while(micros() - time_p < step_delay){ }
              joy_stick();

//      }
    }
//    digitalWrite(LED_BUILTIN, LOW);
    ii++;
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
            joy_stick();

    }
//    digitalWrite(Z_STEP_PIN, LOW);
    delay(300);
    height+=3;
  }
//  while(1){}
//  Serial.println("Scan complete.");
  
}
