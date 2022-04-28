class Colony {

  int antCount;
  int storedAntsCount;
  ArrayList<Ant> wanderingAnts;
  
  ArrayList<Ant> antsToBeRemoved;

  PVector position;
  PVector[] circlePositions;

  float antSpeed;
  float antStrength;
  float antUpkeepCost;
  float antVisionRadius;

  float storedFood;
  
  float lastZoomAmount;
  
  Colony(float x, float y, float aSp, float aSt, float aUC, float aVR) {
    this.antCount = 0;
    this.storedAntsCount = 0;
    this.wanderingAnts = new ArrayList<Ant>();
    this.antsToBeRemoved = new ArrayList<Ant>();
    
    this.position = new PVector(x, y);
    this.circlePositions = new PVector[10];
    for (int i = 0; i < 10; i++) {
      this.circlePositions[i] = new PVector(random(-20, 20), random(-20, 20));
    }
    this.antSpeed = aSp;
    this.antStrength = aSt;
    this.antUpkeepCost = aUC;
    this.antVisionRadius = aVR;
    
    this.storedFood = 100;
    
    this.lastZoomAmount = 1;
  }

  void display(float camX, float camY, float camZoom) {
    //if (camZoom != this.lastZoomAmount) {
    //  this.position.x *= camZoom;
    //  this.position.y *= camZoom;
    //  this.lastZoomAmount = camZoom;
    //}
    noStroke();
    fill(77, 46, 22);
    pushMatrix();
    translate(this.position.x * camZoom - camX, this.position.y * camZoom - camY);
    for (int i = 0; i < 10; i++) {
      circle(this.circlePositions[i].x * camZoom, this.circlePositions[i].y * camZoom, 40 * camZoom);
    }
    popMatrix();
  }

  void handleAnts(float camX, float camY, float camZoom) {
    antDeaths();
    for (Ant a : this.wanderingAnts) {
      a.DrawAnt(camX, camY, camZoom);
    }
  }

  void birthAnt() {
    float ran = random(0, 10000);
    if (ran < storedFood) {
      println("new ant?");
      antCount++;
      storedAntsCount++;
    }
  }

  void emergeAnt() {
    if (storedAntsCount > 0) {
      Ant a = new Ant(this.position.x, this.position.y, this.antSpeed, this.antStrength, this.antUpkeepCost, this.antVisionRadius, this);
      wanderingAnts.add(a);
      storedAntsCount--;
      println("ant spawned?");
    }
  }

  void storeAnt(Ant a) {
    if (wanderingAnts.size() > 0) {
      wanderingAnts.remove(a);
      storedAntsCount++;
    }
  }

  void addAntToDeathList(Ant a) {
    this.antsToBeRemoved.add(a);
  }

  void antDeaths() {
    for (Ant a : this.antsToBeRemoved) {
      this.wanderingAnts.remove(a);
    }
  }
}
