// Programa : Teste LCD 20x4 Arduino
// Autor : Arduino e Cia

// Carrega a biblioteca do LCD
#include <LiquidCrystal.h>

// Inicializa o LCD
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

int i = 0;

void setup()
{
  // Define o LCD com 20 colunas e 4 linhas
  lcd.begin(20, 4);
  
  // Mostra informacoes no display
}

void loop()
{
  lcd.setCursor(0,0);
  lcd.print("L");
  lcd.setCursor(2,0);
  lcd.print("U");
  lcd.setCursor(4,0);
  lcd.print("C");
  lcd.setCursor(6,0);
  lcd.print("A");
  lcd.setCursor(8,0);
  lcd.print("S");

while (i < 19){
  lcd.setCursor(i,1);
  lcd.print("Dorador");

  if (i==19){
    i = 0;
  } else {
    i++;
  }

  delay(2000);
}
  
  lcd.setCursor(0,2);
  lcd.print("Fornaciari");
  lcd.setCursor(0,3);
  lcd.print("arduinoecia.com.br");
}

