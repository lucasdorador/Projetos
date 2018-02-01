/*
   Programa: Teste para monitoramento de portas abertas
   Autor: Lucas Dorador
*/

int pinoBuzzer = 13; // porta 13 em output para o Buzzer
int pinoSensor = 7; // porta 7 em input para o sensor
int val = 0; // variável para ler o status do pino do sensor
int contTempo = 1;
float seno;
int frequencia;

void setup() {
  Serial.begin(9600);
  pinMode(pinoBuzzer, OUTPUT); // declarando o pino do Buzzer como output
  pinMode(pinoSensor, INPUT); // declarando o pino do sensor como input
}

void loop() {
  val = digitalRead(pinoSensor); // lendo o estado do sensor e atribuindo a variável val

  if (val == HIGH) {// verifica se a entrada é alta (quando os dois módulos estão separados), e acende o led vermelho e apaga o verde
    if (contTempo == 10) {
      for (int x = 0; x < 180; x++) {
        //converte graus para radiando e depois obtém o valor do seno
        seno = (sin(x * 3.1416 / 180));
        //gera uma frequência a partir do valor do seno
        frequencia = 2000 + (int(seno * 1000));
        tone(pinoBuzzer, frequencia);
        delay(3);
      }
    } else {
      Serial.print("Tempo com a porta aberta: ");
      Serial.println(contTempo);
      contTempo = contTempo + 1;
      delay(1000);
    }
  }
  else { //se não acenderá o led verde e apagará o vermelho
    contTempo = 1;
    noTone(pinoBuzzer);
  }
}
