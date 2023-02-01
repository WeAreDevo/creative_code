float _angnoise, _radiusnoise;
float _xnoise, _ynoise, _x1noise, _x4noise, _y1noise, _y4noise, _c1noise, _c2noise;
float _angle = -PI/2;
float _radius;
float _strokeCol = 254;
int _strokeChange = -1;

void setup() {
  size(500, 300);
  smooth();
  frameRate(30);
  background(255);
  noFill();
  _angnoise = random(10);
  _radiusnoise = random(10);
  _xnoise = random(10);
  _ynoise = random(10);
  _c1noise = random(1);
  _c2noise = random(1);
  _x1noise = random(10);
  _x4noise = random(10);
  _y1noise = random(10);
  _y4noise = random(10);
}


void draw() {
  _radiusnoise += 0.005;
  _c1noise+=0.05;
  _c2noise+=0.05;
  _radius = (noise(_radiusnoise) * 450) +1;
  _angnoise += 0.005;
  _angle += (noise(_angnoise) * 6) - 3;
  if (_angle > 360) { _angle -= 360; }
  if (_angle < 0) { _angle += 360; }
  _xnoise += 0.01;
  _ynoise += 0.01;
  _x1noise += 0.01;
  _y1noise += 0.01;
  _x4noise += 0.01;
  _y4noise += 0.01;
  float centerX = width/2 + (noise(_xnoise) * 100) - 50;
  float centerY = height/2 + (noise(_ynoise) * 100) - 50;
  float rad = radians(_angle);
  float x2 = centerX + (_radius * cos(rad));
  float y2 = centerY + (_radius * sin(rad));
  float x1 = centerX + noise(_c1noise)*(x2 - centerX) + (noise(_x1noise)* 200) - 100;
  float y1 = centerY + noise(_c1noise)*(y2 - centerY) + (noise(_y1noise)* 200) - 100;
  float opprad = rad + PI;
  float x3 = centerX + (_radius * cos(opprad));
  float y3 = centerY + (_radius * sin(opprad));
  float x4 = centerX + noise(_c2noise)*(x3 - centerX) + (noise(_x4noise)* 200) - 100;
  float y4 = centerY + noise(_c2noise)*(y3 - centerY) + (noise(_y4noise)* 200) - 100;
  _strokeCol += _strokeChange;
  if (_strokeCol > 254) { _strokeChange = -1; }
  if (_strokeCol < 0) { _strokeChange = 1; }
  stroke(_strokeCol, 60);
  strokeWeight(1);
  bezier(x2, y2,x1, y1, x4, y4, x3, y3);
  
  saveFrame("frames/####.tif");
}
