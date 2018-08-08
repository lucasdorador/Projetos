//correçao do erro

//rodar antes do codigo acima

// Date and time functions using a DS1307 RTC connected via I2C and Wire lib

#include <Wire.h>
#include "RTClib.h"

RTC_DS1307 RTC;

char daysOfTheWeek[7][13] = {"Domingo", "Segunda-Feira", "Terça-Feira", "Quarta-Feira", "Quinta-Feira", "Sexta-Feira", "Sábado"};

void setup () {
  Serial.begin(57600);
  Wire.begin();
  RTC.begin();
  //RTC.adjust(DateTime(__DATE__, __TIME__));

  if (!RTC.isrunning()) {
    // following line sets the RTC to the date & time this sketch was compiled
    RTC.adjust(DateTime(__DATE__, __TIME__));
  }
}

void loop () {
   Data_e_Hora();
}

void Data_e_Hora(){
  DateTime now = RTC.now();
  char Hora[16];
  char Data[16];

  sprintf(Hora,"%02u:%02u:%02u", now.hour(),now.minute(),now.second());  
  sprintf(Data,"%02d/%02d/%02d", now.day(),now.month(),now.year());    
   
  Serial.print(Data);
  Serial.print(' ');
  Serial.print(Hora);  
  Serial.print(' ');
  Serial.print(daysOfTheWeek[now.dayOfTheWeek()]);
  Serial.println();
  delay(1000); 
}

