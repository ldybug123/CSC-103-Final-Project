class Magic {
  
  //variables
  int x;
  float y;
  int d;
  int speed;
  
  color magicColor;
  
  boolean shouldRemove;
  
  float mTop;
  float mBottom;
  float mLeft;
  float mRight;
  
  //constructor
  Magic(int startingX, float startingY) {
    x = startingX;
    y = startingY;
    magicColor = color (250, 234, 179);
    
    d = 8;
    
    speed = 10;
    
    shouldRemove = false;
  }
  
  void render () {
    fill (magicColor);
    circle (x, y, d);
  }
  
  void move () {
    x -= speed;
  }
  
  void checkRemove() {
    if (x < 0){
      shouldRemove = true;
    }
  }
  
  void hitbox() {
    mTop = y - d/2;
    mBottom = y + d/2;
    mLeft = x - d/2;
    mRight = x + d/2;
  }
  
  void collideWithForestEnemy(Enemy aEnemy) {
    if (mLeft <= aEnemy.eRight) {
      forestEnemyIsDead = true;
      this.shouldRemove = true;
    }
    
    else{
    forestEnemyIsDead = false;
    }
    
  }
  
  void collideWithLakeEnemy(Enemy aEnemy) {
    if (mLeft <= aEnemy.eRight) {
      forestEnemyIsDead = true;
      lakeEnemyIsDead = true;
      this.shouldRemove = true;
    }
    
    else{
     lakeEnemyIsDead = false; 
    }
  }
    void collideWithCaveEnemy(Enemy aEnemy) {
    if (mLeft <= aEnemy.eRight) {
      forestEnemyIsDead = true;
      lakeEnemyIsDead = true;
      caveEnemyIsDead = true;
      this.shouldRemove = true;
    }
    
    else{
     caveEnemyIsDead = false; 
    }
    
  }
  
 
    
  }
 
