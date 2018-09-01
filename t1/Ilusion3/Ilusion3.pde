int c;
///Cuadrante 1
//blanco1
float c1b1x;
float c1b1y;
//blanco2
float c1b2x;
float c1b2y;
//negro1
float c1n1x;
float c1n1y;
//negro2
float c1n2x;
float c1n2y;

///Cuadrante 2
//blanco1
float c2b1x;
float c2b1y;
//blanco2
float c2b2x;
float c2b2y;
//negro1
float c2n1x;
float c2n1y;
//negro2
float c2n2x;
float c2n2y;

///Cuadrante 3
//blanco1
float c3b1x;
float c3b1y;
//blanco2
float c3b2x;
float c3b2y;
//negro1
float c3n1x;
float c3n1y;
//negro2
float c3n2x;
float c3n2y;

///Cuadrante 4
//blanco1
float c4b1x;
float c4b1y;
//blanco2
float c4b2x;
float c4b2y;
//negro1
float c4n1x;
float c4n1y;
//negro2
float c4n2x;
float c4n2y;

///mitad vertical superior
//blanco1
float mvsb1x;
float mvsb1y;
//blanco2
float mvsb2x;
float mvsb2y;
//negro1
float mvsn1x;
float mvsn1y;
//negro2
float mvsn2x;
float mvsn2y;

///mitad vertical inferior
//blanco1
float mvib1x;
float mvib1y;
//blanco2
float mvib2x;
float mvib2y;
//negro1
float mvin1x;
float mvin1y;
//negro2
float mvin2x;
float mvin2y;


///mitad horizontal izquierda
//blanco1
float mhib1x;
float mhib1y;
//blanco2
float mhib2x;
float mhib2y;
//negro1
float mhin1x;
float mhin1y;
//negro2
float mhin2x;
float mhin2y;


///mitad horizontal derecha
//blanco1
float mhdb1x;
float mhdb1y;
//blanco2
float mhdb2x;
float mhdb2y;
//negro1
float mhdn1x;
float mhdn1y;
//negro2
float mhdn2x;
float mhdn2y;

void setup() {
  size(660, 660);
  background(255);
  c = 0;


  ///Cuadrante 1
  //blanco1
  c1b1x=0;
  c1b1y=0;
  //blanco2
  c1b2x=0;
  c1b2y=0;
  //negro1
  c1n1x=0;
  c1n1y=0;
  //negro2
  c1n2x=0;
  c1n2y=0;

  ///Cuadrante 2
  //blanco1
  c2b1x=0;
  c2b1y=0;
  //blanco2
  c2b2x=0;
  c2b2y=0;
  //negro1
  c2n1x=0;
  c2n1y=0;
  //negro2
  c2n2x=0;
  c2n2y=0;

  ///Cuadrante 3
  //blanco1
  c3b1x=0;
  c3b1y=0;
  //blanco2
  c3b2x=0;
  c3b2y=0;
  //negro1
  c3n1x=0;
  c3n1y=0;
  //negro2
  c3n2x=0;
  c3n2y=0;

  ///Cuadrante 4
  //blanco1
  c4b1x=0;
  c4b1y=0;
  //blanco2
  c4b2x=0;
  c4b2y=0;
  //negro1
  c4n1x=0;
  c4n1y=0;
  //negro2
  c4n2x=0;
  c4n2y=0;

  ///mitad vertical superior
  //blanco1
  mvsb1x=0;
  mvsb1y=0;
  //blanco2
  mvsb2x=0;
  mvsb2y=0;
  //negro1
  mvsn1x=0;
  mvsn1y=0;
  //negro2
  mvsn2x=0;
  mvsn2y=0;

  ///mitad vertical inferior
  //blanco1
  mvib1x=0;
  mvib1y=0;
  //blanco2
  mvib2x=0;
  mvib2y=0;
  //negro1
  mvin1x=0;
  mvin1y=0;
  //negro2
  mvin2x=0;
  mvin2y=0;


  ///mitad horizontal izquierda
  //blanco1
  mhib1x=0;
  mhib1y=0;
  //blanco2
  mhib2x=0;
  mhib2y=0;
  //negro1
  mhin1x=0;
  mhin1y=0;
  //negro2
  mhin2x=0;
  mhin2y=0;


  ///mitad horizontal derecha
  //blanco1
  mhdb1x=0;
  mhdb1y=0;
  //blanco2
  mhdb2x=0;
  mhdb2y=0;
  //negro1
  mhdn1x=0;
  mhdn1y=0;
  //negro2
  mhdn2x=0;
  mhdn2y=0;
}

void draw() {
  background(255);
  fill(0);
  for (int i = 0; i < width; i+=120) {
    for (int j =0; j < height; j+=120) {
      rect(i, j, 60, 60);
    }
  }
  for (int i = 0; i < width; i+=120) {
    for (int j =0; j < height; j+=120) {
      rect(i+60, j+60, 60, 60);
    }
  }
  
  //Nota: Los cuadritos deben recorrer 30px, por lo tanto las coordenadas deben cambiar 30px en cada movimiento
  //////////////////////////////////////////////////////////////////////// Cuadros pequeños ///////////////////////////////////////////////////////77
  //////////////Cuadrante 1
  /// Blanco 1
  
  for (int i = 0; i < 300; i+=120) {
    for (int j =0; j < 300; j+=120) {
      fill(255);
      rect(c1b1x+i+10, c1b1y+j+10, 10, 10);
    }
  }
  for (int i = 0; i < 200; i+=120) {
    for (int j =0; j < 200; j+=120) {
      rect(c1b1x+i+70, c1b1y+j+70, 10, 10);
    }
  }
  
  ///Blanco 2
  for (int i = 0; i < 300; i+=120) {
    for (int j =0; j < 300; j+=120) {
      fill(255);
      rect(c1b2x+i+40, c1b2y+j+40, 10, 10);
    }
  }
  for (int i = 0; i < 200; i+=120) {
    for (int j =0; j < 200; j+=120) {
      rect(c1b2x+i+100, c1b2y+j+100, 10, 10);
    }
  }
  
  ///Negro 1
  for (int i = 0; i < 201; i+=120) {
    for (int j =0; j < 300; j+=120) {
      fill(0);
      rect(c1n1x+i+70, c1n1y+j+10, 10, 10);
    }
  }
  for (int i = 0; i < 261; i+=120) {
    for (int j =0; j < 200; j+=120) {
      rect(c1n1x+i+10, c1n1y+j+70, 10, 10);
    }
  }
  
  ///Negro 2
  for (int i = 0; i < 240; i+=120) {
    for (int j =0; j < 300; j+=120) {
      fill(0);
      rect(c1n2x+i+100, c1n2y+j+40, 10, 10);
    }
  }
  for (int i = 0; i < 291; i+=120) {
    for (int j =0; j < 201; j+=120) {
      rect(c1n2x+i+40, c1n2y+j+100, 10, 10);
    }
  }
}
