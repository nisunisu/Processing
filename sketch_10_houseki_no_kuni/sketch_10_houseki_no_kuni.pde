Easing e=new EasingInExpo();

// 以下はlerpColorで使う(=要RGB)なのでcolorModeの前に初期化する
color c1=color(0,50,100);
color c2=color(0,0,0);

int num=70;
float[][] xyPos=new float[num][2];
float[] radius=new float[num];
float[] brightness=new float[num];
float[] alpha=new float[num];
float[][] xySpeed=new float[num][2];
float easingCnt=0;

MaryQuant[] mq=new MaryQuant[num];

String str1="#Processing";
boolean isStr1=false;
float alphaStr1=-15;

void setup(){
  size(500,500);
  frameRate(30);
  noCursor();

  stroke(4);

  noStroke();
  colorMode(HSB,360,100,100);
  ellipseMode(RADIUS);

  textSize(50);
  textAlign(CENTER);

  housekiInit();

  for(int i=0; i<mq.length; i++){
    mq[i]=new MaryQuant(xyPos[i][0],xyPos[i][1],radius[i],250,80,brightness[i],alpha[i]);
  }
}

void draw(){
  // background(0,0,0);
  backgroundGradation();
  translate(width/2,height/2);
  if(isStr1==true){
    textPop();
    textPopUpdate();
    housekiDraw();
    housekiUpdate();
  }

}
void mousePressed(){
  housekiInit();
  isStr1=true;
}
void keyPressed(){
  isStr1=false;
}
void textPop(){
  pushStyle();
    fill(255,0,100,alphaStr1);
    text(str1,0,0);
  popStyle();
}
void textPopUpdate(){
  if(alphaStr1<0){
    alphaStr1++;
  }else{
    alphaStr1=100;
  }
}
void backgroundGradation(){
  pushStyle();
  colorMode(RGB);
  for(float i=0; i<height; i+=5){
    color c=lerpColor(c1,c2,i/height);
    fill(c);
    rect(0,i,width,5);
  }
  popStyle();
}
void housekiInit(){
  for(int i=0; i<num; i++){
    xyPos[i][0]=random(-85,85); // x座標
    xyPos[i][1]=random(-30,110); // y座標
    radius[i]=random(35,50);
    brightness[i]=random(30,100);
    alpha[i]=random(-15,0);
    xySpeed[i][0]=random(-10,10); // x
    //xySpeed[i][1]=-3;             // y
    xySpeed[i][1]=map(radius[i],35,50,-2.5,-4.5);             // y
  }
  easingCnt=0;
}
void housekiDraw(){
  for(int i=0; i<num; i++){
    if(alpha[i]>=0){
      fill(255,0,brightness[i]);
      ellipse(xyPos[i][0],xyPos[i][1],radius[i],radius[i]);
      //mq[i].display(xyPos[i][0],xyPos[i][1],radius[i],250,80,brightness[i],100);
    }
  }
}
void housekiUpdate(){
  for(int i=0; i<num; i++){
    xyPos[i][0] += xySpeed[i][0]*(1-easeOutExpo(easingCnt));
    xyPos[i][1] += xySpeed[i][1];
    alpha[i]+=1;
    if(radius[i]>=2){
      radius[i]-=1.1;
    }
  }
  easingCnt+=0.008;
}

// void mousePressed(){
//   cnt++;
//
//   int _tmp=int(random(5));
//   x=e.get(_tmp);
//   y=easeInExpo(_tmp);
//
//   println("cnt="+cnt+", _tmp="+_tmp+", x/y="+x/y);
// }
