/*
  Description:
    MaryQuantロゴを描画する
    なおロゴを構成する円の半径は以下の通り。
     ・中心の円(小) … 150px
     ・中心の円(中) … 178px
     ・中心の円(大) … 325px
     ・周囲の円     … 193px
    よって半径の比は30:36:65:39。
  
  Arguments:
    _x ... xPos
    _y ... yPos
    _r ... radius
    _a ... alpha
*/

class MaryQuant{
  /*
    変数定義
  */
  
  PShape mq; // PShapeの親
  PShape e1; // radius1
  PShape e2; // ドーナツ。radius2, radius3
  PShape oe1,oe2,oe3,oe4,oe5; //OuterEllipse. radius4, radius5
  
  // 描画図形の中心座標
  float xPos;
  float yPos;

  // マリクワの各円の半径
  float radius1; // 小さいの円の半径
  float radius2; // 透過する円の半径（透過させたいのでbeginContour-endContourする）
  float radius3; // 大きい円の半径
  float radius4; // 周囲の円の半径
  float radius5; // 周囲の円を配置する座標を求めるための半径

  // マリクワ外周円の個数とxy座標
  int _eNum=5;    // 周囲の円の個数
  float[][] xyPosS=new float[_eNum][2]; //xy座標格納用。xyPosSurround.
  int angle=360/_eNum; // 360度を_eNumで割ると何度になるか

  // 彩度、透明度
  float hue;
  float saturation;
  float brightness;
  float alpha;
 

  /*
    コンストラクタ
  */
  MaryQuant(float _x,float _y,float _r,float _h,float _s,float _b,float _a){
    // 描画のx座標、y座標、Alpha
    xPos=_x;
    yPos=_y;
    hue=_h;   // 使っていない要素
    saturation=_s;
    brightness=_b;
    alpha=_a; // 使っていない要素
    
    // 各円の半径
    // 基準となるradiusを取得
    radius3=_r;
    
    // radius3を基準として代入していく
    radius1=radius3*30/65;
    radius2=radius3*36/65;
    radius4=radius3*39/65;
    radius5=radius3*0.9; //測ってないけど多分0.9くらい。
    
    // 書式定義
    noStroke();
    colorMode(HSB,360,100,100,100);
    color c=color(hue,saturation,brightness,alpha);
    fill(c);
    
    // 親GROUPでcreateShape
    mq=createShape(GROUP);
    
    // 中心円
    ellipseMode(RADIUS);
    e1=createShape(ELLIPSE,xPos,yPos,radius1,radius1);
    
    // ドーナツ部分
    e2=createShape();
      e2.beginShape();
        //radius3の円
        for(int i=0; i<=360; i++){
          float __x=radius3*cos(radians(i));
          float __y=radius3*sin(radians(i));
          e2.vertex(xPos+__x,yPos+__y);
        }
        //radius2の円。透過箇所
        e2.beginContour();
          for(int i=360; i>=0; i--){
            float __x=radius2*cos(radians(i));
            float __y=radius2*sin(radians(i));
            e2.vertex(xPos+__x,yPos+__y);
          }
        e2.endContour();
      e2.endShape();
    
    // 周囲の円
    float ang0=360/5;
    float ang1=radians(-90+ang0*1);
    float ang2=radians(-90+ang0*2);
    float ang3=radians(-90+ang0*3);
    float ang4=radians(-90+ang0*4);
    float ang5=radians(-90+ang0*5);
    float angARC=radians(99);
    oe1=createShape(ARC,xPos+radius5*cos(ang1),yPos+radius5*sin(ang1),radius4,radius4,ang1-angARC,ang1+angARC);
    oe2=createShape(ARC,xPos+radius5*cos(ang2),yPos+radius5*sin(ang2),radius4,radius4,ang2-angARC,ang2+angARC);
    oe3=createShape(ARC,xPos+radius5*cos(ang3),yPos+radius5*sin(ang3),radius4,radius4,ang3-angARC,ang3+angARC);
    oe4=createShape(ARC,xPos+radius5*cos(ang4),yPos+radius5*sin(ang4),radius4,radius4,ang4-angARC,ang4+angARC);
    oe5=createShape(ARC,xPos+radius5*cos(ang5),yPos+radius5*sin(ang5),radius4,radius4,ang5-angARC,ang5+angARC);
    
    /*
      透過円の順番を意識してaddする
    */
    mq.addChild(oe5);
    mq.addChild(oe4);
    mq.addChild(oe3);
    mq.addChild(oe2);
    mq.addChild(oe1);
    mq.addChild(e2);
    mq.addChild(e1);

  }
  
  void display(float _x,float _y,float _r, float _h,float _s,float _b,float _a){
    translate(_x,_y);
    scale(_r/radius3);
     e1.setFill(color(_h,_s,_b,_a));
     e2.setFill(color(_h,_s,_b,_a));
    oe1.setFill(color(_h,_s,_b,_a));
    oe2.setFill(color(_h,_s,_b,_a));
    oe3.setFill(color(_h,_s,_b,_a));
    oe4.setFill(color(_h,_s,_b,_a));
    oe5.setFill(color(_h,_s,_b,_a));
    
    //描画
    shape(mq);
  }

}
