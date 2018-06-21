//Programa: Conectando Sensor Ultrassonico HC-SR04 ao Arduino
//Autor: FILIPEFLOP

//Carrega a biblioteca do sensor ultrassonico
#include <Ultrasonic.h>

//Define os pinos para o trigger e echo
#define pino_trigger 11
#define pino_echo 8

//Inicializa o sensor nos pinos definidos acima
Ultrasonic ultrasonic(pino_trigger, pino_echo);

void setup()
{
  Serial.begin(9600);
  Serial.println("Lendo dados do sensor...");
}

void loop()
{
  //Le as informacoes do sensor, em cm e pol
  float cmMsec;
  long microsec = ultrasonic.timing();
  cmMsec = ultrasonic.convert(microsec, Ultrasonic::CM);

  if (cmMsec <= 22.00) {
  //Exibe informacoes no serial monitor
  Serial.print("Distancia em Menor: ");
  Serial.println(cmMsec);  
  } else{
  Serial.print("Distancia em cm: ");
  Serial.println(cmMsec);}  
  
  delay(1000);
}
