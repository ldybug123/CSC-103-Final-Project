class Player {

  // variables

  int x;
  float y;
  
  int w;
  int h;
  
  color playerColor;
  
  boolean isMovingLeft;
  boolean isMovingRight;
  
  int speed;
  
  float pTop;
  float pBottom;
  float pLeft;
  float pRight;
  
  //constructor
  Player (int startingX, int startingY, int startingW, int startingH) {
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;
    
    isMovingLeft = false;
    isMovingRight = false;
    
    speed = 8;
  }
  
  //functions
  void render () {
    fill(playerColor);
    rect(x,y,w,h);
  }
  
  void move() {
    if (isMovingLeft == true) {
      x -= speed; 
    }
    if (isMovingRight == true) {
      x += speed;
    }
  }
  
  void hitbox() {
    pTop = y - w/2;
    pBottom = y + w/2;
    pLeft = x - w/2;
    pRight = x + w/2;
  }
  
  void wallDetect() {
    //wall detection for right wall
    if (x + w >= width) {
        x = width-w;
    }
  }
  
}
