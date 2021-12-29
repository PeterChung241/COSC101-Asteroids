// Level manager is responsible for displaying
// the title screen and screens between rounds.
// i am undecided if this needs to be a seperate class 
// or just part of the main draw loop.

class Game_States
{
  //Constants
  
  //Variables.
  PImage title;
  PImage startButton;
  PImage gameOver;
  PImage enterName;
  PImage highscoreButton;
  PImage highscoreTitle;
  PImage nameScore;
  PImage controls;
  PImage getReady;
  PImage newRound;
  PImage heart;
  PImage exitButton;
  PImage creditsButton;
  PImage creditsScreen;
  //Game States Constructor
  Game_States()
  {
    //loads the title image.
    title = loadImage("Title.png");
    startButton = loadImage("Start.png");
    gameOver = loadImage("GameOver.png");
    enterName = loadImage("Name.png");
    highscoreButton = loadImage("HighscoreButton.png");
    highscoreTitle = loadImage("HighscoreTitle.png");
    nameScore = loadImage("NameScore.png");
    controls = loadImage("Controls.png");
    getReady = loadImage("GetReady.png");
    newRound = loadImage("NewRound.png");
    heart = loadImage("Heart.png");
    exitButton = loadImage("Exit.png");
    creditsButton = loadImage("Credits.png");
    creditsScreen = loadImage("CreditScreen.png");
  }
  // called at the start of the game.
  boolean NewGame(Asteroid_Manager AM)
  {
    // simply checks if the game has started
    // e.g has the player clicked the start button
    
    boolean buttonClicked = false;
    background(0);
    AM.UpdateAsteroids();
    image(title, width / 2, 130);
    buttonClicked = OnHoverButton(300, 400, 200, 50, startButton);
    if(OnHoverButton(700, 400, 200, 50, exitButton))
    {
      exit();
    }

    return buttonClicked;
  }
  
  // shows a newround screen and a countdown.
  int NewRound(int duration)
  {
    background(0);
    image(getReady, width / 2, 100);
    image(newRound, width / 2, 200);
    duration -= millis();
    textSize(70);
    fill(255);
    stroke(255);
    textSize(170);
    text(duration / 1000, width / 2 - 30, height / 2 + 30);  
    return duration;
  }
  
  boolean GameOver(String name, boolean acceptName, StringList Names, IntList Scores)
  {
    boolean buttonClicked;
    if(!acceptName)
    {
      background(0);
      stroke(255);
      fill(255);
      image(gameOver, width / 2, 100);
      image(enterName, width / 2, 200);
      rect((width / 2) - 125, 365, 250, 50, 10);
      textSize(30);
      fill(0);
      text(name.toUpperCase(), (width / 2) - (name.length() * 10), 400);
      buttonClicked = OnHoverButton(width/2, 550, 850, 50, highscoreButton);
      return buttonClicked;
    }
    else
    {
      int i = 0;
      int offset = 0;
      background(0);
      image(highscoreTitle, width  / 2, 50); 
      image(nameScore, width  / 2, 120); 
      
      for(i = 0; i < Names.size(); i++)
      {
        text(Names.get(i).toUpperCase(), 175, 200 + offset);
        text(Scores.get(i), 750, 200 + offset);
        offset += 35;
      }
      if(OnHoverButton(300, 580, 200, 50, creditsButton))
      {
        credits = true;
      }
      if(OnHoverButton(700, 580, 200, 50, exitButton))
      {
        exit();
      }
      return true;
    }
    
    
  }
  void InGame(int lives, int score)
  {
    int xOffset = 20;
    for(int i = 0; i < lives; i++)
    {
      image(heart, xOffset, 15);
      xOffset += 40;
    }
    fill(255);
    stroke(255);
    textSize(30);
    text(score, 900, 25);
  }
  
  void CreditScreen()
  {
    background(0);
    image(creditsScreen, width / 2 , height / 2);
    if(OnHoverButton(width / 2, 580, 200, 50, exitButton))
    {
      exit();
    }
  }

  boolean OnHoverButton(float posX, float posY, float buttonWidth, float buttonHeight, PImage buttonImg)
  {
    fill(255);
    stroke(255);
    rect(posX - (buttonWidth / 2), posY - (buttonHeight / 2), buttonWidth, buttonHeight, 10);
    image(buttonImg, posX , posY);
    if(mouseX >=  posX - (buttonWidth / 2) && mouseX < posX + (buttonWidth / 2))
    {
      if(mouseY >= posY - (buttonHeight / 2) && mouseY <= posY + (buttonHeight / 2))
      {
        fill(200);
        rect(posX - (buttonWidth / 2), posY - (buttonHeight / 2), buttonWidth, buttonHeight, 10);
        image(buttonImg, posX , posY);
        if(mouseButton == LEFT)
        {
          AM.DestoryAsteroids();
          return true;
        }
      }
    }
    return false;
  }
}
