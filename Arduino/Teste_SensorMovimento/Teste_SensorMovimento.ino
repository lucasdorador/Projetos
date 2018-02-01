int pinoSensor = 12;
int valorSensor = 0;

void setup() {
  Serial.begin(9600);
  pinMode(pinoSensor, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  valorSensor = digitalRead(pinoSensor);

  if (valorSensor == LOW) {
    Serial.println("Sem Movimento!");
  } else if (valorSensor == HIGH) {
    Serial.println("Movimento Detetado!");
  }
}
