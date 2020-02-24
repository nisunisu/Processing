// オブジェクトの数
int num=20;

// xy座標と半径
FloatList posX=new FloatList();
FloatList posY=new FloatList();
FloatList radius=new FloatList();
// HSB用
FloatList hue=new FloatList();
FloatList saturation=new FloatList();
FloatList brightness=new FloatList();
FloatList alpha=new FloatList();

// 様々な色
color bgColor;
color houganColor;



/*
  setup
  ----------------------------------------------------------------------
*/
void setup(){
  size(1280,720);
  //fullScreen();
  colorMode(HSB,360,100,100,255);
  strokeWeight(5);
  frameRate(20);
  rectMode(RADIUS);
  ellipseMode(RADIUS);
  noFill();
  
  // FloatList初期化
  initializeFloatList();
  
  // Color初期化
  bgColor=color(100,0,100,255);
  houganColor=color(100,0,80,255);
}



/*
  draw
  ----------------------------------------------------------------------
*/
void draw(){
  // 変数
  background(bgColor);
  
  // 方眼紙
  pushStyle();
    strokeWeight(1);
    stroke(houganColor);
    for(int i=0; i<width; i+=25){
      line(i,0,i,height);
    }
    for(int j=0; j<height; j+=25){
      line(0,j,width,j);
    }
  popStyle();
  
  // numの数だけ図形を描画
  for(int i=0; i<num; i++){
    // HSB定義
    stroke(hue.get(i),saturation.get(i),brightness.get(i),alpha.get(i));

    // 処理
    rect(posX.get(i),posY.get(i),radius.get(i),radius.get(i)); // 正方形
    //ellipse(posX.get(i),posY.get(i),radius.get(i),radius.get(i)); // 円
  }
  
  // update
  updateFloatList();
  
  // 初期化
  // 色相用FloatListの最小値が255を超えた場合はリセット
  if(alpha.max()<=0){
    initializeFloatList();
  }
  
}



/*
  FloatListの値を更新
  ----------------------------------------------------------------------
*/
void updateFloatList(){
  // 図形の半径と色相を更新
  for(int i=0; i<num; i++){
    radius.add(i,1);
    alpha.sub(i,8);
  }
}



/*
  FloatListをまとめて初期化
  ----------------------------------------------------------------------
*/
void initializeFloatList(){
  // 要素をクリア
  posX.clear();
  posY.clear();
  radius.clear();
  hue.clear();
  saturation.clear();
  brightness.clear();
  alpha.clear();

  // numの数だけFloatListにappend
  for(int i=0; i<num; i++){
    // 変数
    float _tmp1=random(width);
    float _tmp2=random(height);
    float _tmp3=random(100);
    float _tmp4=random(70,135);
    float _tmp5=random(80);
    float _tmp6=random(30);
    float _tmp7=random(100,250);
    
    // 代入
    posX.append(_tmp1);
    posY.append(_tmp2);
    radius.append(_tmp3);
    hue.append(_tmp4);
    saturation.append(_tmp5);
    brightness.append(_tmp6);
    alpha.append(_tmp7);
  }
}
