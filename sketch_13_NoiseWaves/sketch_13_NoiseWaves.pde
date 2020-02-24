/*
  For executing with VSCode Integrated Terminal
*/
// processing-java --sketch=$(pwd) --run

// frameRate用
final int _I_FRAMERATE=30;

// 日付用
import java.util.Calendar;
Calendar cal=Calendar.getInstance();

import java.text.SimpleDateFormat; // formatメソッドの戻り値はString
SimpleDateFormat hms = new SimpleDateFormat("HHmmss"); //HHだと24時間2桁

// method_1用
NoiseWave[] obj=new NoiseWave[3];

// method_2用
CrossPattern obj_2;

void setup(){
  size(720,480);
  // fullScreen();
  // pixelDensity(2);
  frameRate(_I_FRAMERATE);
  noFill();
  noCursor();
  colorMode(HSB,360,100,100,100);
  ellipseMode(RADIUS);
  rectMode(RADIUS);
  
  for(int i=0; i<obj.length; i++){
    obj[i]=new NoiseWave(200);
  };
  
  obj_2=new CrossPattern(90);
}
void draw(){ //<>//
  background(0,0,100);
  
  for(int i=0; i<obj.length; i++){
    obj[i].display();
    obj[i].update();
  };

  obj_2.display();
  obj_2.update();

  line(width/2,0,width/2,height);
  line(0,height/2,width,height/2);
}

/*
  General
*/
void mousePressed(){
  for(int i=0; i<obj.length; i++){
    obj[i]=new NoiseWave(70*i);
  }
}
void keyPressed(){
  frameCount=0;
}