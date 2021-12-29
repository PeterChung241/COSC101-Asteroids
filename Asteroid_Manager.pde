// Manages asteroid swarms
// responsible for creating, updating and destroying asteroids.

class Asteroid_Manager
{
  //constants
  float ASTEROIDSIZE = 8.99;
  int SMALLESTASTEROIDINDEX = 6;
  //Variables.
  ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
  int asteroidMultiplier = 3;
  int i;
  
  
  //initializes an asteroid field base on level.
  void InitializeAsteroids(int Level)
  {
    // random algorithim i came up with to increase the amount
    // of spawned asteroids when a new level starts.
    int asteroidQuantity = (Level + asteroidMultiplier) * asteroidMultiplier;
    //make sure the array is clear prior to creating a new asteroid field.
    asteroids.clear();
    
    //loop and create a new asteroid every iteration.
    for(i = 0; i < asteroidQuantity; i++)
    {
      //create some random variables for the asteroids.
      PVector tempPos = new PVector(random(0, width), random(0, height));

      //Clear area around ship when level starts.  Might need to be tweeked if 
      //too many astroids spawn towards left and bottom of screen, but doesn't seem
      //be a problem so far.
      if (tempPos.x > 312 && tempPos.x < 712)
        tempPos.x += 200;
      if (tempPos.y > 180 && tempPos.y < 560)
        tempPos.y += 300;
      
      PVector tempDir = new PVector(random(-1, 1), random(-1,1));
      //cast to an int, max number is 8.99 so we only get whole numbers
      //from 0 too 8
      int tempSize = (int)random(0, ASTEROIDSIZE);
      //create the new asteroid and store it in a tempAsteroid variable.
      Asteroid tempAsteroid = new Asteroid(tempPos, tempDir, tempSize);
      // load the asteroid into the list.
      asteroids.add(tempAsteroid);
    }
  }
  
  //This function is called everyframe and controls the updating
  //of asteroid positions.
  void UpdateAsteroids()
  {
    //loop through the current asteroids.
    for(i = 0; i < asteroids.size(); i++)
    {
      // get the current iterations asteroid.
      Asteroid tempAsteroid = asteroids.get(i);
      
      //update its position, based on the unique direction and speed
      // of the asteroid.
      tempAsteroid.pos.x += tempAsteroid.dir.x * tempAsteroid.speed;
      tempAsteroid.pos.y += tempAsteroid.dir.y * tempAsteroid.speed;
      // check if we need to teleport it to the other side of the screen.
      AsteroidScreenWrap(tempAsteroid);
      // finally draw the asteroid.
      image(tempAsteroid.currentImg, tempAsteroid.pos.x,tempAsteroid.pos.y);
    }
  }
  
  // called when a collision is detected.
  void DestroyAsteroid(int AsteroidIndex)
  {
    // get the asteroid that was collided with.
    Asteroid tempAsteroid = asteroids.get(AsteroidIndex);
    // check if its a not the smallest asteroid.
    // if it isnt, when it dies, spawn a random amount of 
    // smaller asteroids.
    if(tempAsteroid.maxSize <= SMALLESTASTEROIDINDEX)
    { 
      //decide how many to spawn
      //TODO: possible make the 1 and 5 into a variable.
      // i didnt initially because they are only used here.
      // but might make sense for tuning to have a easily understood name
      // to describe what they are doing.
      int childrenToSpawn = (int)random(1,5);
      //spawn some asteroids.
      SpawnAsteroids(childrenToSpawn, tempAsteroid);
      // remove it from the list so we dont draw it again
      // TODO: if i get the animatons going, here would be a good spot to trigger
      // an explosion.
      asteroids.remove(AsteroidIndex);
    }
    else
    {
      // okay it was a small asteroid, so all that is needed is to remove it
      // from the draw list.
      asteroids.remove(AsteroidIndex);
    } 
  }
  
  // pretty self explanatory, if it go too far one side, teleports it to the other.
  // does this for both x and y directions.
  // it does it based off of screen hieght and width and image height and width.
  // so it shouldnt be affected by screen resizing or image changes.
  void AsteroidScreenWrap(Asteroid AsteroidToWrap)
  {
      if(AsteroidToWrap.pos.x > width + AsteroidToWrap.currentImg.width)
      {
        AsteroidToWrap.pos.x = -AsteroidToWrap.currentImg.width;
      }
      else if(AsteroidToWrap.pos.x < -AsteroidToWrap.currentImg.width)
      {
        AsteroidToWrap.pos.x = width + AsteroidToWrap.currentImg.width;
      }
    
      if(AsteroidToWrap.pos.y > height + AsteroidToWrap.currentImg.height)
      {
        AsteroidToWrap.pos.y = -AsteroidToWrap.currentImg.height;
      }
      else if(AsteroidToWrap.pos.y < -AsteroidToWrap.currentImg.height)
      {
        AsteroidToWrap.pos.y = height + AsteroidToWrap.currentImg.height;
      }
  }
  
  // spawn new asteroids, this is used when destroying large asteroids
  // and we want to spawn some smaller ones in its place.
  // takes in how many you want to spawn and the asteroid thats being destroyed.
  void SpawnAsteroids(int Quantity, Asteroid ParentAsteroid)
  {
    //loop through the quantity and create some baby asteroids.
    for(i = 0; i < Quantity; i++)
    {
      //some random characteristics for the new asteroids.
      PVector tempPos = new PVector(random(ParentAsteroid.pos.x - ParentAsteroid.radius, 
                                    ParentAsteroid.pos.x + ParentAsteroid.radius), 
                                    random(ParentAsteroid.pos.y - ParentAsteroid.radius, 
                                    ParentAsteroid.pos.y + ParentAsteroid.radius));
      PVector tempDir = new PVector(random(-1, 1), random(-1,1));
      // make sure the asteroids are always smaller than the one dieing.
      int tempSize = (int)random(ParentAsteroid.maxSize, ASTEROIDSIZE);
      //make the new asteroid.
      Asteroid tempAsteroid = new Asteroid(tempPos,tempDir,tempSize);
      // add it to the draw list.
      asteroids.add(tempAsteroid);
    }
  }
  
  void DestoryAsteroids()
  {
    asteroids.clear();
  }
}