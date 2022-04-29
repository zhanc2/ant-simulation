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
  
  float size;
  
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
    this.size = 1;
  }

  void display(float camX, float camY, float camZoom) {
    if (this.size <= 40) {
      this.size = min(this.size + 0.5, 40);
    }
    
    noStroke();
    pushMatrix();
    translate(this.position.x * camZoom - camX, this.position.y * camZoom - camY);
    fill(15, 138, 20);
    for (int i = 0; i < 10; i++) {
      circle(this.circlePositions[i].x * camZoom, this.circlePositions[i].y * camZoom, this.size + 17 * camZoom);
    }
    fill(77, 46, 22);
    for (int i = 0; i < 10; i++) {
      circle(this.circlePositions[i].x * camZoom, this.circlePositions[i].y * camZoom, this.size * camZoom);
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
      storedFood -= 10;
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
