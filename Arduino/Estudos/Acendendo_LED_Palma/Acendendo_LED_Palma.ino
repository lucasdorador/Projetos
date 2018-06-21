
// Projeto 45 – Acendendo LED com sensor de som

int microfone = 7; // Pino digital ligado ao sensor de som (DO)
int led = 8; // Pino ligado ao LED
 
int contPalmas = 0; // Contador de Palmas
int palmasRequeridaLigaLed = 2; // Contagem para acender o LED
int palmasRequeridaDesligaLed = 2; // Contagem para apagar o LED
 
// Tempo máximo entre o pulso seguinte
unsigned long tempMaxSom = 1000; 
unsigned long tempMinSom = 300;  
unsigned long compriSonoro = 100; // Comprimento do som esperado
unsigned long time;
unsigned long startTime = 0;
 
void setup() {    
 pinMode(microfone, INPUT); // Inicia o pino do microfone como entrada
 pinMode(led, OUTPUT); // Inicia os pino do LED como saída
// Desliga LED (o LED é invertido HIGH = desliga / LOW = liga)
 digitalWrite(led, HIGH); 
}
 
void loop() { 
 // Inicia a contagem de tempo
 time = millis();
 // Verifica o tempo entre o pulso inicial e o seguinte
 unsigned long tempoAposPalma = time - startTime;
 
 if (tempoAposPalma >= compriSonoro && digitalRead(microfone) == LOW) {
 
 // Verifica se o pulso recebido respeita o intervalo entre 1 pulso e outro
 if (tempoAposPalma < tempMinSom || tempoAposPalma > tempMaxSom) {
   
 // Caso contrario o intervalo resetara a contagem e o tempo
 contPalmas = 0;
 startTime = millis();
 }
 else {
   
 // Iniciada a contagem de pulso e o tempo
 contPalmas ++;
 startTime = millis();
 }
 
 // Verifica se a contagem de palma é igual ou superior ao número... 
//esperado e se o LED esta desligado
if((contPalmas>=palmasRequeridaLigaLed-1)&&(digitalRead(led)==HIGH)){
   
 // Acende o LED e zera a contagem
 digitalWrite(led, LOW);
 contPalmas = 0;
 }
 
 // Verifica se a contagem de palma é igual ou superior ao número... 
//esperado e se o LED esta aceso
if((contPalmas>=palmasRequeridaDesligaLed-1)&&(digitalRead(led)==LOW)){
   
 // Desliga LED e zera contagem
 digitalWrite(led, HIGH);
 contPalmas = 0;
 }
 }
}
