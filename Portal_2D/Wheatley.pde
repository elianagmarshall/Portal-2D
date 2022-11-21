class Wheatley {
  PImage leftWheatley, rightWheatley; //images of Wheatley facing left and right
  PImage angryWheatley; //image if angry version of Wheatley
  PImage wheatleyText; //images of the Wheatley text boxes
  int wheatleyTextCounter; //counter for wheatleyText string
  int endWheatleyTimer; //end time for displaying the Wheatley scene
  int wheatleyVoice1=0; //counter to play voiceWheatley1 sound once
  int wheatleyVoice2=0; //counter to play voiceWheatley2 sound once
  int wheatleyVoice3=0; //counter to stop playing sound
  boolean displayWheatleyScene; //boolean to display the Wheatley scene
  boolean singleWheatleyScene; //boolean to display the Wheatley scene once

  Wheatley() {
    leftWheatley=loadImage("leftWheatley.png");
    rightWheatley=loadImage("rightWheatley.png");
    angryWheatley=loadImage("angryWheatley.png");

    endWheatleyTimer=10000; //Wheatley scene will be displayed after 15 seconds
  }

  void wheatleySceneTimer() {
    if (score>endWheatleyTimer && singleWheatleyScene==false) { //if the score is greater than the end time for displaying the Wheatley scene and the Wheatley scene has not been displayed once
      displayWheatleyScene=true; //the Wheatley scene is displayed
      singleWheatleyScene=true; //the Wheatley scene has been displayed once
    }
  }

  void wheatleyScene() {
    wheatleyText=loadImage("wheatleyText"+str(wheatleyTextCounter)+".png");
    if (displayWheatleyScene) { //if the Wheatley scene is displayed
      image(leftWheatley, 10, 10); //draw Wheatley in the top left corner
      image(wheatleyText, 250, 125); //draw the Wheatley text boxes
      pause=true; //the game is paused
      if (wheatleyTextCounter>1) { //if the counter for the Wheatley text boxes is greater than 1
        pause=false; //the game is not paused
        displayWheatleyScene=false; //the Wheatley scene is not displayed
      }
    }
  }

  void voiceWheatleyScene() {
    if (wheatleyTextCounter==0 && displayWheatleyScene) //if the counter for the Wheatley text boxes is 0 and the Wheatley scene is displayed
      wheatleyVoice1++; //increase the wheatleyVoice1 counter
    if (wheatleyVoice1==1) //if the wheatleyVoice1 counter is 1
      voiceWheatley1.play(); //play voiceWheatley1 sound
    if (wheatleyTextCounter==1) //if the counter for the Wheatley text boxes is 1
      wheatleyVoice2++; //increase the wheatleyVoice2 counter
    if (wheatleyVoice2==1) { //if the wheatleyVoice2 counter is 1
      voiceWheatley1.stop(); //stop playing voiceWheatley1 sound
      voiceWheatley2.play();//play voiceWheatley2 sound
    }
    if (wheatleyTextCounter==2) //if the counter for the Wheatley text boxes is 2
      wheatleyVoice3++; //increase the wheatleyVoice3 counter
    if (wheatleyVoice3==1) //if the wheatleyVoice3 counter is 1
      voiceWheatley2.stop(); //stop playing voiceWheatley2 sound
  }
}
