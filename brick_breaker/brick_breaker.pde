int xPlayerPos;
int yPlayerPos;
int playerHeight;
int playerWidth;
int ballSize;
int xBallPos;
int yBallPos;
int xBallVel;
int yBallVel;
int xBallDir;
int yBallDir;
int brickWidth;
int brickHeight;
int playerLives;
int padding;
boolean ballHitRdy; //to prevent getting ball stuck in paddle
boolean gameOver;


class Brick{
  Brick(int positionX, int positionY, int health){
    posX = positionX;
    posY = positionY;
    hp = health;
    brickWidth = 75;
    brickHeight = 25;
    if(hp == 1){
      c = #E6A7E7;
    }
    else if(hp == 2){
      c = #C18DC9;
    }
    else{
      c = #986889;
    }
  }
  int hp;
  int posX;
  int posY;
  int brickWidth;
  int brickHeight;
  color c;
  void changePosX(int newPos){
    posX = newPos;
  }
  void changePosY(int newPos){
    posY = newPos;
  }
  void changeHP(int newHP){
    hp = newHP;
  }
  void update(){
    if(hp == 1){
      c = #E6A7E7;
      makeBrick();
    }
    else if(hp == 2){
      c = #C18DC9;
      makeBrick();
    }
    else if(hp == 3){
      c = #986889;
      makeBrick();
    }
    else{
      //destruction animation?
    }
  }
  void makeBrick(){
    fill(c);
    rect(posX, posY, brickWidth, brickHeight);
  }
  void dmg(){
    hp--;
  }
}

Brick[] bricks;
PFont f;

void initializeBricks(){ //fix this
  int brickHP = 3; //counts down
  int spacing = 25;
  int startX = 0;
  int startY = 10;
  int positionY = startY;
  int levels = 3;
  int brickIterator = 0;
  for (int yMultiplier = 1; yMultiplier <= levels; yMultiplier++){
    for(int xPosition = startX; xPosition < width; xPosition += spacing + 75){ //75 is brick width - make that cleaner later
      //bricks[brickIterator].changePosX(xPosition);
      //bricks[brickIterator].changePosY(startY * yMultiplier);
      //bricks[brickIterator].changeHP(brickHP);
      //bricks[brickIterator].makeBrick();
      bricks[brickIterator] = new Brick(xPosition, positionY, brickHP);
      brickIterator++;
    }
    brickHP--;
    if (startX == 0){
      startX = 25;
    }
    else{
      startX = 0;
    }
    positionY = positionY + bricks[0].brickHeight + 10;
  }
}

void updateBricks(){
  for(int i = 0; i < bricks.length; i++){
    bricks[i].update();
  }
}

void detectBrickCollision(){
  
}

void updateLifeStat(){
  int posX = 10;
  int posY = height - 10;
  int size = 5;
  for(int i = 0; i < playerLives; i++){
    ellipse(posX, posY, size, size);
    posX += 15;
  }
}

void setup(){
  size(800,600);
  background(255,255,255);
  f = createFont("Arial",16,true);
  gameOver = false;
  padding = 20;
  playerLives = 3;
  playerWidth = 100;
  playerHeight = 15;
  xPlayerPos = width/2 - playerWidth/2;
  yPlayerPos = height - playerHeight - padding;
  ballSize = 15;
  xBallPos = width/2;
  yBallPos = height/2;
  xBallVel = 2;
  yBallVel = 2;
  xBallDir = 1;
  yBallDir = 1;
  ellipse(xBallPos, yBallPos, ballSize, ballSize);
  rect(xPlayerPos, yPlayerPos, playerWidth, playerHeight);
  bricks = new Brick[24];
  initializeBricks();
  ballHitRdy = true;
}

void draw(){
  background(255,255,255);
  fill(255,255,255);
  ellipse(xBallPos, yBallPos, ballSize, ballSize);
  rect(xPlayerPos - playerWidth/2, yPlayerPos, playerWidth, playerHeight);
  
  if(gameOver){
    println("gameover");
    textFont(f);
    fill(0);
    textAlign(CENTER);
    text("Game Over", width/2, height/2);
  }
  
  if(xBallPos >= width - ballSize/2 || xBallPos <= 0 + ballSize/2){
    xBallDir = xBallDir * -1;
    xBallVel = xBallVel * xBallDir;
    ballHitRdy = true;
  }
  if(yBallPos <= 0 + ballSize/2){
    yBallDir = yBallDir * -1;
    yBallVel = yBallVel * yBallDir;
    ballHitRdy = true;
  }
  else if(yBallPos > height){
    playerLives--;
    if(playerLives > 0){
      xBallPos = width/2;
      yBallPos = height/2;
    }
    else{
      gameOver = true;
    }
  }
  
  //tests for collision with paddle and changes y direction of ball
  if(xBallPos > xPlayerPos - playerWidth/2 && xBallPos < xPlayerPos + playerWidth/2 && yBallPos >= yPlayerPos && yBallPos < yPlayerPos + playerHeight && ballHitRdy){
    yBallDir *= -1;
    yBallVel *= yBallDir;
    ballHitRdy = false;
    //println("success");
  }
  
  /* //for testing
  println("ball:");
  println(xBallPos);
  println("player:");
  println(xPlayerPos - playerWidth/2);
  */
  xBallPos=xBallPos+xBallVel;
  yBallPos=yBallPos+yBallVel;
  
  /*
  //ball drop?
  if (xBallPos>=width || xBallPos<=0){
     xBallDir=-xBallDir; // now my direction is -1, moving to the left
     xBallVel=xBallVel*xBallDir; // makes xVelocity negative
   }
   
   if(yBallPos>=height || yBallPos<=0){
     
     yBallDir=-yBallDir;
     yBallVel=yBallVel*yBallDir;
   }
   */
   
   //bricks
   updateBricks();
   //if(yBallPos < 
   
   updateLifeStat();
}

void mouseMoved(){
  //background(255,255,255);
  if(mouseX > playerWidth/2 && mouseX < width - playerWidth/2){
    xPlayerPos = mouseX;
  }
  else if(mouseX < playerWidth/2){
    xPlayerPos = playerWidth/2;
  }
  else{
    xPlayerPos = width - playerWidth/2 - 1;
  }
}