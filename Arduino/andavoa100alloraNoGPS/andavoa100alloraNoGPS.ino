//SENZA GPS
#include <SPI.h>
#include <SD.h>
#include <Wire.h>

//const int MPU=0x68;

//accelerometer
int16_t AcX,AcY,AcZ,temp,GyX,GyY,GyZ;

#define TEMPERATURA_OFF (0<<7)|(0<<6)|(0<<5)|(0<<4)|(1<<3)|(0<<2)|(0<<1)|(0<<0)
#define TEMPERATURA_ON (0<<7)|(0<<6)|(0<<5)|(0<<4)|(0<<3)|(0<<2)|(0<<1)|(0<<0)
#define SET_2G ((0<<7)|(0<<6)|(0<<5)|(0<<4)|(0<<3)|(0<<2)|(0<<1)|(0<<0))
#define SET_4G ((0<<7)|(0<<6)|(0<<5)|(0<<4)|(1<<3)|(0<<2)|(0<<1)|(0<<0))
#define SET_8G ((0<<7)|(0<<6)|(0<<5)|(1<<4)|(0<<3)|(0<<2)|(0<<1)|(0<<0))
#define SET_16G ((0<<7)|(0<<6)|(0<<5)|(1<<4)|(1<<3)|(0<<2)|(0<<1)|(0<<0))
#define scale_factor_2G 16384.00
#define scale_factor_4G 8192.00
#define scale_factor_8G 4096.00
#define scale_factor_16G 2048.00



int count = 0; // number of read blocks. If blocks > 5, write on file

unsigned long t0; //accensione
unsigned long time_acc;

File dataFile;
String fileName;

int num = 0;

void setup() {

  //SERIAL SETUP
  Serial.begin(9600);


  //ACCELEROMETER SETUP
  Wire.begin();
  Wire.beginTransmission(0x68);
  Wire.write(0x6B); 
  Wire.write(0);    
  Wire.endTransmission(true);
  //******************************************************** 
  Wire.beginTransmission(0x68); 
  Wire.write(0x1C); //ACCEL_CONFIG register
  Wire.write(SET_4G);    // scrivere SET_2G SET_4G SET_8G SET_16G in base al fondoscala voluto
  Wire.endTransmission(true);

  //SD SETUP
  Serial.print("Initializing SD card...");
  if (!SD.begin(4)) {
    Serial.println("initialization failed!");
    while (1);
  }
  Serial.println("initialization done.");
  

  // choose file name
  while(SD.exists("NOGPS"+String(num)+".csv")){
    num++;
  }
  Serial.println("NOGPS"+String(num)+".csv");
  //CREATE FILES
  dataFile = SD.open("NOGPS"+String(num)+".csv", FILE_WRITE);
  
}


void loop() {
    //acc
    Wire.beginTransmission(0x68);
    Wire.write(0x3B);  
    Wire.endTransmission(false);
    Wire.requestFrom(0x68,14,true);  
    AcX=Wire.read()<<8|Wire.read();    
    AcY=Wire.read()<<8|Wire.read();  
    AcZ=Wire.read()<<8|Wire.read();
    temp = Wire.read()<<8|Wire.read(); 
    GyX=Wire.read()<<8|Wire.read();  
    GyY=Wire.read()<<8|Wire.read();  
    GyZ=Wire.read()<<8|Wire.read();

    unsigned long mm = millis();
    time_acc = mm;
    Serial.println(String(time_acc) + ", " + String(AcX) + ", " + String(AcY) + ", " + String(AcZ) + ", " + String(GyX) + ", " + String(GyY) + ", " + String(GyZ));

    dataFile.print("ACC"); 
    dataFile.print(", "); 
    dataFile.print(time_acc); 
    dataFile.print(", "); 
    dataFile.print((AcX/scale_factor_4G),4);
    dataFile.print(", "); 
    dataFile.print((AcY/scale_factor_4G),4);
    dataFile.print(", "); 
    dataFile.print((AcZ/scale_factor_4G),4);
    dataFile.print(", "); 
    dataFile.print(GyX);
    dataFile.print(", "); 
    dataFile.print(GyY);
    dataFile.print(", "); 
    dataFile.println(GyZ);
    delay(100);

    count++;

    if(count > 5){
      dataFile.close();
      dataFile = SD.open("NOGPS"+String(num)+".csv", FILE_WRITE);
      count = 0;
      Serial.println("*******************scritto");
    }
}
