float rad=1000;
int ang=0;

void setup(){
  size(1000,1000,P2D);
  strokeWeight(2);
  stroke(100);
}
void draw(){
  //background(255);
  //格子線
  for(int i=0; i<width; i+=50){
    line(i,0,i,height);
  }
  for (int j=0; j<height; j+=50){
    line(0,j,width,j);
  }
  
  //描画
  pushMatrix();
    translate(width/2,height/2);
      display();
      println(ang);
      ang++;
  popMatrix();
  
  //十字線
  line(0,height/2,width,height/2);
  line(width/2,0,width/2,height);
  noFill();
  ellipse(width/2,height/2,1000,1000);
}

void display(){
  float _a=rad/sqrt(2.0);
  rectMode(CENTER); //rect(中心のx座標, 中心のy座標, 幅の半分, 高さの半分)
  pushMatrix();
    rotate(radians(ang));
    rect(0,0,_a,_a);
  popMatrix();
}
