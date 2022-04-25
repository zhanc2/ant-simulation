class Colony {
  
  int antCount;
  int storedAntsCount;
  ArrayList<Ant> wanderingAnts;
  
  PVector position;
  
  float antSpeed;
  float antStrength;
  float antUpkeepCost;
  float antVisionRadius;
  
  float storedFood;
  
  void display() {
    
  }
  
  void addAnt() {
    antCount++;
    storedAntsCount++;
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
  
}
