void setup() {
  size(500, 500);
}

void draw() {
  background(0);
  
  pushMatrix();
  fill(0,249,0);
  translate(width/2, height/2);
  rotate(frameCount / 100.0);
  polygon(0, 0, 200, 4);
  popMatrix();
  
  int sizeBox = (mouseX%250);
  fill(255,249,0);
  noStroke();
  rect(0,0,sizeBox,sizeBox);
  rect(0,height-sizeBox,sizeBox,sizeBox);
  rect(width-sizeBox,0,sizeBox,sizeBox);
  rect(width-sizeBox,height-sizeBox,sizeBox,sizeBox);
 
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
