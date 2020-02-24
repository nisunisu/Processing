ColorfulCircles obj;
int fpg=190; // frame per GIF output

void setup() {
  size(720,480,P2D);
  frameRate(30);
  smooth();
  pixelDensity(displayDensity());
  colorMode(HSB,360,100,100,100);
  ellipseMode(CENTER);
  blendMode(ADD);
  obj=new ColorfulCircles(6,180,fpg);
}

void draw() {
  background(20);
  obj.fnMain();
}
