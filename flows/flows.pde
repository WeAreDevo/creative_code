import java.util.LinkedList;
import java.util.Queue;

boolean debug = false;

color[] blues = {#2975CC,#59D2FE,#65AFFF};
color[] greens = {#4FFF7E,#A1FF96,#B0FFBE,#66FFAD};
color[] whites = {#FEF7FF,#F2FFFF,#FDFFF7,#FFF5F6, #F9FFF7};
color[] reds = {#FF0533,#FF7A93,#E3394F, #FF7569};
color[] curr;

FlowField flowfield;
Queue<ArrayList> q = new LinkedList<>();

PGraphics bg;

void setup() {
  size(800, 1000);
  flowfield = new FlowField(10);
  ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();
  // Make a whole bunch of vehicles with random maxspeed and maxforce values
  for (int i = 0; i < 500; i++) {
    int dir = random(0,1)<=0.5 ? -1 : 1;
    vehicles.add(new Vehicle(new PVector(random(0, width),random(0, height)), random(2, 5), random(0.1, 0.5), blues[int(random(0, blues.length))], 1) );
  }
  q.add(vehicles);
  
  bg = createGraphics(width, height);
  bg.beginDraw();
  bg.background(255,3);
  bg.noStroke();
  for (int i = 0; i < 300000; i++) {
    float x = random(width);
    float y = random(height);
    float s = noise(x*0.01, y*0.01)*2;
    bg.fill(240, 3);
    bg.rect(x, y, s, s);
  }
  bg.endDraw();
}

void draw() {
  //fill(255, 2);
  //noStroke();
  //rect(0,0,width, height);
  flowfield.update();

  if (debug) flowfield.display();
  // Tell all the vehicles to follow the flow field
  for(ArrayList<Vehicle> vehicles : q){
    
    for (Vehicle v : vehicles) {
      if(v.r < 2) continue;
      v.follow(flowfield);
      v.run();
    }
  }
  
  image(bg,0,0);
  saveFrame("frames_2/####.tif");
}


void keyPressed() {
  if (key == 'g') {
    curr=greens;
  }if (key == 'w') {
    curr=whites;
  }if (key == 'r') {
    curr=reds;
  }if (key == 'b') {
    curr=blues;
  }
  populate();
}

// Make a new flowfield
void populate() {
  //flowfield.init();
  ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();
  int dir = random(0,1)<=0.5 ? -1 : 1;
  for (int i = 0; i < 500; i++) {
    vehicles.add(new Vehicle(new PVector(random(0, width),random(0, height)), random(2, 5), random(0.1, 0.5), curr[int(random(0, curr.length))], dir) );
  }
  if(q.size()>=5) q.remove();
  q.add(vehicles);
}
