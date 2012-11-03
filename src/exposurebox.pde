// include the library code:
#include <LiquidCrystal.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(7, 8, 9, 10, 11, 12);
int time = 0;
int curSecs = 59;
const int buttonMin = 2;
const int buttonPlu = 3;
const int buttonSet = 4;
const int transistor = 5;
int minState = 0;
int plusState = 0;
int setState = 0;

void setup() {
  pinMode(buttonMin, INPUT);
  pinMode(buttonPlu, INPUT);
  pinMode(buttonSet, INPUT);
  pinMode(transistor, OUTPUT);
  digitalWrite(transistor, LOW);
  // set up the LCD's number of columns and rows: 
  lcd.begin(16, 2);
  // Print a message to the LCD.
  lcd.print(" THBOUNZER  EXP ");
  lcd.setCursor(0, 1);
  lcd.print("   BOX  TIMER   ");
  delay(3000);
  lcd.clear();
}

void loop() {
  lcd.print(" SEL  EXP TIME: ");
  lcd.setCursor(7, 1);
  if (time > 9){
    lcd.print(time);
  }else{
    lcd.print("0");
    lcd.print(time);
  }
  lcd.home();
  minState = digitalRead(buttonMin);
  plusState = digitalRead(buttonPlu);
  setState = digitalRead(buttonSet);
  if ( (minState == HIGH) && (time > 0) ) {         
    time--;      
    delay(300);
  }
  if (plusState == HIGH) {         
    time++;    
    delay(300);  
  }
  if ( (setState == HIGH) && (time > 0) ){
    delay(300);
    startTiming();
  } 
}

void startTiming(){
  lcd.clear();
  lcd.print(" BURNING BOARD! ");
  lcd.setCursor(0, 1);
  lcd.print("  TIME ");
  lcd.print(time);
  lcd.print(" min  ");
  delay(1500);
  digitalWrite(transistor, HIGH);
  time--;
  while(time > -1){
    lcd.clear();
    lcd.print("### EXPOSING ###");
    lcd.setCursor(6, 1);
    lcd.print(time);
    lcd.print(":");
    if (curSecs > 9){
      lcd.print(curSecs);
    }else{
      lcd.print("0");
      lcd.print(curSecs);
    }
    delay(1000);
    curSecs--;
    if (curSecs == 0){
      time--;
      if (time > -1){
        curSecs=59;
      }
    } 
  }
  time = 0;
  curSecs = 59;
  digitalWrite(transistor, LOW);
  lcd.clear();
  
}
