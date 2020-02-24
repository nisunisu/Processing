class HatchBackground{
  // 変数：hatchBackground()
  float haba=40;   // ひし形の幅
  float takasa=20; // ひし形の高さ

  // --------------------------------------------------
  int fnMain(int phase){
    // 概要   ：格子状の背景を描画する
    // 処理1  ：hatchBackground() ... 格子状の背景を描画する
    // 外部pde：なし
    // 備考   ：外部変数phaseに対して何の変更も加えない
    // 戻値   ：int phase
    hatchBackground();
    return phase;
  }
  void hatchBackground(){
    // 概要：網掛けの背景を表示する
    pushStyle();
      noFill();
      // haba  =map(mouseX,-20, width,20,50);
      // takasa=map(mouseY,-20,height,20,50);
      for(float x=0; x<width +haba  ; x+=haba*2){
      for(float y=0; y<height+takasa; y+=takasa*2){
        // 下に行くほど線を暗くする
        float bright=map(y,0,height,90,25);
        stroke(0,0,bright);
        // ひし形
        beginShape();
          for(int i=0; i<4; i++){
            float r= (i%2==0) ? haba : takasa;
            vertex(
              x + r*cos(HALF_PI*i),
              y + r*sin(HALF_PI*i)
            );
          }
        endShape(CLOSE);
      }}
    popStyle();
  }
}
