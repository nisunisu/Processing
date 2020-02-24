int eNum=2;        //正方形の1辺上にある円の数
float[][] xyPos;   //円のxy座標用二次元配列
color c;           //stroke用
float[] sp;        // 円の移動速度
float cX=0;
float cY=0;

FloatList xTrajectory; //軌跡x
FloatList yTrajectory; //軌跡y

// 軌跡xとyに格納するか判断するための変数
float[] pxPos=new float[3]; // 2...this, 1...before, 0...beforebefore
float[] pyPos=new float[3]; // 2...this, 1...before, 0...beforebefore


void setup(){
  size(600,600,P2D);
  frameRate(60);
  strokeWeight(3);
  noFill();
  
  /*
    もろもろ初期化
  */
  // 2次元配列
  xyPos=new float[eNum][2]; //xとyの二次元が欲しいので二つ目の[]は2。(三次元ならここは3)
  for(int row=0; row<2; row++){
    for(int col=0; col<2; col++){
      xyPos[row][col]=50;
    }
  }
  
  // stroke用の色
  c=color(120);
  stroke(c);
  
  // 円の移動速度
  sp=new float[eNum];
  sp[0]=25;  // 円1の速度
  sp[1]=20;  // 円2の速度
  
  //軌跡用List
  xTrajectory=new FloatList();
  yTrajectory=new FloatList();
  // 要素1を格納
  xTrajectory.append(50);
  yTrajectory.append(50);

  //軌跡xとyに格納するか判断するための変数
  for(int i=0; i<3; i++){
    pxPos[i]=50;
    pyPos[i]=50;
  }
}

void draw(){
  /*
    1. 変数宣言
    1. 描画（正方形、2つの円、2円の中間の円）
    1. 値更新
    1. 
    1. 
  */
  
  background(255);
  
  /*
    変数宣言
  */
  // 2円の中間座標xとy
  cX=(xyPos[0][0]+xyPos[1][0])*0.5;
  cY=(xyPos[0][1]+xyPos[1][1])*0.5;

  /*
    描画
  */
  // 正方形
  rect(50,50,500,500);
  
  // 円3つ
  //正方形の一辺を周回する2つの円
  for(int i=0; i<eNum; i++){
    ellipse(xyPos[i][0],xyPos[i][1],30,30);
  }
  // 2つの円を結ぶ直線
  line(xyPos[0][0],xyPos[0][1],xyPos[1][0],xyPos[1][1]);
  // 2つの円の中央
  ellipse(cX,cY,30,30);
  
  // 軌跡
  pxPos[0]=pxPos[1];
  pxPos[1]=pxPos[2];
  pxPos[2]=cX;
  
  pyPos[0]=pyPos[1];
  pyPos[1]=pyPos[2];
  pyPos[2]=cY;

  // 傾き
  float slope2=(pyPos[2]-pyPos[1])/(pxPos[2]-pyPos[1]);
  float slope1=(pyPos[1]-pyPos[0])/(pxPos[1]-pyPos[0]);
  // 傾きが変わった時に、1フレーム前のxy座標を記録する。（要素2以降）
  if(slope1 != slope2){
    xTrajectory.append(pxPos[1]);
    yTrajectory.append(pyPos[1]);
  }
  
  // 軌跡用FloatListの要素数が2以上の場合のみ実行
  pushStyle();
    //blendMode(ADD);
    //int hue = (int)random(160, 230);
    //fill(hue,80,30);
    
    // 1つ前までの線
    for(int i=0; i<xTrajectory.size()-1; i++){
      line(xTrajectory.get(i), yTrajectory.get(i),xTrajectory.get(i+1),yTrajectory.get(i+1)); //通常版
    }
    // 現在描画中の線
    int _num=xTrajectory.size()-1;
    //println(_num);
    line(cX,cY,xTrajectory.get(_num),yTrajectory.get(_num));
    
  popStyle();
  
  
  /*
    値更新
  */
  update();

  //情報出力
  if(frameCount%60 == 0){
    println(frameCount);
  }

}

void update(){
  //for(int i=0; i<eNum; i++){
  //  if( xyPos[i][1]<=50  ) xyPos[i][1]=50;  xyPos[i][0]+=sp[i]; // yが50の時
  //  if( xyPos[i][0]>=550 ) xyPos[i][0]=550; xyPos[i][1]+=sp[i]; // xが550の時
  //  if( xyPos[i][1]>=550 ) xyPos[i][1]=550; xyPos[i][0]-=sp[i]; // yが550の時
  //  if( xyPos[i][0]<=50  ) xyPos[i][0]=50;  xyPos[i][1]-=sp[i]; // xが50の時
  //}
  for(int i=0; i<eNum; i++){
    if(xyPos[i][1]<=50 ){xyPos[i][1]=50 ; xyPos[i][0]+=sp[i];} // yが50の時
    if(xyPos[i][0]>=550){xyPos[i][0]=550; xyPos[i][1]+=sp[i];} // xが550の時
    if(xyPos[i][1]>=550){xyPos[i][1]=550; xyPos[i][0]-=sp[i];} // yが550の時
    if(xyPos[i][0]<=50 ){xyPos[i][0]=50 ; xyPos[i][1]-=sp[i];} // xが50の時
  }
}
