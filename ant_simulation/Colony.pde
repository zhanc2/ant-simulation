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
  
  boolean dying;
  boolean dead;
  
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
    
    this.storedFood = 200;
    
    this.lastZoomAmount = 1;
    this.size = 1;
    
    this.c = color(random(105, 255), random(105, 255), random(105, 255));
    
    this.dying = false;
    this.dead = false;
  }

  void display(float camX, float camY, float camZoom) {
    death();
    // This makes the colony grow when first formed and shrink on death
    if (this.dying) {
      if (this.size > 0) this.size = max(this.size - 0.5*simulationSpeed, 0);
      else this.dead = true;
    } else if (this.size <= 35) this.size = min(this.size + 0.5*simulationSpeed, 35);
    
    noStroke();
    pushMatrix();
    translate(this.position.x * camZoom - camX, this.position.y * camZoom - camY);
    // the colony is made up of 10 randomized circles
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
  
  /*
  Queen ants will check to see if their current position is far enough from other colonies every 6 seconds.
  If it is satisfactory, it will return a new colony there and disappear.
  */
  
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

  /*
  The spawn rate is based on how much food is stored
  At first, the ant is stored and doesn't exist, only when it emerges does it become an actual Ant object.
  Another random check will spawn a queen ant with slightly randomized stats
  */
  void birthAnt(float spawnRate) {
    float ran = random(0, 10000f/simulationSpeed);
    if (ran < storedFood) {
      if (ran < storedFood/spawnRate) {
        float speedChange = random(-1.5, 1.5);
        float strengthChange = random(-1.5, 1.5);
        QueenAnt qa = new QueenAnt(this.position.x, this.position.y, this.antSpeed + speedChange, this.antStrength + strengthChange, this.antUpkeepCost - speedChange/2, this.antVisionRadius - strengthChange*10, this);
        this.queenAnts.add(qa);
        return;
      }
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
    }
  }

  void addAntToDeathList(Ant a) {
    this.antsToBeRemoved.add(a);
  }

  // You can't edit an ArrayList while iterating through it, so a separate list needs to be kept track of.
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
  
  void PassFoodToAnt(ArrayList<Food> food) {
    for(Ant a: this.wanderingAnts){
      a.KnowFood(food);
    }
  }
  
  void depositFood(float amount) {
    this.storedFood += amount;
  }
  
  void death() {
    if (storedFood <= 20 && this.wanderingAnts.size() < 3) this.dying = true;
  }
  
  boolean inNeedOfAnts() {
    return this.wanderingAnts.size() < 3;
  }
}
