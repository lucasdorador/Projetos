#include <Ultrasonic.h> //INCLUSÃO DA BIBLIOTECA NECESSÁRIA PARA FUNCIONAMENTO DO CÓDIGO

const int echoPin = 8; //PINO DIGITAL UTILIZADO PELO HC-SR04 ECHO(RECEBE)
const int trigPin = 11; //PINO DIGITAL UTILIZADO PELO HC-SR04 TRIG(ENVIA)

const int pinoBuzzer = 2; //PINO DIGITAL EM QUE O BUZZER ESTÁ CONECTADO

Ultrasonic ultrasonic(trigPin,echoPin); //INICIALIZANDO OS PINOS

int distancia; //CRIA UMA VARIÁVEL CHAMADA "distancia" DO TIPO INTEIRO
String result; //CRIA UMA VARIÁVEL CHAMADA "result" DO TIPO STRING
float cmMsec;

void setup(){
pinMode(echoPin, INPUT); //DEFINE O PINO 7 COMO ENTRADA (RECEBE)
pinMode(trigPin, OUTPUT); //DEFINE O PINO 6 COMO SAÍDA (ENVIA)
pinMode(pinoBuzzer, OUTPUT); //DECLARA O PINO COMO SENDO SAÍDA

  Serial.begin(9600);
  Serial.println("Lendo dados do sensor...");
}
void loop(){

//hcsr04(); // FAZ A CHAMADA DO MÉTODO "hcsr04()"
calculadistancia();

if(cmMsec <= 10){// SE A DISTÂNCIA ENTRE O OBJETO E O SENSOR ULTRASONICO FOR MENOR QUE 30CM, FAZ
  digitalWrite(pinoBuzzer, LOW);
//tone(pinoBuzzer,1500);//ACIONA O BUZZER
Serial.print("Distancia em cm: ");
Serial.println(cmMsec);
}else{//SENÃO, FAZ
//noTone(pinoBuzzer);//BUZZER PERMANECE DESLIGADO
digitalWrite(pinoBuzzer, HIGH);
}

}
//MÉTODO RESPONSÁVEL POR CALCULAR A DISTÂNCIA
void hcsr04(){
digitalWrite(trigPin, LOW); //SETA O PINO 6 COM UM PULSO BAIXO "LOW"
delayMicroseconds(2); // DELAY DE 2 MICROSSEGUNDOS
digitalWrite(trigPin, HIGH); //SETA O PINO 6 COM PULSO ALTO "HIGH"
delayMicroseconds(10); // DELAY DE 10 MICROSSEGUNDOS
digitalWrite(trigPin, LOW); //SETA O PINO 6 COM PULSO BAIXO "LOW" NOVAMENTE
// FUNÇÃO RANGING, FAZ A CONVERSÃO DO TEMPO DE
//RESPOSTA DO ECHO EM CENTÍMETROS E ARMAZENA
//NA VARIÁVEL "distancia"
//long microsec = ultrasonic.timing();
//distancia = ultrasonic.convert(microsec, Ultrasonic::CM);
//distancia = (ultrasonic.Ranging(CM)); // VARIÁVEL GLOBAL RECEBE O VALOR DA DISTÂNCIA MEDIDA
delay(500); //INTERVALO DE 500 MILISSEGUNDOS
}

void calculadistancia() {
  long microsec = ultrasonic.timing();
  cmMsec = ultrasonic.convert(microsec, Ultrasonic::CM); 
}

