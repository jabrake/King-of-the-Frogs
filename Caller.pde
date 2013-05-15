public class Caller {

  String phoneNumber;
  String label;
  String uniqueID;

  public PVector frogLocation;
  public PVector frogVelocity = new PVector(0, 0);
  private PVector tongueLocation;

  float angle;
  float amplitude = 300;
  float distance;
  float xTongue, yTongue;
  float xTT, yTT;
  float winThresh = 120;

  boolean catches = false;

  boolean tongue1 = false;
  boolean tongue2 = false;
  boolean tongue3 = false;
  boolean tongue4 = false;
  boolean tongue6 = false;
  boolean tongue7 = false;
  boolean tongue8 = false;
  boolean tongue9 = false;

  boolean catching = false;

  int imageIndex = 0;

  public Caller(String uniqueID, String phoneNumber, String callerLabel) {

    int startX = frogCounter*120;
    int startY = (height-130);
    frogLocation = new PVector(startX, startY);
    tongueLocation = new PVector(frogLocation.x+60, frogLocation.y+47);
    this.uniqueID = uniqueID;
    this.phoneNumber = phoneNumber;
    this.label = callerLabel;

    imageIndex = int(random(0, frog.length));
  }


  void display() {

    image(frog[imageIndex], frogLocation.x, frogLocation.y);
    fill(0, 51, 51, 200);
    rect(frogLocation.x+10, height-30, 100, 30);
    fill(255);
    textFont(UserDigits, 14);
    text(label, frogLocation.x+20, height-10);
    strokeWeight(6);
    stroke(33, 66, 33);
    line(frogLocation.x+60, height-30, frogLocation.x+60, frogLocation.y+105);
    noStroke();
  }

  //Functions to move up and down based on what fly is eaten
  void moveUp() {
    frogLocation.y -= 30;
    tongueLocation.y -= 30;
  }

  void moveDown() {
    frogLocation.y += 30;
    tongueLocation.y += 30;
  }
  
  //Boolean to determine who wins
  boolean winner() {
    if (frogLocation.y < winThresh) {
      return true;
    } 
    else {
      return false;
    }
  }
  
  //Function to control tongue direction for all callers
  void tongue() {

    if (tongue1) {
      noStroke();
      fill(155, 0, 0);
      image(mouth, frogLocation.x, frogLocation.y);

      yTongue = map(sin(angle), -1, 1, 0, amplitude);
      angle += 0.1;
      if (angle >= radians(300)) {
        tongue1 = false;
        angle = 0;
        catching = false;
      }

      pushMatrix();
      translate(tongueLocation.x, tongueLocation.y);
      rotate(radians(-45));
      arc(0, 0, 7, yTongue, radians(180), radians(360), CHORD);
      popMatrix();
    }

    if (tongue2) {
      noStroke();
      fill(155, 0, 0);
      image(mouth, frogLocation.x, frogLocation.y);

      yTongue = map(sin(angle), -1, 1, 0, amplitude);
      angle += 0.1;
      if (angle >= radians(300)) {
        tongue2 = false;
        angle = 0;
        catching = false;
      }

      arc(tongueLocation.x, tongueLocation.y, 7, yTongue, radians(180), radians(360), CHORD);
    }

    if (tongue3) {
      noStroke();
      fill(155, 0, 0);
      image(mouth, frogLocation.x, frogLocation.y);

      yTongue = map(sin(angle), -1, 1, 0, amplitude);
      angle += 0.1;
      if (angle >= radians(300)) {
        tongue3 = false;
        angle = 0;
        catching = false;
      }

      pushMatrix();
      translate(tongueLocation.x, tongueLocation.y);
      rotate(radians(45));
      arc(0, 0, 7, yTongue, radians(180), radians(360), CHORD);
      popMatrix();
    }

    if (tongue4) {
      noStroke();
      fill(155, 0, 0);
      image(mouth, frogLocation.x, frogLocation.y);

      xTongue = map(sin(angle), -1, 1, 0, amplitude);
      angle += 0.1;
      if (angle >= radians(300)) {
        tongue4 = false;
        angle = 0;
        catching = false;
      }

      arc(tongueLocation.x, tongueLocation.y, xTongue, 7, radians(90), radians(270), CHORD);
    }

    if (tongue6) {
      noStroke();
      fill(155, 0, 0);
      image(mouth, frogLocation.x, frogLocation.y);

      xTongue = map(sin(angle), -1, 1, 0, amplitude);
      angle += 0.1;
      if (angle >= radians(300)) {
        tongue6 = false;
        angle = 0;
        catching = false;
      }
      arc(tongueLocation.x, tongueLocation.y, xTongue, 7, radians(270), radians(450), CHORD);
    }

    if (tongue7) {
      noStroke();
      fill(155, 0, 0);
      image(mouth, frogLocation.x, frogLocation.y);

      yTongue = map(sin(angle), -1, 1, 0, amplitude);
      angle += 0.1;
      if (angle >= radians(300)) {
        tongue7 = false;
        angle = 0;
        catching = false;
      }

      pushMatrix();
      translate(tongueLocation.x, tongueLocation.y);
      rotate(radians(45));
      arc(0, 0, 7, yTongue, radians(0), radians(180), CHORD);

      popMatrix();
    }

    if (tongue8) {
      noStroke();
      fill(155, 0, 0);
      image(mouth, frogLocation.x, frogLocation.y);

      yTongue = map(sin(angle), -1, 1, 0, amplitude);
      angle += 0.1;
      if (angle >= radians(300)) {
        tongue8 = false;
        angle = 0;
        catching = false;
      }
      arc(tongueLocation.x, tongueLocation.y, 7, yTongue, radians(0), radians(180), CHORD);
    }


    if (tongue9) {
      noStroke();
      fill(155, 0, 0);
      image(mouth, frogLocation.x, frogLocation.y);

      yTongue = map(sin(angle), -1, 1, 0, amplitude);
      angle += 0.1;
      if (angle >= radians(300)) {
        tongue9 = false;
        angle = 0;
        catching = false;
      }

      pushMatrix();
      translate(tongueLocation.x, tongueLocation.y);
      rotate(radians(-45));
      arc(0, 0, 7, yTongue, radians(0), radians(180), CHORD);
      popMatrix();
    }
  }
  
  //Boolean to determine if a fly is eaten or not
  boolean catches (float locX, float locY) {
    if (tongue1) {
      xTT =  tongueLocation.x + sin(radians(-135))*yTongue/2;//tongueLocation.x/2 + xTongue/2;
      yTT =  tongueLocation.y + cos(radians(-135))*yTongue/2;//tongueLocation.y - yTongue/2;
    }

    else if (tongue3) {
      xTT =  tongueLocation.x + cos(radians(-45))*yTongue/2;//tongueLocation.x/2 + xTongue/2;
      yTT =  tongueLocation.y + sin(radians(-45))*yTongue/2;//tongueLocation.y - yTongue/2;
    }

    else  if (tongue2 || tongue4) {
      xTT = tongueLocation.x - xTongue/2;
      yTT = tongueLocation.y - yTongue/2;
    }

    else if (tongue6 || tongue8) {
      xTT = tongueLocation.x + xTongue/2;
      yTT = tongueLocation.y + yTongue/2;
    }

    else  if (tongue7) {
      xTT =  tongueLocation.x + sin(radians(-45))*yTongue/2;//tongueLocation.x/2 + xTongue/2;
      yTT =  tongueLocation.y + cos(radians(-45))*yTongue/2;//tongueLocation.y - yTongue/2;
    }

    else if (tongue9) {
      xTT =  tongueLocation.x + cos(radians(45))*yTongue/2;//tongueLocation.x/2 + xTongue/2;
      yTT =  tongueLocation.y + sin(radians(45))*yTongue/2;//tongueLocation.y - yTongue/2;
    }
    if (!catching) {
      return false;
    }

    //Tongue origin location (red)
    // fill(255, 0, 0);
    // ellipse(tongueLocation.x, tongueLocation.y, 10, 10);

    //Tongue tip location (green)
    // fill(0, 255, 0);
    // ellipse(xTT, yTT, 10, 10);

    //Bug location (blue)
    //  fill(0, 0, 255);
    //  ellipse(locX, locY, 10, 10);

    //Distance for collision detection
    distance = dist(xTT, yTT, locX, locY);
    if (distance < 25) {
      return true;
    }
    else {
      return false;
    }
  }
  
  //Key presses to trigger tongue direction and sound effects
  public void newKeypress(String keypress) {

    char keychar = keypress.charAt(0);

    if (!someoneWon) {
      if (!gameDefault) {

        switch(keychar) {

        case '1':
          tongue1 = true;
          catching = true;
          slurp.play();
          slurp.rewind();
          break;

        case '2':
          tongue2 = true;
          catching = true;
          slurp.play();
          slurp.rewind();
          break;

        case '3':
          tongue3 = true;
          catching = true;
          slurp.play();
          slurp.rewind();
          break;

        case '4':
          tongue4 = true;
          catching = true;
          slurp.play();
          slurp.rewind();
          break;

        case '6':
          tongue6 = true;
          catching = true;
          slurp.play();
          slurp.rewind();
          break;

        case '7':
          tongue7 = true;
          catching = true;
          slurp.play();
          slurp.rewind();
          break;

        case '8':
          tongue8 = true;
          catching = true;
          slurp.play();
          slurp.rewind();
          break;

        case '9':
          tongue9 = true;
          catching = true;
          slurp.play();
          slurp.rewind();
          break;
        }
      }
    }
  }

  public boolean isCaller(String checkID) {
    return uniqueID.equals(checkID);
  }
}

