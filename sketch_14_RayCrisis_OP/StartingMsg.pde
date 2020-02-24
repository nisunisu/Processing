class StartingMsg{
  PFont font;
  char[] arrChar={'S','T','A','R','T'};
  int num=arrChar.length;
  PVector[] current =new PVector[num];
  PVector[] target  =new PVector[num];
  PVector[] velocity=new PVector[num];
  float[]   pHeading=new   float[num];
  float[]   cHeading=new   float[num];
  int loopCnt=0;
  int maxLoopCnt=2;   // 2回ループして3回めに文字が中央へ移動する
  boolean isRun=true; // falseになるとこのclassの処理を終了する
  int rate=30;        // setup()で指定しているframeRateと同じ値を指定する

  StartingMsg(){
    font=loadFont("Constantia-Italic-48.vlw");
    textFont(font,80);
    textAlign(CENTER,CENTER);

    for(int i=0; i<num; i++){
      current[i] =new PVector(random(width),random(height));
      target[i]  =new PVector(random(width),random(height));
      velocity[i]=PVector.sub(target[i],current[i]);
      velocity[i].div(rate); // 1secでtargetに到達できるようにする
      
      // sub(target,current)の角度を算出しておく
      PVector curVector=PVector.sub(target[i],current[i]);
      cHeading[i]=curVector.heading();
      pHeading[i]=0;
    }
  }
  
  
  // --------------------------------------------------
  int fnMain(int phase){
    // 概要   ：ランダムな位置に「START」の5文字を表示させる
    //          表示された文字は2回移動し、その後横一列に並ぶ
    //          その後、文字は点滅して消える
    // 処理1  ：moveChars() ... 
    // 処理2  ：updateectors() ... ベクター座標にvelocityを追加する
    // 外部pde：なし（技術力がないので現在はEasing出来ない）
    // 備考   ：なし
    // 戻値   ：int phase
    if(isRun==true){
      moveChars();
      updateVectors();
    }
    println(frameCount+" : "+loopCnt);
    // phase=incrementPhase(phase); // Globalで使っているphaseをインクリメントし、このクラスのfnMainが使われないようにする
    return phase;
  }
  // --------------------------------------------------
  void moveChars(){
    for(int i=0; i<num; i++){
      text(arrChar[i],current[i].x,current[i].y);
    }
  }
  void updateVectors(){
    // ループカウンタ制御用
    boolean isNext=false;

    // 方向が変わっていない(=pHeadingとcHeadingが同一）の場合のみVectorをupdate
    for(int i=0; i<num; i++){
      // pHとcHが数frameでずれてしまう(ドットのレベルで移動するため)ことを防ぐためfloorを使う
      PVector curTmp;
      curTmp=PVector.sub(target[i],current[i]);
      pHeading[i]=floor(curTmp.heading());      // heading：旧
        current[i].add(velocity[i]);            // currentをupdate
      curTmp=PVector.sub(target[i],current[i]);
      cHeading[i]=floor(curTmp.heading());      // heading：新
      
      // ベクターの角度のうち一つでもが逆転しているものがあればisNextをtrueにする
      if(pHeading[i] != cHeading[i]){
        isNext=true;
      }
    }
    // 条件を満たす場合にloopCntをインクリメント
    if(isNext==true){
      loopCnt++;
      if(loopCnt<maxLoopCnt){
        initializeAgain();
      }else if(loopCnt==maxLoopCnt){
        initForSetCenter();
      }else{
        isRun=false; // 処理を終了する
      }
    }
  }
  void initializeAgain(){
    // 再度、ランダムな位置を次のtargetにする
    for(int i=0; i<num; i++){
      target[i]  =new PVector(random(width),random(height));
      velocity[i]=PVector.sub(target[i],current[i]);
      velocity[i].div(rate);
    }
  }
  void initForSetCenter(){
    // 画面中央を次のtargetにする
    for(int i=0; i<num; i++){
      float xPos=(i+1) * width/(num+1);
      target[i]  =new PVector(xPos,height/2);
      velocity[i]=PVector.sub(target[i],current[i]);
      velocity[i].div(rate);
    }
  }
}
