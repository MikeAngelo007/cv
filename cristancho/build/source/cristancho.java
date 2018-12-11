import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import frames.primitives.*; 
import frames.core.*; 
import frames.processing.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class cristancho extends PApplet {


class Boid {
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
  }

  public void run(ArrayList<Boid> bl) {
    t += .1f;
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

  public Vector avoid(Vector target) {
    Vector steer = new Vector(); // creates vector for steering
    steer.set(Vector.subtract(position, target)); // steering vector points away from
    steer.multiply(1 / sq(Vector.distance(position, target)));
    return steer;
  }

  //-----------behaviors---------------

  public void flock(ArrayList<Boid> boids) {
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

  public void move() {
    velocity.add(acceleration); // add acceleration to velocity
    velocity.limit(maxSpeed); // make sure the velocity vector magnitude does not
    // exceed maxSpeed
    position.add(velocity); // add velocity to position
    frame.setPosition(position);
    frame.setRotation(Quaternion.multiply(new Quaternion(new Vector(0, 1, 0), atan2(-velocity.z(), velocity.x())),
      new Quaternion(new Vector(0, 0, 1), asin(velocity.y() / velocity.magnitude()))));
    acceleration.multiply(0); // reset acceleration
  }

  public void checkBounds() {
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

  public void render() {
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

    //draw boid
    beginShape(TRIANGLES);

    if(one){
      /*
      vertex(3 * sc, 0, 0);
      vertex(-3 * sc, 2 * sc, 0);
      vertex(-3 * sc, -2 * sc, 0);

      vertex(3 * sc, 0, 0);
      vertex(-3 * sc, 2 * sc, 0);
      vertex(-3 * sc, 0, 2 * sc);

      vertex(3 * sc, 0, 0);
      vertex(-3 * sc, 0, 2 * sc);
      vertex(-3 * sc, -2 * sc, 0);

      vertex(-3 * sc, 0, 2 * sc);
      vertex(-3 * sc, 2 * sc, 0);
      vertex(-3 * sc, -2 * sc, 0);
      */
      vertex(2 * sc, 0, 2 * sc);     //  6, 0,6
      vertex(0, 0, 3 * sc);          //  0, 0,9
      vertex(0, sc, 2 * sc);         //  0, 3,6

      vertex(2 * sc, 0, 2 * sc);     //  6, 0,6
      vertex(0, 0, 3 * sc);          //  0, 0,9
      vertex(0, -sc, 2 * sc);        //  0,-3,6

      vertex(2 * sc, 0, 2 * sc);     //  6, 0,6
      vertex(0, 0, sc);              //  0, 0,3
      vertex(0, sc, 2 * sc);         //  0, 3,6

      vertex(2 * sc, 0, 2 * sc);     //  6, 0,6
      vertex(0, 0, sc);              //  0, 0,3
      vertex(0, -sc, 2 * sc);        //  0,-3,6

      vertex(-5 * sc, 0, 2 * sc);    //-15, 0,0
      vertex(0, 0, 3 * sc);          //  0, 0,9
      vertex(0, sc, 2 * sc);         //  0, 3,6

      vertex(-5 * sc, 0, 2 * sc);    //-15, 0,0
      vertex(0, 0, 3 * sc);          //  0, 0,9
      vertex(0, -sc, 2 * sc);        //  0,-3,6

      vertex(-5 * sc, 0, 2 * sc);    //-15, 0,0
      vertex(0, 0, sc);              //  0, 0,3
      vertex(0, sc, 2 * sc);         //  0, 3,6

      vertex(-5 * sc, 0, 2 * sc);    //-15, 0,0
      vertex(0, 0, sc);              //  0, 0,3
      vertex(0, -sc, 2 * sc);        //  0,-3,6

    }
    if(two){
      vertex(3 * sc, 0, 0);          //  9, 0,0
      vertex(-3 * sc, 0, 0);         // -9, 0,0
      vertex(0, 3 * sc, sc);         //  0, 9,3

      vertex(3 * sc, 0, 0);          //  9, 0,0
      vertex(-3 * sc, 0, 0);         // -9, 0,0
      vertex(0, 3 * sc, 3 * sc);     //  0, 9,9

      vertex(3 * sc, 0, 0);          //  9, 0,0
      vertex(-3 * sc, 0, 0);         // -9, 0,0
      vertex(0, -3 * sc, sc);        //  0, 9,3

      vertex(3 * sc, 0, 0);          //  9, 0,0
      vertex(-3 * sc, 0, 0);         // -9, 0,0
      vertex(0, -3 * sc, 3 * sc);    //  0,-9,9
    }
    endShape();

    popStyle();
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





Scene scene;
Interpolator interpolator;
//flock bounding box
int flockWidth = 640;
int flockHeight = 640;
int flockDepth = 600;
boolean avoidWalls = true;
boolean one = true;
boolean two = false;

int initBoidNum = 300; // amount of boids to start the program with
ArrayList<Boid> flock;
Frame avatar;
boolean animate = true;

public void setup() {
  
  scene = new Scene(this);
  scene.setBoundingBox(new Vector(0, 0, 0), new Vector(flockWidth, flockHeight, flockDepth));
  scene.setAnchor(scene.center());
  scene.setFieldOfView(PI / 3);
  scene.fitBall();
  // create and fill the list of boids
  flock = new ArrayList();
  for (int i = 0; i < initBoidNum; i++)
    flock.add(new Boid(new Vector(flockWidth / 2, flockHeight / 2, flockDepth / 2)));
  interpolator =  new Interpolator(scene);
}

public void draw() {
  background(10, 50, 25);
  ambientLight(128, 128, 128);
  directionalLight(255, 255, 255, 0, 1, -100);
  walls();
  scene.traverse();

  pushStyle();
  strokeWeight(3);
  stroke(255,0,0);
  scene.drawPath(interpolator);
  popStyle();

  // uncomment to asynchronously update boid avatar. See mouseClicked()
  // updateAvatar(scene.trackedFrame("mouseClicked"));
}

public void walls() {
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

public void updateAvatar(Frame frame) {
  if (frame != avatar) {
    avatar = frame;
    if (avatar != null)
      thirdPerson();
    else if (scene.eye().reference() != null)
      resetEye();
  }
}

// Sets current avatar as the eye reference and interpolate the eye to it
public void thirdPerson() {
  scene.eye().setReference(avatar);
  scene.interpolateTo(avatar);
}

// Resets the eye
public void resetEye() {
  // same as: scene.eye().setReference(null);
  scene.eye().resetReference();
  scene.lookAt(scene.center());
  scene.fitBallInterpolation();
}

// picks up a boid avatar, may be null
public void mouseClicked() {
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
public void mouseDragged() {
  if (scene.eye().reference() == null)
    if (mouseButton == LEFT)
      // same as: scene.spin(scene.eye());
      scene.spin();
    else if (mouseButton == RIGHT)
      // same as: scene.translate(scene.eye());
      scene.translate();
    else
      // same as: scene.zoom(mouseX - pmouseX, scene.eye());
      scene.zoom(mouseX - pmouseX);
}

// highlighting and 'third-person' interaction
public void mouseMoved(MouseEvent event) {
  // 1. highlighting
  scene.cast("mouseMoved", mouseX, mouseY);
  // 2. third-person interaction
  if (scene.eye().reference() != null)
    // press shift to move the mouse without looking around
    if (!event.isShiftDown())
      scene.lookAround();
}

public void mouseWheel(MouseEvent event) {
  // same as: scene.scale(event.getCount() * 20, scene.eye());
  scene.scale(event.getCount() * 20);
}

public void keyPressed() {
  switch (key) {
  case 'a':
    animate = !animate;
    break;
  case 's':
    if (scene.eye().reference() == null)
      scene.fitBallInterpolation();
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
    int index = PApplet.parseInt(random(0,initBoidNum));
    interpolator.addKeyFrame(flock.get(index).frame);
    break;
  case '-':
    if(interpolator.keyFrames().isEmpty()){
      println(" ¡No hay puntos para eliminar! ");
      break;
    }else{
      //interpolator.purge();
      println(interpolator.keyFrames());
      println(interpolator.keyFrame(0) + " pos: 0");
      interpolator.removeKeyFrame(0);
      println(interpolator.keyFrames());
    }

    break;

  case ' ':
    if (scene.eye().reference() != null)
      resetEye();
    else if (avatar != null)
      thirdPerson();
    break;
  case '1':
    one = !one;
    two = !two;
    break;
  }
}
  public void settings() {  size(800, 720, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "cristancho" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
