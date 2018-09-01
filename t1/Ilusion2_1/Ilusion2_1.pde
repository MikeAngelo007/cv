float a;
float b;
void setup() {
  size(800, 800);
  background(255);
  a=0;
  b=0;
}
void draw() {
  background(255);
  strokeWeight(1);
  fill(0);

  for (int i = -width; i < width; i+=40) {
    for (int j = 0; j < height; j+=40) {
      rect(a+i, j, 20, 20);
    }
  }
  for (int i = width*2; i > -width; i-=40) {
    for (int j = -20; j < height; j+=40) {
      rect(b+i-15, j, 20, 20);
    }
  }
  for (int j = 0; j < height; j+=20) {
    stroke(130, 130, 130);
    line(0, j, width, j);
  }

  if (mousePressed == true) {
    a = a+2;
    if (a > width) {
      a = 0;
    }
    b = b-2;
    if (b < -width) {
      b = 0;
    }
  }
}
