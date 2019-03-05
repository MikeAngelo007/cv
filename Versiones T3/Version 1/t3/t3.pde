class Boid {

  // En algun punto de la clase se hace el 1er punto :v
  public Frame frame;
  // fields
  Vector position, velocity, acceleration, alignment, cohesion, separation; // position, velocity, and acceleration in
  // a vector datatype
  float neighborhoodRadius; // radius in which it looks for fellow boids
  float maxSpeed = 4; // maximum magnitude for the velocity vector
  float maxSteerForce = .1f; // maximum magnitude of the steering vector
  float sc = 3; // scale factor for the render of the boid
  float flap = 0;
  float t = 0;


  ///////////////////////////////////////////  Declaracion Face to Vertex

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







    ///////////////////////////////////////////  Declaracion Vertex to Vertex




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

     ///////////////////////////////////////////  Fin Declaracion



  PShape sh;   ////////// Modo retenido
  Boid(Vector inPos) {
    position = new Vector();
    position.set(inPos);
    frame = new Frame(scene) {
      // Note that within visit() geometry is defined at the
      // frame local coordinate system.
      @Override
      public void visit() {
        if (animate)
          run(flock);
        render();
      }
    };
    frame.setPosition(new Vector(position.x(), position.y(), position.z()));
    velocity = new Vector(random(-1, 1), random(-1, 1), random(1, -1));
    acceleration = new Vector(0, 0, 0);
    neighborhoodRadius = 100;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////   Modo retenido ///////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if(!modeR){


    sh = createShape();

     if(typeR){

       println("Entro a retenido true");

       sh.beginShape(TRIANGLE_STRIP);
           sh.stroke(color(255,0, 0));
          sh.fill(color(0, 255, 0, 125));
       for(int i=0;i<4;i++){
         for(int j=0;j<3;j++){
           int v=faces[i][j];
           sh.vertex(vertes[v][0],vertes[v][1],vertes[v][2]);
         }
       }



       sh.endShape();
     }
     if(!typeR){
       println("Entro a retenido false");
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

       sh.beginShape(TRIANGLE_STRIP);
           sh.stroke(color(0, 255, 0));
          sh.fill(color(255, 0, 0, 125));
        for(int i=0; i< 4;i++){
           ArrayList<float[]> v = figure.get(i);
           float[] o = v.get(0);
           float[] d = v.get(1);
           for(int j=0; j<3;j++){
             ArrayList<float[]> ve = figure.get((int) d[j]);
             float[] de = ve.get(0);
             //sh.line(o[0],o[1],o[2],de[0],de[1],de[2]);

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
                 sh.vertex(vertes0[0],vertes0[1],vertes0[2]);
               break;

               case 1:
                   fill(color(234, 0, 234, 125));
                  sh.vertex(vertes1[0],vertes1[1],vertes1[2]);
               break;

               case 2:
                 fill(color(234, 0, 234, 125));
                 sh.vertex(vertes2[0],vertes2[1],vertes2[2]);

               break;

               case 3:
                 fill(color(234, 0, 234, 125));
                 sh.vertex(vertes3[0],vertes3[1],vertes3[2]);

               break;
             }
           }
         }

        sh.endShape();
     }

    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  }

  public void run(ArrayList<Boid> bl) {
    t += .1;
    flap = 10 * sin(t);
    // acceleration.add(steer(new Vector(mouseX,mouseY,300),true));
    // acceleration.add(new Vector(0,.05,0));
    if (avoidWalls) {
      acceleration.add(Vector.multiply(avoid(new Vector(position.x(), flockHeight, position.z())), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(position.x(), 0, position.z())), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(flockWidth, position.y(), position.z())), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(0, position.y(), position.z())), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(position.x(), position.y(), 0)), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(position.x(), position.y(), flockDepth)), 5));
    }
    flock(bl);
    move();
    checkBounds();
  }

  Vector avoid(Vector target) {
    Vector steer = new Vector(); // creates vector for steering
    steer.set(Vector.subtract(position, target)); // steering vector points away from
    steer.multiply(1 / sq(Vector.distance(position, target)));
    return steer;
  }

  //-----------behaviors---------------

  void flock(ArrayList<Boid> boids) {
    //alignment
    alignment = new Vector(0, 0, 0);
    int alignmentCount = 0;
    //cohesion
    Vector posSum = new Vector();
    int cohesionCount = 0;
    //separation
    separation = new Vector(0, 0, 0);
    Vector repulse;
    for (int i = 0; i < boids.size(); i++) {
      Boid boid = boids.get(i);
      //alignment
      float distance = Vector.distance(position, boid.position);
      if (distance > 0 && distance <= neighborhoodRadius) {
        alignment.add(boid.velocity);
        alignmentCount++;
      }
      //cohesion
      float dist = dist(position.x(), position.y(), boid.position.x(), boid.position.y());
      if (dist > 0 && dist <= neighborhoodRadius) {
        posSum.add(boid.position);
        cohesionCount++;
      }
      //separation
      if (distance > 0 && distance <= neighborhoodRadius) {
        repulse = Vector.subtract(position, boid.position);
        repulse.normalize();
        repulse.divide(distance);
        separation.add(repulse);
      }
    }
    //alignment
    if (alignmentCount > 0) {
      alignment.divide((float) alignmentCount);
      alignment.limit(maxSteerForce);
    }
    //cohesion
    if (cohesionCount > 0)
      posSum.divide((float) cohesionCount);
    cohesion = Vector.subtract(posSum, position);
    cohesion.limit(maxSteerForce);

    acceleration.add(Vector.multiply(alignment, 1));
    acceleration.add(Vector.multiply(cohesion, 3));
    acceleration.add(Vector.multiply(separation, 1));
  }

  void move() {
    velocity.add(acceleration); // add acceleration to velocity
    velocity.limit(maxSpeed); // make sure the velocity vector magnitude does not
    // exceed maxSpeed
    position.add(velocity); // add velocity to position
    frame.setPosition(position);
    frame.setRotation(Quaternion.multiply(new Quaternion(new Vector(0, 1, 0), atan2(-velocity.z(), velocity.x())),
      new Quaternion(new Vector(0, 0, 1), asin(velocity.y() / velocity.magnitude()))));
    acceleration.multiply(0); // reset acceleration
  }

  void checkBounds() {
    if (position.x() > flockWidth)
      position.setX(0);
    if (position.x() < 0)
      position.setX(flockWidth);
    if (position.y() > flockHeight)
      position.setY(0);
    if (position.y() < 0)
      position.setY(flockHeight);
    if (position.z() > flockDepth)
      position.setZ(0);
    if (position.z() < 0)
      position.setZ(flockDepth);
  }

  void render() {



    pushStyle();

    // uncomment to draw boid axes
    //scene.drawAxes(10);

    strokeWeight(2);
    stroke(color(40, 255, 40));
    fill(color(0, 255, 0, 125));

    // highlight boids under the mouse
    if (scene.trackedFrame("mouseMoved") == frame) {
      stroke(color(0, 0, 255));
      fill(color(0, 0, 255));
    }

    // highlight avatar
    if (frame ==  avatar) {
      stroke(color(255, 0, 0));
      fill(color(255, 0, 0));
    }
     ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     //////////////////////////////////////////////////   Modo retenido ///////////////////////////////////////////////////////////////////////
     //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if(!modeR){
      shape(sh);
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////   Modo inmediato ///////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if(modeR){

      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////    Face to vertex  ///////////////////////////////////////////////////////////////
      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      if(typeR){

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


      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////    Vertex to vertex  ///////////////////////////////////////////////////////////////
      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      if(!typeR){




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



      //draw boid

    }
    popStyle();
  }
}

class Funcion{
  public ArrayList<Vector> points;

  public void setPoints(ArrayList<Vector> po){
    stroke(211,11,210);
    strokeWeight(5);
    this.points = po;
  }

  // public int fact(int n){
  //   int fact = 1;
  //   while ( n!=0) {
  //     fact=fact*n;
  //     n--;
  //   }
  //   return fact;
  // }

  public int fact(int n){
    if(n==0){
      return 1;
    }else{
      return n* fact(n-1);
    }
  }

  public float combi(int n,int i){
    float num = fact(n);
    float den = fact(i) * fact(n-i);
    return num / den;
  }
  public float bernstein(float t, int n, int i){
    return combi(n,i)*pow(t,i)*pow(1-t,n-i);
  }
  private Vector m(int i) {
    return Vector.multiply( Vector.subtract( points.get(i+1), points.get(i-1) ), 0.5 );
  }
  public void Bezier(){
    float pxf;
    float pyf;
    float pzf;

    float pxi = (points.get(0).x()+4*points.get(1).x()+points.get(2).x())/6;
    float pyi = (points.get(0).y()+4*points.get(1).y()+points.get(2).y())/6;
    float pzi = (points.get(0).z()+4*points.get(1).z()+points.get(2).z())/6;

    int n = points.size()-1;
        for(int i=0;i<=n-3;i++)
        {

          for(float t=0;t<=1;t=t+0.01)
          {
            float f1x=-points.get(i).x()+3*points.get(i+1).x()-3*points.get(i+2).x()+points.get(i+3).x();
            float f2x=3*points.get(i).x()-6*points.get(i+1).x()+3*points.get(i+2).x();
            float f3x=-3*points.get(i).x()+3*points.get(i+2).x();
            float f4x=points.get(i).x()+4*points.get(i+1).x()+points.get(i+2).x();
            pxf=(pow(t,3)*(f1x)+pow(t,2)*(f2x)+pow(t,1)*(f3x)+1*(f4x))/6;
            float f1y=-points.get(i).y()+3*points.get(i+1).y()-3*points.get(i+2).y()+points.get(i+3).y();
            float f2y=3*points.get(i).y()-6*points.get(i+1).y()+3*points.get(i+2).y();
            float f3y=-3*points.get(i).y()+3*points.get(i+2).y();
            float f4y=points.get(i).y()+4*points.get(i+1).y()+points.get(i+2).y();
            pyf=(pow(t,3)*(f1y)+pow(t,2)*(f2y)+pow(t,1)*(f3y)+1*(f4y))/6;

            float f1z=-points.get(i).z()+3*points.get(i+1).z()-3*points.get(i+2).z()+points.get(i+3).z();
            float f2z=3*points.get(i).z()-6*points.get(i+1).z()+3*points.get(i+2).z();
            float f3z=-3*points.get(i).z()+3*points.get(i+2).z();
            float f4z=points.get(i).z()+4*points.get(i+1).z()+points.get(i+2).z();
            pzf=(pow(t,3)*(f1z)+pow(t,2)*(f2z)+pow(t,1)*(f3z)+1*(f4z))/6;

            line(pxi,pyi,pzi,pxf,pyf,pzf);

            pxi=pxf;
            pyi=pyf;
            pzi=pzf;
          }

        }
    }

  public void Hermite(){
    int n = points.size();
    Vector aux = null;
    Vector currentPoint = points.get(0);
    for (int i=1; i<n-2;i++){
      Vector P0 = points.get(i);
      Vector P1 = points.get(i+1);

      currentPoint = P0;
      Vector m0= m(i);
      Vector m1= m(i+1);

      for(float t=0; t<=1; t+=0.01){

        float h00 = 2*pow(t,3)-3*pow(t,2)+1;
        float h10 = pow(t,3)-2*pow(t,2)+t;
        float h01 = -2*pow(t,3)+3*pow(t,2);
        float h11 = pow(t,3)-pow(t,2);

        Vector aux1 = Vector.add(Vector.multiply(P0, h00),Vector.multiply(m0, h10));
        Vector aux2 = Vector.add(Vector.multiply(P1, h01),Vector.multiply(m1, h11));
        aux = Vector.add(aux1, aux2);

        line(currentPoint.x(),currentPoint.y(),currentPoint.z(),aux.x(),aux.y(),aux.z());
        currentPoint = aux;
        }

        line(currentPoint.x(),currentPoint.y(),currentPoint.z(),P1.x(),P1.y(),P1.z());
      }
    }
    
    
    void splineCubicaNatural() {
    
    float ax[] = new float[8], bx[] = new float[8], cx[] = new float[8], dx[] = new float[8];
    float ay[] = new float[8], by[] = new float[8], cy[] = new float[8], dy[] = new float[8];
    float az[] = new float[8], bz[] = new float[8], cz[] = new float[8], dz[] = new float[8];
    
    float deriv[] = new float[8], gamma[] = new float[8], omega[] = new float[8]; 

    gamma[0] = .5;
    for(int i = 1; i < 7; ++i) gamma[i] = 1. / (4. - gamma[i-1]);
    gamma[7] = 1. / (2. - gamma[6]);
    
    omega[0] = 3. * (points.get(1).x()-points.get(0).x()) * gamma[0];
    for(int i = 1; i < 7; ++i) omega[i] = (3. * (points.get(i+1).x() - points.get(i-1).x()) - omega[i-1]) * gamma[i];
    omega[7] = (3. * (points.get(7).x()-points.get(6).x()) - omega[6]) * gamma[7];
    
    deriv[7] = omega[7];
    for(int i = 6; i>= 0; --i) deriv[i] = omega[i] - gamma[i] * deriv[i+1];
    
    for(int i = 0; i < 7; ++i) {
      ax[i] = points.get(i).x();
      bx[i] = deriv[i];
      cx[i] = 3. * (points.get(i+1).x()-points.get(i).x()) - 2. * deriv[i] - deriv[i+1];
      dx[i] = 2. * (points.get(i).x() - points.get(i+1).x()) + deriv[i] + deriv[i+1];      
    }
    
    omega[0] = 3. * (points.get(1).y() - points.get(0).y()) * gamma[0];
    for (int i = 1; i < 7; ++i) omega[i] = (3. * (points.get(i+1).y() - points.get(i-1).y()) - omega[i-1]) * gamma[i];
    omega[7] = (3. * (points.get(7).y() - points.get(6).y()) - omega[6]) * gamma[7];
    
    deriv[7] = omega[7];
    for (int i = 6; i >= 0; --i) deriv[i] = omega[i] - gamma[i] * deriv[i+1];
    
    for (int i = 0; i<7; ++i) {
      ay[i] = points.get(i).y();
      by[i] = deriv[i];
      cy[i] = 3. * (points.get(i+1).y() - points.get(i).y()) -2. * deriv[i] - deriv[i+1];
      dy[i] = 2. * (points.get(i).y() - points.get(i+1).y()) + deriv[i] + deriv[i+1];
    }
    
    omega[0] = 3. * (points.get(1).z() - points.get(0).z()) * gamma[0];
    for (int i = 1; i < 7; ++i) omega[i] = (3. * (points.get(i+1).z() - points.get(i-1).z()) - omega[i-1]) * gamma[i];
    omega[7] = (3. * (points.get(7).z() - points.get(6).z()) - omega[6]) * gamma[7];
    
    deriv[7] = omega[7];
    for (int i = 6; i >= 0; --i) deriv[i] = omega[i] - gamma[i] * deriv[i+1];
    
    for (int i = 0; i<7; ++i) {
      az[i] = points.get(i).z();
      bz[i] = deriv[i];
      cz[i] = 3. * (points.get(i+1).z() - points.get(i).z()) -2. * deriv[i] - deriv[i+1];
      dz[i] = 2. * (points.get(i).z() - points.get(i+1).z()) + deriv[i] + deriv[i+1];
    }
    
    float xpx, ypx, zpx;
    
    for (int i = 0; i < 7+1; ++i) {

      float puntox = ax[i] + bx[i] + cx[i] + dx[i];
      float puntoy = ay[i] + by[i] + cy[i] + dy[i];
      float puntoz = az[i] + bz[i] + cz[i] + dz[i];
      
      
      for(float t=0; t<=1; t+=0.01){
        xpx = (float)(ax[i]+bx[i]*t+cx[i]*pow(t,2)+dx[i]*pow(t,3));
        ypx = (float)(ay[i]+by[i]*t+cy[i]*pow(t,2)+dy[i]*pow(t,3));
        zpx = (float)(az[i]+bz[i]*t+cz[i]*pow(t,2)+dz[i]*pow(t,3));
        
        line(puntox, puntoy, puntoz, xpx, ypx, zpx);
        
        puntox = xpx;
        puntoy = ypx;
        puntoz = zpx;
      }
    }
   }
}

/**
 * Flock of Boids
 * by Jean Pierre Charalambos.
 *
 * This example displays the famous artificial life program "Boids", developed by
 * Craig Reynolds in 1986 [1] and then adapted to Processing by Matt Wetmore in
 * 2010 (https://www.openprocessing.org/sketch/6910#), in 'third person' eye mode.
 * The Boid under the mouse will be colored blue. If you click on a boid it will
 * be selected as the scene avatar for the eye to follow it.
 *
 * 1. Reynolds, C. W. Flocks, Herds and Schools: A Distributed Behavioral Model. 87.
 * http://www.cs.toronto.edu/~dt/siggraph97-course/cwr87/
 * 2. Check also this nice presentation about the paper:
 * https://pdfs.semanticscholar.org/73b1/5c60672971c44ef6304a39af19dc963cd0af.pdf
 * 3. Google for more...
 *
 * Press ' ' to switch between the different eye modes.
 * Press 'a' to toggle (start/stop) animation.
 * Press 'p' to print the current frame rate.
 * Press 'm' to change the boid visual mode.
 * Press 'v' to toggle boids' wall skipping.
 * Press 's' to call scene.fitBallInterpolation().
 */

import frames.primitives.*;
import frames.core.*;
import frames.processing.*;

Scene scene;
////////////////////////////////////////////////////  Inicio curvas ////////////////////////////
Interpolator interpolator;
//flock bounding box
static int flockWidth = 1280;
static int flockHeight = 720;
static int flockDepth = 600;
static boolean avoidWalls = true;
static boolean typeR=true;
static boolean modeR=false;

Funcion bezier,hermite,natural;
int mod=0;

int initBoidNum = 900; // amount of boids to start the program with
ArrayList<Boid> flock;
Frame avatar;
boolean animate = true;




void setup() {
  size(1000, 800, P3D);
  scene = new Scene(this);
  scene.setFrustum(new Vector(0, 0, 0), new Vector(flockWidth, flockHeight, flockDepth));
  scene.setAnchor(scene.center());
  //scene.setFieldOfView(PI / 3);
  scene.fit();
  // create and fill the list of boids
  flock = new ArrayList();
  for (int i = 0; i < initBoidNum; i++)
    flock.add(new Boid(new Vector(flockWidth / 2, flockHeight / 2, flockDepth / 2)));





  ////////////////////////////////////////////////////  Inicio curvas ////////////////////////////
  interpolator =  new Interpolator(scene, new Frame());


  for (int i = 0; i < 8; i++) {
    Frame ctrlPoint = new Frame(scene);
    int index = int(random(0,initBoidNum));
    ctrlPoint.setPosition(flock.get(index).position);
    interpolator.addKeyFrame(ctrlPoint);
  }


  bezier = new Funcion();
  hermite = new Funcion();
  natural= new Funcion();
}

void draw() {
  background(10, 50, 25);
  ambientLight(128, 128, 128);
  directionalLight(255, 255, 255, 0, 1, -100);
  walls();


  scene.traverse();


  ////////////////////////////////////////////////////  Inicio curvas ////////////////////////////
  // pushStyle();
  // strokeWeight(4);
  // stroke(255,0,0);
  // scene.drawPath(interpolator,1);
  // popStyle();

  // uncomment to asynchronously update boid avatar. See mouseClicked()
  // updateAvatar(scene.trackedFrame("mouseClicked"));

  // println("Modo:" + modeR);
  // println("Representacion:" + typeR);

  ArrayList<Vector> stars = new ArrayList<Vector>();

  // for(int i=0;i<8;i++){
  //   int index = int(random(0,initBoidNum));
  //   interpolator.addKeyFrame(flock.get(index).frame);
  // }



  for(Frame frame : interpolator.keyFrames()){
    stars.add(frame.position());
    //puntos.add(punto);
  }

  if(mod==0){
      bezier.setPoints(stars);
      bezier.Bezier();
  }else if(mod==1){
    hermite.setPoints(stars);
      hermite.Hermite();
  }else if(mod==2){
    natural.setPoints(stars);
      natural.splineCubicaNatural();
  }

}

void walls() {
  pushStyle();
  noFill();
  stroke(255, 255, 0);

  line(0, 0, 0, 0, flockHeight, 0);
  line(0, 0, flockDepth, 0, flockHeight, flockDepth);
  line(0, 0, 0, flockWidth, 0, 0);
  line(0, 0, flockDepth, flockWidth, 0, flockDepth);

  line(flockWidth, 0, 0, flockWidth, flockHeight, 0);
  line(flockWidth, 0, flockDepth, flockWidth, flockHeight, flockDepth);
  line(0, flockHeight, 0, flockWidth, flockHeight, 0);
  line(0, flockHeight, flockDepth, flockWidth, flockHeight, flockDepth);

  line(0, 0, 0, 0, 0, flockDepth);
  line(0, flockHeight, 0, 0, flockHeight, flockDepth);
  line(flockWidth, 0, 0, flockWidth, 0, flockDepth);
  line(flockWidth, flockHeight, 0, flockWidth, flockHeight, flockDepth);
  popStyle();
}

void updateAvatar(Frame frame) {
  if (frame != avatar) {
    avatar = frame;
    if (avatar != null)
      thirdPerson();
    else if (scene.eye().reference() != null)
      resetEye();
  }
}

// Sets current avatar as the eye reference and interpolate the eye to it
void thirdPerson() {
  scene.eye().setReference(avatar);
  scene.fit(avatar, 1);
}

// Resets the eye
void resetEye() {
  // same as: scene.eye().setReference(null);
  scene.eye().resetReference();
  scene.lookAt(scene.center());
  scene.fit(1);
}

// picks up a boid avatar, may be null
void mouseClicked() {
  // two options to update the boid avatar:
  // 1. Synchronously
  updateAvatar(scene.track("mouseClicked", mouseX, mouseY));
  // which is the same as these two lines:
  // scene.track("mouseClicked", mouseX, mouseY);
  // updateAvatar(scene.trackedFrame("mouseClicked"));
  // 2. Asynchronously
  // which requires updateAvatar(scene.trackedFrame("mouseClicked")) to be called within draw()
  // scene.cast("mouseClicked", mouseX, mouseY);
}

// 'first-person' interaction
void mouseDragged() {
  if (scene.eye().reference() == null)
    if (mouseButton == LEFT)
      // same as: scene.spin(scene.eye());
      scene.spin();
    else if (mouseButton == RIGHT)
      // same as: scene.translate(scene.eye());
      scene.translate();
    else
      // same as: scene.zoom(mouseX - pmouseX, scene.eye());
      scene.moveForward(mouseX - pmouseX);
}

// highlighting and 'third-person' interaction
void mouseMoved(MouseEvent event) {
  // 1. highlighting
  scene.cast("mouseMoved", mouseX, mouseY);
  // 2. third-person interaction
  if (scene.eye().reference() != null)
    // press shift to move the mouse without looking around
    if (!event.isShiftDown())
      scene.lookAround();
}

void mouseWheel(MouseEvent event) {
  // same as: scene.scale(event.getCount() * 20, scene.eye());
  scene.scale(event.getCount() * 20);
}

void keyPressed() {
  switch (key) {
  case 'a':
    animate = !animate;
    break;
  case 's':
    if (scene.eye().reference() == null)
      scene.fit();
    break;
  case 't':
    scene.shiftTimers();
    break;
  case 'p':
    println("Frame rate: " + frameRate);
    break;
  case 'v':
    avoidWalls = !avoidWalls;
    break;
  case '+':
    for(int i=0;i<8;i++){
      int index = int(random(0,initBoidNum));
      interpolator.addKeyFrame(flock.get(index).frame);
    }


    break;
  case '-':
    if(!interpolator.keyFrames().isEmpty()){
      for(int i=0;i<8;i++){
        interpolator.removeKeyFrame(0);
      }
    }
  case ' ':
    if (scene.eye().reference() != null)
      resetEye();
    else if (avatar != null)
      thirdPerson();
    break;

    case 'm':
    modeR=!modeR;
    break;

    case 'c':
    typeR=!typeR;
    break;

    case 'y':
    if(mod==0){
      stroke(0, 255, 0);
      mod=1;
    }else if(mod==1){
      stroke(255, 255, 0);
      mod=2;
    }else if(mod==2){
      stroke(255, 0, 255);
      mod=0;
    }
    break;
  }
}
