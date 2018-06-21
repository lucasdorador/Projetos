//Programa : Sensor de presenca com modulo PIR
//Autor : FILIPEFLOP

int pinorele = 2; //Pino ligado ao rele
int pinopir = 7; //Pino ligado ao sensor PIR
int acionamento; //Variavel para guardar valor do sensor

void setup()
{
pinMode(pinorele, OUTPUT); //Define pino rele como saida
pinMode(pinopir, INPUT); //Define pino sensor como entrada
delay(5000);
Serial.begin(9600);
}

void loop()
{
acionamento = digitalRead(pinopir); //Le o valor do sensor PIR

if (acionamento == LOW) //Sem movimento, mantem rele desligado
{
digitalWrite(pinorele, HIGH);
Serial.println("Parado");
}
else //Caso seja detectado um movimento, aciona o rele
{
digitalWrite(pinorele, LOW);
Serial.println("Movimento !!!");
}
}
