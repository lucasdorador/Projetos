#define LIGA  LOW
#define DESLIGA HIGH

int const pinoSensorPIR = 3;
int const pinoBoia = 4;
int const pinoMotor = 5;
int const pinoLEDFuncionando = 6;
int const pinoLEDParado = 7;
int const pinoLEDS,emAgua = 12;
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
  Sensor(DESLIGA);
}

void loop() {
  vliRespBoia      = digitalRead(pinoBoia);
  vliRespSensorPIR = digitalRead(pinoSensorPIR);

  //Serial.print("Resposta Boia: ");
  //Serial.println(vliRespBoia);
  //Serial.print("Resposta Sensor: ");
  //Serial.println(vliRespSensorPIR);
  delay(100);

  if ((vliRespSensorPIR == 1) && (vliRespBoia == 1)) {
    //Serial.println("Ligou Motor");
    Sensor(LIGA);
    digitalWrite(pinoLEDFuncionando, HIGH);
    digitalWrite(pinoLEDParado, LOW);
    delay(5);
  } else {
    //Serial.println("Desligou Motor");
    Sensor(DESLIGA);
    digitalWrite(pinoLEDFuncionando, LOW);
    digitalWrite(pinoLEDParado, HIGH);
    delay(5);
  }

  if (vliRespBoia == 0) {
    digitalWrite(pinoLEDSemAgua, HIGH);
  } else {
    digitalWrite(pinoLEDSemAgua, LOW);
  }
}

void Sensor (int ligadesliga){
  digitalWrite(pinoMotor, ligadesliga); 
}
