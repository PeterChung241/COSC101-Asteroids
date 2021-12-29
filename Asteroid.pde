// the asteroid base class.
//the class that holds the data for each asteroid.
// one of these will be created for each asteroid
// and will hold unique data.

class Asteroid
{
  //CONSTANTS
  int IMGQTY = 9;
  
  //Variables.
  PVector pos;
  PVector dir;
  PImage[] asteroidImgs = new PImage[IMGQTY];
  PImage currentImg;
  float collisionRadius;
  float asteroidCentre;
  float speed;
  int size;
  int maxSize;
  float radius;
  int i;
  
  //Asteroid Constructor
  //Sets up the initial variables when creating a new
  //Asteroid class.
  Asteroid(PVector Position, PVector Direction, int Size)
  {
    // set asteroid characteristics.
    pos = Position;
    dir = Direction;
    size = Size;
    speed = random(2,5);
    //load the asteroid images
    for(i = 0; i < asteroidImgs.length; i++)
    {
      asteroidImgs[i] = loadImage("Asteroid_" + i + ".png");
    }
    
    //sets the image to use based on the inputed "size" varable.
    currentImg = asteroidImgs[size];
    
    // depending on the size, set the maxSize of the
    // asteroid to be spawned when this one dies.
    // TODO: possible change name of maxSize, could be a bit confusing.
    if(size <= 2)
    {
      maxSize = 3;
    }
    else if(size > 2 && size <= 5)
    {
      maxSize = 6;
    }
    else
    {
      maxSize = 7;
    }
    
    if(size < 3)
      radius = 28.0; //32
    else if(size >=3 && size < 6)
      radius = 20.0; //24
    else
      radius = 16.0; // 18
    
  }
}
