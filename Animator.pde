class Animator
{
  int frame = 0;
  IntList explosionStates;
  PImage[] explosionAnim = new PImage[6];
  PImage[] shipImages = new PImage[2];
  PImage[] shipExplosion = new PImage[10];
  PImage currentShipImage;
  PVector shipExplosionPos;
  int shipExplosionState = 0;
  boolean shipExploding = false;
  ArrayList<PVector> explosionLocations;
  
  
  Animator()
  {
    for(int i = 0; i < explosionAnim.length; i++)
    {
      explosionAnim[i] = loadImage("explosion_" + i + ".png");
    }
    for(int i = 0; i < shipImages.length; i++)
    {
      shipImages[i] = loadImage("Ship_" + i + ".png");
    }
    for(int i = 0; i < shipExplosion.length; i++)
    {
      shipExplosion[i] = loadImage("ShipExplosion_" + i + ".png");
    }
    currentShipImage = shipImages[0];
    explosionLocations = new ArrayList<PVector>();
    explosionStates = new IntList();
  }
  
  void UpdateAnimations()
  { 
    frame += 1;
    if(frame > frameRate)
    {
      frame = 0;
    }
    if(shipExploding)
    {
      if(shipExplosionState > 9)
      {
        shipExplosionState = 0;
        shipExploding = false;
      }
      
      if(frame % 2 == 0)
      {
        image(shipExplosion[shipExplosionState], shipExplosionPos.x, shipExplosionPos.y);
        shipExplosionState += 1;
      }
    }
    for(int i = 0; i < explosionStates.size(); i++)
    {
      if(explosionStates.get(i) / 3 > 5)
      {
        explosionStates.remove(i);
        explosionLocations.remove(i);
      }
    }
    
    for(int i = 0; i < explosionLocations.size(); i++)
    {
      int imageState = explosionStates.get(i) / 3;
      PImage displayedImage = explosionAnim[imageState];
      PVector tempLocation = explosionLocations.get(i);
      image(displayedImage, tempLocation.x, tempLocation.y);
      explosionStates.set(i, explosionStates.get(i) + 1);
    }
  }
  void ExplodeShip(PVector Location)
  {
    shipExplosionPos = new PVector(Location.x, Location.y);
    shipExploding = true;
  }
  void AddExplosionAnimation(PVector Location)
  {
    PVector tempLocation = new PVector(Location.x, Location.y);
    explosionLocations.add(tempLocation);
    explosionStates.append(0);
  }
  
  void DrawShip(boolean invunerable)
  {
    boolean toggleShip = false;
    if(invunerable)
    {
      
      if( frame % 8 == 0)
      {
        
        toggleShip = true;
      }
      else
      {
        toggleShip = false;
      }
      
    }
    else
    {
      currentShipImage = shipImages[0];
    }
    
    if(toggleShip)
    {
      if(currentShipImage == shipImages[0])
      {
        currentShipImage = shipImages[1];
      }
      else
      {
        currentShipImage = shipImages[0];
      }
    }

    
    currentShipImage.resize(55,70);
    image(currentShipImage, 0, 0);
  }
}