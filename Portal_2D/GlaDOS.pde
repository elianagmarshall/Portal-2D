class GlaDOS {
  PImage leftGlados, rightGlados; //images of GlaDOS facing left and right
  PImage introText; //images of the intro text boxes
  PImage deathText; //images of the death scene text boxes
  int introTextCounter=0; //counter for introText string
  int deathTextCounter=0; //counter for deathText string
  int introVoice1=0; //counter to play voiceIntro1 sound once
  int introVoice2=0; //counter to play voiceIntro2 sound once
  int introVoice3=0; //counter to play voiceIntro3 sound once
  int introVoice4=0; //counter to play voiceIntro4 sound once
  int introVoice5=0; //counter to stop playing sound
  int deathVoice1=0; //counter to play voiceDeath1 sound once
  int deathVoice2=0; //counter to play voiceDeath2 sound once
  int deathVoice3=0; //counter to stop playing sound
  boolean displayIntroScene; //boolean to display the intro scene
  boolean displayDeathScene; //boolean to display the death scene
  boolean singleDeathScene; //boolean to display the death scene once

  GlaDOS() {
    leftGlados=loadImage("leftGlados.png");
    rightGlados=loadImage("rightGlados.png");
  }

  void introScene() {
    introText=loadImage("introText"+str(introTextCounter)+".png");
    if (displayIntroScene) { //if the intro is displayed
      image(leftGlados, 0, 0); //draw GlaDOS in the top left corner
      image(introText, 320, 125); //draw intro text boxes
      if (introTextCounter>4) { //if the counter for the intro text boxes is greater than 4
        pause=false; //the game is not paused
        displayIntroScene=false; //the intro is not displayed
      }
    }
  }

  void voiceIntroScene() {
    if (introTextCounter==1) //if the counter for the intro text boxes is 1
      introVoice1++; //increase the introVoice1 counter
    if (introVoice1==1) //if the introVoice1 counter is 1
      voiceIntro1.play(); //play voiceIntro1 sound
    if (introTextCounter==2) //if the counter for the intro text boxes is 2
      introVoice2++; //increase the introVoice2 counter
    if (introVoice2==1) { //if the introVoice1 counter is 2
      voiceIntro1.stop(); //stop playing voiceIntro1 sound
      voiceIntro2.play(); //play voiceIntro2 sound
    }
    if (introTextCounter==3) //if the counter for the intro text boxes is 3
      introVoice3++; //increase the introVoice3 counter
    if (introVoice3==1) { //if the introVoice3 counter is 1
      voiceIntro2.stop(); //stop playing voiceIntro2 sound
      voiceIntro3.play(); //play voiceIntro3 sound
    }
    if (introTextCounter==4) //if the counter for the intro text boxes is 4
      introVoice4++; //increase the introVoice4 counter
    if (introVoice4==1) { //if the introVoice4 counter is 1
      voiceIntro3.stop(); //stop playing voiceIntro3 sound
      voiceIntro4.play(); //play voiceIntro4 sound
    }
    if (introTextCounter==5) //if the counter for the intro text boxes is 5
      introVoice5++; //increase the introVoice5 counter
    if (introVoice5==1) //if the introVoice5 counter is 1
      voiceIntro4.stop(); //stop playing voiceIntro4 sound
  }

  void deathScene() {
    deathText=loadImage("deathText"+str(deathTextCounter)+".png");
    if (player2) { //if there is a second player
      if (singleDeathScene==false) { //if the death scene has not been displayed once
        if (p1.atlasAlive==false || p2.pbodyAlive==false) //if Atlas is not alive and PBody is not alive
          displayDeathScene=true; //the death scene is displayed
        if (displayDeathScene) { //if the death scene is displayed
          image(rightGlados, width-300, 0); //draw GlaDOS in the top right corner
          image(deathText, 10, 125); //draw the death text boxes
          pause=true; //the game is paused
          if (deathTextCounter>1) { //if the counter for the death text boxes is greater than 1
            pause=false; //the game is not paused
            displayDeathScene=false; //the death scene is not displayed
            singleDeathScene=true; //the death scene has been displayed once
          }
        }
      }
    }
  }

  void voiceDeathScene() {
    if (deathTextCounter==0 && displayDeathScene) //if the counter for the death text boxes is 0 and the death scene is displayed
      deathVoice1++; //increase the deathVoice1 counter
    if (deathVoice1==1) //if the deathVoice1 counter is 1
      voiceDeath1.play(); //play voiceDeath1 sound
    if (deathTextCounter==1) //if the counter for the death text boxes is 1
      deathVoice2++;  //increase the deathVoice2 counter
    if (deathVoice2==1) { //if the deathVoice2 counter is 1
      voiceDeath1.stop(); //stop playing voiceDeath1 sound
      voiceDeath2.play(); //play voiceDeath2 sound
    }
    if (deathTextCounter==2) //if the counter for the death text boxes is 2
      deathVoice3++; //increase the deathVoice3 counter
    if (deathVoice3==1) //if the deathVoice3 counter is 1
      voiceDeath2.stop(); //stop playing voiceDeath2 sound
  }
}
