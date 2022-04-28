class Colony {

  int antCount;
  int storedAntsCount;
  ArrayList<Ant> wanderingAnts;

  PVector position;
  PVector[] circlePositions;

  float antSpeed;
  float antStrength;
  float antUpkeepCost;
  float antVisionRadius;

  float storedFood;
  
  Colony(float x, float y, float aSp, float aSt, float aUC, float aVR) {
    this.antCount = 0;
    this.storedAntsCount = 0;
    this.wanderingAnts = new ArrayList<Ant>();
    
    
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
  }

  void display(float camX, float camY, float camZoom) {
    noStroke();
    fill(77, 46, 22);
    pushMatrix();
    translate(this.position.x - camX, this.position.y - camY);
    for (int i = 0; i < 10; i++) {
      circle(this.circlePositions[i].x * camZoom, this.circlePositions[i].y * camZoom, 40 * camZoom);
    }
    popMatrix();
  }

  void handleAnts(float camX, float camY, float camZoom) {
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

  void antDeath(Ant a) {
    if (wanderingAnts.size() > 0) {
      wanderingAnts.remove(a);
      antCount--;
    }
  }
}
