/*
  noiseにより生成した波を表示する
  
  以下意味なし
    1. translate
    1. 2つ以上の変数/配列による宣言・処理
*/

// Test用
// PassingWave obj = new PassingWave();
// void setup(){
//   size(300,300);
// }
// void draw(){
//   obj.display();
//   obj.update();
// }

class PassingWave {
  color lineCol; // 線用
  float lineBase;   // lineの基本となる高さ
  float lineHeight; // 波を生じた際の高さ

  PassingWave(){
  }

  void display() {
    pushStyle();
      stroke(lineCol);
      strokeWeight(3);
      for(int x=0; x<width; x++){
        line(x,lineBase,x+1,lineBase);
      }
    popStyle();
  }

  void update(){
  }

  void move(){
  }
}
