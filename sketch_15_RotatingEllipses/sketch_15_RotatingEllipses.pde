// frameRate constant
final int MY_FRAMERATE=30;

// Easing
// Usage : val=map(easeOutQuad(easingCnt),0,1,valStart,valEnd);
float easingCnt=0;
float easingAdd=MY_FRAMERATE/2000.0;

// every phase
int num=20;
EllipsoidalOrbit[] obj=new EllipsoidalOrbit[num];
float minRad=4;
float maxRad=12; // 
float[] objX=new float[num];
float[] objY=new float[num];

// phase 2
FloatList centerX=new FloatList();
FloatList centerY=new FloatList();
FloatList radius=new FloatList();
IntList radiusFrame=new IntList();


// ----------------------------------------------------------------------
void setup(){
  size(500,500,P2D);
  pixelDensity(displayDensity());
  frameRate(MY_FRAMERATE);
  colorMode(HSB,360,100,100,100);
  ellipseMode(RADIUS);
  //blendMode(ADD);

  for(int i=0; i<obj.length; i++){
    float _largeRad=300*noise(i);
    float _smallRad=200*noise(i);
    float _ellipseRad=random(minRad,maxRad);
    float _ellipseAngle=360*noise(i);  // ここを0代入にすると調和のとれた感じになる
    float _rotateAngle=360/obj.length*i;
    color _fillColor=color(random(150,200),80,random(40,80));
    obj[i]=new EllipsoidalOrbit(_largeRad,_smallRad,_ellipseRad,_ellipseAngle,_rotateAngle,_fillColor);
  }

  background(0,0,20,10); // 1フレーム目がチカチカしないようにする
}

void draw(){
  // background(0,0,15,80);
  fill(0,0,20,10); rect(0,0,width,height); // 薄い四角を被せて残像を表現する

  // for Debugging----------
  // stroke(0,0,80);
  // noFill();
  // line(0,height/2,width,height/2);
  // line(width/2,0,width/2,height);
  // ellipse(width/2,height/2,200,200);
  // ellipse(mouseX,mouseY,3,3);
  // println("xPos, yPos, frameCount, side : "+nf(mouseX,4)+", "+nf(mouseY,4)+", "+nf(frameCount,4));
  // -----------------------

  /*
    --- Ellipse-Round Ellipse ---
  */
  for(int i=0; i<obj.length; i++){
    obj[i].display();
    objX[i]=obj[i]._x;
    objY[i]=obj[i]._y;
  }


  /*
    --- 円が一定距離以上接近するとエフェクトを発生させる ---
  */
  // for(int i=0; i<num; i++){
  //   for(int j=0; j<num; j++){
  //     if (i<j) { // 2回計算を阻止
  //       if(abs(objX[i]-objX[j])<5){
  //         if(abs(objY[i]-objY[j])<5){
  //           centerX.append(abs(objX[i]+objX[j])/2);
  //           centerY.append(abs(objY[i]+objY[j])/2);
  //           radius.append(0);
  //           radiusFrame.append(0);
  //         }
  //       }
  //     }
  //   }
  // }
  // for(int i=0; i<centerX.size(); i++){
  //   ellipse(centerX.get(i),centerY.get(i),radius.get(i),radius.get(i));
  //   println("[DEBUG]"+centerX.get(i));

    
  //   // update
  //   int _nextRadiusFrame=radiusFrame.get(i) + 1; // 1インクリメント
  //   radiusFrame.set(i,_nextRadiusFrame);
    
  //   float _nextRadius=map(easeOutQuad(_nextRadiusFrame/30.0),0,1,0,100);
  //   radius.set(i,_nextRadius);
    
  //   if(_nextRadiusFrame>30){
  //     centerX.remove(i);
  //     centerY.remove(i);
  //     radius.remove(i);
  //     radiusFrame.remove(i);
  //   }  
  // }


}



// CLASS:
// ----------------------------------------------------------------------
class EllipsoidalOrbit{
  float lRad,sRad,eAngle; // large半径、small半径、円用の角度
  float eRad;
  float rotateAngle;
  color eCol;
  float _x,_y; // class外へ渡すために便利なので定義する
  boolean isZero=false;

  EllipsoidalOrbit(float _largeRad, float _smallRad, float _ellipseRad, float _ellipseAngle, float _rotateAngle, color _fillColor){
    lRad=_largeRad;
    sRad=_smallRad;
    eAngle=_ellipseAngle;
    eRad=_ellipseRad;
    rotateAngle=_rotateAngle;
    eCol=_fillColor;
  }

  void display(){
    pushMatrix();
    pushStyle();
      translate(width/2,height/2);
      rotate(radians(rotateAngle));
      noStroke();
      fill(eCol);
        _x=lRad*sin(radians(eAngle));
        _y=sRad*cos(radians(eAngle));
        ellipse(_x,_y,eRad,eRad);
    popStyle();
    popMatrix();
    
    //update
    eAngle+=map(eRad,minRad,maxRad,1.5,3);
    if(isZero==false){
      if(lRad>0) lRad-=1;
      if(sRad>0) sRad-=1;
      
      if((lRad<=0)&&(sRad<=0)) isZero=true;
    }else{
      lRad+=3;
      sRad+=3;
    }
    // rotateAngle++;
  }
}

// TEMPLATE(NOT IN USE):
// ----------------------------------------------------------------------
void mousePressed(){
}
void keyPressed(){
  frameCount=0;
}
void init_1(){
}
void display_1(){
}
