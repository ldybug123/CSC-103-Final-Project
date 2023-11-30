import processing.sound.*;

//declaring vars
Player p1;
Enemy e1;
Enemy e2;
Enemy e3;
Enemy e4;
Enemy e5;
Enemy e6;
Mushroom m1;
Mushroom m2;
Mushroom m3;

int state = 0;

float mushRight;

float eRight;
int aPlayer;

float mLeft;

int aEnemy;

PImage witchStillImg;
PImage witchleft0;
PImage witchleft1;
PImage witchleft2;
PImage redMushroomImg;
PImage blueMushroomImg;
PImage purpleMushroomImg;
PImage wolfImg;
PImage witchHutImg;
PImage forestImg;
PImage lakeImg;
PImage frogImg;
PImage caveImg;
PImage spiderImg;
PImage mushroomsImg;

Animation witchLeftAnimation;
PImage[] witchLeftImages = new PImage[3];

SoundFile magic;
SoundFile bgMusic;

ArrayList<Magic> magicList;

boolean playerIsDead = false;
boolean forestEnemyIsDead = false;
boolean lakeEnemyIsDead = false;
boolean caveEnemyIsDead = false;
boolean forestMushCollected = false;
boolean lakeMushCollected = false;

void setup () {
  size (1000, 600);

  //rectMode(CENTER);
  //imageMode(CENTER);
  textAlign(CENTER);

  //initialize vars


  p1 = new Player(840, height-165, 50, 50);
  e1 = new Enemy(10, height-100, 50, 50);
  e2 = new Enemy (150, height-100, 50, 50);
  e3 = new Enemy (20, height-100, 50, 50);
  e4 = new Enemy (300, height-100, 50, 50);
  e5 = new Enemy (150, height-100, 50, 50);
  e6 = new Enemy (10, height-100, 50, 50);
  m1 = new Mushroom(20, height-120, 20, 20, 0);
  m2 = new Mushroom(20, height-120, 20, 20, 1);
  m3 = new Mushroom(20, height-120, 20, 20, 2);

  magicList = new ArrayList<Magic>();

  magic = new SoundFile (this, "magicSound.wav");
  bgMusic = new SoundFile (this, "Daily (Prod. by Lukrembo).wav");

  witchStillImg = loadImage("witchstill.png");
  witchleft0 = loadImage("witchleft0.png");
  witchleft1 = loadImage("witchleft1.png");
  witchleft2 = loadImage("witchleft2.png");
  witchStillImg.resize(witchStillImg.width, witchStillImg.height);
  witchleft0.resize(witchleft0.width/1, witchleft0.height/1);
  witchleft1.resize(witchleft1.width/1, witchleft1.height/1);
  witchleft2.resize(witchleft2.width/1, witchleft2.height/1);
  redMushroomImg = loadImage("redMushroom.png");
  redMushroomImg.resize(redMushroomImg.width/1, redMushroomImg.height/1);
  wolfImg = loadImage("wolf.png");
  wolfImg.resize(wolfImg.width, wolfImg.height);
  witchHutImg = loadImage("witchHut.png");
  forestImg = loadImage("forest.png");
  lakeImg = loadImage("lake.png");
  frogImg = loadImage("frog.png");
  frogImg.resize(frogImg.width/1, frogImg.height/1);
  blueMushroomImg = loadImage("blueMushroom.png");
  blueMushroomImg.resize(blueMushroomImg.width/1, blueMushroomImg.height/1);
  caveImg = loadImage("cave.png");
  spiderImg = loadImage("spider.png");
  spiderImg.resize(spiderImg.width/1, spiderImg.height/1);
  purpleMushroomImg = loadImage("purpleMushroom.png");
  purpleMushroomImg.resize(purpleMushroomImg.width/1, purpleMushroomImg.height/1);
  mushroomsImg = loadImage("mushrooms.png");

  for (int index=0; index < 3; index++) {
    witchLeftImages[index] = loadImage("witchleft" + index + ".png");
  }

  witchLeftAnimation = new Animation(witchLeftImages, .05, 1);
}

void draw () {
  //background (211, 236, 255);

  witchLeftAnimation.display(p1.x, p1.y);

  //states
  switch(state) {
    //first case
  case 0:
    background(mushroomsImg);
    textSize(100);
    fill(255);
    text("MUSHROOM QUEST!", width/2, height/3);
    textSize(70);
    fill(255);
    text("Left Click To Start", width/2, height/2);

    textSize(50);
    text("Press 's' To See Synopsis", width/2, height/1.5);
    text("Press 'c' To See Controls", width/2, height/1.2);
    if (bgMusic.isPlaying() == false) {
      bgMusic.play();
    }
    break;
    //second case
  case 1:
    background(mushroomsImg);
    textSize(70);
    fill(255);
    text("Press 'a' To Move", width/2, height/3);
    text("Press 'spacebar' To Shoot Magic", width/2, height/2);
    text("Press 'r' To Return To Start Screen", width/2, height/1.5);
    break;

    //third case
  case 2:
    background (witchHutImg);
    //image (witchStillImg, p1.x, p1.y);
    witchLeftAnimation.display(p1.x, p1.y);
    //player functions
    p1.move();
    p1.hitbox();
    p1.wallDetect();

    if (p1.x < 0) {
      state = 3;
      p1.x = 1000;
    }
    break;

    //fourth case
  case 3:
    background (forestImg);
    witchLeftAnimation.display(p1.x, p1.y);



    collideWithPlayer = false;

    //for loop that goes through all magic
    for (Magic aMagic : magicList) {
      aMagic.render();
      aMagic.move();
      aMagic.hitbox();
      aMagic.checkRemove();
    }

    //for loop that removes unwanted magic
    for (int i = magicList.size()-1; i >= 0; i = i-1) {
      Magic aMagic = magicList.get(i);

      if (aMagic.shouldRemove == true) {
        magicList.remove(aMagic);
      }
    }

    //player functions
    p1.move();
    p1.hitbox();
    p1.wallDetect();

    //enemy functions
    if (!e1.shouldRemove) {
      image (wolfImg, e1.x, e1.y);
      e1.move();
      e1.hitbox();
      e1.wallDetect();
      e1.collideWithPlayer(p1);
      e1.hitByBullet(magicList);
    }



    if (collideWithPlayer == true) {
      state = 2;
    }

    if (e1.shouldRemove == true) {
      state = 5;
    }

    break;

    //fifth case
  case 4:
    background (229, 130, 148);
    textSize(80);
    fill(255);
    text("Sorry, You Were Defeated!", width/2, height/3);
    text("Press 'r' To Return To Start", width/2, height/2);
    break;

    //sixth case
  case 5:
    background (forestImg);
    witchLeftAnimation.display(p1.x, p1.y);

    image (redMushroomImg, m1.x, m1.y);

    collideWithPlayer = false;


    //for loop that goes through all magic
    for (Magic aMagic : magicList) {
      aMagic.render();
      aMagic.move();
      aMagic.hitbox();
      //aMagic.collideWithForestEnemy(e1);
      aMagic.checkRemove();
    }

    //for loop that removes unwanted magic
    for (int i = magicList.size()-1; i >= 0; i = i-1) {
      Magic aMagic = magicList.get(i);

      if (aMagic.shouldRemove == true) {
        magicList.remove(aMagic);
      }
    }

    //player functions
    p1.move();
    p1.hitbox();
    p1.wallDetect();

    //mushroom functions
    //m1.render();
    m1.hitbox();
    m1.collideWithPlayer(p1);

    if (forestMushCollected == true) {
      state = 6;
    }

    break;

    //seventh case
  case 6:
    background (forestImg);
    witchLeftAnimation.display(p1.x, p1.y);
    collideWithPlayer = false;
    p1.move();
    p1.hitbox();
    p1.wallDetect();
    textSize (80);
    text ("Mushroom Collected!", width/2, height/6);

    if (p1.x < 0) {
      state = 7;
      p1.x = 1000;
    }

    break;


    //eigth case
  case 7:
    background (lakeImg);
    witchLeftAnimation.display(p1.x, p1.y);




    collideWithPlayer = false;

    //for loop that goes through all magic
    for (Magic aMagic : magicList) {
      aMagic.render();
      aMagic.move();
      aMagic.hitbox();
      //aMagic.collideWithLakeEnemy(e2);
      //aMagic.collideWithLakeEnemy(e3);
      aMagic.checkRemove();
    }

    //for loop that removes unwanted magic
    for (int i = magicList.size()-1; i >= 0; i = i-1) {
      Magic aMagic = magicList.get(i);

      if (aMagic.shouldRemove == true) {
        magicList.remove(aMagic);
      }
    }

    //player functions
    p1.move();
    p1.hitbox();
    p1.wallDetect();

    //enemy functions
    if (!e2.shouldRemove) {
      image (frogImg, e2.x, e2.y);
      e2.move();
      e2.hitbox();
      e2.wallDetect();
      e2.collideWithPlayer(p1);
      e2.hitByBullet(magicList);
    }
    if (!e3.shouldRemove) {
      image (frogImg, e3.x, e3.y);
      e3.move();
      e3.hitbox();
      e3.wallDetect();
      e3.collideWithPlayer(p1);
      e3.hitByBullet(magicList);
    }


    if (collideWithPlayer == true) {
      state = 2;
    }

    if (e2.shouldRemove == true && e3.shouldRemove == true) {
      state = 8;
    }

    break;

    //ninth case
  case 8:
    background (lakeImg);
    witchLeftAnimation.display(p1.x, p1.y);

    image (blueMushroomImg, m2.x, m2.y);

    collideWithPlayer = false;
    p1.move();
    p1.hitbox();
    p1.wallDetect();
    m2.hitbox();
    m2.collideWithPlayer(p1);

    //for loop that goes through all magic
    for (Magic aMagic : magicList) {
      aMagic.render();
      aMagic.move();
      aMagic.hitbox();
      aMagic.collideWithLakeEnemy(e2);
      aMagic.checkRemove();
    }

    //for loop that removes unwanted magic
    for (int i = magicList.size()-1; i >= 0; i = i-1) {
      Magic aMagic = magicList.get(i);

      if (aMagic.shouldRemove == true) {
        magicList.remove(aMagic);
      }
    }

    if (lakeMushCollected == true) {
      state = 9;
    }

    break;

  case 9:
    background(lakeImg);
    witchLeftAnimation.display(p1.x, p1.y);
    collideWithPlayer = false;
    p1.move();
    p1.hitbox();
    p1.wallDetect();
    textSize(80);
    fill(101, 117, 201);
    text("Mushroom Collected!", width/2, height/6);

    if (p1.x < 0) {
      state = 10;
      p1.x = 1000;
    }

    break;


    //tenth case
  case 10:
    background(caveImg);
    witchLeftAnimation.display(p1.x, p1.y);
    p1.move();
    p1.hitbox();
    p1.wallDetect();

   if (!e4.shouldRemove) {
      image (spiderImg, e4.x, e4.y);
      e4.move();
      e4.hitbox();
      e4.wallDetect();
      e4.collideWithPlayer(p1);
      e4.hitByBullet(magicList);
    }
  
  if (!e5.shouldRemove) {
      image (spiderImg, e5.x, e5.y);
      e5.move();
      e5.hitbox();
      e5.wallDetect();
      e5.collideWithPlayer(p1);
      e5.hitByBullet(magicList);
    }
  
   if (!e6.shouldRemove) {
      image (spiderImg, e6.x, e6.y);
      e6.move();
      e6.hitbox();
      e6.wallDetect();
      e6.collideWithPlayer(p1);
      e6.hitByBullet(magicList);
    }

    collideWithPlayer = false;

    //for loop that goes through all magic
    for (Magic aMagic : magicList) {
      aMagic.render();
      aMagic.move();
      aMagic.hitbox();
      aMagic.collideWithCaveEnemy(e3);
      aMagic.checkRemove();
    }

    //for loop that removes unwanted magic
    for (int i = magicList.size()-1; i >= 0; i = i-1) {
      Magic aMagic = magicList.get(i);

      if (aMagic.shouldRemove == true) {
        magicList.remove(aMagic);
      }
    }

    if (collideWithPlayer == true) {
      state = 2;
    }

   if (e4.shouldRemove == true && e5.shouldRemove == true && e6.shouldRemove == true) {
      state = 11;
    }


    break;

    //eleventh case
  case 11:
    background(caveImg);
    witchLeftAnimation.display(p1.x, p1.y);

    image (purpleMushroomImg, m3.x, m3.y);

    p1.move();
    p1.hitbox();
    p1.wallDetect();
    m3.hitbox();
    m3.collideWithPlayer(p1);

    break;

  case 12:
    background(caveImg);
    witchLeftAnimation.display(p1.x, p1.y);
    collideWithPlayer = false;
    p1.move();
    p1.hitbox();
    p1.wallDetect();
    textSize(80);
    fill(255);
    text("Mushroom Collected!", width/2, height/6);

    textSize(60);
    text ("Press 'h' To Return To Your Hut", width/2, height/3);

    break;
    //twelfth case
  case 13:
    background (witchHutImg);
    image (witchStillImg, p1.x, p1.y);
    textSize (50);
    text ("Congratulations! You Win!", width/2, height/5);
    text ("Press 'r' To Return To Start Screen.", width/2, height/3);
    break;

  case 14:
    background(mushroomsImg);
    textSize(24);
    fill(255);

    text("You play as a witch who specializes in studying mushrooms and their effects in potions you make.", width/2, height/6);
    text("After years of work, your mushroom collection is nearly complete.", width/2, height/4.5);
    text("Your goal is to collect these mushrooms to complete your collection,", width/2, height/3.6);
    text("each of which can be found in a different location.", width/2, height/3);
    text("However, there will be danger involved in your journey to these locations", width/2, height/2.6);
    text("in the form of different enemies.", width/2, height/2.3);
    text("To win, you must successfully collect all three mushrooms", width/2, height/2);
    text("from each location and return to your hut.", width/2, height/1.8);

    textSize(50);
    text("Press 'r' To Return To Start Screen.", width/2, height/1.2);

    break;
  }
}


void mousePressed () {
  state = 2;
}

void keyPressed () {
  if (key == 'a') {
    p1.isMovingLeft = true;
    witchLeftAnimation.isAnimating = true;
  }
  if (key == ' ') {
    magicList.add(new Magic(p1.x, p1.w*10.5));
    magic.play();
  }
  if (key == 'r') {
    state = 0;
    p1 = new Player(840, height-165, 50, 50);
    collideWithPlayer = false;
    playerIsDead = false;
    e1 = new Enemy(60, height-100, 50, 50);
  }
  if (key == 'c') {
    state = 1;
  }

  if (key == 's') {
    state = 14;
  }

  if (key == 'h') {
    state = 13;
    p1.x = 550;
  }
}

void keyReleased () {
  if (key == 'a') {
    p1.isMovingLeft = false;
    witchLeftAnimation.isAnimating = false;
  }
}

boolean collideWithPlayer;
{
  if (playerIsDead == true) {
    state = 4;
  }
}
