class Enemy {
  
  // variables
  int x;
  float y;
  
  int w;
  int h;
  
  color enemyColor;
  
  boolean isMovingRight;
  boolean shouldRemove = false;
  boolean forestEnemyIsDead = false;
  boolean lakeEnemyIsDead = false;
  boolean caveEnemyIsDead = false;
  
  int speed;
  
  float eTop;
  float eBottom;
  float eLeft;
  float eRight;
  
  //constructor
  Enemy (int startingX, int startingY, int startingW, int startingH) {
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;
    enemyColor = color (247, 205, 242);
    
    isMovingRight = true;
    
    speed = 2 ;
  }
  
  //functions
  void render () {
    fill(enemyColor);
    rect(x,y,w,h);
  }
  
  void move() {

    if (isMovingRight == true) {
      x += speed;
      
    }
      
  }
  
   void hitbox() {
    eTop = y - w/2;
    eBottom = y + w/2;
    eLeft = x - w/2;
    eRight = x + w/2;
  }
  
   void wallDetect() {
    //wall detection for right wall
    if (x + w >= width) {
        x = width-w;
    }
  }
  
  void collideWithPlayer (Player aPlayer) {
    if (eRight >= aPlayer.pLeft) {
      playerIsDead = true;
    }
    if (playerIsDead == true) {
      state = 4;
    }
    else {
    playerIsDead = false;
    }
  }
  
  void hitByBullet(ArrayList<Magic> magList){
    for (int i = 0; i < magList.size(); i++){
      Magic m = magList.get(i);
      if (m.mLeft < eRight && m.mRight > eLeft){
        magList.remove(i);
        shouldRemove = true;
      }
    }
  }
  
    
  }
  
