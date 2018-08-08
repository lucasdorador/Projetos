// Programa : Teste LCD 20x4 Arduino
// Autor : Arduino e Cia

// Carrega a biblioteca do LCD
#include <LiquidCrystal.h>

// Inicializa o LCD
LiquidCrystal lcd(12, 13, 7, 6, 5, 4);

void setup()
{
  // Define o LCD com 20 colunas e 4 linhas
  lcd.begin(20, 4);
  
  // Mostra informacoes no display
  lcd.setCursor(3,0);
  lcd.print("Arduino e Cia");
  lcd.setCursor(2,1);
  lcd.print("Display LCD 20x4");
  lcd.setCursor(0,2);
  lcd.print("LUCAS DORADOR FORNAC");
  lcd.setCursor(1,3);
  lcd.print("arduinoecia.com.br");
}

void loop()
{
  // Seu codigo aqui
}
