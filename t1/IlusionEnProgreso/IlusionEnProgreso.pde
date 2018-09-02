float w;
float h;
float hi;
float wi;

int tick;
float vel;
void setup(){
  size(1000,500);
  background(0);
  w = 500;
  h = 250;
  wi = 0;
  hi = 0;
  tick = 0;
  vel = 0.5;
}
void draw(){
  background(0);
  
  stroke(255);
  noFill();
  
  for(int i = 0; i < width/2; i+=50){
    rect(w-i,h-(i/2),(i+wi)*2,i+hi);
  }
  
  
  w = w - vel;
  if(w < 0){
    w = width/2;
  }
  
  h = h - vel/2;
  if(h < 0){
    h = height/2;
  }
  
  wi = wi + vel;
  if(wi > width){
    wi = width/2;
  }
  
  hi = hi + vel;
  if(hi > height){
    hi = height/2;
  }
  
  
}
