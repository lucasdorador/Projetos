int pinoRele = 5;
int estadorele = 0;

void setup() {
  pinMode(pinoRele, OUTPUT);
}

void loop() {
  estadorele = !estadorele;
  digitalWrite(pinoRele, estadorele);
  delay(3000);
}
