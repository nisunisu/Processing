// int num=30;
// PVector[] pv=new PVector[num];
// float[] radius=new float[num];
// float[] initialRad=new float[num];
// color[] linecol=new color[num];
// color[] fillcol=new color[num];
// float[] alpha=new float[num];
ColorfulCircles objCC;
int fpg=190; // frame per GIF output

void setup() {
  size(720,480,P2D);
  frameRate(30);
  smooth();
  pixelDensity(displayDensity());
  colorMode(HSB,360,100,100,100);
  ellipseMode(CENTER);
  blendMode(ADD);
  // strokeWeight(2); //有効にすると途端に重くなる

  // fnInit();
  objCC=new ColorfulCircles(fpg);
  
}

void draw() {
  background(20);
  // for (int i=0; i<num; i++){
  //   stroke(linecol[i]);
  //   fill(fillcol[i]);
  //     ellipse(pv[i].x,pv[i].y,radius[i],radius[i]);
  // }
  // // update
  // fnUpdate();
  // frameCount= (frameCount>fpg) ? 0 : frameCount ; // hueがmaxになったら0に戻す
  objCC.fnMain();

}

// void fnInit(){
//   for (int i=0; i<num; i++){
//     fnInitUnit(i);
//   }
// }
// void fnInitUnit(int i){
//   pv[i]=new PVector(random(width),random(height));
//   initialRad[i]=random(40,130);
//   radius[i]=initialRad[i];
//   float stdHue=map(frameCount,0,fpg,0,360);  // 時間経過で色合いが変化
//   // float stdHue=map(mouseX,0,width,0,360); // mouseXで色合いが変化
//   float h=random(stdHue-20,stdHue+20);
//   float a=random(30,100);
//   linecol[i]=color (h,100,80,a); // lineをfillより濃くする
//   fillcol[i]=color (h, 70,80,a);
// }
// void fnUpdate(){
//   for (int i=0; i<num; i++){
//     fnUpdateUnit(i);
//   }
// }
// void fnUpdateUnit(int i){
//   // fillとlineでalphaの減衰度を分けてlineが長く残るようにする
//   // fill
//   float h=       hue(fillcol[i]);
//   float s=saturation(fillcol[i]);
//   float b=brightness(fillcol[i]);
//   float a=     alpha(fillcol[i]);
//   a--;
//   fillcol[i]=color(h,s,b,a);
  
//   // line
//   float h2=       hue(linecol[i]);
//   float s2=saturation(linecol[i]);
//   float b2=brightness(linecol[i]);
//   float a2=     alpha(linecol[i]);
//   a2-=0.3;
//   linecol[i]=color(h2,s2,b2,a2);

//   // 半径が規定値を超えたら初期化する 
//   radius[i]++;
//   if(radius[i]>initialRad[i]*2){
//     fnInitUnit(i);
//   }
// }
