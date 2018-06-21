#include <Thermistor.h>
Thermistor temp(0); 
float seno;
int frequencia;


void setup() {
Serial.begin(9600);
}
void loop() {
int temperature = temp.getTemp();
Serial.print("Temperatura: ");
Serial.print(temperature);
Serial.println("°C");

if ((temperature > 26) and (temperature < 28)) {
   for(int x=0;x<180;x++){
    //converte graus para radiando e depois obtém o valor do seno
    seno=(sin(x*3.1416/180));
    //gera uma frequência a partir do valor do seno
    frequencia = 2000+(int(seno*1000));
    tone(6,frequencia);
    delay(10);
  }
}
else if (temperature > 28){
   for(int x=0;x<180;x++){
    //converte graus para radiando e depois obtém o valor do seno
    seno=(sin(x*3.1416/180));
    //gera uma frequência a partir do valor do seno
    frequencia = 2000+(int(seno*1000));
    tone(6,frequencia);
    delay(2);
   }}
else{
    noTone(6);
    }
}
