// Definir el pin utilizado para el sensor de temperatura
const int tempPin = A0;
const int controlPin = 9; // Pin digital del dispositivo de control
const float tempSetpoint = 100.0; // Temperatura deseada en grados Celsius
const float Kp = 40; // Factor de proporcionalidad

void setup() {
  pinMode(controlPin, OUTPUT);
  // Iniciar la comunicación serial a una velocidad de 9600 baudios
  Serial.begin(9600);
}

void loop() {
  // Leer la temperatura actual del sensor
  float temp = analogRead(tempPin); // leer el pin de entrada analógico
  temp = (((5 * temp)*100)/1023); // Convertir la lectura del sensor a grados Celsius
  float error = tempSetpoint - temp; // Cálculo del error de temperatura
  float controlOutput = Kp * error; // Cálculo de la señal de control

   // Ajustar la salida del controlador en el pin digital
  if (controlOutput > 255) {
    controlOutput = 255;
  }
  else if (controlOutput < 0) {
    controlOutput = 0;
  }
  analogWrite(controlPin, controlOutput);
  
  // Enviar la temperatura por el puerto serie
  Serial.println(temp);
  // Imprimir el valor de temperatura en la consola del Monitor Serie
  Serial.print("Temperatura: ");
  Serial.print(temp);
  Serial.print(" °C - Error: ");
  Serial.print(error);
  Serial.print(" - Salida de control: ");
  Serial.println(controlOutput);
  
  // Esperar un tiempo antes de volver a leer la temperatura
}