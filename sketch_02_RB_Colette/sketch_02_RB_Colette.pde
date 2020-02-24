float rad=220; //カラーホイール配置の半径
int eNum=12;   //カラーホイールの個数。360の約数。
float eDia=80;
int ang=0;
int angAdd=-1;
int cnt=0;
String str="hogehoge";

color[] col=new color[eNum];

void setup(){
  size(750,750);
  frameRate(30);
  noStroke();
  colorMode(HSB,360,100,100,100);
  for(int i=0; i<eNum; i++){
    float hue=360/eNum*i;
    col[i]=color(hue,60,90);
  }

  textAlign(CENTER, CENTER);
  textSize(50);
}

void draw(){
  background(255);
  translate(width/2, height/2);

  for(int i=0; i<eNum; i++){
    float angle=ang+360/eNum*i;
    float xPos=rad*cos(radians(angle));
    float yPos=rad*sin(radians(angle));
    
    fill(col[i]);
    ellipse(xPos,yPos,eDia,eDia);
  }
  ang+=2;
  
  //テキストカラー
  if (cnt<170) fill(cnt);
  else         fill(170);
  //テキスト  
  text(str,0,0); //text, x座標, y座標
  cnt++;
}
