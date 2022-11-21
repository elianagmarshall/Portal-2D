class FinalScene {
  PImage finalText; //images of the final text boxes
  int finalTextCounter; //counter for finalText string
  int endFinalTimer; //end time for displaying the final scene
  int finalVoice1=0; //counter to play voiceFinal1 sound once
  int finalVoice2=0; //counter to play voiceFinal2 sound once
  int finalVoice3=0; //counter to play voiceFinal3 sound once
  int finalVoice4=0; //counter to play voiceFinal4 sound once
  int finalVoice5=0; //counter to play voiceFinal5 sound once
  int finalVoice6=0; //counter to play voiceFinal6 sound once
  int finalVoice7=0; //counter to play voiceFinal7 sound once
  int finalVoice8=0; //counter to play voiceFinal8 sound once
  int finalVoice9=0; //counter to play voiceFinal9 sound once
  int finalVoice10=0; //counter to play voiceFinal10 sound once
  int finalVoice11=0; //counter to play voiceFinal11 sound once
  int finalVoice12=0; //counter to play voiceFinal12 sound once
  int finalVoice13=0; //counter to stop playing sound
  boolean displayWheatleyText, displayGladosText; //booleans to display GlaDOS and Wheatley text
  boolean displayFinalScene; //boolean to display the final scene
  boolean singleFinalScene; //boolean to display the final scene once

  FinalScene() {
    endFinalTimer=20000; //final scene will be displayed after 20 second
  }

  void finalSceneTimer() {
    if (score>endFinalTimer && singleFinalScene==false) { //if the score is greater than the end time for displaying the final scene and the final scene has not been displayed once
      displayFinalScene=true; //the final scene is displayed
      singleFinalScene=true; //the final scene is displayed once
    }
  }

  void finalScene() {
    finalText=loadImage("finalText"+str(finalTextCounter)+".png");
    if (displayFinalScene) { //if the final scene is displayed
      if (finalTextCounter==0 || finalTextCounter==2 || finalTextCounter==6 || finalTextCounter==8 || finalTextCounter==10) { //if the counter for the final text boxes is 0, 1, 2, 6, 8, or 10
        displayWheatleyText=true; //display Wheatley text
        displayGladosText=false; //do not display GlaDOS text
      } else {
        displayGladosText=true; //display GlaDOS text
        displayWheatleyText=false; //do not display Wheatley text
      }
      if (displayWheatleyText) { //if Wheatley text is displayed
        if (finalTextCounter>5) //if the counter for the final text boxes is greater than 5
          image(w.angryWheatley, width-190, 10); //draw angry Wheatley in the top right corner
        else
          image(w.rightWheatley, width-190, 10); //draw Wheatley in the top right corner
        image(g.leftGlados, 0, 0); //draw GladDOS in the top left corner
        image(finalText, 320, 250); //draw the final text boxes near Wheatley
        pause=true; //the game is paused
      }
      if (displayGladosText) { //if GlaDOS text is displayed
        image(g.leftGlados, 0, 0); //draw GlaDOS in the top left corner
        if (finalTextCounter>5) //if the counter for the final text boxes is greater than 5
          image(w.angryWheatley, width-190, 10); //draw angry Wheatley in the top right corner
        else
          image(w.rightWheatley, width-190, 10); //draw Wheatley in the top right corner
        image(finalText, 10, 250); //draw the final text boxes near GlaDOS
        pause=true; //the game is paused
      }
      if (finalTextCounter>11) { //if the counter for the final text boxes is greater than 11
        displayFinalScene=false; //the final scene is not displayed
        pause=false; //the game is not paused
      }
    }
  }

  void voiceFinalScene() {
    if (finalTextCounter==0 && displayFinalScene) //if the counter for the final text boxes is 0 and the final scene is displayed
      finalVoice1++; //increase the finalVoice1 counter
    if (finalVoice1==1) //if the finalVoice1 counter is 1
      voiceFinal1.play(); //play voiceFinal1 sound
    if (finalTextCounter==1) //if the counter for the final text boxes is 1
      finalVoice2++; //increase the finalVoice2 counter
    if (finalVoice2==1) { //if the finalVoice2 counter is 1
      voiceFinal1.stop(); //stop playing voiceFinal1 sound
      voiceFinal2.play(); //play voiceFinal2 sound
    }
    if (finalTextCounter==2) //if the counter for the final text boxes is 2
      finalVoice3++; //increase the finalVoice3 counter
    if (finalVoice3==1) { //if the finalVoice3 counter is 1
      voiceFinal2.stop(); //stop playing voiceFinal2 sound
      voiceFinal3.play(); //play voiceFinal3 sound
    }
    if (finalTextCounter==3) //if the counter for the final text boxes is 3
      finalVoice4++; //increase the finalVoice4 counter
    if (finalVoice4==1) { //if the finalVoice4 counter is 1
      voiceFinal3.stop(); //stop playing voiceFinal3 sound
      voiceFinal4.play(); //play voiceFinal4 sound
    }
    if (finalTextCounter==4) //if the counter for the final text boxes is 4
      finalVoice5++; //increase the finalVoice5 counter
    if (finalVoice5==1) { //if the finalVoice5 counter is 1
      voiceFinal4.stop(); //stop playing voiceFinal4 sound
      voiceFinal5.play(); //play voiceFinal5 sound
    }
    if (finalTextCounter==5) //if the counter for the final text boxes is 4
      finalVoice6++; //increase the finalVoice6 counter
    if (finalVoice6==1) {  //if the finalVoice6 counter is 1
      voiceFinal5.stop(); //stop playing voiceFinal5 sound
      voiceFinal6.play(); //play voiceFinal6 sound
    }
    if (finalTextCounter==6) //if the counter for the final text boxes is 6
      finalVoice7++; //increase the finalVoice7 counter
    if (finalVoice7==1) { //if the finalVoice7 counter is 1
      voiceFinal6.stop(); //stop playing voiceFinal6 sound
      voiceFinal7.play(); //play voiceFinal7 sound
    }
    if (finalTextCounter==7) //if the counter for the final text boxes is 7
      finalVoice8++; //increase the finalVoice8 counter
    if (finalVoice8==1) { //if the finalVoice8 counter is 1
      voiceFinal7.stop(); //stop playing voiceFinal7 sound
      voiceFinal8.play();  //play voiceFinal8 sound
    }
    if (finalTextCounter==8) //if the counter for the final text boxes is 8
      finalVoice9++; //increase the finalVoice9 counter
    if (finalVoice9==1) { //if the finalVoice9 counter is 1
      voiceFinal8.stop(); //stop playing voiceFinal8 sound
      voiceFinal9.play(); //play voiceFinal9 sound
    }
    if (finalTextCounter==9) //if the counter for the final text boxes is 9
      finalVoice10++; //increase the finalVoice10 counter
    if (finalVoice10==1) { //if the finalVoice10 counter is 1
      voiceFinal9.stop(); //stop playing voiceFinal9 sound
      voiceFinal10.play(); //play voiceFinal10 sound
    }
    if (finalTextCounter==10) //if the counter for the final text boxes is 10
      finalVoice11++; //increase the finalVoice11 counter
    if (finalVoice11==1) { //if the finalVoice11 counter is 1
      voiceFinal10.stop(); //stop playing voiceFinal10 sound
      voiceFinal11.play(); //play voiceFinal11 sound
    }
    if (finalTextCounter==11) //if the counter for the final text boxes is 11
      finalVoice12++; //increase the finalVoice12 counter
    if (finalVoice12==1) { //if the finalVoice12 counter is 1
      voiceFinal11.stop(); //stop playing voiceFinal11 sound
      voiceFinal12.play(); //play voiceFinal12 sound
    }
    if (finalTextCounter==12) //if the counter for the final text boxes is 12
      finalVoice13++; //increase the finalVoice13 counter
    if (finalVoice13==1) //if the finalVoice13 counter is 1
      voiceFinal12.stop(); //stop playing voiceFinal12 sound
  }
}
