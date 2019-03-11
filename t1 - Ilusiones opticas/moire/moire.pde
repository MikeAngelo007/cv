float[][] distances;
float maxDistance;
int spacer;

void setup() {
  size(800, 800);
  maxDistance = dist(width/2, height/2, width, height);
  distances = new float[width][height];
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      float distance = dist(width/2, height/2, x, y);
      distances[x][y] = distance/maxDistance * 255;
    }
  }
  spacer = 17;
  strokeWeight(8);
}

void draw() {
  background(255);
  for (int y = 0; y < height; y += spacer) {
    for (int x = 0; x < width; x += spacer) {
      stroke(distances[x][y], 122, 122);
      point(x + spacer/2, y + spacer/2);
    }
  }
  
  rotate(TWO_PI/(mouseX/4));
  translate((mouseX-(width)),(mouseY-(height)));
  for (int y = 0; y < height*2; y += spacer) {
    for (int x = 0; x < width*2; x += spacer) {
      stroke(0);
      point(x + spacer/2, y + spacer/2);
    }
  }
}
