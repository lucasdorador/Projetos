#define pinVerde    12
#define pinAmarelo  11
#define pinVermelho 10
#define pinBotao    2

void botaoAcionado();

void setup() {
  pinMode(pinVerde, OUTPUT);
  pinMode(pinAmarelo, OUTPUT);
  pinMode(pinVermelho, OUTPUT);
  
  pinMode(pinBotao, INPUT_PULLUP);
  
  attachInterrupt(digitalPinToInterrupt(pinBotao), botaoAcionado, RISING);
}

void loop() {

  digitalWrite(pinVerde, HIGH);
  digitalWrite(pinAmarelo, LOW);
  delay(1000);

  digitalWrite(pinVerde, LOW);
  digitalWrite(pinAmarelo, HIGH);
  delay(1000);

}

void botaoAcionado() {
static bool estado = LOW;
static unsigned long delayEstado;


   if ( (millis() - delayEstado) > 100 ) {
     estado = !estado;
     delayEstado = millis();
   }
   
   digitalWrite(pinVermelho, estado);
}

