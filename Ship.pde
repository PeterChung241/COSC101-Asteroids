// Ship class,
// handles the movement of the ship based on user input.
// has a simply physics simulation to apply drag to the ship
// 

class Ship
{
  //Constants
  
  //Variables
  PVector pos;
  float thrust = 0.15;
  float drag = 0.99;
  PVector velocity = new PVector(0,0);
  float rotation = 0.0;
  float angle;
  float radius = 28.75;
  boolean invunerable = false;
  
  
  
  public void InitializeShip()
  {
    pos = new PVector(width * 0.5,height * 0.5);
    angle = radians(5.0);
 
  }
  
  public void UpdateShip(boolean[] Input)
  {
   
    // apply a drag, essentially just reducing our velocity by 0.01%;
    velocity.x *= drag;
    velocity.y *= drag;
    
    // add our velocity to the current position.
    pos.x += velocity.x;
    pos.y += velocity.y;


    
    // wrap the screen, if we go off one side, re-appear on the other.
    if(pos.x > width + 30)
    {
        pos.x = -30;
    }
    else if(pos.x < -30)
    {
        pos.x = width + 30;
    }
    
    if(pos.y > height + 30)
    {
        pos.y = -30;
    }
    else if(pos.y < -30)
    {
        pos.y = height + 30;
    }
   
    // apply rotation or thrust based on user input.
    if(Input[LEFT])
    {
        rotation -= angle;
    }
    
    if(Input[RIGHT])
    {
        rotation += angle;

    }
    
    if(Input[UP]) 
    {
        velocity.x += sin(rotation) * thrust;
        velocity.y -= cos(rotation) * thrust;
    }
    if(Input[DOWN])
    {
        velocity.x -= sin(rotation) * thrust;
        velocity.y += cos(rotation) * thrust;
    }

   
    // move the whole co-ordinate system to the ships location
    pushMatrix();
    translate(pos.x, pos.y);
    // rotate the co-ordinates so ship is facing right way.
    rotate(rotation);
    // draw the ship
    Anim.DrawShip(invunerable);
    popMatrix();
  }
}
