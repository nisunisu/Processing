class ExpandCube{
  color gridCol=color (120,100,100,100); // ColorMode=HSB の前提で定義する
  float side    =1;    // 開始時の一辺の長さ。side/2で0除算にならないように1にする
  float sideFrom=side; // 一辺の長さを1から1000に変えていく
  float sideTo  =800;
  float gridDensity=side/10; // 1辺に対して何本の格子を作るか
  
  // Easing : ex) val=map(easeOutQuad(easingVal),0,1,valStart,valEnd);
  float easingVal=0;
  float easingAdd=0.03;
  
  // --------------------------------------------------
  int fnMain(int phase){
    // 概要   ：どんどん大きくなる緑色のGridを描画する
    //          Easing処理もこのクラス内で完結させる
    // 処理1  ：expandGridCube() ... 緑色のGridを描画する
    // 処理2  ：updateGridVal() ... Easing.pdeを使ってGridの一辺の長さを変更する
    // 外部pde：Easing.pde
    // 備考   ：ObjectのnewはColorMode有効後に行うため、setuup内で実施のこと
    // 戻値   ：int phase
    expandGridCube();
    updateGridVal();
    if(side>=sideTo){
      phase=incrementPhase(phase); // Globalで使っているphaseをインクリメントし、このクラスのfnMainが使われないようにする
    }
    return phase;
  }
  // --------------------------------------------------
  void expandGridCube(){
    // 外部変数：width, height, frameCount
    pushStyle();
    pushMatrix();
      translate(width/2,height/2,0);
      rotateX(frameCount*0.01);
      rotateY(frameCount*0.01);
      rotateZ(frameCount*0.01);
      stroke(gridCol);
        // --------------------------------------------
        float s=side/2; // sideが0にならないようにする
        for(float x=-s; x<=s; x+=gridDensity){
        for(float y=-s; y<=s; y+=gridDensity){
          line(x,y,s,x,y,-s);
        }}
        for(float x=-s; x<=s; x+=gridDensity){
        for(float z=-s; z<=s; z+=gridDensity){
          line(x,s,z,x,-s,z);
        }}
        for(float y=-s; y<=s; y+=gridDensity){
        for(float z=-s; z<=s; z+=gridDensity){
          line(s,y,z,-s,y,z);
        }}
        box(side);
    popMatrix();
    popStyle();
  }
  void updateGridVal(){
    easingVal+=easingAdd;
    side=map(easeInQuad(easingVal),0,1,sideFrom,sideTo);
    gridDensity=side/10;
  }
  int incrementPhase(int phase){
    phase++;
    return phase;
  }
}