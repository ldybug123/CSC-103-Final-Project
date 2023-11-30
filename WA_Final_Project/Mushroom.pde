class Mushroom {
  //variables
  int x;
  float y;
  
  int w;
  int h;
  
  int mushroomNumber;
  
  color mushroomColor;
  
  float mushTop;
  float mushBottom;
  float mushLeft;
  float forestMushRight;
  float lakeMushRight;
  float caveMushRight;
  
  boolean forestMushCollected = false;
  boolean lakeMushCollected = false;
  boolean caveMushCollected = false;


//constructor
Mushroom (int startingX, int startingY, int startingW, int startingH, int aMushroomNumber) {
  x = startingX;
  y = startingY;
  w = startingW;
  h = startingH;
  mushroomNumber = aMushroomNumber;
  mushroomColor = color(185, 60, 85);
  
  }
  
  void render() {
    fill(mushroomColor);
    rect(x,y,w,h);
  }
  
  void hitbox () {
    mushTop = y - w/2;
    mushBottom = y + w/2;
    mushLeft = x - w/2;
    forestMushRight = x + w/2;
    lakeMushRight = x + w/2;
    caveMushRight = x + w/2;
  }
  
  void collideWithPlayer (Player aPlayer) {
    if (mushroomNumber == 0 && forestMushRight >= aPlayer.pLeft) {
      textSize(80);
      fill(255);
      forestMushCollected = true;
      
      state = 6;
    } 
    
   if (mushroomNumber == 1 && lakeMushRight >= aPlayer.pLeft) {
      textSize(80);
      fill(255);
      lakeMushCollected = true;
      
      state = 9;
      background (lakeImg);
    }
   
   if (mushroomNumber == 2 && caveMushRight >= aPlayer.pLeft) {
      textSize(80);
      fill(255);
      caveMushCollected = true;
      
      state = 12;
      background (caveImg);
    }
    
}

}
