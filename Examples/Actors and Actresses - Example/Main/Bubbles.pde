/**
 * This class creates the bubbles and contains the functions that allow it to  be
 * moved and displayed for the program.
 */

class Bubbles {
  String name;
  PVector location;
  PVector velocity;
  float topspeed;
  float t = random(100);
  float n = random(100);
  float move = 0;
  color c;
  Bubbles(float x, float y, String name, color c) { // constructors for the class
    location = new PVector(x, y); // initializing the locations
    velocity = new PVector(0, 0); // initializing the velocity
    this.name = name; // giving the bubble a variable that holds name of the Actor
    this.c = c;
  }
  /** 
   * This function displays the bubbles on the screen, and it updates
   * the radius of the bubble
   */
  void display(float radius) {   
    move += 1;
    fill(c, 100);
    stroke(255);
    ellipse(location.x, location.y, radius+30, radius+30); // allows the radius' of one bubble to be seen if theres one movie only
    fill(#FF0000);
    text(name, location.x, location.y);
  }
  /** 
   * This function gives the Bubble a new location
   */
  void order(int xnew) {
    location.y = height/2;
    location.x = xnew;
  }
  /** 
   * This function allows the bubbles to move around in a noise like manner
   */

  void movement() {
    velocity.x = map(noise(t), 0, 1, 0, width); // updates velocity for x component
    velocity.y = map(noise(n), 0, 1, 0, height); // updats velocity for y component
    n+= 0.01;
    t+= 0.01;
    location.set(velocity);
  }
  /**
   * This function changes the fill of the bubble when the mouse is pressed
   */
  void changeFill(color newC){
    if (mousePressed){
    c = newC;
    }
  }
}

