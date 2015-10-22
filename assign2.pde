//You should implement your assign2 here.
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;

PImage Hp;
PImage Enemyship;
PImage Fightership;
PImage bg1;
PImage bg2;
PImage treasure;
PImage start1;
PImage start2;
PImage end1;
PImage end2;


int x, y, bx;
int randomP,HP_num;
int gameState;

float EnemyshipX,EnemyshipY;
float FightershipX,FightershipY;
float treasureX,treasureY;
float speed = 20;

void setup(){
  size(640,480);
  x = bx=0;
  y = 200;
  HP_num=20;
  randomP=floor(random(100));  
  start1= loadImage("img/start1.png");
  start2= loadImage("img/start2.png");
  end1= loadImage("img/end1.png");
  end2= loadImage("img/end2.png");
  Fightership= loadImage("img/fighter.png");
  Enemyship = loadImage("img/enemy.png");
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  treasure= loadImage("img/treasure.png");
  Hp = loadImage("img/hp.png");
  EnemyshipY=randomP*640/100;
  gameState = GAME_START;
  FightershipX=640-Fightership.width-10;
  FightershipY=480/2;  
}

void draw(){
  background(255);
  
  switch (gameState){
    case GAME_START:
    image(start1,0,0);
      if ((mouseX > 200 && mouseX < 460) && (mouseY > 375 && mouseY < 420)){
        if (mousePressed){
          // click
          gameState = GAME_RUN;
        }else{
          // hover
          noStroke();
          image(start2,0,0);        
        }
      }   
    break;
    
    case GAME_RUN:

      fill(255,0,0);
      image(bg1,((bx+640)%1280-640),0);
      image(bg2,bx%1280-640,0);
       EnemyshipX=x%(640+Enemyship.width-1)-Enemyship.width;
      // EnemyshipY=480*randomP/100;
       if (EnemyshipX==-61)
         EnemyshipY=floor(random(480));
   //    println(EnemyshipX);
      image(Enemyship,EnemyshipX,EnemyshipY);
      image(Fightership,FightershipX,FightershipY);
       treasureX=(640-treasure.width)*randomP/100;
       treasureY=(480-treasure.height)*randomP/100;
      image(treasure,treasureX,treasureY);
      colorMode(RGB);
      rect(5, 0, (Hp.width-10)*HP_num/100, Hp.height*0.7);
      fill(255,0,0);
      image(Hp,0,0);
      x+=5;
      bx++;
      
      if (((EnemyshipX+Enemyship.width>=FightershipX) && (EnemyshipX+Enemyship.width<=(FightershipX+Fightership.width))) || ((EnemyshipX>=FightershipX) && (EnemyshipX<=(FightershipX+Fightership.width))))
       if (((EnemyshipY+Enemyship.height>=FightershipY) && (EnemyshipY+Enemyship.height<=(FightershipY+Fightership.height))) || ((EnemyshipY>=FightershipY) && (EnemyshipY<=(FightershipY+Fightership.height))))
        {
          HP_num-=20;
          x=0;         
        }

      if (((treasureX+treasure.width>=FightershipX) && (treasureX+treasure.width<=(FightershipX+Fightership.width))) || ((treasureX>=FightershipX) && (treasureX<=(FightershipX+Fightership.width))))
       if (((treasureY+treasure.height>=FightershipY) && (treasureY+treasure.height<=(FightershipY+Fightership.height))) || ((treasureY>=FightershipY) && (treasureY<=(FightershipY+Fightership.height))))
        {
          HP_num+=10;
          if (HP_num>=100)
           HP_num=100;
           randomP=floor(random(100));
        }
       
       if (EnemyshipY>FightershipY)
         EnemyshipY-=2;
       else
         EnemyshipY+=2;
         
      if (HP_num<=0)
         gameState = GAME_LOSE;
      
    break;
     
    case GAME_LOSE:
    image(end1,0,0);
      if ((mouseX > 200 && mouseX < 436) && (mouseY > 305 && mouseY < 349)){
        if (mousePressed){
          // click
          EnemyshipY=randomP*640/100;
          gameState = GAME_START;
          FightershipX=640-Fightership.width-10;
          FightershipY=480/2;
          x=0;
          HP_num=100;
          gameState = GAME_RUN;
        }else{
          // hover
          noStroke();
          image(end2,0,0);        
        }
      }
    
    break;
  }
  
  
}


void keyPressed() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        FightershipY-=speed;
        if (FightershipY<=0)
         FightershipY=0;
        break;
      case DOWN:
        FightershipY += speed;
        if (FightershipY+Fightership.height>=480)
         FightershipY=480-Fightership.height;
        break;
      case LEFT:
        FightershipX -= speed;
        if (FightershipX<=0)
         FightershipX=0;        
        break;
      case RIGHT:
        FightershipX += speed;
        if (FightershipX+Fightership.width>=640)
         FightershipX=640-Fightership.width;

        break;
    }
  }
}
void keyReleased(){

}
