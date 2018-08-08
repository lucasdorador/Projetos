/*
   Curso de Arduino WR Kits Aula 29

   www.wrkits.com.br
   facebook.com/wrkits
   youtube.com/user/canalwrkits

   Menu para Display LCD 16 x 2

   Autor: Eng. Wagner Rambo, Data: Agosto de 2015

*/

// --- Bibliotecas Auxiliares ---
#include <LiquidCrystal.h>                              //Biblioteca para o display LCD
#include <Thermistor.h>                                 //Biblioteca para o Sensor de Temperatura
#include <Wire.h>
#include "RTClib.h"                                     //Biblioteca para o Relogio

// --- Mapeamento de Hardware ---
#define butUp      12                                   //Botão para selecionar tela acima no digital 12
#define butDown    11                                   //Botão para selecionar tela abaixo no digital 11
#define butP       10                                   //Botão de ajuste mais no digital 10
#define butM        9                                   //Botão de ajuste menos no digital 9
#define Lamp1      A0                                   //Saída para lâmpada 1 no A0 (será usado como digital)
#define Lamp2      A1                                   //Saída para lâmpada 2 no A1 (será usado como digital)
#define SensorTemp  2                                   //Entrada para o Sensor de Temperatura. A2

// --- Protótipo das Funções Auxiliares ---
void changeMenu();                                      //Função para modificar o menu atual
void dispMenu();                                        //Função para mostrar o menu atual
void data_hora();                                       //Função do menu1, data e hora
void temperatura();                                     //Função do menu2, temperatura
void lights();                                          //Função do menu3, acionamento de lampadas
void menu4();                                           //Função do menu4

// --- Variáveis Globais ---
char menu = 0x01;                                       //Variável para selecionar o menu
char set1 = 0x00, set2 = 0x00;                          //Controle das lâmpadas
boolean t_butUp, t_butDown, t_butP, t_butM;             //Flags para armazenar o estado dos botões
float ldrValor = 0;                                     //Variavel para receber o valor do SensorTemp
long previousMillis = 0;                                // Variável de controle do tempo

// --- Hardware do LCD ---
LiquidCrystal disp(7,  //RS no digital 7
                   6,  //EN no digital 6
                   5,  //D4 no digital 5
                   4,  //D5 no digital 4
                   3,  //D6 no digital 3
                   2); //D7 no digital 2

// --- Hardware do Relogio ---
RTC_DS1307 RTC;
char daysOfTheWeek[7][13] = {"Domingo", "Segunda-Feira", "Terca-Feira", "Quarta-Feira", "Quinta-Feira", "Sexta-Feira", "Sabado"};

// --- Hardware do Thermistor ---
Thermistor temp(SensorTemp);

// --- Configurações Iniciais ---
void setup()
{
  Wire.begin();
  RTC.begin();

  //RTC.adjust(DateTime(__DATE__, __TIME__));

  if (!RTC.isrunning()) {
    // following line sets the RTC to the date & time this sketch was compiled
    RTC.adjust(DateTime(__DATE__, __TIME__));
  }

  previousMillis = millis();
  disp.begin(20, 4);                                     //Inicializa LCD 20 x 4

  for (char i = 9; i < 13; i++) pinMode(i, INPUT_PULLUP); //Entrada para os botões (digitais 9 a 12) com pull-ups internos

  pinMode(Lamp1, OUTPUT);                                //Configura saída para lâmpada 1
  pinMode(Lamp2, OUTPUT);                                //Configura saída para lâmpara 2

  t_butUp   = 0x00;                                      //limpa flag do botão Up
  t_butDown = 0x00;                                      //limpa flag do botão Down
  t_butP    = 0x00;                                      //limpa flag do botão P
  t_butM    = 0x00;                                      //limpa flag do botão M

  digitalWrite(Lamp1, LOW);                              //Lâmpada 1 inicia apagada
  digitalWrite(Lamp2, HIGH);                             //Lâmpada 2 inicia apagada


} //end setup


// --- Loop Infinito ---
void loop()
{
  changeMenu();
  dispMenu();
} //end loop

// --- Desenvolvimento das Funções Auxiliares ---
void changeMenu()                                       //Modifica o menu atual
{
  if (!digitalRead(butUp))   t_butUp   = 0x01;         //Botão Up pressionado? Seta flag
  if (!digitalRead(butDown)) t_butDown = 0x01;         //Botão Down pressionado? Seta flag

  if (digitalRead(butUp) && t_butUp)                   //Botão Up solto e flag setada?
  { //Sim...
    t_butUp = 0x00;                                   //Limpa flag

    disp.clear();                                     //Limpa display
    menu++;                                           //Incrementa menu

    if (menu > 0x04) menu = 0x01;                     //Se menu maior que 4, volta a ser 1

  } //end butUp

  if (digitalRead(butDown) && t_butDown)               //Botão Down solto e flag setada?
  { //Sim...
    t_butDown = 0x00;                                 //Limpa flag

    disp.clear();                                     //Limpa display
    menu--;                                           //Decrementa menu

    if (menu < 0x01) menu = 0x04;                     //Se menu menor que 1, volta a ser 4

  } //end butDown

} //end changeMenu

void dispMenu()                                         //Mostra o menu atual
{
  switch (menu)                                       //Controle da variável menu
  {
    case 0x01:                                       //Caso 1
      data_hora();                               //Chama a função de relógio

      break;                                     //break
    case 0x02:                                       //Caso 2
      temperatura();                             //Chama a função do termômetro

      break;                                     //break
    case 0x03:                                       //Caso 3
      lights();                                  //Chama função para acionamento de lâmpadas

      break;                                     //break
    case 0x04:                                       //Caso 4
      menu4();                                   //Chama função para o menu4

      break;                                     //break

  } //end switch menu

} //end dispMenu

void data_hora()                                        //Data e Hora (menu1)
{
  long redLedInterval = 1000;                           // Tempo em ms do intervalo a ser executado
  unsigned long currentMillis = millis();               //Tempo atual em ms

  if (currentMillis - previousMillis > redLedInterval) {
    previousMillis = currentMillis;
    DateTime now = RTC.now();
    char Hora[16];
    char Data[16];
    int espacoDiaSemana = 0;
    String diadasemana = "";

    sprintf(Hora, "%02u:%02u:%02u", now.hour(), now.minute(), now.second());
    sprintf(Data, "%02d/%02d/%02d", now.day(), now.month(), now.year());

    disp.setCursor(4, 0);
    disp.print("DATA e HORA");
    disp.setCursor(5, 1);
    disp.print(Data);
    diadasemana = daysOfTheWeek[now.dayOfTheWeek()];
    espacoDiaSemana = diadasemana.length();
    espacoDiaSemana = (int) (20 - espacoDiaSemana) / 2;
    disp.setCursor(espacoDiaSemana, 2);
    disp.print(diadasemana);
    disp.setCursor(6, 3);
    disp.print(Hora);
  }
}

void temperatura()                                      //Temperatura (menu2)
{
  long redLedInterval = 1000;                           // Tempo em ms do intervalo a ser executado
  unsigned long currentMillis = millis();               //Tempo atual em ms

  disp.setCursor(4, 1);                                 //Posiciona cursor na coluna 1, linha 1
  disp.print("Temperatura");                            //Imprime mensagem
  //Lógica de verificação do tempo
  if (currentMillis - previousMillis > redLedInterval) {
    previousMillis = currentMillis;                   // Salva o tempo atual
    ldrValor = temp.getTemp();                        //Captura o valor do sensorTemp
    disp.setCursor(6, 2);                             //Posiciona cursor na coluna 2, linha 2
    disp.print(ldrValor);                             //Mostrador (apenas ilustrativo......)
    disp.write(B11011111);                            // Imprime o símbolo de grau
    disp.print("C");
  }
} //end temperatura()

void lights()                                           //Acionamento de lâmpadas (menu3)
{

  disp.setCursor(0, 0);                                //Posiciona cursor na coluna 1, linha 1
  disp.print("Acionar Lampadas");                      //Imprime mensagem do menu 3


  if (!digitalRead(butP))    t_butP    = 0x01;         //Botão P pressionado? Seta flag
  if (!digitalRead(butM))    t_butM    = 0x01;         //Botão M pressionado? Seta flag

  if (digitalRead(butP) && t_butP)                     //Botão P solto e flag setada?
  { //Sim...
    t_butP = 0x00;                                    //Limpa flag

    set1++;                                           //Incrementa set1

    if (set1 > 2) set1 = 0x01;                        //Se maior que 2, volta a ser 1

    switch (set1)                                     //Controle do set1
    {
      case 0x01:                                    //Caso 1
        disp.setCursor(0, 1);                   //Posiciona cursor na coluna 1, linha 2
        disp.print("L1 on ");                   //Imprime mensagem
        digitalWrite(Lamp1, HIGH);              //Liga lâmpada 1
        break;                                  //Break
      case 0x02:                                    //Caso 2
        disp.setCursor(0, 1);                   //Posiciona cursor na coluna 1, linha 2
        disp.print("L1 off");                   //Imprime mensagem
        digitalWrite(Lamp1, LOW);               //Desliga lâmpada 1
        break;                                  //Break

    } //end switch set1

  } //end butP

  if (digitalRead(butM) && t_butM)                     //Botão D solto e flag setada?
  { //Sim...
    t_butM = 0x00;                                    //Limpa flag

    set2++;                                           //Incrementa set2

    if (set2 > 2) set2 = 0x01;                        //Se maior que 2, volta a ser 1

    switch (set2)                                     //Controle do set2
    {
      case 0x01:                                    //Caso 1
        disp.setCursor(8, 1);                   //Posiciona cursor na coluna 8, linha 2
        disp.print("L2 OFF ");                   //Imprime mensagem
        digitalWrite(Lamp2, HIGH);              //Liga lâmpada 2
        break;                                  //Break
      case 0x02:                                    //Caso 2
      
        disp.setCursor(8, 1);                   //Posiciona cursor na coluna 8, linha 2
        disp.print("L2 ON ");                   //Imprime mensagem
        digitalWrite(Lamp2, LOW);               //Liga lâmpada 1
        break;                                  //Break

    } //end switch set1

  } //end butM


} //end lights

void menu4()                                            //Função genérica para um quarto menu...
{
  disp.setCursor(0, 0);                                //Posiciona cursor na coluna 1, linha 1
  disp.print("Menu 4");                                //Imprime mensagem
  disp.setCursor(7, 1);                                //Posiciona cursor na coluna 8, linha 2

  // Desenvolver uma função de data e hora...

  disp.print("LUCAS D.");                               //Créditos


} //end menu4
//pode-se implementar quantos menus quiser
//............
