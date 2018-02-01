/*
 * Programa: Monitoramento de portas ou janelas com MC-38a
 * Autor: Saulo Alexandre - Autocore Robótica
 * 
 * Para mais informações e tutoriais incriveis como esse acesse http://autocorerobotica.blog.br
 */

int ledVermelho = 13; // porta 13 em output para o LED vermelho
int ledVerde = 12; // porta 12 em output para o LED verde
int pinoSensor = 7; // porta 7 em input para o sensor
int val = 0; // variável para ler o status do pino do sensor

void setup() {

 pinMode(ledVermelho, OUTPUT); // declarando o pino do LED vermelho como output
 pinMode(ledVerde, OUTPUT); // declarando o pino do LED verde como output
 pinMode(pinoSensor, INPUT); // declarando o pino do sensor como input
}
void loop(){

 val = digitalRead(pinoSensor); // lendo o estado do sensor e atribuindo a variável val
 if (val == HIGH) {// verifica se a entrada é alta (quando os dois módulos estão separados), e acende o led vermelho e apaga o verde

 digitalWrite(ledVermelho, HIGH); // LED verde ON
 digitalWrite(ledVerde, LOW); // LED vermelho OFF

} else { //se não acenderá o led verde e apagará o vermelho

 digitalWrite(ledVerde, HIGH); // LED verde ON
 digitalWrite(ledVermelho, LOW); // LED vermelho OFF

 }
}
