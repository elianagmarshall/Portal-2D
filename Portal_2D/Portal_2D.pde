import processing.sound.*; //allows sound to be imported into Processing
SoundFile portal2Music; //background music
SoundFile voiceIntro1, voiceIntro2, voiceIntro3, voiceIntro4; //GlaDOS voice lines for the introText
SoundFile voiceDeath1, voiceDeath2; //GlaDOS voice lines for when one player dies in a 2-player game
SoundFile voiceWheatley1, voiceWheatley2; //Wheatley voice lines for the Wheatley cut scene
SoundFile voiceFinal1, voiceFinal2, voiceFinal3, voiceFinal4, voiceFinal5, voiceFinal6, voiceFinal7, voiceFinal8, voiceFinal9, voiceFinal10, voiceFinal11, voiceFinal12; //GlaDOS and Wheatley voice lines for the final cut scene

PImage startScreen; //image of the Portal2D start screen
PImage arrow; //image of an arrow
PImage p1Controls, p2Controls; //images of the player 1 and player 2 controls
PImage p1Gameplay, p2Gameplay; //images of the player 1 and player 2 gameplay
PImage portal2DBackground; //image of the portal2D background
PImage endScreen; //image of the portal2D game over screen
PFont pixelFont; //font for the score and high score
int startGameTimer, currentGameTimer; //start time and current time for the game timer
int score, highScore; //score and highest score overall
int  screenCounter; //counter to display various screens
boolean startGame, endGame; //boolean for if the game has started or ended
boolean p1Screens, p2Screens; //booleans to display player 1 and player 2 screens
boolean singleScreen; //boolean to display screens once
boolean p1Arrow, p2Arrow; //booleans for if the arrow is on 1 player or 2 player
boolean player2; //boolean for if there are 2 players
boolean pause; //boolean for if the game is paused
boolean beginGameTimer; //boolean to begin the game timer
boolean scoreChange; //boolean to change the high score

Atlas p1; //constructs 1 object from the class Atlas with p1 parameters
PBody p2; //constructs 1 object from the class PBody with p2 parameters
Turrets[] t = new Turrets[3]; //array to construct 3 objects from the class Turrets with t parameters
GlaDOS g; //constructs 1 object from the class GlaDOS with g parameters
Wheatley w; //constructs 1 object from the class Wheatley with w parameters
FinalScene f; //constructs 1 object from the class FinalScene with f parameters

void setup() {
  size(800, 800); //size of the run window
  startScreen=loadImage("startScreen.png");
  arrow=loadImage("arrow.png");
  p1Controls=loadImage("p1Controls.png");
  p2Controls=loadImage("p2Controls.png");
  p1Gameplay=loadImage("p1Gameplay.png");
  p2Gameplay=loadImage("p2Gameplay.png");
  portal2DBackground=loadImage("portal2DBackground.png");
  endScreen=loadImage("endScreen.png");
  pixelFont=createFont("pixelFont.TTF", 25);
  portal2Music=new SoundFile(this, "portal2Music.wav");
  voiceIntro1=new SoundFile(this, "voiceIntro1.wav");
  voiceIntro2=new SoundFile(this, "voiceIntro2.wav");
  voiceIntro3=new SoundFile(this, "voiceIntro3.wav");
  voiceIntro4=new SoundFile(this, "voiceIntro4.wav");
  voiceDeath1=new SoundFile(this, "voiceDeath1.wav");
  voiceDeath2=new SoundFile(this, "voiceDeath2.wav");
  voiceWheatley1=new SoundFile(this, "voiceWheatley1.wav");
  voiceWheatley2=new SoundFile(this, "voiceWheatley2.wav");
  voiceFinal1=new SoundFile(this, "voiceFinal1.wav");
  voiceFinal2=new SoundFile(this, "voiceFinal2.wav");
  voiceFinal3=new SoundFile(this, "voiceFinal3.wav");
  voiceFinal4=new SoundFile(this, "voiceFinal4.wav");
  voiceFinal5=new SoundFile(this, "voiceFinal5.wav");
  voiceFinal6=new SoundFile(this, "voiceFinal6.wav");
  voiceFinal7=new SoundFile(this, "voiceFinal7.wav");
  voiceFinal8=new SoundFile(this, "voiceFinal8.wav");
  voiceFinal9=new SoundFile(this, "voiceFinal9.wav");
  voiceFinal10=new SoundFile(this, "voiceFinal10.wav");
  voiceFinal11=new SoundFile(this, "voiceFinal11.wav");
  voiceFinal12=new SoundFile(this, "voiceFinal12.wav");

  portal2Music.play(); //Portal 2 music constantly plays
  portal2Music.loop(); //when Portal 2 music ends, start playing again
  portal2Music.amp(0.5); //lowers the volume of Portal 2 music to half its volume
  p1 = new Atlas(); //initializes the class Atlas
  p2 = new PBody(); //initializes the class PBody
  g = new GlaDOS(); //initialzes the class GlaDOS
  w = new Wheatley(); //initializes the class Wheatley
  f= new FinalScene(); //initializrs
  for (int index=0; index<t.length; index++) //index variable has an initial value of 0, must be less than the length of t array, and increases by increments of 1
    t[index] = new Turrets(); //initializes t array
  g.displayIntroScene=true; //intro scene is displayed
  pause=true; //the game is paused
}

void draw() {
  startScreen(); //draws the start screen
  endScreen(); //draws the end screen
  scoring(); //implements and displays a scoring system
  if (startGame && endGame==false) { //if the game has started and has not ended
    gameTimer(); //timer to record the time spent in-game
    g.voiceIntroScene(); //plays the voice sound during the intro
    g.voiceDeathScene(); //plays the voice sound during the death scene
    w.voiceWheatleyScene(); //plays the voice sound during the Wheatley scene
    f.voiceFinalScene(); //plays the voice sound during the final scene
    if (player2) { //if there is a second player
      p2.pbodyPortals(); //displays PBody's portals when used
      p2.pbody(); //displays PBody
      p2.pbodyMove(); //allows PBody to move
      p2.pbodyBoundaries(); //enforces boundaries at the edges of the run window for PBody
      p2.pbodyPortalTimer(); //displays PBody's portals for half a second when used
      p2.pbodyPortalCooldown(); //disables the usage of PBody's portals for 5 seconds
      p2.pbodyCooldownBar(); //draws the different stages of PBody's cooldown bar
      p2.pbodyHitTimer(); //displays electricity surrounding PBody for a duration of 1 second
    }
    p1.atlasPortals(); //displays Atlas' portals when used
    p1.atlas(); //displays Atlas
    p1.atlasMove(); //allows Atlas to move
    p1.atlasBoundaries(); //enforces boundaries at the edges of the run window for Atlas
    p1.atlasPortalTimer(); //displays Atlas' portals for half a second when used
    p1.atlasPortalCooldown(); //disables the usage of Atlas' portals for 5 seconds
    p1.atlasCooldownBar(); //draws the different stages of Atlas' cooldown bar
    p1.atlasHitTimer(); //displays electricity surrounding Atlas for a duration of 1 second
    for (int index=0; index<t.length; index++) { //index variable has an initial value of 0, must be less than the length of t array, and increases by increments of 1
      t[index].turretsP1(p1.atlasX); //the turrets always face Atlas
      t[index].turretsMove(); //allows the turrets to move
      t[index].turretSpeedIncrease(); //increases the speed of the turrets every 3 seconds
      t[index].turretCollision(t); //detects when the turrets collide and resets one of the turrets during each collision
      p1.atlasHearts(t[index].turretLocation, t[index].turretWidth); //displays Atlas' remaining number of hearts
      if (player2) { //if there is a second player
        t[index].turretsP2(p1.atlasX, p1.atlasY, p2.pbodyX, p2.pbodyY); //the turrets face the closest player
        p2.pbodyHearts(t[index].turretLocation, t[index].turretWidth); //displays PBody's remaining number of hearts
      }
      if (frameCount%25==0) { //if 25 frames have passed
        if (pause==false) { //if the game is not paused
          t[index].turretsAdjustP1(p1.atlasX, p1.atlasY); //the turrets move towards Atlas
          t[index].turretsAdjustP2(p1.atlasX, p1.atlasY, p2.pbodyX, p2.pbodyY); //the turrets move towards the closest player
        }
      }
    }
    g.introScene(); //displays the intro scene before gameplay begins
    g.deathScene(); //displays the death scene when one player in a 2 player game dies
    w.wheatleySceneTimer(); //tracks when 10 seconds of gameplay have passed
    w.wheatleyScene(); //displays the Wheatley scene after 10 seconds of gameplay
    f.finalSceneTimer(); //tracks when 20 seconds of gameplay have passed
    f.finalScene(); //displays the final scene after 20 seconds of gameplay
  }
}

void startScreen() {
  if (startGame==false) { //if the game has not started
    image(startScreen, 0, 0); //draw the start screen
    if (p1Screens==false && p2Screens==false) { //if the player 1 and player 2 screens are not displayed
      if (p1Arrow) //if the arrow is on 1 player
        image(arrow, 220, 420); //draw the arrow beside "1 player"
      if (p2Arrow) //if the arrow is on 2 player
        image(arrow, 220, 590); //draw the arrow beside "2 player"
      if (p1Arrow==false && p2Arrow==false) //if the arrow is not on 1 player or 2 player
        p1Arrow=true; //the arrow is on 1 player
    }
    if (p1Screens && screenCounter==1) //if the 1 player screens are displayed and the counter for the screens is 1
      image(p1Controls, 0, 0); //draw the 1 player controls screen
    else if (p1Screens && screenCounter==2)  //if the 1 player screens are displayed and the counter for the screens is 2
      image(p1Gameplay, 0, 0); //draw the 1 player gameplay screen
    else if (p2Screens && screenCounter==1) //if the 2 player screens are displayed and the counter for the screens is 1
      image(p2Controls, 0, 0); //draw the 2 player controls screen
    else if (p2Screens && screenCounter==2) //if the 2 player screens are displayed and the counter for the screens is 2
      image(p2Gameplay, 0, 0); //draw the 2 player gameplay screen
  } else {
    image(portal2DBackground, 0, 0, 800, 800); //draw the Portal 2D baackground
  }
}

void endScreen() {
  if (player2==false) { //if there is not a second player
    if (p1.atlasAlive==false) //if Atlas is not alive
      endGame=true; //the game is over
  }
  if (player2) { //if there is a second player
    if (p1.atlasAlive==false && p2.pbodyAlive==false) //if Atlas and Pbody are not alive
      endGame=true; //the game is over
  }
  if (endGame) //if the game is over
    image(endScreen, 0, 0); //draw the end screen
}

void gameTimer() {
  if (startGame && endGame==false) { //if the game has started and has not ended
    if (beginGameTimer==false) { //if the game timer has not begun
      startGameTimer+=1000/60; //adds 1 second to the start time for the game timer every 60 seconds
      if (pause==false) //if the game is not paused
        beginGameTimer=true; //the game timer has begun
    }
    currentGameTimer+=1000/60; //adds 1 second to the current time for the game timer every 60 seconds
  }
  if (pause && g.displayIntroScene==false) //if the game is paused and the intro scene is not displayed
    startGameTimer+=1000/60; //adds 1 second to the start time for the game timer every 60 seconds
}

void scoring() {
  if (pause==false) //if the game is not paused
    score=currentGameTimer-startGameTimer; //the score is equal to the time spent in-game
  fill(0); //black fill colour
  textFont(pixelFont); //text uses pixelFont
  text(score, width/2+30, height-30); //displays the score in the bottom middle of the screen
  if (endGame) { //if the game has ended
    if (scoreChange==false) { //if the high score has not changed
      scoreChange=true; //the high score changes
      highScore=score; //the score becomes the high score
    }
    if (score>highScore) //if the score is greater than the high score
      highScore=score; //the score becomes the high score
    fill(255); //white fill colour
    text(score, width/2-120, height/2+137); //displays the score in the end screen
    text(highScore, width/2-30, height/2+270); //displays the high score in the end screen
  }
}

void keyPressed() {
  if (key==ENTER) { //if enter is pressed
    singleScreen=false; //the screens have not been displayed once
    if (startGame==false && singleScreen==false && screenCounter<3) { //if the game has not started, the screens have not been displayed, and the counter for the screens is less than 3
      screenCounter++; //the counter for the screens increases by 1
      singleScreen=true; //the screens have been displayed once
    }
    if (p2Arrow==false && screenCounter<3) //if the arrow is not on 2 player and the counter for the screens is less than 3
      p1Screens=true; //the 1 player screens are displayed
    else if (p2Arrow && screenCounter<3) //if the arrow is on 2 player and the counter for the screens is less than 3
      p2Screens=true; //the 2 player screens are displayed
    if (screenCounter>2) { //if the counter for the screens is greater than 2
      if (p2Arrow==false && startGame==false) { //if the arrow is not on 2 player and the game has not started
        p1.atlasX=width/2-45; //Atlas' x-coordinate is reset to its initial 1 player x-coordinate
        p1.atlasY=height/2; //Atlas' y-coordinate is reset to its initial 1 player-y coordinate
      } else if (p2Arrow && startGame==false) { //if the arrow is on 2 player and the game has not started
        p1.atlasX=width/2-150; //Atlas' x-coordinate is reset to its initial 2 player y-coordinate
        p1.atlasY=height/2; //Atlas' y-coordinate is reset to its initial 2 player y-coordinate
        p2.pbodyX=width/2+50; //PBody's x-coordinate is reset to its initial x-coordinate
        p2.pbodyY=height/2; //PBody's y-coordinate is reset to its initial y-coordinate
      }
      p1Screens=false; //the 1 player screens are not displayed
      p2Screens=false; //the 2 player screens are not displayed
      startGame=true; //the game has started
      if (p2Arrow) //if the arrow is on 2 player
        player2=true; //there is a second player
      if (g.introTextCounter<5) //if the counter for the intro text boxes is less than 5
        g.introTextCounter++; //increase the counter for the intro text boxes by 1
      if (g.displayDeathScene && g.deathTextCounter<2) //if the death scene is displayed and the counter for the death scene text boxes is less than 2
        g.deathTextCounter++; //increase the counter for the death scene text boxes by 1
      if (w.displayWheatleyScene && w.wheatleyTextCounter<2) //if the Wheatley scene is displayed and the counter for the Wheatley scene text boxes is less than 2
        w.wheatleyTextCounter++; //increase the counter for the Wheatley scene text boxes by 1
      if (f.displayWheatleyText && f.finalTextCounter<12) //if the Wheatley text boxes are displayed during the final scene and the counter for the Wheatley text boxes is less than 12
        f.finalTextCounter++; //increase the counter for the Wheatley text boxes by 1
      if (f.displayGladosText && f.finalTextCounter<12) //if the GlaDOS text boxes are displayed during the final scene and the counter for the GlaDOS text boxes is less than 12
        f.finalTextCounter++; //increase the counter for the GlaDOS text boxes by 1
    }
  }
  if (startGame && pause==false) { //if the game has started and the game is not paused
    p1.atlasKeyPressed(); //allows Atlas to move using 'w', 'a', 's', and 'd'
    if (player2) //if there is a second player
      p2.pbodyKeyPressed(); //allows PBody to move using the up, left, down, and right arrow keys
  }
  if (key==CODED) { //detects special keys
    if (keyCode==UP) { //if the up arrow key is pressed
      if (startGame==false) { //if the game has not started
        p1Arrow=true; //the arrow is on 1 player
        p2Arrow=false; //the arrow is not on 2 player
      }
    }
    if (keyCode==DOWN) { //if the down arrow key is pressed
      if (startGame==false) { //if the game has not started
        p1Arrow=false; //the arrow is not on 1 player
        p2Arrow=true; //the arrow is on 2 player
      }
    }
  }
  if (key=='p') { //if 'p' is pressed
    if (pause==false) //if the game is not paused
      pause=true; //the game is paused
    else
      pause=false; //the game is not paused
    if (g.displayIntroScene || g.displayDeathScene || w.displayWheatleyScene || f.displayFinalScene) //if any of the cut scenes are displayed
      pause=true; //the game is paused
  }
  if (key=='r') { //if 'r' is pressed
    if (endGame) { //if the game has ended
      startGame=false; //the game has not started
      endGame=false; //the game has not ended
      pause=true; //the game is paused
      p2Arrow=false; //the arrow is not on 2 player
      player2=false; //there is not a second player
      p1.atlasAlive=true; //Atlas is alive
      p2.pbodyAlive=true; //PBody is alive
      p1.atlasElec=false; //there is not electrcity surrounding Atlas
      p2.pbodyElec=false; //there is not electricity surround PBody
      p1.useAtlasPortals=false; //Atlas' portals are not being used
      p2.usePbodyPortals=false; //PBody's portals are not being used
      g.displayIntroScene=true; //the intro is displayed
      g.displayDeathScene=false; //the death scene is not displayed
      w.displayWheatleyScene=false; //the Wheatley scene is not displayed
      f.displayFinalScene=false; //the final scene is not displayed
      screenCounter=0; //the counter to display the screens is reset to 0
      startGameTimer=0; //the start time for the game timer is reset to 0
      currentGameTimer=0; //the current time for the game timer is reset to 0
      p1.atlasHearts=3; //Atlas' number of hearts is reset to 0
      p2.pbodyHearts=3; //PBody's number of hearts is reset to 0
      g.introTextCounter=0; //the counter for the intro text boxes is reset to 0
      g.introVoice1=0; //the counter to play voiceIntro1 is reset to 0
      g.introVoice2=0; //the counter to play voiceIntro2 is reset to 0
      g.introVoice3=0; //the counter to play voiceIntro3 is reset to 0
      g.introVoice4=0; //the counter to play voiceIntro4 is reset to 0
      g.introVoice5=0; //the counter to stop playing sound is reset to 0
      g.deathTextCounter=0; //the counter for the death text boxes is reset to 0
      g.deathVoice1=0; //the counter to play voiceDeath1 is reset to 0
      g.deathVoice2=0; //the counter to play voiceDeath2 is reset to 0
      g.deathVoice3=0; //the counter to stop playing sound is reset to 0
      w.wheatleyTextCounter=0; //the counter for the Wheatley text boxes is reset to 0
      w.wheatleyVoice1=0; //the counter to play voiceWheatley1 is reset to 0
      w.wheatleyVoice2=0; //the counter to play voiceWheatley2 is reset to 0
      w.wheatleyVoice3=0; //the counter to stop playing sound is reset to 0
      f.finalTextCounter=0; //the counter for the final text boxes is reset to 0
      f.finalVoice1=0; //the counter to play voiceFinal1 is reset to 0
      f.finalVoice2=0; //the counter to play voiceFinal2 is reset to 0
      f.finalVoice3=0; //the counter to play voiceFinal3 is reset to 0
      f.finalVoice4=0; //the counter to play voiceFinal4 is reset to 0
      f.finalVoice5=0; //the counter to play voiceFinal5 is reset to 0
      f.finalVoice6=0; //the counter to play voiceFinal6 is reset to 0
      f.finalVoice7=0; //the counter to play voiceFinal7 is reset to 0
      f.finalVoice8=0; //the counter to play voiceFinal8 is reset to 0
      f.finalVoice9=0; //the counter to play voiceFinal9 is reset to 0
      f.finalVoice10=0; //the counter to play voiceFinal10 is reset to 0
      f.finalVoice11=0; //the counter to play voiceFinal11 is reset to 0
      f.finalVoice12=0; //the counter to play voiceFinal2 is reset to 0
      f.finalVoice13=0; //the counter to stop playing sound is reset to 0
      for (int index=0; index<t.length; index++) //index variable has an initial value of 0, must be less than the length of t array, and increases by increments of 1
        t[index]=new Turrets(); //resets the turrets
    }
  }
}

void keyReleased() {
  if (startGame) { //if the game has started
    p1.atlasKeyReleased(); //detects when 'w', 'a', 's', or 'd' has been released
    p2.pbodyKeyReleased(); //detect when the up, left, down, or right arrow has been released
  }
}

void mousePressed() {
  if (startGame && pause==false) { //if the game has started and is not paused
    p1.atlasMousePressed(); //Atlas uses its portals if the left mouse button is pressed
    p2.pbodyMousePressed(); //PBody uses its portals if the right mouse button is pressed
  }
}
