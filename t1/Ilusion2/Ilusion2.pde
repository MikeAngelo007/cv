float a;
float b;
float c;
float d;
void setup() {
  size(600, 600);
  background(0);
  //a = height/2;
  //b = width/2;
  //c = height/2;
  //d = width/2;

  b = 0;
  d = 0;

  a = (-1)*(height/2);
  c = (-1)*(height/2);
}
void draw() {
  //background(0);
  stroke(255);
  noFill();

  for (int i=600; i >0; i-=25) {
    if (i%2 == 0) {
      fill(255);
      ellipse(300, 300, 0+i, 0+i);
    } else {
      fill(0);
      ellipse(300, 300, 0+i, 0+i);
    }
  }

  fill(255, 255, 255);
  //fill(0,0,0);
  ellipse(b, 260, 30, 15);
  ellipse(d, 340, 30, 15);

  fill(0, 0, 0);
  stroke(0);
  ellipse(260, c, 15, 30);
  ellipse(340, a, 15, 30);
  
  //ellipse(238, c, 15, 30);
  //ellipse(362, a, 15, 30);
  b = b + 5;
  if (b > width+(width/2)) { 
    b = 0;
  }
  d = d + 5;
  if (d > width+(width/2)) { 
    d = 0;
  }

  a = a + 5;
  if (a > height) {
    a = (-1)*(height/2);
  }
  c = c + 5;
  if (c > height) {
    c = (-1)*(height/2);
  }
  //a = a - 3;
  //if (a < 0) { 
  //  a = height/2; 
  //}
  //b = b - 3;
  //if (b < 0) { 
  //  b = width/2; 
  //}
  //c = c + 3;
  //if (c > height) { 
  //  c = height/2; 
  //}
  //d = d + 3;
  //if (d > width) { 
  //  d = width/2; 
  //}

  if (mousePressed == true) {
    for (int i=600; i >0; i-=25) {
      if (i%2 == 0) {
        fill(0);
        ellipse(300, 300, 0+i, 0+i);
      } else {
        fill(255);
        ellipse(300, 300, 0+i, 0+i);
      }
    }
    fill(255, 255, 255);
    //fill(0,0,0);
    ellipse(b, 260, 30, 15);
    ellipse(d, 340, 30, 15);

    fill(0, 0, 0);
    stroke(0);
    ellipse(260, c, 15, 30);
    ellipse(340, a, 15, 30);
    b = b + 5;
    if (b > width+(width/2)) { 
      b = 0;
    }
    d = d + 5;
    if (d > width+(width/2)) { 
      d = 0;
    }

    a = a + 5;
    if (a > height) {
      a = (-1)*(height/2);
    }
    c = c + 5;
    if (c > height) {
      c = (-1)*(height/2);
    }
  }
  
  //mousePressed();
}

void mousePressed(){
  for (int i=600; i >0; i-=25) {
      if (i%2 == 0) {
        fill(0);
        ellipse(300, 300, 0+i, 0+i);
      } else {
        fill(255);
        ellipse(300, 300, 0+i, 0+i);
      }
    }
    fill(255, 255, 255);
    //fill(0,0,0);
    ellipse(b, 260, 30, 15);
    ellipse(d, 340, 30, 15);

    fill(0, 0, 0);
    stroke(0);
    ellipse(260, c, 15, 30);
    ellipse(340, a, 15, 30);
    b = b + 5;
    if (b > width+(width/2)) { 
      b = 0;
    }
    d = d + 5;
    if (d > width+(width/2)) { 
      d = 0;
    }

    a = a + 5;
    if (a > height) {
      a = (-1)*(height/2);
    }
    c = c + 5;
    if (c > height) {
      c = (-1)*(height/2);
    }
}
