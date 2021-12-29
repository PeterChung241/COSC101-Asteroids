class Collision_Detection
{
  float distance;
  float distanceX;
  float distanceY;
  SoundFile explosion;

  Collision_Detection(processing.core.PApplet _papplet)
  {
    explosion = new SoundFile(_papplet, "explosion.mp3");
  }
  
  void Update_Ship_Collision()
  {
    if(ship.invunerable)
    {
      return;
    }
    for (int i = 0; i < AM.asteroids.size(); i++)
    {
      Asteroid tempAsteroid = AM.asteroids.get(i);
      distanceX = ship.pos.x - tempAsteroid.pos.x;
      distanceY = ship.pos.y - tempAsteroid.pos.y;
      distance = sqrt(pow(distanceX, 2) + pow(distanceY, 2));
      
      if (distance <= ship.radius + tempAsteroid.radius)
      {
        BM.fireMode = 1;
        alive = false;
        lives--;
        Anim.ExplodeShip(ship.pos);
        explosion.play();
        ship.pos.x = width * 0.5;
        ship.pos.y = height * 0.5;
        ship.velocity.x = 0;
        ship.velocity.y = 0;
      }
    }  
  }
  
  int Update_Missile_Collision(Animator Anim)
  {
    for (int i = 0; i < AM.asteroids.size(); i++)
    {
      Asteroid tempAsteroid = AM.asteroids.get(i);
      for (int j = 0; j < BM.bullets.size(); j++)
      {
        Bullet tempBullet = BM.bullets.get(j);
        distanceX = tempBullet.pos.x - tempAsteroid.pos.x;
        distanceY = tempBullet.pos.y - tempAsteroid.pos.y;
        distance = sqrt(pow(distanceX, 2) + pow(distanceY, 2));
        
        if (distance <= tempBullet.radius + tempAsteroid.radius)
        {
          explosion.play();
          BM.DestroyBullet(j);
          AM.DestroyAsteroid(i);
          Anim.AddExplosionAnimation(tempAsteroid.pos);
          score = tempAsteroid.size * 10;
          return score;
        }
      }
    }  
    
    return 0;
  }
  
  
  void Update_Power_Up_Collision()
  {
    if(PU.spawned == true && alive == true)
    {
      distanceX = ship.pos.x - PU.pos.x;
      distanceY = ship.pos.y - PU.pos.y;
      distance = sqrt(pow(distanceX, 2) + pow(distanceY, 2));
      
      if (distance <= ship.radius + PU.radius)
      {
        if (PU.state == 2)
          BM.fireMode = 2;
        else if (PU.state == 3)
          BM.fireMode = 3;
        PU.Spawn_Power_Up();
      }
    }
  }
  
}
