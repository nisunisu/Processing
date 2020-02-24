class ColorfulCircles{
  int num=30;
  PVector[]   pv    =new PVector[num];
  float[] radius    =new float[num];
  float[] initialRad=new float[num];
  color[] linecol   =new color[num];
  color[] fillcol   =new color[num];
  float[] alpha     =new float[num];
  int fpg; // frame per GIF output
  int thisFrameCount=0;

  ColorfulCircles(int fpg){
    this.fpg=fpg;
    fnInit();
  }

  void fnMain(){
    // 概要   ：水面に出来た波紋のような円を描画する。
    //         　frameCountに対応したHueの色になる。
    //          frameCountはdraw()のpdeに設定されたgif出力用のframe数に到達すると0にリセットされる。
    // 処理1  ：fnDrawColorCircles() ... 波紋を描画
    // 処理2  ：fnUpdateAlpha() ... 波紋のfillとstrokeのalphaを減衰させる。また波紋の半径が初期値の二倍となった場合に初期化を行う
    // 処理3  ：fnSetFrameCount() ... thisFrameCountをインクリメントする。gif出力用のframe数に到達した場合0に設定する
    // 外部pde：なし
    // 備考   ：colorMode(HSB,360,100,100,100)が前提
    // 戻値   ：int phase
    fnDrawColorCircles();
    fnUpdateAlpha();
    fnSetFrameCount();
  }

  // ---------------------------------------------------------------------
  void fnDrawColorCircles(){
    for (int i=0; i<num; i++){
      stroke(linecol[i]);
      fill(fillcol[i]);
        ellipse(pv[i].x,pv[i].y,radius[i],radius[i]);
    }
  }
  
  // ---------------------------------------------------------------------
  void fnInit(){
    for (int i=0; i<num; i++){
      fnInitUnit(i);
    }
  }
  void fnInitUnit(int i){
    pv[i]=new PVector(random(width),random(height));
    initialRad[i]=random(40,130);
    radius[i]=initialRad[i];
    float stdHue=map(thisFrameCount,0,fpg,0,360);  // 時間経過で色合いが変化
    // float stdHue=map(mouseX,0,width,0,360); // mouseXで色合いが変化
    float h=random(stdHue-20,stdHue+20);
    float a=random(30,100);
    linecol[i]=color (h,100,80,a); // lineをfillより濃くする
    fillcol[i]=color (h, 70,80,a);
  }

  // ---------------------------------------------------------------------
  void fnUpdateAlpha(){
    for (int i=0; i<num; i++){
      fnUpdateAlphaUnit(i);
    }
  }
  void fnUpdateAlphaUnit(int i){
    // fillとlineでalphaの減衰度を分けてlineが長く残るようにする
    // fill
    float h=       hue(fillcol[i]);
    float s=saturation(fillcol[i]);
    float b=brightness(fillcol[i]);
    float a=     alpha(fillcol[i]);
    a--;
    fillcol[i]=color(h,s,b,a);
    
    // line
    float h2=       hue(linecol[i]);
    float s2=saturation(linecol[i]);
    float b2=brightness(linecol[i]);
    float a2=     alpha(linecol[i]);
    a2-=0.3;
    linecol[i]=color(h2,s2,b2,a2);

    // 半径が規定値を超えたら初期化する 
    radius[i]++;
    if(radius[i]>initialRad[i]*2){
      fnInitUnit(i);
    }
  }
  void fnSetFrameCount(){
    thisFrameCount++;
    thisFrameCount= (thisFrameCount>this.fpg) ? 0 : thisFrameCount ;
  }

}