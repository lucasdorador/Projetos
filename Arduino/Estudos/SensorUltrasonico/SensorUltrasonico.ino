//Carrega a biblioteca do sensor ultrassonico
#include <Ultrasonic.h>

//Define os pinos para o trigger e echo
#define pino_trigger 3
#define pino_echo 6

int pinoBoia = 4;
int pinoRele = 5;
int vliRespBoia = 0;
int vliRespMotor = 0;

//Inicializa o sensor nos pinos definidos acima
Ultrasonic ultrasonic(pino_trigger, pino_echo);

void setup()
{
  Serial.begin(9600);
  Serial.println("Lendo dados do sensor...");
  pinMode(pinoBoia, INPUT);
  pinMode(pinoRele, OUTPUT);
}

void loop()
{
  vliRespBoia = digitalRead(pinoBoia);
  //Le as informacoes do sensor, em cm e pol
  float cmMsec, inMsec;
  long microsec = ultrasonic.timing();
  cmMsec = ultrasonic.convert(microsec, Ultrasonic::CM);
  inMsec = ultrasonic.convert(microsec, Ultrasonic::IN);
  //Exibe informacoes no serial monitor
  Serial.print("Distancia em cm: ");
  Serial.print(cmMsec);
  Serial.print(" - Distancia em polegadas: ");
  Serial.print(inMsec);
  Serial.print(" - Resposta Boia: ");
  Serial.println(vliRespBoia);

  if ((cmMsec <= 20.00) && (vliRespBoia == 1)) {
    Serial.print("Liga Motor - ");
    digitalWrite(pinoRele, LOW);
    vliRespMotor = digitalRead(pinoRele);
    Serial.println(vliRespMotor);
  } else {
    Serial.print("Desliga Motor - ");
    digitalWrite(pinoRele, HIGH);
    vliRespMotor = digitalRead(pinoRele);
    Serial.println(vliRespMotor);
  }

  delay(1000);
}
