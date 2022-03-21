//script to test the sensor matrix prototype with arduino integration



void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(50, OUTPUT);
  pinMode(52, OUTPUT);
//digitalWrite(50, LOW);
//digitalWrite(52,LOW);
//delay(5000);
}

void loop() {
  // put your main code here, to run repeatedly:
  //int OneOne = analogRead(A8);
  //Serial.print("Low ");
  //Serial.println(OneOne);
  //delay(1000);
  digitalWrite(50,HIGH);
  digitalWrite(52,HIGH);
  int RowOne = analogRead(A8);
  int RowTwo = analogRead(A9);
  Serial.print("Row one ");  
  Serial.println(RowOne);
  Serial.print("Row two ");  
  Serial.println(RowTwo);
  delay(1000);
//  digitalWrite(50,LOW);
//  digitalWrite(52,LOW); 
}
