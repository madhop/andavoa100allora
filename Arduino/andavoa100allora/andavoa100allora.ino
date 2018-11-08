#include <TinyGPS++.h>
#include <SoftwareSerial.h>
#include <SPI.h>
#include <SD.h>
#include <Wire.h>

//const int MPU=0x68;

//accelerometer
int16_t AcX,AcY,AcZ,Tmp,GyX,GyY,GyZ;

//gps
//static const int RXPin = 10, TXPin = 11;
//static const uint32_t GPSBaud = 9600;
// The TinyGPS++ object
TinyGPSPlus gps;
// The serial connection to the GPS device
SoftwareSerial ss(6,5);

//static const int n_blocks = 10;

int count = 0; // number of read blocks. If blocks > 5, write on file

unsigned long time_gps;
unsigned long t0; //accensione
unsigned long time_acc;
unsigned long gps_delay;

File dataFile;
String fileName;

int num = 0;

void setup() {

  //SERIAL SETUP
  Serial.begin(9600);

  //GPS SETUP
  ss.begin(9600);

  //ACCELEROMETER SETUP
  Wire.begin();
  Wire.beginTransmission(0x68);
  Wire.write(0x6B); 
  Wire.write(0);    
  Wire.endTransmission(true);

  //SD SETUP
  Serial.print("Initializing SD card...");
  if (!SD.begin(4)) {
    Serial.println("initialization failed!");
    while (1);
  }
  Serial.println("initialization done.");
  

  // chose file name
  /*while(SD.exists("AAA"+String(num)+".csv")){
    num++;
  }
  Serial.println("AAA"+String(num)+".csv");
  Serial.println("GGG"+String(num)+".csv");
  //CREATE FILES
  accDataFile = SD.open("AAA"+String(num)+".csv", FILE_WRITE);
  //gpsDataFile = SD.open("G_"+String(num)+".csv", FILE_WRITE);
  gpsDataFile = SD.open("GGG"+String(num)+".csv", FILE_WRITE);*/
  //FILE SETUP
  bool looppa = true;
  while(looppa){
    while (looppa && ss.available() > 0){
        gps.encode(ss.read());
        if (gps.location.isUpdated()){
          time_gps = gps.time.value();
          //unsigned long mmm = millis();
          //t0 = mmm; //time_gps - mmm + gps_delay;  // tempo dell'accensione rispetto al tempo del GPS
          t0 = time_gps;
          looppa = false;
       }
   }
  }
  
  fileName = String(time_gps);
  fileName = String(fileName[0]) + String(fileName[1]) + String(fileName[2]) + String(fileName[3]) + String(fileName[4]) + String(fileName[5]);
  // open the file. note that only one file can be open at a time
  Serial.println(fileName+".csv");
  dataFile = SD.open(fileName+".csv", FILE_WRITE);
}


void loop() {
    //gps
    while (ss.available() > 0){
     
        gps.encode(ss.read());
        if (gps.location.isUpdated()){
          time_gps = t0 + millis();//gps.time.value();
         
          Serial.print("Latitude = "); 
          Serial.print(gps.location.lat(), 6);
          Serial.print(" Longitude = "); 
          Serial.print(gps.location.lng(), 6);
          Serial.print(" Time = ");
          Serial.println(time_gps);

          dataFile.print("GPS"); 
          dataFile.print(", "); 
          dataFile.print(time_gps); 
          dataFile.print(", "); 
          dataFile.print(gps.location.lat(), 6);
          dataFile.print(", "); 
          dataFile.println(gps.location.lng(), 6);

          count += 1;
       }
    }

    
    //acc
    Wire.beginTransmission(0x68);
    Wire.write(0x3B);  
    Wire.endTransmission(false);
    Wire.requestFrom(0x68,12,true);  
    AcX=Wire.read()<<8|Wire.read();    
    AcY=Wire.read()<<8|Wire.read();  
    AcZ=Wire.read()<<8|Wire.read();  
    GyX=Wire.read()<<8|Wire.read();  
    GyY=Wire.read()<<8|Wire.read();  
    GyZ=Wire.read()<<8|Wire.read();

    unsigned long mm = millis();
    time_acc = mm + t0;
    Serial.println(String(time_acc) + ", " + String(AcX) + ", " + String(AcY) + ", " + String(AcZ) + ", " + String(GyX) + ", " + String(GyY) + ", " + String(GyZ));

    dataFile.print("ACC"); 
    dataFile.print(", "); 
    dataFile.print(time_acc); 
    dataFile.print(", "); 
    dataFile.print(AcX);
    dataFile.print(", "); 
    dataFile.print(AcY);
    dataFile.print(", "); 
    dataFile.print(AcZ);
    dataFile.print(", "); 
    dataFile.print(GyX);
    dataFile.print(", "); 
    dataFile.print(GyY);
    dataFile.print(", "); 
    dataFile.println(GyZ);
    //delay(333);

    if(count > 5){
      dataFile.close();
      dataFile = SD.open(fileName+".csv", FILE_WRITE);
      count = 0;
      Serial.println("*******************scritto");
    }
}
