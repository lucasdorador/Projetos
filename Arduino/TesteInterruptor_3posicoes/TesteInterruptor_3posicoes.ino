
int vliInterruptorI = 0;
int vliInterruptorII = 0;

int const LED_I  = 8;
int const LED_II = 7;
int const Interruptor_I  = 3;
int const Interruptor_II = 4;

void setup() {  
  Serial.begin(9600);
  pinMode(Interruptor_I, INPUT);
  pinMode(Interruptor_II, INPUT);
  pinMode(LED_I, OUTPUT);
  pinMode(LED_II, OUTPUT);

}

void loop() {
  vliInterruptorI  = digitalRead(Interruptor_I);
  vliInterruptorII = digitalRead(Interruptor_II);

  Serial.print("Resposta vliInterruptorI: ");
  Serial.println(vliInterruptorI);

  Serial.print("Resposta vliInterruptorII: ");
  Serial.println(vliInterruptorII);
  
  if (vliInterruptorI == 1) {
      delay(20);
      digitalWrite(LED_I, LOW);
      digitalWrite(LED_II, HIGH);
     } else if (vliInterruptorII == 1) {
      delay(20);
      digitalWrite(LED_II, LOW);
      digitalWrite(LED_I, HIGH);      
     } else {
      digitalWrite(LED_II, HIGH);
      digitalWrite(LED_I, HIGH);            
     } 

}
