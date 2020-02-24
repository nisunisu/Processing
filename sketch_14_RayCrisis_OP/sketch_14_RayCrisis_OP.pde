// Global:
// frameRate constant
final int I_FRAMERATE=30;

// class用newはColorModeが有効になるsetup内で実行する
int phase=1;
StartingMsg objStart;
HatchBackground objHatch;
ShrinkCube objShrink; // phase1用
ExpandCube objExpand; // phase2用

// ----------------------------------------------------------------------
void setup(){
  size(720,480,P3D);
    pixelDensity(displayDensity());
    frameRate(I_FRAMERATE);
    noFill();
    colorMode(HSB,360,100,100,100);
    ellipseMode(CENTER);
  objStart =new StartingMsg(); 
  objHatch =new HatchBackground(); 
  objShrink=new ShrinkCube(); // Phase1
  objExpand=new ExpandCube(); // Phase2
}
void draw(){
  background(0,0,15);
  if(phase==1) objHatch.fnMain(phase);
  if(phase==1) objStart.fnMain(phase);
  // if(phase==2) phase=objShrink.fnMain(phase);
  // if(phase==3) phase=objExpand.fnMain(phase);
}
