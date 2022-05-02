class Colony {

  int antCount;
  int storedAntsCount;
  ArrayList<Ant> wanderingAnts;
  ArrayList<QueenAnt> queenAnts;
  
  ArrayList<Ant> antsToBeRemoved;
  ArrayList<QueenAnt> queenAntsToBeRemoved;

  PVector position;
  PVector[] circlePositions;

  float antSpeed;
  float antStrength;
  float antUpkeepCost;
  float antVisionRadius;

  float storedFood;
  
  float lastZoomAmount;
  
  float size;
  
  color c;
  
  Colony(float x, float y, float aSp, float aSt, float aUC, float aVR) {
    this.antCount = 0;
    this.storedAntsCount = 0;
    this.wanderingAnts = new ArrayList<Ant>();
    this.antsToBeRemoved = new ArrayList<Ant>();
    this.queenAnts = new ArrayList<QueenAnt>();
    this.queenAntsToBeRemoved = new ArrayList<QueenAnt>();
    
    this.position = new PVector(x, y);
    this.circlePositions = new PVector[10];
    for (int i = 0; i < 10; i++) {
      this.circlePositions[i] = new PVector(random(-20, 20), random(-20, 20));
    }
    this.antSpeed = aSp;
    this.antStrength = aSt;
    this.antUpkeepCost = aUC;
    this.antVisionRadius = aVR;
    
    this.storedFood = 500;
    
    this.lastZoomAmount = 1;
    this.size = 1;
    
    this.c = color(random(175, 255), random(175, 255), random(175, 255));
  }

  void display(float camX, float camY, float camZoom) {
    if (this.size <= 35) {
      this.size = min(this.size + 0.5*simulationSpeed, 35);
    }
    
    noStroke();
    pushMatrix();
    translate(this.position.x * camZoom - camX, this.position.y * camZoom - camY);
    fill(15, 138, 20);
    for (int i = 0; i < 10; i++) {
      circle(this.circlePositions[i].x * camZoom, this.circlePositions[i].y * camZoom, (this.size + 17) * camZoom);
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
  
  Colony handleQueens(float camX, float camY, float camZoom, ArrayList<Colony> colonies) {
    for (QueenAnt qa : this.queenAnts) {
      qa.DrawAnt(camX,camY,camZoom);
      if (qa.timeSinceLastCheck > frameRate * 3f/simulationSpeed) {
        if (qa.checkIfGoodSpot(colonies)) {
          Colony c = new Colony(qa.PosX, qa.PosY, qa.speed, qa.strength, qa.upkeepCost, qa.visionRadius);
          this.queenAntsToBeRemoved.add(qa);
          return c;
        } else {
          qa.timeSinceLastCheck = 0;
        }
      }
      qa.timeSinceLastCheck++;
    }
    return null;
  }

  void birthAnt(float spawnRate) {
    float ran = random(0, 10000f/simulationSpeed);
    if (ran < storedFood) {
      if (ran < storedFood/spawnRate) {
        println("queen ant?");
        float speedChange = random(-1.5, 1.5);
        float strengthChange = random(-1.5, 1.5);
        QueenAnt qa = new QueenAnt(this.position.x, this.position.y, this.antSpeed + speedChange, this.antStrength + strengthChange, this.antUpkeepCost - speedChange, this.antVisionRadius - strengthChange, this);
        this.queenAnts.add(qa);
        return;
      }
      //println("new ant?");
      antCount++;
      storedAntsCount++;
      storedFood -= 10;
    }
  }

  void emergeAnt() {
    if (storedAntsCount > 0) {
      Ant a = new Ant(this.position.x, this.position.y, this.antSpeed, this.antStrength, this.antUpkeepCost, this.antVisionRadius, this, this.c);
      wanderingAnts.add(a);
      storedAntsCount--;
      //println("ant spawned?");
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
    for (QueenAnt qa : this.queenAntsToBeRemoved) {
      this.queenAnts.remove(qa);
    }
    this.antsToBeRemoved.clear();
    this.queenAntsToBeRemoved.clear();
  }
  
  void PassFoodToAnt(ArrayList food) {
    for(Ant a: this.wanderingAnts){
      a.KnowFood(food);
    }
  }
}
