class Atlas {
  PImage leftAtlas, rightAtlas; //images of Atlas facing left and right
  PImage bluePortal, purplePortal; //images of the blue and purple portals
  PImage atlasHearts0, atlasHearts1, atlasHearts2, atlasHearts3; //images of Atlas' number of hearts
  PImage atlasCooldown0, atlasCooldown1, atlasCooldown2, atlasCooldown3, atlasCooldown4, atlasCooldown5; //images of Atlas' portal cooldown bar
  PImage atlasElectricity; //image of blue electricity
  float atlasX, atlasY; //x and y coordinates of Atlas
  float atlasWidth=120; //width of Atlas
  float atlasYBoundaryT=30; //top y boundary for Atlas
  float atlasYBoundaryB=90; //bottom y boundary for Atlas
  float atlasXBoundaryL=30; //left x boundary for Atlas
  float atlasXBoundaryR=120; //right x boundary for Atlas
  float atlasSpeed; //speed of Atlas
  float bluePortalX, bluePortalY; //x and y coordinates of the blue portal
  float atlasPortalWidth=45; //width of the portals
  float atlasPortalHeight=153; //height of the portals
  float atlasHearts=3; //counter for Atlas' number of hearts
  float atlasCooldownHeight=45; //height of the cooldown bar
  float startAtlasPortals, currentAtlasPortals, endAtlasPortals; //start time, current time, and end time for displaying Atlas' portals
  float startAtlasCooldown, currentAtlasCooldown, endAtlasCooldown; //start time, current time, and end time for Atlas' portal cooldown
  float startAtlasHit, currentAtlasHit, endAtlasHit; //start time, current time, and end time for Atlas' hit duration
  boolean atlasLeft, atlasRight;//boolean for if Atlas is facing left or right
  boolean wPressed, aPressed, sPressed, dPressed; //boolean for if keys 'w', 'a', 's', and/or 'd' is being pressed
  boolean useAtlasPortals; //boolean for if Atlas' portals are being used
  boolean beginAtlasPortals; //boolean to begin the timer that displays Atlas' portals
  boolean beginAtlasCooldown; //boolean to begin the timer for Atlas' portal cooldown
  boolean beginAtlasHit; //boolean to begin the timer for Atlas' hit duration
  boolean atlasHit; //boolean for if Atlas is being hit
  boolean atlasElec; //boolean to display electricity surrounding Atlas
  boolean atlasAlive; //boolean for if Atlas is alive

  Atlas() {
    leftAtlas=loadImage("leftAtlas.png");
    rightAtlas=loadImage("rightAtlas.png");
    bluePortal=loadImage("bluePortal.png");
    purplePortal=loadImage("purplePortal.png");
    atlasHearts0=loadImage("atlasHearts0.png");
    atlasHearts1=loadImage("atlasHearts1.png");
    atlasHearts2=loadImage("atlasHearts2.png");
    atlasHearts3=loadImage("atlasHearts3.png");
    atlasCooldown0=loadImage("atlasCooldown0.png");
    atlasCooldown1=loadImage("atlasCooldown1.png");
    atlasCooldown2=loadImage("atlasCooldown2.png");
    atlasCooldown3=loadImage("atlasCooldown3.png");
    atlasCooldown4=loadImage("atlasCooldown4.png");
    atlasCooldown5=loadImage("atlasCooldown5.png");
    atlasElectricity=loadImage("atlasElectricity.png");

    atlasY=height/2; //initial Atlas y-coordinate is in the middle of the y-axis
    endAtlasPortals=500; //end time of 0.5 seconds for displaying Atlas' portals
    endAtlasCooldown=5000; //end time of 5 seconds for Atlas' portal cooldown
    endAtlasHit=1000; //end time of 1 second for Atlas' hit duration
    atlasAlive=true; //Atlas is alive
  }

  void atlas() {
    if (atlasAlive) { //if atlas is alive
      if (atlasLeft==false && atlasRight==false && player2) {  //if Atlas is not facing left or right and there is a second player
        atlasX=width/2-150; //Atlas x-coordinate is in the middle left of the x-axis
        image(rightAtlas, atlasX, atlasY); //draw Atlas facing right
      }
      if (atlasLeft==false && atlasRight==false && player2==false) { //if Atlas is not facing left or right and there is not a second player
        atlasX=width/2-45; //Atlas x-coordinate is in the middle of the x-axis
        image(rightAtlas, atlasX, atlasY); //draw Atlas facing right
      }
      if (atlasLeft) //if Atlas is facing left
        image(leftAtlas, atlasX-35, atlasY); //draw Atlas facing left
      if (atlasRight) //if Atlas is facing right
        image(rightAtlas, atlasX, atlasY); //draw Atlas facing right
    }
  }

  void atlasBoundaries() {
    if (atlasX<atlasXBoundaryL) //if Atlas' x-coordinate is less than Atlas' left x boundary
      atlasX+=atlasSpeed; //Atlas cannot move to the left
    if (atlasX>width-atlasXBoundaryR) //if Atlas' x-coordinate is greater than Atlas' right x boundary
      atlasX-=atlasSpeed; //Atlas cannot move to the right
    if (atlasY<atlasYBoundaryT) //if Atlas' y-coordinate is less than Atlas' top y boundary
      atlasY+=atlasSpeed; //Atlas cannot move upwards
    if (atlasY>height-atlasYBoundaryB) //if Atlas' y-coordinate is less than Atlas' bottom y boundary
      atlasY-=atlasSpeed; //Atlas cannot move downwards
  }

  void atlasPortals() {
    if (useAtlasPortals && beginAtlasCooldown==false && atlasAlive) {  //if Atlas' portals are being used, Atlas' portal cooldown has not begun, and Atlas is alive
      image(purplePortal, atlasX, atlasY-50); //draw the purple portal at Atlas' coordinates
      image(bluePortal, bluePortalX-atlasPortalWidth/2, bluePortalY-atlasPortalHeight/2); //draw the blue portal where the left mouse button was pressed
      atlasSpeed=0; //Atlas cannot move
    } else {
      atlasSpeed=5; //Atlas can move at a speed of 5
    }
  }

  void atlasPortalTimer() {
    if (beginAtlasPortals==false) { //if the timer for displaying Atlas' portals has not begun
      beginAtlasPortals=true; //the timer for displaying Atlas' portals has begun
      startAtlasPortals=millis(); //returns the number of milliseconds that have passed since opening the game
    }
    currentAtlasPortals=millis(); //returns the number of milliseconds that have passed since opening the game
    if (currentAtlasPortals-startAtlasPortals>endAtlasPortals && useAtlasPortals==true) { //if the current time for displaying Atlas' portals minus the start time for displaying Atlas' portals is greater than the end time for displaying Atlas' portals and Atlas' portals are being used
      useAtlasPortals=false; //Atlas' portals are not being used
      beginAtlasPortals=false; //the timer for displaying Atlas' portals has not begun
      beginAtlasCooldown=true; //the timer for Atlas' portal cooldown has begun
      startAtlasCooldown=millis(); //returns the number of milliseconds that have passed since opening the game
      atlasX=bluePortalX-atlasPortalWidth/2; //Atlas' x-coordinate becomes the x-coordinate of the blue portal
      atlasY=bluePortalY-atlasPortalHeight/2; //Atlas'y-coordinate becomes the y-coordinate of the blue portal
    }
  }

  void atlasPortalCooldown() {
    if (beginAtlasCooldown) { //if the timer for Atlas' portal cooldown has begun
      if (currentAtlasCooldown-startAtlasCooldown>endAtlasCooldown) //if the current time for Atlas' portal cooldown minus the start time for Atlas' portal cooldown is greater than the end time for Atlas' portal cooldown
        beginAtlasCooldown=false; //the timer for Atlas' portal cooldown has not begun
      if (currentAtlasCooldown-startAtlasCooldown<endAtlasCooldown) //if the current time for Atlas' portal cooldown minus the start time for Atlas' portal cooldown is less than the end time for Atlas' portal cooldown
        useAtlasPortals=false; //Atlas' portals are not being used
    }
    currentAtlasCooldown=millis(); //returns the number of milliseconds that have passed since opening the game
  }

  void atlasCooldownBar() {
    if (beginAtlasCooldown==false || atlasAlive==false) //if the timer for Atlas' portal cooldown has not begun or Atlas is not alive
      image(atlasCooldown5, 10, height-atlasCooldownHeight-10); //draw a full cooldown bar in the bottom left corner
    if (beginAtlasCooldown && atlasAlive) { //if the timer for Atlas' portal cooldown has begun and Atlas is alive
      if (currentAtlasCooldown-startAtlasCooldown<1000) //if the current time for Atlas' portal cooldown minus the start time for Atlas' portal cooldown is less than 1 second
        image(atlasCooldown4, 10, height-atlasCooldownHeight-10); //draw a 4/5 full cooldown bar in the bottom left corner
      if (currentAtlasCooldown-startAtlasCooldown<2000 && currentAtlasCooldown-startAtlasCooldown>1000)  //if the current time for Atlas' portal cooldown minus the start time for Atlas' portal cooldown is less than 2 seconds and the current time for Atlas' portal cooldown minus the start time for Atlas' portal cooldown is greater than 1 second
        image(atlasCooldown3, 10, height-atlasCooldownHeight-10); //draw a 3/5 full cooldown bar in the bottom left corner
      if (currentAtlasCooldown-startAtlasCooldown<3000 && currentAtlasCooldown-startAtlasCooldown>2000) //if the current time for Atlas' portal cooldown minus the start time for Atlas' portal cooldown is less than 3 seconds and the current time for Atlas' portal cooldown minus the start time for Atlas' portal cooldown is greater than 2 seconds
        image(atlasCooldown2, 10, height-atlasCooldownHeight-10); //draw a 2/5 full cooldown bar in the bottom left corner
      if (currentAtlasCooldown-startAtlasCooldown<4000 && currentAtlasCooldown-startAtlasCooldown>3000) //if the current time for Atlas' portal cooldown minus the start time for Atlas' portal cooldown is less than 4 seconds and the current time for Atlas' portal cooldown minus the start time for Atlas' portal cooldown is greater than 3 seconds
        image(atlasCooldown1, 10, height-atlasCooldownHeight-10); //draw a 1/5 full cooldown bar in the bottom left corner
      if (currentAtlasCooldown-startAtlasCooldown<5000 && currentAtlasCooldown-startAtlasCooldown>4000) //if the current time for Atlas' portal cooldown minus the start time for Atlas' portal cooldown is less than 5 seconds and the current time for Atlas' portal cooldown minus the start time for Atlas' portal cooldown is greater than 4 seconds
        image(atlasCooldown0, 10, height-atlasCooldownHeight-10); //draw an empty cooldown bar in the bottom left corner
    }
  }

  void atlasHearts(PVector turretLocation, float turretWidth) {
    if (atlasHit==false) { //if Atlas is not being hit
      if (dist(turretLocation.x, turretLocation.y, atlasX, atlasY)<turretWidth/2+atlasWidth/2) { //if a turret collides with Atlas
        atlasHit=true; //Atlas is being hit
        atlasElec=true; //display electricity surrounding Atlas
        atlasHearts--; //Atlas has one less heart
      }
    }
    if (atlasHearts==3) //if Atlas has 3 hearts
      image(atlasHearts3, 10, height-100); //draw three hearts in the bottom left corner
    if (atlasHearts==2) //if Atlas has 2 hearts
      image(atlasHearts2, 10, height-100); //draw two hearts in the bottom left corner
    if (atlasHearts==1) //if Atlas has 1 heart
      image(atlasHearts1, 10, height-100); //draw one heart in the bottom left corner
    if (atlasHearts<1) { //if Atlas has less than 1 heart
      image(atlasHearts0, 10, height-100); //draw zero hearts in the bottom left corner
      atlasAlive=false; //Atlas is not alive
    }
    if (atlasElec && atlasAlive) //if electricity is displayed surrounding Atlas and Atlas is alive
      image(atlasElectricity, atlasX-15, atlasY+15); //draw electricity surrounding Atlas
  }

  void atlasHitTimer() {
    if (beginAtlasHit==false) { //if the timer for Atlas' hit duration has not begun
      beginAtlasHit=true; //the timer for Atlas' hit duration has begun
      startAtlasHit=millis(); //returns the number of milliseconds that have passed since opening the game
    }
    currentAtlasHit=millis(); //returns the number of milliseconds that have passed since opening the game
    if (currentAtlasHit-startAtlasHit>endAtlasHit) { //if the current time for Atlas' hit duration minus the start time for Atlas' hit duration is greater than the end time for Atlas' hit duration
      beginAtlasHit=false; //the timer for Atlas' hit duration has not begun
      atlasHit=false; //Atlas is not being hit
      atlasElec=false; //do not display electricity surrounding Atlas
    }
  }

  void atlasMove() {
    if (wPressed) //if 'w' is being pressed
      atlasY-=atlasSpeed; //Atlas moves upwards
    if (aPressed) //if 'a' is being pressed
      atlasX-=atlasSpeed; //Atlas moves to the left
    if (sPressed) //if 's' is being pressed
      atlasY+=atlasSpeed; //Atlas moves downwards
    if (dPressed) //if 'd' is being pressed
      atlasX+=atlasSpeed; //Atlas moves to the right
  }

  void atlasKeyPressed() {
    if (key=='w') //if 'w' is being pressed
      wPressed=true; //'w' is being pressed
    if (key=='a') { //if 'a' is being pressed
      aPressed=true; //'a' is being pressed
      atlasLeft=true; //Atlas is facing left
      atlasRight=false; //Atlas is not facing right
    }
    if (key=='s') //if 's' is being pressed
      sPressed=true; //'s' is being pressed
    if (key=='d') { //if 'd' is being pressed
      dPressed=true; //'d' is being pressed
      atlasRight=true; //Atlas is facing right
      atlasLeft=false; //Atlas is not facing left
    }
  }

  void atlasKeyReleased() {
    if (key=='w')  //if 'w' is released
      wPressed=false; //'w' is not being pressed
    if (key=='a') //if 'a' is released
      aPressed=false; //'a' is not being pressed
    if (key=='s') //if 's' is released
      sPressed=false; //'s' is not being pressed
    if (key=='d') //if 'd' is released
      dPressed=false; //'d' is not being pressed
  }

  void atlasMousePressed() {
    if (mouseButton==LEFT) { //if the left mouse button is pressed
      startAtlasPortals=millis(); //returns the number of milliseconds that have passed since opening the game
      if (beginAtlasCooldown==false) //if the timer for Atlas' portal cooldown has not begun
        useAtlasPortals=true; //Atlas' portals are being used
      bluePortalX=mouseX; //the x-coordinate of the blue portal is the x-coordinate of the mouse when it was pressed
      bluePortalY=mouseY; //the y-coordinate of the blue portal is the y-coordinate of the mouse when it was pressed
    }
  }
}
