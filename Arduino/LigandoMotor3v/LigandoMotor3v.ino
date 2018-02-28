/*************************************************************************
*                    Ligando e Desligando Motor DC                       *
*                     arduinolivre.wordpress.com                         *
*************************************************************************/
 
int base = 8; //Variável base recebendo o Pino digital 8
 
void setup() {
  pinMode(base,OUTPUT); //Definindo o pino 8 como saída
}
 
void loop() {
  digitalWrite(base, HIGH); //Sinal alto(5v) -&gt; Ligar Motor
  delay(5000);  //Espere 5 segundos
}
