///////////////////////////  FaceVertex
float sc = 3;
float three= 3 * sc;
float two= 2 * sc;

int[][] faces= {{0,1,2},
                     {0,1,3},
                     {0,3,2},
                     {3,1,2}};
float[][] vertes= {{three, 0, 0},
                  {-three, two, 0},
                  {-three, -two, 0},
                  {-three, 0, two}};
                  
///////////////////////////  VertexVertex
ArrayList< ArrayList<float[]> > figure = new ArrayList< ArrayList<float[]> >();
     float[] vertes0= {three, 0, 0};
     float[] vertes1=  {-three, two, 0};
     float[] vertes2={-three, -two, 0};
     float[] vertes3=  {-three, 0, two};


     float[] v0= {1, 2, 3};
     float[] v1=  {0, 2, 3};
     float[] v2={0, 1, 3};
     float[] v3=  {0, 1, 2};

     ArrayList<float[]> ver0 = new ArrayList<float[]>();

     ArrayList<float[]> ver1 = new ArrayList<float[]>();

     ArrayList<float[]> ver2 = new ArrayList<float[]>();

     ArrayList<float[]> ver3 = new ArrayList<float[]>();
     
     
     
///////////////////////////////////// Spline Surface
ArrayList<Vector> bc = new ArrayList<Vector>();

 
 
PShape retFVMode(PShape bo){
  PShape em = createShape();
  em.beginShape(TRIANGLE_STRIP);
           em.stroke(color(255,0, 0));
          em.fill(color(0, 255, 0, 125));
       for(int i=0;i<4;i++){
         for(int j=0;j<3;j++){
           int v=faces[i][j];
           em.vertex(vertes[v][0],vertes[v][1],vertes[v][2]);
         }
       }



       em.endShape();
       bo.addChild(em);
  
  return bo;
}

void inmFVMode(){
  beginShape(TRIANGLES);
       stroke(color(0, 255, 0));
      fill(color(255, 40, 255, 125));
         for(int i=0;i<4;i++){
          for(int j=0;j<3;j++){
            int v=faces[i][j];
            vertex(vertes[v][0],vertes[v][1],vertes[v][2]);
          }
        }
       endShape();
}

void inmVVMode(){
   ver0.add(vertes0);
       ver0.add(v0);
       figure.add(ver0);


       ver1.add(vertes1);
       ver1.add(v1);
       figure.add(ver1);


       ver2.add(vertes2);
       ver2.add(v2);
       figure.add(ver2);


       ver3.add(vertes3);
       ver3.add(v3);
       figure.add(ver3);

       beginShape(TRIANGLES);
       stroke(color(255, 40, 255));
      fill(color(0, 255, 0, 125));
        for(int i=0; i< 4;i++){
           ArrayList<float[]> v = figure.get(i);
           float[] o = v.get(0);
           float[] d = v.get(1);
           for(int j=0; j<3;j++){

             //ArrayList<float[]> ve = figure.get((int) d[j]);
             //float[] de = ve.get(0);
             //line(o[0],o[1],o[2],de[0],de[1],de[2]);


             int ver=0;
             switch(i){
               case 0:
                 ver =(int) v0[j];
               break;

               case 1:
                  ver =(int) v1[j];
               break;

               case 2:
                 ver =(int) v2[j];
               break;

               case 3:
                 ver =(int) v3[j];
               break;
             }

             switch(ver){
               case 0:
                 fill(color(234, 0, 234, 125));
                 vertex(vertes0[0],vertes0[1],vertes0[2]);
               break;

               case 1:
                   fill(color(234, 0, 234, 125));
                  vertex(vertes1[0],vertes1[1],vertes1[2]);
               break;

               case 2:
                 fill(color(234, 0, 234, 125));
                 vertex(vertes2[0],vertes2[1],vertes2[2]);

               break;

               case 3:
                 fill(color(234, 0, 234, 125));
                 vertex(vertes3[0],vertes3[1],vertes3[2]);

               break;
             }


           }
       }

      endShape();
}


PShape retVVMode(PShape bo){
       ver0.add(vertes0);
       ver0.add(v0);
       figure.add(ver0);


       ver1.add(vertes1);
       ver1.add(v1);
       figure.add(ver1);


       ver2.add(vertes2);
       ver2.add(v2);
       figure.add(ver2);


       ver3.add(vertes3);
       ver3.add(v3);
       figure.add(ver3);

       PShape em = createShape();
       em.beginShape(TRIANGLES);
       stroke(color(0, 255, 0));
      fill(color(255,0, 0, 125));
        for(int i=0; i< 4;i++){
           ArrayList<float[]> v = figure.get(i);
           float[] o = v.get(0);
           float[] d = v.get(1);
           for(int j=0; j<3;j++){

             //ArrayList<float[]> ve = figure.get((int) d[j]);
             //float[] de = ve.get(0);
             //line(o[0],o[1],o[2],de[0],de[1],de[2]);


             int ver=0;
             switch(i){
               case 0:
                 ver =(int) v0[j];
               break;

               case 1:
                  ver =(int) v1[j];
               break;

               case 2:
                 ver =(int) v2[j];
               break;

               case 3:
                 ver =(int) v3[j];
               break;
             }

             switch(ver){
               case 0:
                 fill(color(234, 0, 234, 125));
                 em.vertex(vertes0[0],vertes0[1],vertes0[2]);
               break;

               case 1:
                   fill(color(234, 0, 234, 125));
                  em.vertex(vertes1[0],vertes1[1],vertes1[2]);
               break;

               case 2:
                 fill(color(234, 0, 234, 125));
                 em.vertex(vertes2[0],vertes2[1],vertes2[2]);

               break;

               case 3:
                 fill(color(234, 0, 234, 125));
                 em.vertex(vertes3[0],vertes3[1],vertes3[2]);

               break;
             }


           }
       }

      em.endShape();
      
      bo.addChild(em);
      
     return bo;
}


Vector splineSurface(ArrayList<Vector> P,float u,float v){
  
  Vector[] pu = new Vector[4];
  
  for(int i=0; i<4;i++){
    Vector[] curveP = new Vector[4];
    curveP[0] = P.get(i * 4); 
    curveP[1] = P.get(i * 4 + 1); 
    curveP[2] = P.get(i * 4 + 2); 
    curveP[3] = P.get(i * 4 + 3);
    pu[i]= bezier3(curveP,u);
  }
  
  return bezier3(pu,v);
}

void inmSSMode(){
  
    bc.add(new Vector(three, 0, 0)); // 1
    bc.add(new Vector(-three, two, 0)); // 2
    bc.add(new Vector(-three, -two, 0)); // 3
    bc.add(new Vector(-three, 0, two)); // 4
    
    bc.add(new Vector(-three, two, 0)); // 2
    bc.add(new Vector(-three, -two, 0)); // 3
    bc.add(new Vector(-three, 0, two)); // 4
    bc.add(new Vector(three, 0, 0)); // 1
    
    bc.add(new Vector(-three, -two, 0)); // 3
    bc.add(new Vector(-three, 0, two)); // 4
    bc.add(new Vector(three, 0, 0)); // 1
    bc.add(new Vector(-three, two, 0)); // 2
    
    bc.add(new Vector(-three, 0, two)); // 4
    bc.add(new Vector(three, 0, 0)); // 1
    bc.add(new Vector(-three, two, 0)); // 2
    bc.add(new Vector(-three, -two, 0)); // 3
    
  
    ArrayList<Vector> curvePoints = new ArrayList<Vector>();
       for(int i = 0; i <= 100; i ++) {
         for(int j = 0; j <= 100; j ++){
          float u = i * 0.01;
          float v = i * 0.01;
          Vector P = splineSurface(bc, u,v);
          curvePoints.add(P);
        }
      }
      beginShape();
      for(int i = 0; i < curvePoints.size(); i ++) {
        Vector P = curvePoints.get(i);
        pushStyle();
          stroke(255, 0, 0);
          strokeWeight(5);
          if(i != 0) {
            vertex(P.x(), P.y(), P.z());
          }
        popStyle();
      }
      endShape();
}

PShape retSSMode(PShape bo){
  
    bc.add(new Vector(three, 0, 0)); // 1
    bc.add(new Vector(-three, two, 0)); // 2
    bc.add(new Vector(-three, -two, 0)); // 3
    bc.add(new Vector(-three, 0, two)); // 4
    
    bc.add(new Vector(-three, two, 0)); // 2
    bc.add(new Vector(-three, -two, 0)); // 3
    bc.add(new Vector(-three, 0, two)); // 4
    bc.add(new Vector(three, 0, 0)); // 1
    
    bc.add(new Vector(-three, -two, 0)); // 3
    bc.add(new Vector(-three, 0, two)); // 4
    bc.add(new Vector(three, 0, 0)); // 1
    bc.add(new Vector(-three, two, 0)); // 2
    
    bc.add(new Vector(-three, 0, two)); // 4
    bc.add(new Vector(three, 0, 0)); // 1
    bc.add(new Vector(-three, two, 0)); // 2
    bc.add(new Vector(-three, -two, 0)); // 3
    
  
    ArrayList<Vector> curvePoints = new ArrayList<Vector>();
       for(int i = 0; i <= 100; i ++) {
         for(int j = 0; j <= 100; j ++){
          float u = i * 0.01;
          float v = i * 0.01;
          Vector P = splineSurface(bc, u,v);
          curvePoints.add(P);
        }
      }
      PShape em = createShape();
      em.beginShape();
      for(int i = 0; i < curvePoints.size(); i ++) {
        Vector P = curvePoints.get(i);
        pushStyle();
          stroke(255, 0, 0);
          strokeWeight(5);
          if(i != 0) {
            em.vertex(P.x(), P.y(), P.z());
          }
        popStyle();
      }
      em.endShape();
      
      bo.addChild(em);
   return bo;
}
