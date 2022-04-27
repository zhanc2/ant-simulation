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
  
  Colony(float x, float y) {
    this.position = new PVector(x, y);
    this.circlePositions = new PVector[10];
    for (int i = 0; i < 10; i++) {
      this.circlePositions[i] = new PVector(random(-20, 20), random(-20, 20));
    }
  }

  void display() {
    noStroke();
    fill(77, 46, 22);
    pushMatrix();
    translate(this.position.x, this.position.y);
    for (int i = 0; i < 10; i++) {
      circle(this.circlePositions[i].x, this.circlePositions[i].y, 40);
    }
    popMatrix();
  }

  void birthAnt() {
    float ran = random(0, 100000);
    if (ran < storedFood) {
      antCount++;
      storedAntsCount++;
    }
  }

  void emergeAnt() {
    Ant a = new Ant(this.position.x, this.position.y, this.antSpeed, this.antStrength, this.antUpkeepCost, this.antVisionRadius, this);
    wanderingAnts.add(a);
    storedAntsCount--;
  }

  void storeAnt(Ant a) {
    wanderingAnts.remove(a);
    storedAntsCount++;
  }

  void antDeath(Ant a) {
    wanderingAnts.remove(a);
    antCount--;
  }
}
