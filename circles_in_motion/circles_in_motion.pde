int _num = 10;
Circle[] _circleArr = {};

void setup() {
  size(1000,800);
  background(255);
  smooth();
  strokeWeight(1);
  fill(150, 50);
  drawCircles();
}
void draw() {
  //background(255);
  for (int i=0; i<_circleArr.length; i++) {
  Circle thisCirc = _circleArr[i];
  thisCirc.updateMe();
  }
}

void mouseReleased() {
  drawCircles();
}

void keyPressed() {
  saveFrame();
}

void drawCircles() {
  for (int i=0; i<_num; i++) {
    Circle thisCirc = new Circle();
    //thisCirc.drawMe();
    _circleArr = (Circle[])append(_circleArr, thisCirc);
  }
}

class Circle {
float x, y;
float radius;
color linecol, fillcol;
float gray;
float c;
float alph, alpha;
float xmove, ymove, xnoise, ynoise;

Circle () {
  x = random(width);
  y = random(height);
  radius = random(100) + 10;
  linecol = color(random(255), random(255), random(255));
  fillcol = color(random(255), random(255), random(255));
  gray = random(100);
  c = random(255);
  alph = random(100);
  alpha = random(50);
  xnoise = random(10);
  ynoise = random(10);
  xmove = random(10) - 5;
  ymove = random(10) - 5;
}

void drawMe() {
  noStroke();
  fill(fillcol, alph);
  ellipse(x, y, radius*2, radius*2);
  stroke(linecol, 150);
  noFill();
  ellipse(x, y, 10, 10);
}

void updateMe() {
  x += noise(xnoise)*10 - 5;
  y += noise(ynoise)*10 - 5;
  xnoise+=0.005;
  ynoise+=0.005;
  if (x > (width+radius)) { x = 0 - radius; }
  if (x < (0-radius)) { x = width+radius; }
  if (y > (height+radius)) { y = 0 - radius; }
  if (y < (0-radius)) { y = height+radius; }
  
  for (int i=0; i<_circleArr.length; i++) {
    Circle otherCirc = _circleArr[i];
    if (otherCirc != this) {
      float dis = dist(x, y, otherCirc.x, otherCirc.y);
      float overlap = dis - radius - otherCirc.radius;
      if (overlap < 0) {
        float midx, midy;
        midx = (x + otherCirc.x)/2;
        midy = (y + otherCirc.y)/2;
        stroke((c + otherCirc.c)/2, (alph + otherCirc.alph)/2);
        //noFill();
        overlap *= -1;
        fill((gray + otherCirc.gray)/2,(alph + otherCirc.alph)/2);
        ellipse(midx, midy, overlap, overlap);
      }  
    }
  }

  //drawMe();
}

}
