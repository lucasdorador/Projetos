#define pinBotaoDebug 2
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


#define LIGA  HIGH
#define DESLIGA LOW

int const pinoSensorPIR = 3; //Fio Marrom
int const pinoRele = 5; //Fio Verde
int const LEDAmarelo_Funcionamento = 7; // Fio Laranja
int const pinoBoia = 2; //Fio Azul
int const LEDVermelho_FaltaAgua = 11; //Fio Branco
int const Botao_I_ModoAutomatico = 12; //Fio Azul
int const Botao_II_ModoManual = 13; //Fio Cinza
int vliRespBoia = 0;
int vliRespSensorPIR = 0;
int vliRespBotaoI = 0;
int vliRespBotaoII = 0;

void AcionaMotor();
void ValidaStatusBoia();

void setup() {

#if habilitaDebugSerial == true
  Serial.begin(115200);
  pinMode(pinBotaoDebug, INPUT_PULLUP);
#endif

  //INPUT
  pinMode(Botao_I_ModoAutomatico, INPUT);
  pinMode(Botao_II_ModoManual, INPUT);
  pinMode(pinoSensorPIR, INPUT);
  pinMode(pinoBoia, INPUT);
  //OUTPUT
  pinMode(pinoRele, OUTPUT);
  pinMode(LEDAmarelo_Funcionamento, OUTPUT);
  pinMode(LEDVermelho_FaltaAgua, OUTPUT);

  attachInterrupt(digitalPinToInterrupt(pinoSensorPIR), AcionaMotor, CHANGE);
  attachInterrupt(digitalPinToInterrupt(pinoBoia), ValidaStatusBoia, CHANGE);

  Sensor(DESLIGA);
}

void loop() {
  delay(500);
  vliRespBoia      = digitalRead(pinoBoia);
  vliRespBotaoI    = digitalRead(Botao_I_ModoAutomatico);
  vliRespBotaoII   = digitalRead(Botao_II_ModoManual);

  #if habilitaDebugSerial == true
  debug(1, "vliRespSensorPIR", String(digitalRead(pinoSensorPIR)), 1000);   
  debug(1, "vliRespBoia", String(vliRespBoia), 1000);
  debug(1, "Botao_I_ModoAutomatico", String(digitalRead(Botao_I_ModoAutomatico)), 1000);
  debug(1, "Botao_II_ModoManual", String(digitalRead(Botao_II_ModoManual)), 1000);
  debug(1, "Pino Relê", String(digitalRead(pinoRele)), 1000);
  #endif

  if (vliRespBotaoII == 1) {
    detachInterrupt(digitalPinToInterrupt(pinoSensorPIR));
    AcionaMotor_Manual();
    #if habilitaDebugSerial == true
      debug(6, "Modo Manual", "", 1000);
    #endif
  } else if (vliRespBotaoI == 1) {
    attachInterrupt(digitalPinToInterrupt(pinoSensorPIR), AcionaMotor, CHANGE);
    #if habilitaDebugSerial == true
      debug(7, "Modo Automatico", "", 1000);
    #endif
  } else {
    Sensor(DESLIGA);
    detachInterrupt(digitalPinToInterrupt(pinoSensorPIR));
    #if habilitaDebugSerial == true
      debug(8, "Modo Desligado", "", 1000);
    #endif
  }
}

void AcionaMotor() {
  static unsigned long delayEstado;

  #if habilitaDebugSerial == true
  debug(2, "Entrou na Interrupção", "", 1000);
  #endif

  #if habilitaDebugSerial == true
  debug(3, "vliRespBoia", String(vliRespBoia), 1000);
  debug(3, "vliRespSensorPIR", String(vliRespSensorPIR), 1000);
  #endif

  delay(500);
  vliRespSensorPIR = digitalRead(pinoSensorPIR);

  if ((millis() - delayEstado) > 100) {
    if ((vliRespSensorPIR == 1) && (vliRespBoia == 1)) {
      Sensor(LIGA);
      digitalWrite(LEDAmarelo_Funcionamento, HIGH);
      delay(5);
    #if habilitaDebugSerial == true
      debug(4, "Sensor Ligado", "", 1000);
    #endif
    } else {
      Sensor(DESLIGA);
      digitalWrite(LEDAmarelo_Funcionamento, LOW);
      delay(5);
    #if habilitaDebugSerial == true
      debug(4, "Sensor Desligado", "", 1000);
    #endif
    }
    delayEstado = millis();
  }
}

void AcionaMotor_Manual() {
  static unsigned long delayEstado;
  
  delay(500);
  vliRespBoia = digitalRead(pinoBoia);

  if ((millis() - delayEstado) > 100) {
    if (vliRespBoia == 1) {
      Sensor(LIGA);
      digitalWrite(LEDAmarelo_Funcionamento, HIGH);
      delay(5);
    #if habilitaDebugSerial == true
      debug(8, "Sensor Ligado", "", 1000);
    #endif
    } else {
      Sensor(DESLIGA);
      digitalWrite(LEDAmarelo_Funcionamento, LOW);
      delay(5);
    #if habilitaDebugSerial == true
      debug(8, "Sensor Desligado", "", 1000);
    #endif
    }
    delayEstado = millis();
  }
}

void ValidaStatusBoia(){    
  vliRespBoia = digitalRead(pinoBoia);  
  
 #if habilitaDebugSerial == true
   debug(9, "Entrou na Interrupção da Boia", "", 1000);
   debug(9, "vliRespBoia", String(vliRespBoia), 1000);
 #endif

 delay(500);

  if (vliRespBoia == 0) {
    digitalWrite(LEDVermelho_FaltaAgua, LIGA);
    Sensor(DESLIGA);
  } else {
    digitalWrite(LEDVermelho_FaltaAgua, DESLIGA);
    if (vliRespBotaoII == 1) {
      Sensor(LIGA);
    }
  }
  
}

void Sensor (int ligadesliga) {
  #if habilitaDebugSerial == true
   debug(5, "Rele", String(ligadesliga), 1000);
  #endif
  digitalWrite(pinoRele, ligadesliga);
}
