class Bugs {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;

  Bugs(PVector l) {
    location = l.get();
    velocity = new PVector(random(-1, 1), random(-1, 1));
    acceleration = new PVector(0, 0);
    r = 10.0;
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void run() {
    update();
    display();
    checkEdges();
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    noStroke();
    imageMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);

    if (velocity.x < 0) {
      rotate(PI);
    }

    image(fly1, 0, 0);
    popMatrix();
    imageMode(CORNER);
  }

  void badBugs() {
    noStroke();
    imageMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);

    if (velocity.x < 0) {
      rotate(PI);
    }

    image(fly2, 0, 0);
    popMatrix();
    imageMode(CORNER);
  }

  void checkEdges() {
    if (location.x > width+20) {
      location.x = -20;
    }
    else if (location.x < -20) {
      location.x = width+20;
    }

    if (location.y > height+20) {
      location.y = -20;
    }
    else if (location.y < -20) {
      location.y = height+20;
    }
  }
}

