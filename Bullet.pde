class Bullet
{
  PVector pos;
  PVector dir;
  float speed;
  float deg;
  float rot;
  float radius;
  PImage bulletImg;
  float bWidth;
  float bHeight;
  int bulletType = 1;

  Bullet(PVector Position,float Degrees)
  {
    bulletType = BM.fireMode;
    radius = 2.5;
    pos = Position;
    speed = 6;
    deg = Degrees;
    bWidth = 30;
    bHeight = 15;
    if(bulletType == 1 || bulletType == 3)
      bulletImg = loadImage("SimpleShot.png");
    else if(bulletType == 2)
      bulletImg = loadImage("PulseWave.png");
  }
}
