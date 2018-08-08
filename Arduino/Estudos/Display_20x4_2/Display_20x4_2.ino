/*
 * Firmware para controlar um display LCD 16x2 by TecDicas
 * Biblioteca/Library : LiquidCrystal
 * 27/10/2017
 */
#include <LiquidCrystal.h> // Adiciona a biblioteca "LiquidCrystal" ao projeto

LiquidCrystal lcd(12, 13, 7, 6, 5, 4); // Pinagem do LCD

void setup()
{
  lcd.begin(16, 2); // Inicia o lcd de 16x2
}

void loop()
{
  lcd.clear();              // Limpa o display
  lcd.setCursor(2, 0);      // 2 = 2 colunas para a direita. 0 = Primeira linha
  lcd.print("Display LCD"); // Imprime um texto
  lcd.setCursor(2, 1);      // 2 = 2 colunas para a direita. 1 = Segunda linha
  lcd.print("* tecdicas.com *"); 
  delay(5000);              // 5 segundos de delay
  
  lcd.clear(); 
  lcd.setCursor(3, 0);
  lcd.print("Ola Mundo!");  
  delay(5000);
}
