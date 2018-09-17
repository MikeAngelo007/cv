float[] coswave; 

void setup() {
  size(800, 500);
  background(255);
}

void draw() {
  paintBackground();
  fill(128,128,128);
  stroke(128,128,128);
  rect(100, height/2, 600,100);
 
}

void paintBackground() {
  
  coswave = new float[width];
  for (int i = 0; i < width; i++) {
    float amount = map(i, 0, width, 0, PI);
    coswave[i] = abs(cos(amount));
  }
  
  for(int i = 0; i < mouseX; i++){
    stroke(255 - coswave[i/2]*255);
    line(i, 0, i, height);
  }
  
  for(int i = mouseX; i < width; i++){
    stroke(255);
    line(i, 0, i, height);
  }
}
