/* COSC101 - Assesment 3
# Authors - Zach Thompson, Peter Chung and Bart Stolarek
#
# Description
# A modern clone of the old Asteroids Game
*/
import processing.sound.*;

Ship ship;
Asteroid_Manager AM;
Game_States GS;
Bullet_Manager BM;
Collision_Detection CD;
Highscores HS;
Animator Anim;
Power_Up PU;

boolean[] keyPress = new boolean[256];
int space = 32;
int level = 0;
int timer;
int lives = 3;
int score = 0;
int respawn_Timer = 90;
int invul_Timer = 60;
boolean alive = true;
boolean shoot = false;
boolean started = false;
boolean newRound = false;
boolean nameEntered = false;
boolean gotData = false;
boolean credits = false;
boolean highscoresConnected = false;
boolean enterKeyActive = false;
PImage background;
ArrayList<Bullet> spawnedBullets;
PFont font;
String playerName = "";
StringList Names = new StringList();
IntList Scores = new IntList();
SoundFile music;
SoundFile shootSound;


void setup() {
    size(1024, 640);
    frameRate(30);
    imageMode(CENTER);
    font = createFont("BlackHole BB", 70);
    textFont(font);
    background = loadImage("Background.jpg");
    AM = new Asteroid_Manager();
    AM.InitializeAsteroids(6);
    GS = new Game_States();
    BM = new Bullet_Manager();
    HS = new Highscores(this);
    CD = new Collision_Detection(this);
    PU = new Power_Up();
    Anim = new Animator();
    
    if(HS.HighscoreConnect())
    {
      highscoresConnected = true;
    }

    music = new SoundFile(this, "Preparing for War.mp3");
    shootSound = new SoundFile(this, "shoot.mp3");
    music.loop();
}
 
void draw() 
{
  background(0);
  image(background, width/2, height/2);
  if(!started)
  {
    started = GS.NewGame(AM);
    return;
  }
  else if( started && level == 0)
  { 
    level = 1;
    AM.InitializeAsteroids(level);
    ship = new Ship();
    ship.InitializeShip();
    PU.Spawn_Power_Up();
  }
  else
  {
    GS.InGame(lives, score);
  }
  
  if(lives == 0 && !credits)
  { 
    if(nameEntered && !gotData)
    {
      HS.UpdateHighscores(playerName, score);
      
      Names.clear();
      Scores.clear();
      Names = HS.GetNames();
      Scores = HS.GetScores();
      gotData = true;
    }
    nameEntered = GS.GameOver(playerName, nameEntered, Names, Scores);
    return;
  }
  
  if(credits)
  {
    GS.CreditScreen();
    return;
  }
  
  AM.UpdateAsteroids();
  spawnedBullets = BM.UpdateBullets();
  score += CD.Update_Missile_Collision(Anim);
  Anim.UpdateAnimations();
  CD.Update_Power_Up_Collision();
  PU.Update_Power_Up();
  
  if(AM.asteroids.size() == 0)
  {
    if(!newRound)
    {
      timer = millis();
      newRound = true;
    }
    else if(newRound && timer + 5000 > millis())
    {
      int duration = timer + 6000;
      duration = GS.NewRound(duration);
    }
    else if(newRound && timer + 5000 < millis())
    {
      level += 1;
      AM.InitializeAsteroids(level);
      ship.invunerable = true;
      newRound = false;
      if(level % 2 == 0)
        PU.spawned = true;
    }
  }
  
  if(alive == true)
  {
    ship.UpdateShip(keyPress);
  
    if(shoot == true) 
    {
      if(BM.fireMode == 1 || BM.fireMode == 2)
      {
        BM.shotFired(90);
        shoot = false;
      }
      else if(BM.fireMode == 3)
      {
        BM.shotFired(85);
        BM.shotFired(95);
        shoot = false;
      }
    }
    CD.Update_Ship_Collision();
  }
  else if(alive == false && lives > 0 && respawn_Timer > 0)
  {
    respawn_Timer--;
  }
  else if(alive == false && lives > 0 && respawn_Timer == 0)
  {
    respawn_Timer = 90;
    alive = true;
    ship.invunerable = true;
  }

  if(ship.invunerable && invul_Timer > 0)
  {
    invul_Timer--;
  }
  else
  {
    ship.invunerable = false;
    invul_Timer = 60;
  }

}
 
void keyPressed() 
{
  keyPress[keyCode] = true;
  if(lives == 0)
  {
    if(playerName.length() < 10 && key != CODED && key != ENTER 
        && key != TAB && key != ' ')
    {
    playerName += key;
    }
    if(key == DELETE | key == BACKSPACE)
    {
      playerName = "";
    }
  }
}
 
void keyReleased() 
{
   keyPress[keyCode] = false;
   if(key == ' ' && alive == true)
   {
      shoot = true;
      if(!newRound)
      {
        shootSound.play();
      }
      
   }
   if(key == ENTER)
   {
     enterKeyActive = false;
   }
}
