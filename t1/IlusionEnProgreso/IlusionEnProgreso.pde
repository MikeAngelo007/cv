float acel;
float a;
void setup() {
  size(700, 700);
  background(0);
  acel = 0;
  
  a=3;
}

void draw() {
  background(0);
  stroke(255);

  for (int i =0; i<495; i+=10) {
    line(5+i, 0, 105+i, 100);
  }
  for (int i =0; i<500; i+=10) {
    line(0, 5+i, 100, 105+i);
  }

  for (int i =0; i<495; i+=10) {
    line(105+i, 600, 205+i, 700);
  }
  for (int i =0; i<500; i+=10) {
    line(600, 105+i, 700, 205+i);
  }


  for (int i =0; i<200; i+=10) { 
    line(505+i, 0, 700, 195-i);
  }

  for (int i =0; i<200; i+=10) { // y aqui
    line(0, 505+i, 195-i, 700);
  }
  
  for (int i =0; i<200; i+=10) {
    line(100, 105+i, 105+i, 100);
  }
  for (int i =300; i<495; i+=10) {
    line(105+i, 600, 600, 105+i);
  }

  for (int i =0; i<295; i+=10) {
    line(100, 305+i, 200, 205+i);
  }
  for (int i =0; i<295; i+=10) {
    line(105+i, 600, 205+i, 500);
  }
  for (int i =0; i<295; i+=10) {
    line(205+i, 200, 305+i, 100);
  }

  for (int i =0; i<295; i+=10) {
    line(500, 205+i, 600, 105+i);
  }

  ////////////////////////////////
  
  
  for (int i =0; i<95; i+=10) {
    line(200, 205+i, 300, 305+i);
  }
  
  for (int i =0; i<95; i+=10) {
    line(205+i, 200, 305+i, 300);
  }
  
  for (int i =0; i<95; i+=10) {
    line(400, 305+i, 500, 405+i);
  }
  
  for (int i =0; i<95; i+=10) {
    line(305+i, 400, 405+i, 500);
  }
  
  
  for (int i =0; i<200; i+=10) {
    line(495-i, 200, 500, 205+i);
  }
  
  for (int i =0; i<200; i+=10) {
    line(200, 305+i, 395-i, 500);
  }
  
  ///////////////////////////////////////////
  
  
  for (int i =0; i<100; i+=10) {
    line(300, 305+i, 305+i, 300);
  }
  
  for (int i =0; i<100; i+=10) {
    line(305+i, 400, 400, 305+i);
  }
  
  
  
  
  
  
  
 ///////////////// Replica
 
 
 
 for (int i =0; i<495; i+=10) {
    line(acel+width+5+i, 0, acel+width+105+i, 100);
  }
  for (int i =0; i<500; i+=10) {
    line(acel+width+0, 5+i, acel+width+100, 105+i);
  }

  for (int i =0; i<495; i+=10) {
    line(acel+width+105+i, 600, acel+width+205+i, 700);
  }
  for (int i =0; i<500; i+=10) {
    line(acel+width+600, 105+i, acel+width+700, 205+i);
  }


  for (int i =0; i<200; i+=10) { 
    line(acel+width+505+i, 0, acel+width+700, 195-i);
  }

  for (int i =0; i<200; i+=10) { // y acelqui
    line(acel+width+0, 505+i, acel+width+195-i, 700);
  }
  
  for (int i =0; i<200; i+=10) {
    line(acel+width+100, 105+i, acel+width+105+i, 100);
  }
  for (int i =300; i<495; i+=10) {
    line(acel+width+105+i, 600, acel+width+600, 105+i);
  }

  for (int i =0; i<295; i+=10) {
    line(acel+width+100, 305+i, acel+width+200, 205+i);
  }
  for (int i =0; i<295; i+=10) {
    line(acel+width+105+i, 600, acel+width+205+i, 500);
  }
  for (int i =0; i<295; i+=10) {
    line(acel+width+205+i, 200, acel+width+305+i, 100);
  }

  for (int i =0; i<295; i+=10) {
    line(acel+width+500, 205+i, acel+width+600, 105+i);
  }

  ////////////////////////////////
  
  
  for (int i =0; i<95; i+=10) {
    line(acel+width+200, 205+i, acel+width+300, 305+i);
  }
  
  for (int i =0; i<95; i+=10) {
    line(acel+width+205+i, 200, acel+width+305+i, 300);
  }
  
  for (int i =0; i<95; i+=10) {
    line(acel+width+400, 305+i, acel+width+500, 405+i);
  }
  
  for (int i =0; i<95; i+=10) {
    line(acel+width+305+i, 400, acel+width+405+i, 500);
  }
  
  
  for (int i =0; i<200; i+=10) {
    line(acel+width+495-i, 200, acel+width+500, 205+i);
  }
  
  for (int i =0; i<200; i+=10) {
    line(acel+width+200, 305+i, acel+width+395-i, 500);
  }
  
  ///////////////////////////////////////////
  
  
  for (int i =0; i<100; i+=10) {
    line(acel+width+300, 305+i, acel+width+305+i, 300);
  }
  
  for (int i =0; i<100; i+=10) {
    line(acel+width+305+i, 400, acel+width+400, 305+i);
  }
  
  
  
  
  if(mousePressed == true){
    acel=acel - a;
    if(acel == -(width*2)){
      acel = 0;
    }
  }
  
  
  
  
}
