/*
正四面体2つ（LinkAmp）が回転する
中央にAegis Novaの文字
光球が上昇する
*/


//LinkAmp用変数
float aS  = 200.0;     //正四面体（小）の1辺の長さ
float aL  = aS*1.5;    //正四面体（大）の1辺の長さ
float ch  = sin(PI/3.0);   //coefficient of height - 正三角形の高さ = 3^0.5/2*a
float chh = sqrt(6.0)/3.0; //coefficient of height - 正四面体の高さ = 6^0.5/3*a
float cg  = 1.0/3.0;      //coefficient of center of gravity - 正三角形にて、底辺から重心:重心から頂点 = 1:2
float cgg = 1.0/4.0;      //coefficient of center of gravity - 正四面体にて、底面から重心:重心から頂点 = 1:3
// aS*ch      //正三角形（小）の高さ
// aS*ch*cg   //正三角形の底辺から重心までの距離
// aS*chh     //正四面体（小）の高さ
// aS*chh*cgg //正四面体の底面から重心までの距離
float rotx  = 0;
float roty  = 0;
//Txt用変数
int i = 0;                  //setupの外で変数宣言
PFont myfont;
LightParticle lp; //ここで初期化するとsizeの前のParticleクラスを取りに行きwidth=height=100になるので初期化しない
//LightParticle[] lp = new LightParticle[5];
void setup() {
  size(1280, 720, P3D);
  pixelDensity(displayDensity());
  println("aS*ch    = " + aS*ch);
  println("aS*ch*cg = " + aS*ch*cg);
  strokeWeight(5);
  myfont = createFont("Coda", 44, true);
  textFont(myfont);
  //frameRate(120);
  //stroke(255,255,0);
  lp = new LightParticle();
  //for(int i = 0; i<lp.length; i++){
  //  lp[i] = new LightParticle();
  //}
  //noLoop(); // draw関数のループを停止させる
}
void draw() {
  //background(0);
  //lp[0].lighten();
  lp.lighten();
  //line(0, 0, width, height);
  //line(0, height, width, 0);

  //translate(width/2, height/2);
  //pushMatrix();
    translate(0, 0, 100);
    if(i < width/2){
      if (i < 255) stroke(i);
      else         stroke(255);
      ++i;
      line(width/2, height/2,  width/2+2*i, height/2);
      line(width/2, height/2,  width/2-2*i, height/2);
    }
    displaytext("Aegis Nova", "INGRESS");
  //popMatrix();

  translate(width/2, height/2);
  //ellipse(0, 0, 50, 50);     //位置把握用球
  rotateX(PI*frameCount/240);
  rotateY(PI*frameCount/180);
  
  pushMatrix();
    translate(0, aS*ch*cg, -aS*chh*cgg);
    drawTetra(aS);
  popMatrix();

  pushMatrix();
    translate(0, aL*ch*cg, -aL*chh*cgg);
    drawTetra(aL);
  popMatrix();
  
  //動画書き出し
  //saveFrame("frames/######.tif");
}
void drawTetra(float a) { //一辺の長さaの正四面体を描画
  //if (i < 255) stroke(0, 128, 128, 100);
  //else         stroke(0, 255-i, i, 100);
  stroke(0, 128, 150, 100);
  noFill();
  //translate(0, a*ch*cg, -a*chh*cgg); //このtranslateはdraw()の中で実行されない。(x,y,z)=(0,0,0)に重心を移動
  beginShape(TRIANGLE_STRIP);
  vertex( a/2,        0,     0);
  vertex(   0,    -a*ch,     0);
  vertex(-a/2,        0,     0); //正三角形その1
  vertex(   0, -a*ch*cg, a*chh); //正三角形その2
  vertex( a/2,        0,     0); //正三角形その3
  vertex(   0,    -a*ch,     0); //正三角形その4
  endShape(CLOSE);
}
void displaytext(String a, String b){
    //文字色条件分岐
    if (i < 255) fill(i);
    else         fill(255);
    // Aegis Nova
    textAlign(CENTER, BOTTOM);
    textSize(100);
    text(a, width/2, height/2); //text, x座標, y座標
    // INGRESS
    textAlign(CENTER, TOP);
    textSize(65);
    text(b, width/2, height/2); //text, x座標, y座標
}
class LightParticle{
  final int MAX_PARTICLE      = 30; // パーティクルの個数
  Particle[] p                = new Particle[MAX_PARTICLE];
  final int LIGHT_FORCE_RATIO = 5;       // 輝き具体の抑制値
  final int LIGHT_DISTANCE    = 50 * 50; // 光が届く距離
  final int BORDER            = 50;      // 光の計算する矩形範囲（高速化のため）
  final float RED_ADD   = 0.0; // 赤色の加算値
  final float GREEN_ADD = 3.9; // 緑色の加算値
  final float BLUE_ADD  = 4.0; // 青色の加算値
  float    baseRed,    baseGreen,    baseBlue;  // 光の色
  float baseRedAdd, baseGreenAdd, baseBlueAdd;  // 光の色の加算量
  LightParticle() {    // パーティクルの初期化
    for (int i = 0; i < p.length; i++) {
      p[i] = new Particle();
    }
    // 光の色の初期化
    baseRed      = 0;
    baseGreen    = 0;
    baseBlue     = 0;
    baseRedAdd   = RED_ADD;
    baseGreenAdd = GREEN_ADD;
    baseBlueAdd  = BLUE_ADD;
  }
  void lighten() {
    background(100); //これをコメントアウトすると正しく機能しない
    // 光の色を変更
    baseRed   += baseRedAdd;
    baseGreen += baseGreenAdd;
    baseBlue  += baseBlueAdd;
    // 色が範囲外になった場合は、色の加算値を逆転させる
    colorOutCheck();
    // 各ピクセルの色の計算
    int tRed   = (int)baseRed;
    int tGreen = (int)baseGreen;
    int tBlue  = (int)baseBlue;
    // 綺麗に光を出すために二乗する
    tRed   *= tRed;
    tGreen *= tGreen;
    tBlue  *= tBlue;
    // 各パーティクルの周囲のピクセルの色について、加算を行う
    loadPixels();
    for (int pid = 0; pid < p.length; pid++) {
      // パーティクルの計算影響範囲
      int left   = max(     0, p[pid].x - BORDER);
      int right  = min( width, p[pid].x + BORDER);
      int top    = max(     0, p[pid].y - BORDER);
      int bottom = min(height, p[pid].y + BORDER);
      // パーティクルの影響範囲のピクセルについて、色の加算を行う
      for (int y = top; y < bottom; y++) {
        for (int x = left; x < right; x++) {
          int pixelIndex = x + y * width;
          // ピクセルから、赤・緑・青の要素を取りだす
          int r = pixels[pixelIndex] >> 16 & 0xFF;
          int g = pixels[pixelIndex] >>  8 & 0xFF;
          int b = pixels[pixelIndex]       & 0xFF;
          // パーティクルとピクセルとの距離を計算する
          int dx = x - p[pid].x;
          int dy = y - p[pid].y;
          int distance = (dx * dx) + (dy * dy);  // 三平方の定理だが、高速化のため、sqrt()はしない。
          // ピクセルとパーティクルの距離が一定以内であれば、色の加算を行う
          if (distance < LIGHT_DISTANCE) {
            int fixFistance = distance * LIGHT_FORCE_RATIO;
            // 0除算の回避
            if (fixFistance == 0) {
              fixFistance = 1;
            }   
            r = r + tRed   / fixFistance;
            g = g + tGreen / fixFistance;
            b = b + tBlue  / fixFistance;
          }
          // ピクセルの色を変更する
          pixels[x + y * width] = color(r, g, b);
        }
      }
      if(p[pid].y < 0) {
        p[pid].y = (int)random(height/2,height);
        p[pid].x = (int)random(width);
        p[pid].vy = (int)random(1,3);
      }else{
        p[pid].y -= p[pid].vy;    
      }
    }
    updatePixels();
  }
  // マウスクリック時に、各パーティクルをランダムな方向に飛ばす
  void mousePressed() {
    for (int pid = 0; pid < MAX_PARTICLE; pid++) {
      p[pid].explode();
    }
  }
  // 色の値が範囲外に変化した場合は符号を変える
  void colorOutCheck() {
    if (baseRed < 10) {
      baseRed     = 10;
      baseRedAdd *= -1;
    }
    else if (baseRed > 255) {
      baseRed     = 255;
      baseRedAdd *= -1;
    }
    if (baseGreen < 10) {
      baseGreen     = 10;
      baseGreenAdd *= -1;
    }
    else if (baseGreen > 255) {
      baseGreen     = 255;
      baseGreenAdd *= -1;
    }
    if (baseBlue < 10) {
      baseBlue     = 10;
      baseBlueAdd *= -1;
    }
    else if (baseBlue > 255) {
      baseBlue     = 255;
      baseBlueAdd *= -1;
    }
  }
  // Particle Class
  class Particle {
    int    x,  y;    // 位置
    float vx, vy;    // 速度(速度 = velocity, 速さ = speed)
    float slowLevel; // 座標追従遅延レベル
    final float DECEL_RATIO = 0.95;  // 減速率(減速 l= decelation)
    Particle() {
      x  = (int)random(width);
      y  = (int)random(height/2,height);
      vy = (int)random(1,3);
      slowLevel = random(100) + 5;
    }
    // 適当な方向に飛び散る
    void explode() {
      vx = random(100) - 50;
      vy = random(100) - 50;
      slowLevel = random(100) + 5;
    }
  }
}
//void mousePressed() {
//  loop(); // draw関数のループを再開させる
//}
 
//void mouseReleased() {
//  noLoop(); // draw関数のループを停止させる
//}