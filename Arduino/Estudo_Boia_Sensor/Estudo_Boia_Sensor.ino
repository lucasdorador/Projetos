int pinoSensorPIR = 3;
int pinoBoia = 4;
int pinoMotor = 5;
int pinoLEDFuncionando = 6;
int pinoLEDParado = 7;
int pinoLEDSemAgua = 12;
int vliRespBoia = 0;
int vliRespSensorPIR = 0;

void setup() {
  Serial.begin(9600);
  pinMode(pinoSensorPIR, INPUT);
  pinMode(pinoBoia, INPUT);
  pinMode(pinoMotor, OUTPUT);
  pinMode(pinoLEDFuncionando, OUTPUT);
  pinMode(pinoLEDParado, OUTPUT);
  pinMode(pinoLEDSemAgua, OUTPUT);
  digitalWrite(pinoMotor, LOW);
}

void loop() {
  vliRespBoia = digitalRead(pinoBoia);
  vliRespSensorPIR = digitalRead(pinoSensorPIR);

  Serial.print("Resposta Boia: ");
  Serial.println(vliRespBoia);
  Serial.print("Resposta Sensor: ");
  Serial.println(vliRespSensorPIR);
  delay(1000);

  if ((vliRespSensorPIR == 1) && (vliRespBoia == 1)) {
    Serial.println("Ligou Motor");
    digitalWrite(pinoMotor, LOW);
    digitalWrite(pinoLEDFuncionando, HIGH);
    digitalWrite(pinoLEDParado, LOW);
  } else {
    Serial.println("Desligou Motor");
    digitalWrite(pinoMotor, HIGH);
    digitalWrite(pinoLEDFuncionando, LOW);
    digitalWrite(pinoLEDParado, HIGH);
  }

  if (vliRespBoia == 0) {
    digitalWrite(pinoLEDSemAgua, HIGH);
  } else {
    digitalWrite(pinoLEDSemAgua, LOW);
  }
}
