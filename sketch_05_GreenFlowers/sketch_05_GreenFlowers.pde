int num=10;
//第一引数は以下の通り
  //1 ... triangle
  //2 ... rect
  //3 ... ellipse
  //4 ... pentagon
GraphicsInOrbit[] gio_0=new GraphicsInOrbit[num]; //三角形
GraphicsInOrbit[] gio_1=new GraphicsInOrbit[num]; //四角形
GraphicsInOrbit[] gio_2=new GraphicsInOrbit[num];
//float t=easeInOutExpo(0.9);

void setup(){
  size(1000,1000,P2D);
  smooth();
  noStroke();
  //frameRate(120);
  //strokeWeight(5);
  //stroke(100);
  
  //colorMode(HSB,100);

  //_iが0, 1, 2のインスタンスを初期化する
  for(int i=0; i<num; i++){
    /*
      Constructor: GraphicsInOrbit(int _i, int _ang, float _rad, float _radOrbt, int _angOrbt)
        int     i; //図形種別
        float rad; //基準円の半径（この円に内接する三角形、正方形、五角形、円を描画する）
        float radOrbt; //図形の周回半径
        int   angOrbt; //図形の周回角度
    */
    gio_0[i]=new GraphicsInOrbit(0,int(random(90)),50,150,i*36);
    gio_1[i]=new GraphicsInOrbit(1,int(random(90)),50,250,i*36+13);
    gio_2[i]=new GraphicsInOrbit(2,int(random(90)),50,350,i*36+26);
  }
}

void draw(){
  background(255);
  line(0,height/2,width,height/2);
  line(width/2,0,width/2,height);
  //ellipse(width/2,height/2,600,600);
  
  translate(width/2,height/2);
    for(int i=0; i<num; i++){
      gio_0[i].display();
      gio_1[i].display();
      gio_2[i].display();

      gio_0[i].update();      
      gio_1[i].update();   
      gio_2[i].update();   

      if(gio_0[i].alpha<=0) gio_0[i]=new GraphicsInOrbit(0,int(random(90)),50,150,i*36);
      if(gio_1[i].alpha<=0) gio_1[i]=new GraphicsInOrbit(1,int(random(90)),50,250,i*36+13);
      if(gio_2[i].alpha<=0) gio_2[i]=new GraphicsInOrbit(2,int(random(90)),50,350,i*36+26);
    }
}
