/*
  For executing with VSCode Integrated Terminal
*/
// processing-java --sketch=$(pwd) --run

// frameRate
final int _I_FRAMERATE=30;

// gifmakerを消したので使わないけど後学のために残しておく
import java.util.Calendar;
import java.text.SimpleDateFormat;
Calendar cal=Calendar.getInstance();
SimpleDateFormat hms = new SimpleDateFormat("HHmmss"); //HHだと24時間2桁


// global
PFont font;
String str="2";

// method_1
int num_1=2;
float side=150;
float x,xStart,xEnd;
float y,yStart,yEnd;
float easingCnt_1=0;
float easingAdd_1=_I_FRAMERATE/1000.0;
color col;

// method_2
float side_2;
float angle,angleStart,angleEnd;
float easingCnt_2=0;
float easingAdd_2=easingAdd_1*2;
int easingRptCnt=0;
int easingMaxRepeat=1;

// method_3
int num_3;
float[] angle_3;
float[] size_3;
color[] c_3;
float hue;
float alpha;
float rad_3,rad_3_Start,rad_3_End;


// ----------------------------------------------------------------
void setup(){
  size(500,500); 
  pixelDensity(displayDensity());
  frameRate(_I_FRAMERATE);
  noFill();
  noCursor();
  // noStroke();
  blendMode(ADD);  // ADDBLEND
  colorMode(HSB,360,100,100,100);
  strokeWeight(2);
  ellipseMode(RADIUS);
  rectMode(RADIUS);
  
  font=loadFont("Constantia-Italic-48.vlw");
  textFont(font,80);
  textAlign(CENTER,CENTER);
  
  init_1();
  init_2();
  init_3();
}
void draw(){
  background(0,0,15);
  //line(width/2,0,width/2,height);
  //line(0,height/2,width,height/2);
  
  translate(width/2,height/2);
  text(str,0,-10); // MOJI
  
  display_1();
  //display_2(); // wacha wacha suru node comment out
  display_3();
  
  // Output for MovieMaker
  //saveFrame("frames/######.tif");
}


// ----------------------------------------------------------------
/*
  General
*/
void mousePressed(){
  //none
}
void keyPressed(){
  if(key=='2'){num_1=2; easingMaxRepeat=2-1; str="2";}
  if(key=='3'){num_1=3; easingMaxRepeat=3-1; str="3";}
  if(key=='4'){num_1=4; easingMaxRepeat=4-1; str="4";}
  if(key=='5'){num_1=5; easingMaxRepeat=5-1; str="5";}
  if(key=='6'){num_1=6; easingMaxRepeat=6-1; str="6";}
  if(key=='7'){num_1=7; easingMaxRepeat=7-1; str="7";}
  if(key=='8'){num_1=8; easingMaxRepeat=8-1; str="8";}
  if(key=='9'){num_1=9; easingMaxRepeat=9-1; str="9";}
  frameCount=0;
  init_1();
  init_2();
  init_3();
}

/*
  1 : N kakukei
*/
void init_1(){
  xStart=side;
  xEnd=-xStart;
  
  yStart=xStart;
  yEnd=xStart;
  x=xStart;
  y=yStart;
  easingCnt_1=0;
  
  col=color(random(360),80,80);
}
void display_1(){
  pushMatrix();
    stroke(col);
    for(int i=0; i<num_1; i++){
      float angle=360/num_1;
      rotate(radians(angle));
      line(xStart,yStart,x,y);
    }
  popMatrix();

  // update
  if(x>xEnd){
    x=map(easeOutCubic(easingCnt_1),0,1,xStart,xEnd);
    easingCnt_1+=easingAdd_1;
  }
}

/*
  2 : A rect which rotates N times
*/
void init_2(){
  side_2=side*0.5;
  angle=0;
  angleStart=angle;
  angleEnd=90;
  easingCnt_2=0;
  easingAdd_2=easingAdd_1*easingMaxRepeat;
  easingRptCnt=0;
}
void display_2(){
  pushMatrix();
    rotate(radians(angle));
    rect(0,0,side_2,side_2);
    println(angle); // debug you
  popMatrix();
  
  // update
  if(angle < angleEnd){
    angle=map(easeInOutQuint(easingCnt_2),0,1,angleStart,angleEnd);
    easingCnt_2+=easingAdd_2;
  }
  if(angle >= angleEnd && easingRptCnt < easingMaxRepeat ){
    angleStart+=angle;
    angleEnd+=angle;
    easingCnt_2=0;
    easingRptCnt++;
  }
}

/*
  3 : N diamonds spreading
*/
void init_3(){
  num_3=num_1;
  angle_3=new float[num_3];
  size_3=new float[num_3];
  c_3=new color[num_3];
  for(int i=0; i<num_3; i++){
    angle_3[i]=360/num_3*i+random(-30,30);
    size_3[i]=50;
    
    c_3[i]=col;
  }
  rad_3_Start=30;
  rad_3=rad_3_Start;
  rad_3_End=200;
}
void display_3(){
  pushStyle();
  pushMatrix();
    rectMode(CENTER);
    rotate(QUARTER_PI); // rotate 45 degree so that a rect becomes a diamond
    for(int i=0; i<num_3; i++){
      float _x=rad_3*cos(radians(angle_3[i]));
      float _y=rad_3*sin(radians(angle_3[i]));
      
      stroke(c_3[i]);
      if(size_3[i]>0){
        pushStyle();
        //strokeWeight(4);
        //  rect(_x,_y,size_3[i],size_3[i]);
        //strokeWeight(3);
        //  rect(_x,_y,size_3[i],size_3[i]);
        strokeWeight(2);
          rect(_x,_y,size_3[i],size_3[i]);
        strokeWeight(1);
          rect(_x,_y,size_3[i],size_3[i]);
        popStyle();
      }
    }
  popMatrix();
  popStyle();
  
  // update
  for(int i=0; i<num_3; i++){
    size_3[i]-=1.5;
  }
  //rad_3=map(easeInOutCirc(easingCnt_1),0,1,rad_3_Start,rad_3_End);
  rad_3=map(easeOutQuint(easingCnt_1),0,1,rad_3_Start,rad_3_End);
}
