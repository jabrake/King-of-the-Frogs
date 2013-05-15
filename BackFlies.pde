class BackFlies {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxspeed;
  float maxforce;
  float r;
  
  BackFlies(PVector l) {
    location = l.get();
    velocity = new PVector(random(-1, 1), random(-1, 1));
    acceleration = new PVector(0, 0);
    r = 10.0;
    maxspeed = 4;
    maxforce = 0.1;
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
    velocity.limit(maxspeed);
    acceleration.mult(0);
  }

  void display() {
    pushMatrix();
    translate(location.x, location.y);
    fill(0);
    ellipse(0, 0, 3, 3);
    popMatrix();
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

  void separate (ArrayList<BackFlies> backflies) {
    float desiredSeparation = 20;
    PVector sum = new PVector();
    int count = 0;

    for (BackFlies other : backflies) {
      float d = PVector.dist(location, other.location);

      if ((d > 0) && (d < desiredSeparation)) {
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);
        sum.add(diff);
        count++;
      }
    }

    if (count > 0) {
      sum.div(count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }
}
