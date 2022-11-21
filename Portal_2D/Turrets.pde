class Turrets {
  PImage leftTurret, rightTurret; //images of turrets facing left and right
  float turretX, turretY; //initial x and y coordinates of the turrets
  float turretWidth=50; //width of the turrets
  int[] x = {-50, 350, 850}; //array to store hard-coded initial x-coordinates for the turrets
  float turretSpeed; //speed of the turrets
  int endTurretSpeedTimer=3000; //end time to increase turret speed
  PVector turretLocation; //stores the x and y coordinates of the turrets
  PVector turretVelocity; //stores the velocity at which the turret moves towards a player
  PVector playerLocation; //stores the x and y coordinates of Atlas or PBody

  Turrets() {
    leftTurret=loadImage("leftTurret.png");
    rightTurret=loadImage("rightTurret.png");

    createTurrets(); //creates the initial x and y coordinates and speed of the turrets
    turretVelocity=new PVector(); //initial velocity of the turrets is 0
    turretLocation=new PVector(turretX, turretY); //initial location of the turrets is equal to the x and y coordinates of the turrets
  }

  void createTurrets() {
    turretX = x[int(random(x.length))]; //turret x-coordinates are randomized to equal one of the hard-coded initial x-coordinates
    turretSpeed=4; //turrets move at a speed of 4
    if (turretX==x[0] || turretX==x[2]) //if the x-coordinate of a turret is -50 or the x-coordinate of a turret is 850
      turretY=320; //the y-coordinate of the turret is 320
    if (turretX==x[1]) //if the x-coordinate of a turret is 350
      turretY=880; //the y-coordinate of the turret is 880
  }

  void turretsP1(float atlasX) {
    if (player2==false) {
      if (atlasX<turretLocation.x) //if the x-coordinate of Atlas is less than the x-coordinate of a turret
        image(leftTurret, turretLocation.x, turretLocation.y); //draw a turret facing left
      if (atlasX>turretLocation.x) //if the x-coordinate of Atlas is greater than the x-coordinate of a turret
        image(rightTurret, turretLocation.x, turretLocation.y); //draw a turret facing right
    }
  }


  void turretsP2(float atlasX, float atlasY, float pbodyX, float pbodyY) {
    if (player2) { //if there is a second player
      if (dist(turretLocation.x, turretLocation.y, atlasX, atlasY)<dist(turretLocation.x, turretLocation.y, pbodyX, pbodyY)) { //if the distance between a turret and Atlas is less than the distance between a turret and PBody
        if (p1.atlasAlive) { //if Atlas is alive
          if (atlasX<turretLocation.x) //if Atlas is to the left of a turret
            image(leftTurret, turretLocation.x, turretLocation.y); //draw a turret facing left
          if (atlasX>turretLocation.x) //if Atlas is to the right of a turret
            image(rightTurret, turretLocation.x, turretLocation.y); //draw a turret facing right
        }
        if (p1.atlasAlive==false) { //if Atlas is not alive
          if (pbodyX<turretLocation.x) //if PBody is to the left of a turret
            image(leftTurret, turretLocation.x, turretLocation.y); //draw a turret facing left
          if (pbodyX>turretLocation.x) //if PBody is to the right of a turret
            image(rightTurret, turretLocation.x, turretLocation.y); //draw a turret facing right
        }
      }
      if (dist(turretLocation.x, turretLocation.y, pbodyX, pbodyY)<dist(turretLocation.x, turretLocation.y, atlasX, atlasY)) {  //if the distance between a turret and PBody is less than the distance between a turret and Atlas
        if (p2.pbodyAlive) { //if PBody is alive
          if (pbodyX<turretLocation.x) //if PBody is to the left of a turret
            image(leftTurret, turretLocation.x, turretLocation.y); //draw a turret facing left
          if (pbodyX>turretLocation.x) //if PBody is to the right of a turret
            image(rightTurret, turretLocation.x, turretLocation.y); //draw a turret facing right
        }
        if (p2.pbodyAlive==false) { //if PBody is not alive
          if (atlasX<turretLocation.x) //if Atlas is to the left of a turret
            image(leftTurret, turretLocation.x, turretLocation.y); //draw a turret facing left
          if (atlasX>turretLocation.x) //if Atlas is to the left of a turret
            image(rightTurret, turretLocation.x, turretLocation.y); //draw a turret facaing right
        }
      }
    }
  }

  void turretSpeedIncrease() {
    println(turretSpeed);
    if (score>endTurretSpeedTimer) { //if score is greater than the end time for the turret speed timer
      endTurretSpeedTimer+=3000; //add 3 seconds to the end timer for the current speed timer
      turretSpeed+=0.1; //increase the turret speed by 0.1
    }
  }

  void turretsMove() {
    if (pause==false) //if the game is not paused
      turretLocation.add(turretVelocity); //the turrets move at a rate of turretVelocity
  }

  void turretsAdjustP1(float atlasX, float atlasY) {
    if (player2==false) { //if there is not a second player
      playerLocation=new PVector(atlasX, atlasY); //the player location is set to Atlas' x and y coordinates
      turretVelocity=PVector.sub(playerLocation, turretLocation); //the turret moves towards Atlas
      turretVelocity.normalize(); //sets the turret velocity to have a magnitude of 1
      turretVelocity.mult(turretSpeed); //sets the turret velocity to have a magnitude equal to the speed of the turrets
    }
  }

  void turretsAdjustP2(float atlasX, float atlasY, float pbodyX, float pbodyY) {
    if (player2) { //if there is a second player
      if (dist(turretLocation.x, turretLocation.y, atlasX, atlasY)<dist(turretLocation.x, turretLocation.y, pbodyX, pbodyY) && p1.atlasAlive) //if the distance between a turret and Atlas is less than the distance between a turret and PBody and Atlas is alive
        playerLocation=new PVector(atlasX, atlasY); //the player location is set to Atlas' x and y coordinates
      if (dist(turretLocation.x, turretLocation.y, atlasX, atlasY)<dist(turretLocation.x, turretLocation.y, pbodyX, pbodyY) && p1.atlasAlive==false) //if the distance between a turret and Atlas is less than the distance between a turret and PBody and Atlas is not alive
        playerLocation=new PVector(pbodyX, pbodyY); //the player location is set to PBody's x and y coordinates
      if (dist(turretLocation.x, turretLocation.y, pbodyX, pbodyY)<dist(turretLocation.x, turretLocation.y, atlasX, atlasY) && p2.pbodyAlive) //if the distance between a turret and PBody is less than the distance between a turret and Atlas and PBody is alive
        playerLocation=new PVector(pbodyX, pbodyY); //the player location is set to PBody's x and y coordinates
      if (dist(turretLocation.x, turretLocation.y, pbodyX, pbodyY)<dist(turretLocation.x, turretLocation.y, atlasX, atlasY) && p2.pbodyAlive==false) //if the distance between a turret and PBody is less than the distance between a turret and Atlas and PBody is not alive
        playerLocation=new PVector(atlasX, atlasY); //the player location is set to Atlas' x and y coordinates
      if (dist(turretLocation.x, turretLocation.y, pbodyX, pbodyY)==dist(turretLocation.x, turretLocation.y, atlasX, atlasY) && p1.atlasAlive) //if the distance between a turret and PBody is equal to the distance between a turret and Atlas and Atlas is alive
        playerLocation=new PVector(atlasX, atlasY); //the player location is set to Atlas' x and y coordinates
      if (dist(turretLocation.x, turretLocation.y, pbodyX, pbodyY)==dist(turretLocation.x, turretLocation.y, atlasX, atlasY) && p1.atlasAlive==false) //if the distance between a turret and PBody is equal to the distance between a turret and Atlas and Atlas is not alive
        playerLocation=new PVector(pbodyX, pbodyY); //the player location is set to PBody's x and y coordinates
      turretVelocity=PVector.sub(playerLocation, turretLocation); //the turret moves towards the closest player
      turretVelocity.normalize(); //sets the turret velocity to have a magnitude of 1
      turretVelocity.mult(turretSpeed); //sets the turret velocity ro have a magnitude equal to the speed of the turrets
    }
  }

  void turretCollision(Turrets [] t) {
    if (collision(t)) { //if a turret collides with another turret
      turretLocation.x = x[int(random(x.length))]; //the turret x-coordinate is reset
      if (turretX==x[0] || turretX==x[2]) //if the x-coordinate of a turret is -50 or the x-coordinate of a turret is 850
        turretY=320; //the y-coordinate of the turret is 320
      if (turretX==x[1]) //if the x-coordinate of a turret is 350
        turretY=880; //the y-coordinate of the turret is 880
    }
  }
  boolean collision(Turrets [] t) { //boolean fo if a turret collides with another turret
    for (int index=0; index<t.length; index++) {  //index variable has an initial value of 0,  must be less than the length of t array, and increases by increments of 1
      float distance = dist(turretLocation.x, turretLocation.y, t[index].turretLocation.x, t[index].turretLocation.y); //distance is equal to the distance bwtween turrets
      if (distance<turretWidth) { //if the distance bwtween turrets is less than the width of a turret
        if (distance>0.25) //if the distance between turrets is greater than 0.25
          return true;
      }
    }
    return false;
  }
}
