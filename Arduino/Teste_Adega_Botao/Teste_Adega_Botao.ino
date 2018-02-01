//Porta ligada ao pino IN1 do modulo
int porta_rele1 = 8;
//Porta ligada ao pino IN2 do modulo
int porta_rele2 = 9;
//Porta ligada ao pino IN3 do modulo
int porta_rele3 = 10;
//Porta ligada ao pino IN do modulo
int porta_rele4 = 11;
//Porta ligada ao botao
int porta_botao = 3;

//Armazena o estado do rele - 0 (LOW) ou 1 (HIGH)
int estadorele1 = 1;
int estadorele2 = 1;
int estadorele3 = 1;
int estadorele4 = 1;

//Armazena o valor lido dos botoes
int leitura1 = 0;
 
void setup()
{
  Serial.begin(9600);
  //Define pinos para o rele como saida
  pinMode(porta_rele1, OUTPUT); 
  pinMode(porta_rele2, OUTPUT);
  pinMode(porta_rele3, OUTPUT);
  pinMode(porta_rele4, OUTPUT);
  //Define pinos dos botoes como entrada
  pinMode(porta_botao, INPUT); 
  //Estado inicial dos reles - desligados
  digitalWrite(porta_rele1, HIGH);
  digitalWrite(porta_rele2, HIGH);
  digitalWrite(porta_rele3, HIGH);
  digitalWrite(porta_rele4, HIGH);
}

void loop()
{
  //Verifica o acionamento do botao
  leitura1 = digitalRead(porta_botao);
  if (leitura1 != 0)
  {
    while(digitalRead(porta_botao) != 0)
    {
      Serial.print("Botão: ");
      Serial.println(porta_botao);
      delay(100);
    }
    
    //Inverte o estado da porta
    estadorele1 = !estadorele1;
    estadorele2 = !estadorele2;
    estadorele3 = !estadorele3;
    estadorele4 = !estadorele4;
        
    Serial.print("Rele 01: ");
    Serial.println(estadorele1);
    Serial.print("Rele 02: ");
    Serial.println(estadorele2);
    Serial.print("Rele 03: ");
    Serial.println(estadorele3);
    Serial.print("Rele 04: ");
    Serial.println(estadorele4);
    
    //Comandos para o rele 1
    digitalWrite(porta_rele1, estadorele1);  
    //Comandos para o rele 2
    digitalWrite(porta_rele2, estadorele2);  
    //Comandos para o rele 3
    digitalWrite(porta_rele3, estadorele3);  
    //Comandos para o rele 4
    digitalWrite(porta_rele4, estadorele4);  
  }   
}
