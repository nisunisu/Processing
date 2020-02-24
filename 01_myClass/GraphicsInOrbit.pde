/*
  三角形or四角形or五角形or円をsketchの中心に描画する
  Constructor: GraphicsInOrbit(int _i, int _ang, float _rad, float _radOrbt, int _angOrbt)
  display();
  update()
*/

class GraphicsInOrbit{
  int     i; //図形種別
  int   ang; //図形の角度
  float rad; //基準円の半径（この円に内接する三角形、正方形、五角形、円を描画する）
  float radOrbt; //図形の周回半径
  int   angOrbt; //図形の周回角度
  
  // HSBのカラー指定用
  color col;
  
  int alpha; //透明度
  int alphaAdd;
  int cnt;   //カウント
  
  // EaseInExpoで実装する
  int angAdd=4;
  float t=map(frameCount,0,frameRate/2,0,1.0);
  float angAddEasing=angAdd * easeInExpo(t);

  //コンストラクタ
  GraphicsInOrbit(int _i, int _ang, float _rad, float _radOrbt, int _angOrbt){
    i=_i;
    ang=_ang;
    rad=_rad;
    
    radOrbt=_radOrbt;
    angOrbt=_angOrbt;
    
    col=color(int(random(100)),100,100);
    
    alpha=0; //透明度
    alphaAdd=3;
    cnt=0;
  }
  
  
  //iの値によって異なる図形を描く
  void display(){
    //0 ... triangle
    //1 ... rect
    //2 ... ellipse
    //3 ... pentagon
    if(i==0){
      /*
        0:三角形
      */
      float _a=rad*cos(radians(30+ang));
      float _b=rad*sin(radians(30+ang));
      float _c=rad*cos(radians(150+ang));
      float _d=rad*sin(radians(150+ang));
      float _e=rad*cos(radians(270+ang));
      float _f=rad*sin(radians(270+ang));

      float _x=radOrbt*cos(radians(angOrbt));
      float _y=radOrbt*sin(radians(angOrbt));

      pushMatrix();
        fill(col,alpha);
        translate(_x,_y);
          triangle(_a,_b,_c,_d,_e,_f);
      popMatrix();
    }else if(i==1){
      /*
        1:四角形
      */
      float _a=rad/sqrt(2.0);
      
      float _x=radOrbt*cos(radians(angOrbt));
      float _y=radOrbt*sin(radians(angOrbt));
      
      rectMode(RADIUS); //rect(中心のx座標, 中心のy座標, 幅の半分, 高さの半分)
      pushMatrix();
        fill(col,alpha);
        translate(_x,_y);
          rotate(radians(ang));
            rect(0,0,_a,_a);
      popMatrix();
    }else if(i==2){
      /*
        2:バイオハザードマークみたいなもの
      */
      
      //FIXME:美しくない
      float _x=radOrbt*cos(radians(angOrbt));
      float _y=radOrbt*sin(radians(angOrbt));
      ellipseMode(RADIUS);

      pushMatrix();
        translate(_x,_y);
          rotate(radians(ang));
            pushStyle();
              fill(col,alpha);
                //扇形3
                arc(0,0,rad,rad,     0,PI*1/3,PIE); //1/3*PIだと変な図形になる
                arc(0,0,rad,rad,PI*2/3,    PI,PIE);
                arc(0,0,rad,rad,PI*4/3,PI*5/3,PIE);

                ellipse(0,0,rad/8,rad/8);
            popStyle();
  
            //中心の円
            //pushStyle();
            //  noStroke();
            //  ellipse(0,0,rad/4,rad/4);
            //popStyle();
             
            //点3つ
            //float _ang1=HALF_PI;
            //float _ang2=PI*7/6;
            //float _ang3=PI*11/6;
            //float _x1=rad*2/3*cos(_ang1);
            //float _y1=rad*2/3*sin(_ang1);
            //float _x2=rad*2/3*cos(_ang2);
            //float _y2=rad*2/3*sin(_ang2);
            //float _x3=rad*2/3*cos(_ang3);
            //float _y3=rad*2/3*sin(_ang3);
            //float _r=rad/12;
            //ellipse(_x1,_y1,_r,_r);
            //ellipse(_x2,_y2,_r,_r);
            //ellipse(_x3,_y3,_r,_r);
      popMatrix();
    }else{
      /*
        3:円
      */
    }
  }
  
  void update(){
    if(alpha>=255 && alphaAdd>0) alphaAdd*=-1; //透明度0(alpha=255)かつalphaAddが正の場合、負にする

    if(cnt<100){
      ang+=2;
    }else{
      ang+=15;
      angOrbt++;
    }

    radOrbt++;
    alpha+=alphaAdd;
    cnt++;
  }
}