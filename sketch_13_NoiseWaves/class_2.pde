/*
  画面に十字パターンを表示する。
  
  以下意味なし
    1. translate
    1. 2つ以上の変数/配列による宣言・処理
  
  "o"キー押下で表示/非表示を切り替え

*/
class CrossPattern {
  float crossLength;
  color col;
  boolean flg=true;

  CrossPattern(float hue){
    crossLength=3;
    col=color(hue,0,25,25);
  }

  void display() {
    pushStyle();
      strokeWeight(1);
      stroke(col);
      if(flg==true){
        // 画面全体に描画
        for(int i=0; i<height; i+=40){
          for(int j=0; j<width; j+=40){
            // 十文字模様
            line(j,i,j+crossLength,i);
            line(j,i,j-crossLength,i);
            line(j,i,j,i+crossLength);
            line(j,i,j,i-crossLength);
          }
        }
      }
    popStyle();
  }

  void update(){
    if(keyPressed){
      // キー押下でフラグ反転=見えなくする
      flg=!flg;
      // 再表示となる場合は色を変える
      if(flg==true){
        col=color(random(360),0,25,25);
      }
    }
  }
}
