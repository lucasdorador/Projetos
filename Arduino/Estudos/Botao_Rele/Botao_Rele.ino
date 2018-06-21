// Programa : Acionamento de rele utilizando push button
// Autor : Arduino e Cia

int PortaRele1 = 4; //define a porta para o acionamento do rele
int PortaRele2 = 5; //define a porta para o acionamento do rele
int PortaRele3 = 6; //define a porta para o acionamento do rele
int PortaRele4 = 7; //define a porta para o acionamento do rele
int pinobotao  = 2;    //Porta utilizada para o botão de acionamento
int leitura;          //Armazena informações sobre a leitura do botão
int estadorele = 0;   //Armazena o estado do relé (ligado/desligado)
int peltier = 9;
int peltier_level = map(10, 0, 99, 0, 255);

void setup()
{
  //Define o pino como saida (sinal para o rele)
  pinMode(PortaRele1, OUTPUT); 
  pinMode(PortaRele2, OUTPUT); 
  pinMode(PortaRele3, OUTPUT); 
  pinMode(PortaRele4, OUTPUT); 
  pinMode(peltier, OUTPUT); 

  //Define o pino como entrada (Pino do botao)
  pinMode(pinobotao, INPUT);      
}

void loop()
{
  leitura = digitalRead(pinobotao);
  if (leitura != 1)
  {
    while(digitalRead(pinobotao) != 1)
    {
      delay(100);
    }
    // Inverte o estado
    estadorele = !estadorele;
    digitalWrite(PortaRele1, estadorele);  
    digitalWrite(PortaRele2, estadorele);  
    digitalWrite(PortaRele3, estadorele);  
    digitalWrite(PortaRele4, estadorele); 
    analogWrite(peltier, peltier_level);
  } 
}
