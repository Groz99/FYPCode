// Script to gather data for processing
// full 23 element data frame will be recorded at each epoch
// This script makes extensive use of open source code and libraries, most notably the MPU library developed by jarzebski
// Available on GIT: https://github.com/jarzebski/Arduino-MPU6050

// Data frame is output in the follow format

// p11, p12, p13, p14, p21, p22, p23, p24, p31, p32, p33, p34, p41, p42, p43, p44, Alpha, Beta, Gamma, X, Y, Z, Temp

//Where symbols are:

//PR Matrix pixels: 

// p11 p12 p13 p14
// p21 p22 p23 p24 
// p31 p32 p33 p34
// p41 p42 p43 p44

// X, Y, Z are acceloremeter readings 

// Gyroscope angular acceleration readings

// Note that for the use case of machine learning, IMU data processing for dead reckoning is not essential. Raw data may be used if it is more useful.


///////////////////////// Attempt to speed up ADC clock
// defines for setting and clearing register bits
#ifndef cbi
#define cbi(sfr, bit) (_SFR_BYTE(sfr) &= ~_BV(bit))
#endif
#ifndef sbi
#define sbi(sfr, bit) (_SFR_BYTE(sfr) |= _BV(bit))
#endif

///////////////////////// Attempt to speed up ADC clock


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Include libraries
#include <Wire.h>
#include <MPU6050.h>

// Initialise pins for PR Matrix 

//Set column pins to be energise by arduino
int ColOne = 52;
int ColTwo = 50;
int ColThree = 48;
int ColFour = 46;

//Set Analogue pins for reading data
int RowOne = A8;
int RowTwo = A9;
int RowThree = A10;
int RowFour = A11;

// Initialise MPU 

MPU6050 mpu;

int counter = 0;

void setup() {

  // Speed up ADC at the cost of some resolution
  // set prescale to 16
  sbi(ADCSRA,ADPS2) ;
  cbi(ADCSRA,ADPS1) ;
  cbi(ADCSRA,ADPS0) ;
  
  // Initialise baud rate to highest supported value to maximise data sample rate
  Serial.begin(115200);

  // even further beyond
  //Serial.begin(2000000);  // increases speed by ~1ms but jitter increased

  // Set up the row scanner pinmodes and initialise all low
  //Set digital pins to output mode
  pinMode(ColOne,OUTPUT);
  pinMode(ColTwo,OUTPUT);
  pinMode(ColThree,OUTPUT);
  pinMode(ColFour,OUTPUT);
  
  //Set all pins low to begin
  digitalWrite(ColOne,LOW);
  digitalWrite(ColTwo,LOW);
  digitalWrite(ColThree,LOW);
  digitalWrite(ColFour,LOW);
  
  // Pre operation checks that MPU is operating correctly 
  Serial.println("Initialize MPU6050");
  while(!mpu.begin(MPU6050_SCALE_2000DPS, MPU6050_RANGE_2G))
  {
    Serial.println("Could not find a valid MPU6050 sensor, check wiring!");
    delay(500);
  }
  
  // If you want, you can set gyroscope offsets
  // mpu.setGyroOffsetX(155);
  // mpu.setGyroOffsetY(15);
  // mpu.setGyroOffsetZ(15);
  
  // Calibrate gyroscope. The calibration must be at rest.
  // If you don't want calibrate, comment this line.
  mpu.calibrateGyro();

  // Set threshold sensivty. Default 3.
  // If you don't want use threshold, comment this line or set 0.
  mpu.setThreshold(3);
  
  // Check settings
  checkSettings();

}

// Subroutine to verify MPU settings are as desired

void checkSettings()
{
  Serial.println();
  
  Serial.print(" * Sleep Mode:        ");
  Serial.println(mpu.getSleepEnabled() ? "Enabled" : "Disabled");
  
  Serial.print(" * Clock Source:      ");
  switch(mpu.getClockSource())
  {
    case MPU6050_CLOCK_KEEP_RESET:     Serial.println("Stops the clock and keeps the timing generator in reset"); break;
    case MPU6050_CLOCK_EXTERNAL_19MHZ: Serial.println("PLL with external 19.2MHz reference"); break;
    case MPU6050_CLOCK_EXTERNAL_32KHZ: Serial.println("PLL with external 32.768kHz reference"); break;
    case MPU6050_CLOCK_PLL_ZGYRO:      Serial.println("PLL with Z axis gyroscope reference"); break;
    case MPU6050_CLOCK_PLL_YGYRO:      Serial.println("PLL with Y axis gyroscope reference"); break;
    case MPU6050_CLOCK_PLL_XGYRO:      Serial.println("PLL with X axis gyroscope reference"); break;
    case MPU6050_CLOCK_INTERNAL_8MHZ:  Serial.println("Internal 8MHz oscillator"); break;
  }
  
  Serial.print(" * Gyroscope:         ");
  switch(mpu.getScale())
  {
    case MPU6050_SCALE_2000DPS:        Serial.println("2000 dps"); break;
    case MPU6050_SCALE_1000DPS:        Serial.println("1000 dps"); break;
    case MPU6050_SCALE_500DPS:         Serial.println("500 dps"); break;
    case MPU6050_SCALE_250DPS:         Serial.println("250 dps"); break;
  } 
  
  Serial.print(" * Gyroscope offsets: ");
  Serial.print(mpu.getGyroOffsetX());
  Serial.print(" / ");
  Serial.print(mpu.getGyroOffsetY());
  Serial.print(" / ");
  Serial.println(mpu.getGyroOffsetZ());
  
  Serial.println();
}


void loop() {

  // Begin non blocking delay
  static int last_time = millis();
  
  ///////////////////////////////// Reading


  // Begin scanning each pixel in series, column by column
  //Column one
  digitalWrite(ColOne,HIGH);
  int p11 = analogRead(RowOne);
  int p12 = analogRead(RowTwo);
  int p13 = analogRead(RowThree);
  int p14 = analogRead(RowFour);
  digitalWrite(ColOne,LOW);
  
  //Column two
  digitalWrite(ColTwo,HIGH);
  int p21 = analogRead(RowOne);
  int p22 = analogRead(RowTwo);
  int p23 = analogRead(RowThree);
  int p24 = analogRead(RowFour);
  digitalWrite(ColTwo,LOW);
  
  //Column three
  digitalWrite(ColThree,HIGH);
  int p31 = analogRead(RowOne);
  int p32 = analogRead(RowTwo);
  int p33 = analogRead(RowThree);
  int p34 = analogRead(RowFour);
  digitalWrite(ColThree,LOW);
  
  //Column four
  digitalWrite(ColFour,HIGH);
  int p41 = analogRead(RowOne);
  int p42 = analogRead(RowTwo);
  int p43 = analogRead(RowThree);
  int p44 = analogRead(RowFour);
  digitalWrite(ColFour,LOW);


  // Read MPU gyro for Alpha, Beta and Gamma readings
  // Ignore raw values, use normalised readings
  //Vector rawGyro = mpu.readRawGyro();
  Vector normGyro = mpu.readNormalizeGyro();
  
//  Serial.print(" Xnorm = ");
//  Serial.print(normGyro.XAxis);
//  Serial.print(" Ynorm = ");
//  Serial.print(normGyro.YAxis);
//  Serial.print(" Znorm = ");
//  Serial.println(normGyro.ZAxis);


  // Read MPU accell for X,Y,Z readings
  // Again use normalised values for now
  // Vector rawAccel = mpu.readRawAccel();

  Vector normAccel = mpu.readNormalizeAccel();
  
//  Serial.print(" Xnorm = ");
//  Serial.print(normAccel.XAxis);
//  Serial.print(" Ynorm = ");
//  Serial.print(normAccel.YAxis);
//  Serial.print(" Znorm = ");
//  Serial.println(normAccel.ZAxis);

  // Read temperature using internal MPU temp sensor  
  float temp = mpu.readTemperature();

    
  Serial.print(p11);
  Serial.print(" ");
  Serial.print(p12);
  Serial.print(" ");
  Serial.print(p13);
  Serial.print(" ");
  Serial.print(p14);
  Serial.print(" ");
  Serial.print(p21);
  Serial.print(" ");
  Serial.print(p22);
  Serial.print(" ");
  Serial.print(p23);
  Serial.print(" ");
  Serial.print(p24);
  Serial.print(" ");
  Serial.print(p31);
  Serial.print(" ");
  Serial.print(p32);
  Serial.print(" ");
  Serial.print(p33);
  Serial.print(" ");
  Serial.print(p34);
  Serial.print(" ");
  Serial.print(p41);
  Serial.print(" ");
  Serial.print(p42);
  Serial.print(" ");
  Serial.print(p43);
  Serial.print(" ");
  Serial.print(p44);
  Serial.print(" ");
  Serial.print(normGyro.XAxis);
  Serial.print(" ");
  Serial.print(normGyro.YAxis);
  Serial.print(" ");
  Serial.print(normGyro.ZAxis);
  Serial.print(" ");
  Serial.print(normAccel.XAxis);
  Serial.print(" ");
  Serial.print(normAccel.YAxis);
  Serial.print(" ");
  Serial.print(normAccel.ZAxis);
  Serial.print(" ");
  Serial.print(temp);
  Serial.print(" ");
  int current_time = millis();
  Serial.println(current_time);





}

  ////////////////////////////////////////////


  
