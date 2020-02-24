class ColorfulCircles{
  int       dotNum; // 円のドット数
  PVector[] pv;
  float     radius;
  // color[] linecol =new color[dotNum];
  // float[] alpha   =new float[dotNum];
  int fpg; // frame per GIF output
  int thisFrameCount;

  ColorfulCircles(int _dotNum, float _radius, int _fpg){
    dotNum=_dotNum;
    pv=new PVector[dotNum];
    radius=_radius;
    fpg=_fpg;
    thisFrameCount=0;
    fnInit();
  }

  void fnMain(){
    // 概要   ：
    // 処理1  ：fnDrawColorCircles() ... 波紋を描画
    // 処理2  ：fnUpdateAlpha() ... 波紋のfillとstrokeのalphaを減衰させる。また波紋の半径が初期値の二倍となった場合に初期化を行う
    // 処理3  ：fnSetFrameCount() ... thisFrameCountをインクリメントする。gif出力用のframe数に到達した場合0に設定する
    // 外部pde：なし
    // 備考   ：colorMode(HSB,360,100,100,100)が前提
    // 戻値   ：int phase
    fnDisplayDots();
  }

  // ---------------------------------------------------------------------
  void fnDisplayDots(){
    for (int i=0; i<dotNum; i++){
      ellipse(pv[i].x,pv[i].y,20,20);
    }
  }
  
  // ---------------------------------------------------------------------
  void fnInit(){
    for (int i=0; i<dotNum; i++){
      float angle=360/dotNum*i;
      pv[i]=new PVector;
      pv[i].x=radius*cos(radians(angle));
      pv[i].y=radius*sin(radians(angle));
    }
  }

  // ---------------------------------------------------------------------
  void fnUpdateAlpha(){
  }

}