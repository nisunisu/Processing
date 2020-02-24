/*
  noiseにより生成した波を表示する
  
  以下意味なし
    1. translate
    1. 2つ以上の変数/配列による宣言・処理
*/
class NoiseWave {
  float xoff; // perlin noiseの要素1。display()実行の度に0に初期化される
  float yoff; // perlin noiseの要素2。update()実行の度にインクリメントされる
  float zoff; // perlin noiseの要素3。コンストラクタ実行時にobj毎に固有の値を割り当てる
  color col;
  color lineCol; // 線用
  float low;  // Waveの最小の高さ
  float high; // Waveの最大の高さ

  NoiseWave(float hue){
    // xoff=0; //display()の度に0になるためここでは初期化しない
    yoff=0;
    zoff=random(0,10000);
    col=color(hue,100,80,30); // 透過しない(-> alpha=100)の方が綺麗
    // lineCol=col;        // Pattern1 ... stroke()がcolと同じ
    lineCol=color(0,0,80); // Pattern2 ... stroke()が灰色
    low=random(50,100);
    high=random(300,400);
  }

  void display() {
    pushStyle();
      fill(col);
      stroke(lineCol);
      strokeWeight(1);
      beginShape(); 
        float xoff=0;
        // xをfloatとして使いたいがために`float x`となっている
        for (float x=0; x<=width; x+=30) {
          float y=map(noise(xoff,yoff,zoff),0,1,low,high); // Option #1: 2D Noise
          vertex(x,y); 
          xoff+=0.05; // for内向けインクリメント
        }
        vertex(width,height);
        vertex(0,height);
      endShape(CLOSE);
    popStyle();
  }

  void update(){
    yoff+=0.01;
  }

  void move(){
  }
}
