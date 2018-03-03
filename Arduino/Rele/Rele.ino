//Programa : Teste Modulo Rele Arduino 2 canais - Lampadas
//Autor : FILIPEFLOP

//Porta ligada ao pino IN1 do modulo
int porta_rele1 = 7;
//Porta ligada ao pino IN2 do modulo
int porta_rele2 = 8;
//Porta ligada ao pino IN3 do modulo
int porta_rele3 = 9;
 
void setup()
{
  //Define pinos para o rele como saida
  pinMode(porta_rele1, OUTPUT); 
  pinMode(porta_rele2, OUTPUT);
  pinMode(porta_rele3, OUTPUT);
}
  
void loop()
{
  digitalWrite(porta_rele1, LOW);  //Liga rele 1
  digitalWrite(porta_rele2, HIGH); //Desliga rele 2
  digitalWrite(porta_rele3, HIGH); //Desliga rele 3
  delay(5000);
  digitalWrite(porta_rele1, HIGH); //Desliga rele 1
  digitalWrite(porta_rele2, LOW);  //Liga rele 2
  digitalWrite(porta_rele3, HIGH); //Desliga rele 3
  delay(5000);
  digitalWrite(porta_rele1, HIGH); //Desliga rele 1
  digitalWrite(porta_rele2, HIGH); //Desliga rele 2
  digitalWrite(porta_rele3, LOW); //Liga rele 3
  delay(5000);
}
