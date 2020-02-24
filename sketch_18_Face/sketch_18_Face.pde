float noiseVal;
float xPos;
float yPos;
float radius;
float thisRadius;

void setup() {
  size(720,480,P2D);
  frameRate(30);
  smooth();
  pixelDensity(displayDensity());
  colorMode(HSB,360,100,100,100);
  ellipseMode(CENTER);
  // --------------------
  noiseVal=random(10);
}

void draw() {
  background(20);
  beginShape();
    for(int angle=0; angle<360; angle++){
      
      curveVertex(xPos,yPos);
    }
  endShape();
}