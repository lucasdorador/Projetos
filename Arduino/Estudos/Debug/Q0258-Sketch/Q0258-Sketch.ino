#define pinBotaoDebug 13
#define habilitaDebugSerial true //define se envia informações do funcionamento para o monitor serial. "true" envia e "false" não envia. Utilizado apenas para identificar problemas de funcionamento atraves do monitor serial do IDE Arduino. Em situações normais, definir este parametro como "false". Quando usar o monitor, ele deve ser configurado para a velocidade de 115200.

#if habilitaDebugSerial == true
void debug(int pontoParada, String nomeVariavel, String valorVariavel, int tempoParada = -1) {   //TempoParada faz delay. Com -1, para até porta 13 mudar de nível
   
  Serial.print("(");
  Serial.print(pontoParada);
  Serial.print(") ");

  Serial.print(nomeVariavel);  
  Serial.print(":");
  Serial.print(valorVariavel);    
  Serial.println();

  if (tempoParada == -1) {

     static bool estadoBotaoAnt = digitalRead(pinBotaoDebug);
     static unsigned long delayDebounce;
     bool estadoBotao;
     bool aguarda = true;
     while (aguarda) {
       estadoBotao = digitalRead(pinBotaoDebug);
       if ( (estadoBotao != estadoBotaoAnt) && !estadoBotao ) {
          if ((millis() - delayDebounce) > 100) {
             aguarda = false;
             delayDebounce = millis();
          }
       } else if (estadoBotao != estadoBotaoAnt) {
         delayDebounce = millis(); 
       }
       estadoBotaoAnt = estadoBotao; 
     } 
  } else if (tempoParada > 0) {
     delay(tempoParada);
  }
}
#endif


//*********************************************************************************************************
void setup() {
  #if habilitaDebugSerial == true
      Serial.begin(115200);
      pinMode(pinBotaoDebug, INPUT_PULLUP); 
  #endif
}

void loop() {

  static byte variavel1 = 1;
  bool variavel2;

  #if habilitaDebugSerial == true
      debug(1, "variavel1", String(variavel1), 100);
  #endif

  variavel1 += 3;
  if ((variavel1 % 2) == 0) {
     variavel2 = true;
  } else { 
     variavel2 = false;
  }  

  #if habilitaDebugSerial == true
      debug(2, "variavel1", String(variavel1), 0);
      debug(2, "variavel2", String(variavel2), 100);
  #endif
}


