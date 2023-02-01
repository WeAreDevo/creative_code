
class Vehicle {

  PVector position;
  PVector velocity;
  PVector acceleration;
  public float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  color c;
  int flowdir;
  int age;
  int alph;

    Vehicle(PVector l, float ms, float mf, color colour, int dir) {
    age = 1;
    alph=0;
    position = l.get();
    r = random(5,30);
    maxspeed = ms;
    maxforce = mf;
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    c = colour;
    flowdir = dir;
  }

  public void run() {
    update();
    borders();
    display();
  }


  // Implementing Reynolds' flow field following algorithm
  // http://www.red3d.com/cwr/steer/FlowFollow.html
  void follow(FlowField flow) {
    PVector desired = flow.lookup(position);
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    steer.mult(flowdir);
    applyForce(steer);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  // Method to update position
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
    if(alph<70) alph++;
    age++;
    age=age%10;
    if(age==0 && r!=0) r--;
  }

  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    fill(c,alph);
    noStroke();
    circle(position.x, position.y, r);
    //pushMatrix();
    //translate(position.x,position.y);
    //rotate(theta);
    //beginShape(TRIANGLES);
    //vertex(0, -r*2);
    //vertex(-r, r*2);
    //vertex(r, r*2);
    //endShape();
    //popMatrix();
  }

  // Wraparound
  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }
}
