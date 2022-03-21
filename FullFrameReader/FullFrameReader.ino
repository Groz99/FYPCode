// script to read full data frame from IMU and PR matrix
// must be specd for mega for pins to apply correctly

#include <Wire.h>
#include <MPU6050.h>

MPU6050 mpu;

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

unsigned long MyTime;

void setup() 
{
  Serial.begin(115200);

  // Initialize MPU6050
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
}

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

void loop()
{
  MyTime = millis();
  Vector rawGyro = mpu.readRawGyro();
  Vector normGyro = mpu.readNormalizeGyro();

  //Serial.print(" Xraw = ");
  //Serial.print(rawGyro.XAxis);
  //Serial.print(" Yraw = ");
  //Serial.print(rawGyro.YAxis);
  //Serial.print(" Zraw = ");
  //Serial.println(rawGyro.ZAxis);

  Serial.print(" Xnorm = ");
  Serial.print(normGyro.XAxis);
  Serial.print(" Ynorm = ");
  Serial.print(normGyro.YAxis);
  Serial.print(" Znorm = ");
  Serial.println(normGyro.ZAxis);

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
  
  Serial.print(p11);
  Serial.print(" ");
  Serial.print(p12) ;
  Serial.print(" ");
  Serial.print(p13) ;
  Serial.print(" ");
  Serial.println(p14);
  //delay(1000);
  
  Serial.print(p21);
  Serial.print(" ");
  Serial.print(p22) ;
  Serial.print(" ");
  Serial.print(p23) ;
  Serial.print(" ");
  Serial.println(p24) ;
  //delay(1000);
  
  Serial.print(p31);
  Serial.print(" ");
  Serial.print(p32) ;
  Serial.print(" ");
  Serial.print(p33) ;
  Serial.print(" ");
  Serial.println(p34);
  //delay(1000);
  
  Serial.print(p41);
  Serial.print(" ");
  Serial.print(p42) ;
  Serial.print(" ");
  Serial.print(p43) ;
  Serial.print(" ");
  Serial.println(p44) ;
  
  Serial.println(MyTime);
  Serial.println("");
  delay(1000);
}
