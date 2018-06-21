// Programa : Teste sensor liquido Arduino
// Autor : Arduino e Cia

// Pino ligado ao sensor de nivel de liquido
int pinosensor = 3;
int pinoRele = 2;

void setup()
{
  Serial.begin(9600);
  pinMode(pinosensor, INPUT);
  pinMode(pinoRele, OUTPUT);
}

void loop()
{
  int estado = digitalRead(pinosensor);
  Serial.print("Estado sensor : ");
  Serial.println(estado);
  switch(estado)
  {
  case 0:
    digitalWrite(pinoRele, HIGH);
    break;
  case 1:
    digitalWrite(pinoRele, LOW);
    break;
  }
  delay(100);
}

