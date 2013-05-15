public class Crown {

  public PVector crownLocation;
  public PVector crownVelocity;

  public Crown() {

    crownLocation = new PVector(width/2, 50);
    crownVelocity  = new PVector(4, 0);
  }

  void run() {

    moving();
    checkEdges();
  }

  void moving() {

    //Float until winner is determined
    crownLocation.add(crownVelocity);
    image(flyingCrown, crownLocation.x, crownLocation.y);
  }

  void detectWinner (PVector winLoc) {

    //Go to location of winner
    image(flyingCrown, winLoc.x+20, 10);
    image(bubble, winLoc.x+130, 10);
    imageMode(CENTER);
    image(winMsg, width/2, height/2);
    imageMode(CORNER);
  }

  void checkEdges() {

    if (crownLocation.x > width-200) {
      crownVelocity.x -= 2;
    } 
    else if (crownLocation.x< 110) {
      crownVelocity.x += 2;
    }
  }
}

