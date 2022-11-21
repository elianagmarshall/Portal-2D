class PBody {
  PImage leftPbody, rightPbody; //images of PBody facing left and right
  PImage orangePortal, redPortal; //images of the orange and red portals
  PImage pbodyHearts0, pbodyHearts1, pbodyHearts2, pbodyHearts3; //images of PBody's number of hearts
  PImage pbodyCooldown0, pbodyCooldown1, pbodyCooldown2, pbodyCooldown3, pbodyCooldown4, pbodyCooldown5; //images of PBody's portal cooldown bar
  PImage pbodyElectricity; //image of orange electricity
  float pbodyX, pbodyY;  //x and y coordinates of PBody
  float pbodyWidth=120; //width of PBody
  float pbodyYBoundaryT=40; //top y boundary for PBody
  float pbodyYBoundaryB=100; //bottom y boundary for PBody
  float pbodyXBoundaryL=40; //left x boundary for PBody
  float pbodyXBoundaryR=120; //right x boundary for PBody
  float pbodySpeed; //speed of PBody
  float orangePortalX, orangePortalY; //x and y coordinates of the orange portal
  float pbodyPortalWidth=90; //width of the portals
  float pbodyPortalHeight=163; //height of the portals
  float pbodyHearts=3; //counter for PBody's number of hearts
  float pbodyCooldownWidth=153; //width of the cooldown bar
  float pbodyCooldownHeight=45; //height of the cooldown bar
  float startPbodyPortals, currentPbodyPortals, endPbodyPortals; //start time, current time, and end time for displaying PBody's portals
  float startPbodyCooldown, currentPbodyCooldown, endPbodyCooldown; //start time, current time, and end time for PBody's portal cooldown
  float startPbodyHit, currentPbodyHit, endPbodyHit; //start time, current time, and end time for PBody's hit duration
  boolean pbodyLeft, pbodyRight; //boolean for if PBody is facing left or right
  boolean upPressed, leftPressed, downPressed, rightPressed; //boolean for if the up, left, down, and/or right arrow key is being pressed
  boolean usePbodyPortals; //boolean for if PBody's portals are being used
  boolean beginPbodyPortals; //boolean to begin the timer that displays PBody's portals
  boolean beginPbodyCooldown; //boolean to begin the timer for PBody's portal cooldown
  boolean beginPbodyHit; //boolean to begin the timer for PBody's hit duration
  boolean pbodyHit; //boolean for if PBody is being hit
  boolean pbodyElec; //boolean to display electricity surrounding PBody
  boolean pbodyAlive; //boolean for if PBody is alive

  PBody() {
    pbodyCooldown0=loadImage("pbodyCooldown0.png");
    pbodyCooldown1=loadImage("pbodyCooldown1.png");
    pbodyCooldown2=loadImage("pbodyCooldown2.png");
    pbodyCooldown3=loadImage("pbodyCooldown3.png");
    pbodyCooldown4=loadImage("pbodyCooldown4.png");
    pbodyCooldown5=loadImage("pbodyCooldown5.png");
    pbodyHearts0=loadImage("pbodyHearts0.png");
    pbodyHearts1=loadImage("pbodyHearts1.png");
    pbodyHearts2=loadImage("pbodyHearts2.png");
    pbodyHearts3=loadImage("pbodyHearts3.png");
    pbodyElectricity=loadImage("pbodyElectricity.png");
    leftPbody=loadImage("leftPbody.png");
    rightPbody=loadImage("rightPbody.png");
    orangePortal=loadImage("orangePortal.png");
    redPortal=loadImage("redPortal.png");

    pbodyX=width/2+50; //initial Atlas x-coordinate is in the middle right of the x-axis
    pbodyY=height/2; //initial Atlas y-coordinate is in the middle of the y-axis
    endPbodyPortals=500;  //end time of 0.5 seconds for displaying PBody's portals
    endPbodyCooldown=5000; //end time of 5 seconds for PBody's portal cooldown
    endPbodyHit=1000; //end time of 1 second for PBody's hit duration
    pbodyAlive=true; //PBody is alive
  }

  void pbody() {
    if (pbodyAlive) { //if PBody is alive
      if (pbodyLeft==false && pbodyRight==false) //if PBody is not facing left or right
        image(leftPbody, pbodyX-45, pbodyY-10); //draw PBody facing left
      if (pbodyLeft) //if PBody is facing left
        image(leftPbody, pbodyX-45, pbodyY); //draw PBody facing left
      if (pbodyRight) //if PBody is facing right
        image(rightPbody, pbodyX, pbodyY); //draw PBody facing right
    }
  }

  void pbodyBoundaries() {
    if (pbodyX<pbodyXBoundaryL) //if PBody's x-coordinate is less than PBody's left x boundary
      pbodyX+=pbodySpeed; //PBody cannot move to the left
    if (pbodyX>width-pbodyXBoundaryR) //if PBody's x-coordinate is greater than PBody's right x boundary
      pbodyX-=pbodySpeed; //PBody cannot move to the right
    if (pbodyY<pbodyYBoundaryT) //if PBody's y-coordinate is less than PBody's top y boundary
      pbodyY+=pbodySpeed; //PBody cannot move upwards
    if (pbodyY>height-pbodyYBoundaryB) //if PBody's y-coordinate is less than PBody's bottom y boundary
      pbodyY-=pbodySpeed; //PBody cannot move downwards
  }

  void pbodyPortals() {
    if (usePbodyPortals && beginPbodyCooldown==false && pbodyAlive) { //if PBody's portals are being used, PBody's portal cooldown has not begun, and PBody is alive
      image(redPortal, pbodyX-10, pbodyY-40); //draw the red portal at PBody's coordinates
      image(orangePortal, orangePortalX-pbodyPortalWidth/2, orangePortalY-pbodyPortalHeight/2); //draw the orange portal where the right mouse button was pressed
      pbodySpeed=0; //PBody cannot move
    } else {
      pbodySpeed=5; //PBody can move at a speed of 5
    }
  }

  void pbodyPortalTimer() {
    if (beginPbodyPortals==false) { //if the timer for displaying PBody's portals has not begun
      beginPbodyPortals=true; //the timer for displaying PBody's portals has begun
      startPbodyPortals=millis(); //returns the number of milliseconds that have passed since opening the game
    }
    currentPbodyPortals=millis(); //returns the number of milliseconds that have passed since opening the game
    if (currentPbodyPortals-startPbodyPortals>endPbodyPortals && usePbodyPortals==true) { ////if the current time for displaying PBody's portals minus the start time for displaying PBody's portals is greater than the end time for displaying PBody's portals and PBody's portals are being used
      usePbodyPortals=false; //PBody's portals are not being used
      beginPbodyPortals=false; //the timer for displaying PBody's portals has not begun
      beginPbodyCooldown=true; //the timer for PBody's portal cooldown has begun
      startPbodyCooldown=millis(); //returns the number of milliseconds that have passed since opening the game
      pbodyX=orangePortalX-pbodyPortalWidth/2; //PBody's x-coordinate becomes the x-coordinate of the orange portal
      pbodyY=orangePortalY-pbodyPortalHeight/2; //PBody's y-coordinate becomes the y-coordinate of the orange portal
    }
  }

  void pbodyPortalCooldown() {
    if (beginPbodyCooldown) { //if the timer for PBody's portal cooldown has begun
      if (currentPbodyCooldown-startPbodyCooldown>endPbodyCooldown) //if the current time for PBody's portal cooldown minus the start time for PBody's portal cooldown is greater than the end time for PBody's portal cooldown
        beginPbodyCooldown=false; //the timer for PBody's portal cooldown has not begun
      if (currentPbodyCooldown-startPbodyCooldown<endPbodyCooldown) //if the current time for PBody's portal cooldown minus the start time for PBody's portal cooldown is less than the end time for PBody's portal cooldown
        usePbodyPortals=false; //PBody's portals are not being used
    }
    currentPbodyCooldown=millis(); //returns the number of milliseconds that have passed since opening the game
  }

  void pbodyCooldownBar() {
    if (beginPbodyCooldown==false || pbodyAlive==false) //if the timer for PBody's portal cooldown has not begun or PBody is not alive
      image(pbodyCooldown5, width-pbodyCooldownWidth-10, height-pbodyCooldownHeight-10); //draw a full cooldown bar in the bottom right corner
    if (beginPbodyCooldown && pbodyAlive) { //if the timer for PBody's portal cooldown has begun and PBody is alive
      if (currentPbodyCooldown-startPbodyCooldown<1000) //if the current time for PBody's portal cooldown minus the start time for PBody's portal cooldown is less than 1 second
        image(pbodyCooldown4, width-pbodyCooldownWidth-10, height-pbodyCooldownHeight-10); //draw a 4/5 full cooldown bar in the bottom right corner
      if (currentPbodyCooldown-startPbodyCooldown<2000 && currentPbodyCooldown-startPbodyCooldown>1000) //if the current time for PBody's portal cooldown minus the start time for PBody's portal cooldown is less than 2 seconds and the current time for PBody's portal cooldown minus the start time for PBody's portal cooldown is greater than 1 second
        image(pbodyCooldown3, width-pbodyCooldownWidth-10, height-pbodyCooldownHeight-10); //draw a 3/5 full cooldown bar in the bottom right corner
      if (currentPbodyCooldown-startPbodyCooldown<3000 && currentPbodyCooldown-startPbodyCooldown>2000)//if the current time for PBody's portal cooldown minus the start time for PBody's portal cooldown is less than 3 seconds and the current time for PBody's portal cooldown minus the start time for PBody's portal cooldown is greater than 2 seconds
        image(pbodyCooldown2, width-pbodyCooldownWidth-10, height-pbodyCooldownHeight-10); //draw a 2/5 full cooldown bar in the bottom right corner
      if (currentPbodyCooldown-startPbodyCooldown<4000 && currentPbodyCooldown-startPbodyCooldown>3000) //if the current time for PBody's portal cooldown minus the start time for PBody's portal cooldown is less than 4 seconds and the current time for PBody's portal cooldown minus the start time for PBody's portal cooldown is greater than 3 seconds
        image(pbodyCooldown1, width-pbodyCooldownWidth-10, height-pbodyCooldownHeight-10); //draw a 1/5 full cooldown bar in the bottom right corner
      if (currentPbodyCooldown-startPbodyCooldown<5000 && currentPbodyCooldown-startPbodyCooldown>4000) //if the current time for PBody's portal cooldown minus the start time for PBody's portal cooldown is less than 5 seconds and the current time for PBody's portal cooldown minus the start time for PBody's portal cooldown is greater than 4 seconds
        image(pbodyCooldown0, width-pbodyCooldownWidth-10, height-pbodyCooldownHeight-10); //draw an empty cooldown bar in the bottom right corner
    }
  }

  void pbodyHearts(PVector turretLocation, float turretWidth) {
    if (pbodyHit==false) { //if PBody is not being hit
      if (dist(turretLocation.x, turretLocation.y, pbodyX, pbodyY)<turretWidth/2+pbodyWidth/2) { //if a turret collides with PBody
        pbodyHit=true; //PBody is being hit
        pbodyElec=true; //display electricity surrounding PBody
        pbodyHearts--; //PBody has one less heart
      }
    }
    if (pbodyHearts==3) //if PBody has 3 hearts
      image(pbodyHearts3, width-150, height-100); //draw three hearts in the bottom right corner
    if (pbodyHearts==2) //if PBody has 2 hearts
      image(pbodyHearts2, width-150, height-100); //draw two hearts in the bottom right corner
    if (pbodyHearts==1) //if PBody has 1 hearts
      image(pbodyHearts1, width-150, height-100); //draw one hearts in the bottom right corner
    if (pbodyHearts<1) { //if PBody has less than 1 hearts
      image(pbodyHearts0, width-150, height-100); //draw zero hearts in the bottom right corner
      pbodyAlive=false; //PBody is not alive
    }
    if (pbodyElec && pbodyAlive) //if electricity is displayed surrounding PBody and PBody is alive
      image(pbodyElectricity, pbodyX-20, pbodyY+15); //draw electricity surrounding PBody
  }

  void pbodyHitTimer() {
    if (beginPbodyHit==false) { //if the timer for PBody's hit duration has not begun
      beginPbodyHit=true; //the timer for PBody's hit duration has begun
      startPbodyHit=millis(); //returns the number of milliseconds that have passed since opening the game
    }
    currentPbodyHit=millis(); //returns the number of milliseconds that have passed since opening the game
    if (currentPbodyHit-startPbodyHit>endPbodyHit) { //if the current time for PBody's hit duration minus the start time for PBody's hit duration is greater than the end time for Pbody's hit duration
      beginPbodyHit=false; //the timer for PBody's hit duration has not begun
      pbodyHit=false; //PBody is not being hit
      pbodyElec=false; //do not display electricity surrounding PBody
    }
  }

  void pbodyMove() {
    if (upPressed) //if the up arrow key is being pressed
      pbodyY-=pbodySpeed; //PBody moves upwards
    if (leftPressed) //if the left arrow key is being pressed
      pbodyX-=pbodySpeed; //PBody moves to the left
    if (downPressed) //if the down arrow key is being pressed
      pbodyY+=pbodySpeed; //PBody moves downwards
    if (rightPressed) //if the right arrow key is being pressed
      pbodyX+=pbodySpeed; //PBody moves to the right
  }

  void pbodyKeyPressed() {
    if (key==CODED) { //detects special keys
      if (keyCode==UP) //if the up arrow key is being pressed
        upPressed=true; //the up arrow key is being pressed
      if (keyCode==LEFT) { //if the left arrow key is being pressed
        leftPressed=true; //the left arrow key is being pressed
        pbodyLeft=true; //PBody is facing left
        pbodyRight=false; //PBody is not facing right
      }
      if (keyCode==DOWN) //if the down arrow key is being pressed
        downPressed=true; //the down arrow key is being pressed
      if (keyCode==RIGHT) { //if the right arrow key is being pressed
        rightPressed=true; //the right arrow key is being pressed
        pbodyRight=true; //Pbody is facing right
        pbodyLeft=false; //Pbody is not facing left
      }
    }
  }

  void pbodyKeyReleased() {
    if (key==CODED) { //detects special keys
      if (keyCode==UP) //if the up arrow key is released
        upPressed=false; //the up arrow key is not being pressed
      if (keyCode==LEFT) //if the left arrow key is released
        leftPressed=false; //the left arrow key is not being pressed
      if (keyCode==DOWN) //if the down arrow key is released
        downPressed=false; //the down arrow key is not being pressed
      if (keyCode==RIGHT) //if the right arrow key is released
        rightPressed=false; //the right arrow key is not being pressed
    }
  }

  void pbodyMousePressed() {
    if (mouseButton==RIGHT) { //if the right mouse button is pressed
      startPbodyPortals=millis(); //returns the number of milliseconds that have passed since opening the game
      if (beginPbodyCooldown==false) //if the timer for PBody's portal cooldown has not begun
        usePbodyPortals=true; //PBody's portals are being used
      orangePortalX=mouseX; //the x-coordinate of the orange portal is the x-coordinate of the mouse when it was pressed
      orangePortalY=mouseY;  //the y-coordinate of the orange portal is the y-coordinate of the mouse when it was pressed
    }
  }
}
