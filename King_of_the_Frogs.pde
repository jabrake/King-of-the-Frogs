import com.itpredial.tinyphone.client.*;
import ddf.minim.*;

PImage[] frog = new PImage[7];
PImage background;
PImage mouth;
PImage flyingCrown;
PImage bubble;
PImage fly1;
PImage fly2;
PImage start;
PImage start2;
PImage winMsg;

ArrayList<Caller> callers = new ArrayList<Caller>();
ArrayList<Bugs> bugs;
ArrayList<Bugs> badBugs;
ArrayList<BackFlies> backflies;
Crown crown;

Minim minim;
AudioPlayer swamp;
AudioPlayer ribbit;
AudioPlayer slurp;
AudioPlayer winribbit;

PFont CallNumber;
PFont UserDigits;
PFont winFont;

boolean swampPlayed;
boolean gameDefault = true;
boolean someoneWon = false; 

int frogCounter = 1;
int frogWinner;
int bugCounter, badBugCounter, bugsAdd, badBugsAdd;
float timeCounter, timePassed;

//Tinyphone client information
String host = "166.78.150.142";
int port = 12002;
String phoneNumber = "1(253)243-3322";
TinyphoneClient tp;

void setup() {

  size(1300, 850);

  minim = new Minim(this);
  swamp = minim.loadFile("swamp.wav");
  ribbit = minim.loadFile("ribbit.wav");
  slurp = minim.loadFile("slurp.wav");
  winribbit = minim.loadFile("winribbit.wav");

  crown = new Crown();

  background = loadImage("lake.jpg");

  //Cycle through frog images for each new caller
  for (int i = 0; i< frog.length; i++) {
    frog[i] = loadImage("frog" + i + ".png" );
  }

  mouth = loadImage("mouth.png");
  flyingCrown = loadImage("crown.png");
  bubble = loadImage("bubble.png");
  fly1 = loadImage("fly.png");
  fly2 = loadImage("fly2.png");
  start = loadImage("start.jpg");
  start2 = loadImage("start2.jpg");
  winMsg = loadImage("winMsg.png");

  CallNumber = loadFont("HelveticaNeue-Bold-30.vlw");
  UserDigits = loadFont("HelveticaNeue-14.vlw");
  winFont = loadFont("HelveticaCY-Bold-60.vlw");

  smooth();
  noStroke();
  tp = new TinyphoneClient(this, host, port, phoneNumber);
  tp.start();

  //Initialize bug arrays
  bugs = new ArrayList<Bugs>(); // Create an empty ArrayList
  for (int i =0 ; i < 150; i++) {
    bugs.add(new Bugs(new PVector(random(width), random(height))));
  }
  badBugs = new ArrayList<Bugs>(); // Create an empty ArrayList
  for (int i =0 ; i < 40; i++) {
    badBugs.add(new Bugs(new PVector(random(width), random(height))));
  }
  backflies = new ArrayList<BackFlies>(); // Create an empty ArrayList
  for (int i =0 ; i < 100; i++) {
    backflies.add(new BackFlies(new PVector(random(width), random(height))));
  }
}

void draw() {
  image(background, 0, 0);

  //Variables to keep track of bugs so they can be re-added when new game begins
  bugCounter = bugs.size();
  badBugCounter = badBugs.size();
  bugsAdd = 80 - bugCounter;
  badBugsAdd = 20 - badBugCounter;

  //Timer + boolean for background audio playback
  timePassed = millis() - timeCounter;

  //Control flow for background sound effect
  if (!swampPlayed) {
    swamp.play();
    timeCounter = millis();
    swampPlayed = true;
  }
  if (timePassed > 37000) {
    swamp.rewind();
    swampPlayed = false;
  }

  //Run all flies
  for (Bugs b : bugs) {
    b.run();
  }
  for (Bugs b : badBugs) {
    b.run();
    b.badBugs();
  }
  for (BackFlies b : backflies) {
    b.run();
    b.separate(backflies);
  }

  //Run crown while there is no winner
  if (!someoneWon) {
    crown.run();
  }

  //Apply game mechanics (catching good/bad flies and win state) for all callers
  synchronized(callers) {
    for (int i = 0; i < callers.size(); i++) {
      Caller c = callers.get(i);
      c.display();
      c.tongue();
      if (c.winner()) {
        frogWinner = i;
        someoneWon = true;
      }

      for (int j = 0; j < bugs.size(); j++) {
        Bugs b = (Bugs) bugs.get(j);
        if (c.catches(b.location.x, b.location.y)) {
          bugs.remove(j);
          bugCounter--;
          c.moveUp();
        }
      }

      for (int j = 0; j < badBugs.size(); j++) {
        Bugs b = (Bugs) badBugs.get(j);
        if (c.catches(b.location.x, b.location.y)) {
          badBugs.remove(j);
          badBugCounter--;
          c.moveDown();
        }
      }
    }
  }

  //  if (frogCounter < 2) {
  //    gameDefault = true;
  //  }
  //  else {
  //    gameDefault = false;
  //    noStroke();
  //  }

  //Start game when space bar is pressed
  if (keyPressed) {
    if (key == ' ') {
      gameDefault = false;
      noStroke();
    }
  }

  //Switch to true when no players in game
  if (frogCounter == 1) {
    gameDefault = true;
  }

  //Game default mode with instructions when game isn't being played
  if (gameDefault) {
    noStroke();
    fill(0, 200);
    rectMode(CORNER);
    rect(0, 0, width, height);
    imageMode(CENTER);
    //image(start, width/2, height/2);
    image(start2, width/2, height/2);
    imageMode(CORNER);

    winribbit.pause();
    winribbit.rewind();
    someoneWon = false;
  }
  
  //Detect winner for all callers
  for (int i = 0; i < callers.size(); i++) {
    Caller c = callers.get(frogWinner);
    if (someoneWon) {
      crown.detectWinner(c.frogLocation);
    }
  }
  
  //If someone wins, play sound effect and re-add bugs that were eaten
  if (someoneWon) {

    winribbit.play();

    for (int i = 0; i < bugsAdd; i++) {
      bugs.add(new Bugs(new PVector(random(width), random(height))));
    }
    for (int i = 0; i < badBugsAdd; i++) {
      badBugs.add(new Bugs(new PVector(random(width), random(height))));
    }
  }
}

//Code executed when new caller is added to game
public void newCallerEvent(TinyphoneEvent event) {
  Caller caller = new Caller(event.getId(), event.getCallerNumber(), event.getCallerLabel());
  synchronized(callers) {
    callers.add(caller);
    frogCounter++;
    ribbit.play();
    ribbit.rewind();
  }
}

//Get caller keypresses
public void keypressEvent(TinyphoneEvent event) {
  synchronized(callers) {
    Caller caller = getCaller(event.getId());
    if (caller != null) {
      caller.newKeypress(event.getValue());
    }
  }
}

Caller getCaller(String id) {
  for (int i = 0; i < callers.size(); i++) {
    Caller caller = callers.get(i);
    if (caller.isCaller(id)) {
      return caller;
    }
  }
  return null;
}

//Code executed when callers hang upf
public void hangupEvent(TinyphoneEvent event) {
  synchronized(callers) {
    for (int i = 0; i < callers.size(); i++) {
      Caller caller = callers.get(i);
      if (caller.isCaller(event.getId())) {
        callers.remove(i);
        frogCounter--;
        break;
      }
    }
  }
}

