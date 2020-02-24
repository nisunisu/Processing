/*
  For executing with VSCode Integrated Terminal
*/
// processing-java --sketch=$(pwd) --run

// frameRate用
final int _I_FRAMERATE=30;

// 何かの判定
boolean isFlg=false;

// method_1用
int alpha=300;
int alphaAdd=-3;

// method_2用
int num=30;
float[][] rar=new float[num][3];  //radius,angle,ellipseRadius
float[][] hsba=new float[num][4]; //hue,saturation,brightness,alpha
float[][] rarAdd=new float[num][3];
float[][] hsbaAdd=new float[num][4];

// Easing用
float easingCnt=0;
float easingAdd=_I_FRAMERATE/1000.0;

// MaryQuant用
MaryQuant[] mq=new MaryQuant[num];

void setup(){
  size(800,800); 
  frameRate(_I_FRAMERATE);
  noCursor();
  noStroke();

  colorMode(HSB,360,100,100,100);
  ellipseMode(RADIUS);

  // textSize(50);
  // textAlign(CENTER);
  
  init_1();
  init_2();
}
void draw(){
  background(0,0,80);
  translate(width/2,height/2);
  
  // draw
  draw_1();
  draw_2();

  // update
  easingCnt+=easingAdd; // common factor update
  update_1();
  update_2();
  
}

/*
  General
*/
void mousePressed(){
  //none
}
void keyPressed(){
  if (key=='R') {
    //none
  }
}

/*
  1. 真ん中の円
*/
void init_1(){
  //none
}
void draw_1(){
  for(int i=0; i<5; i++){
    float _rad=(220-40*i)*easeOutElastic(easingCnt); // 大きい方の円から描く
    fill(20+50*i,60,90,alpha);
    ellipse(0,0,_rad,_rad);
  }
}
void update_1(){
  alpha+=alphaAdd;
}

/*
  2. 放射状の円
*/
void init_2(){
  for(int i=0; i<num; i++){
    rar[i][0]=random(80); // radius
    rar[i][1]=360/num*i+random(45); // angle
    rar[i][2]=random(5,30); // radius
    hsba[i][0]=80/num*i; // hue
    hsba[i][1]=50; // saturation
    hsba[i][2]=90; // brightness
    hsba[i][3]=random(100,150); // alpha
    rarAdd[i][0]=9*map(rar[i][2],5,30,0.1,1);//円が小さいほど遅くする
    rarAdd[i][1]=0; // angleは固定
    rarAdd[i][2]=0; // 円半径は固定
    hsbaAdd[i][3]=-1; // alpha
  }
}
void draw_2(){
  for(int i=0; i<num; i++){
    fill(hsba[i][0],hsba[i][1],hsba[i][2],hsba[i][3]);
    float _x=rar[i][0]*cos(rar[i][1]);
    float _y=rar[i][0]*sin(rar[i][1]);
    float _rad=rar[i][2]*easeOutBounce(easingCnt); //円の半径はEaseOutBounceで大きくなるようにする
    ellipse(_x,_y,_rad,_rad);
  }
}
void update_2(){
  for(int i=0; i<num; i++){
    rar[i][0]+=rarAdd[i][0]; // xy座標をインクリメント
    hsba[i][3]+=hsbaAdd[i][3]; //alphaをデクリメント
  }
}
