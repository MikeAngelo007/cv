/**
 * Space Navigator
 * by Jean Pierre Charalambos.
 *
 * This demo shows how to control your scene shapes using a Space Navigator
 * (3D mouse), with 6 degrees-of-freedom (DOFs). It requires the GameControlPlus
 * library and a Space Navigator and it has been tested only under Linux.
 */

import frames.primitives.*;
import frames.core.*;
import frames.processing.*;

import org.gamecontrolplus.*;
import net.java.games.input.*;

ControlIO control;
ControlDevice device; // my SpaceNavigator
ControlSlider snXPos; // Positions
ControlSlider snYPos;
ControlSlider snZPos;
ControlSlider snXRot; // Rotations
ControlSlider snYRot;
//ControlSlider snZRot;
ControlButton a; // Buttons
ControlButton b;
ControlButton lb; // Buttons
ControlButton rb;
ControlHat hat;

float xp=0;
float yp=0;
float zp=0;

// frames stuff:
Scene scene;
boolean snPicking;
Frame avatar; 

void setup() {
  size(800, 700, P3D);
  openSpaceNavigator();
  scene = new Scene(this);
  //scene.setFieldOfView(PI / 3);
  //scene.setType(Graph.Type.ORTHOGRAPHIC);
  scene.setRadius(1500);
  scene.fit(1);
  Shape[] shapes = new Shape[1];
  for (int i = 0; i < shapes.length; i++) {
    tint(random(0,255), random(0,255), random(0,255), random(150,255));
    shapes[i] = new Shape(scene, loadShape("rocket.obj"));
    //scene.randomize(shapes[i]);
    
    
  }
  
  smooth();
  
  
}

void draw() {
  background(0);
  //scene.eye().setPosition(xp,yp,zp);
  scene.drawAxes();
  scene.traverse();
  
  //if(button1.pressed()){
  //  snPicking = !snPicking;
  //}
  
  if (snPicking)
    spaceNavigatorPicking();
  else
    spaceNavigatorInteraction();
}

void spaceNavigatorPicking() {
  float x = map(snXPos.getValue(), -1.5f, 1.5f, 0, width);
  float y = map(snYPos.getValue(), -1.5f, 1.5f, 0, height);
  // update the space navigator tracked frame:
  scene.cast("SPCNAV", x, y);
  // draw picking visual hint
  pushStyle();
  strokeWeight(3);
  stroke(0, 255, 0);
  scene.drawCross(x, y, 30);
  popStyle();
}



void spaceNavigatorInteraction() {
  
  xp=10 * (hat.right()?-1:(hat.left()?1:0));
  yp=10 * (hat.up()?1:(hat.down()?-1:0));
  zp=10 * snZPos.getValue();
  scene.translate( xp, yp,zp );
  
  //scene.rotate( -snXRot.getValue() * 20 * PI / width, snYRot.getValue() * 20 * PI / width, snZPos.getValue() * 20 * PI / width);
  
    
    //scene.translate( 10, 10 , 10 );
 scene.rotate(  (lb.pressed()? 1:0)*-20* PI / width, (rb.pressed()? 1:0) *20* PI / width,  0);
 
 println(scene.eye().position());
 //println(hat.right());
}

void mouseMoved() {
  scene.cast();
}

void mouseDragged() {
  if (mouseButton == LEFT)
    scene.spin();
  else if (mouseButton == RIGHT)
    scene.translate();
  else
    scene.scale(scene.mouseDX());
}

void mouseWheel(MouseEvent event) {
  scene.moveForward(event.getCount() * 20);
}

void keyPressed() {
  if (key == ' ')
    snPicking = !snPicking;
}

void openSpaceNavigator() {
  println(System.getProperty("os.name"));
  control = ControlIO.getInstance(this);
  String os = System.getProperty("os.name").toLowerCase();
  if (os.indexOf("nix") >= 0 || os.indexOf("nux") >= 0)
    device = control.getMatchedDevice("xbox360");// magic name for linux
  else
    device = control.getMatchedDevice("xbox360");//magic name, for windows
  if (device == null) {
    println("No suitable device configured");
    System.exit(-1); // End the program NOW!
  }
  //device.setTolerance(5.00f);
  snXPos = device.getSlider("j1x");
  snYPos = device.getSlider("j1y");
  snZPos = device.getSlider("z1");
  snXRot = device.getSlider("j2x");
  snYRot = device.getSlider("j2y");
  //snZRot = device.getSlider(5);
  a = device.getButton("a");
  b = device.getButton("b");
  lb = device.getButton("lb");
  rb = device.getButton("rb");
  hat = device.getHat("hat");
}
