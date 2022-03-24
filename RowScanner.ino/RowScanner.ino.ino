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

void setup() {


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

Serial.begin(9600); 

}

void loop() {
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

MyTime = millis();

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
//Serial.println(MyTime);
Serial.println("");

delay(1000);

}
