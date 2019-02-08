

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
static int typeR=1;
static boolean modeR=false;
static boolean surface=false;

int initBoidNum = 900; // amount of boids to start the program with
ArrayList<Boid> flock;
Frame avatar;
boolean animate = true;
String curveType = "b";


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
}


void draw() {
  background(10, 50, 25);
  ambientLight(128, 128, 128);
  directionalLight(255, 255, 255, 0, 1, -100);
  walls();
  scene.traverse();


  // --- DRAW BEZIER, HERMIT AND NATURAL CURVES --- //
  for(int i = 0; i < controlFrames.size(); i++) {
    Vector P = controlFrames.get(i).position();
    pushStyle();
      stroke(0, 0, 255);
      strokeWeight(15);
      point(P.x(), P.y(), P.z());
    popStyle();
  }

  if(controlFrames.size() != 0) {
    drawCurve();
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

void randomControlPoints() {
  controlFrames.clear();
  for(int i=0; i<n; i++) {
    int index = int(random(0, initBoidNum));
    controlFrames.add(flock.get(index).frame);
  }
}

void keyPressed() {
  switch(key) {
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
  case 'v':
    avoidWalls = !avoidWalls;
    break;
  case 'b': // Apply the Bezier curve
    curveType = "b";
    break;
  case 'h': // Apply hermite curve
    if(n != 4) n = 4;
    randomControlPoints();
    curveType = "h";
    break;
  case 'n': // Apply natural curve
    if(n != 4) n = 4;
    randomControlPoints();
    curveType = "n";
    break;
  case 'p':
    randomControlPoints();
    break;
  case '+': // Change between 4 and 8 control points
    if(n == 4 && curveType.equals("b")) n = 8;
    else n = 4;
    randomControlPoints();
    break;
  case '-': // Hide curve
    controlFrames.clear();
    break;
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
    if(typeR == 1){
      typeR=2;
    }else if(typeR == 2){
      typeR=3;
    }else if(typeR == 3){
      typeR=1;
    }
    break;
  
  case 'u':
    if(typeR == 1){
      typeR=2;
    }else if(typeR == 2){
      typeR=1;
    }
    //if(surface){
    //  typeR=1;
    //  surface=false;
      
    //}else{
    //  typeR=0;
    //  surface=true;
    //}
    break;
  }
}
