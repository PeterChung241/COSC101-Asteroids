class Power_Up
{
  PVector pos = new PVector(0,0);
  boolean spawned;
  PImage p_up2 = loadImage("PowerUp01.png");
  PImage p_up3 = loadImage("PowerUp02.png");
  float radius = 15;
  int state;
  
  void Spawn_Power_Up()
  { 
    pos.x = 1455;
    pos.y = random(200, 460);
    state = 2;
    spawned = false;    
  }
  
  void Update_Power_Up()
  { 
    if(spawned == true)
    {
      pos.x -= 1.5;
      pos.y = 30*sin(pos.x/55)*5*cos(pos.x/78)*2*sin(pos.x/129) + height/2;
      if(pos.x < -40)
      {
        PU.Spawn_Power_Up();
      }
      if (pos.x % 150 == 0)
      {
        if(state == 2)
          state = 3;
        else if (state == 3)
          state = 2;
      }
      if (state == 2)
        image(p_up2, pos.x, pos.y, 25, 25);
      else if (state == 3)
        image(p_up3, pos.x, pos.y, 25, 25);
    }
  }
  
}
