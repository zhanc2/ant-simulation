class Simulation {
  
  ArrayList<Colony> colonies;
  ArrayList<Colony> newColonies;
  ArrayList<Colony> coloniesToBeRemoved;
  ArrayList<Food> food;
  ArrayList<Beetle> beetles;
  ArrayList<Beetle> beetlesToBeRemoved;
  // ArrayList<Obstacle> obstacles;
  ArrayList<QueenAnt> queens;
  
  float foodSpawnRate;
  float queenSpawnRate;
  float beetleSpawnRate;
  
  Camera camera;
  
  Simulation() {
    this.food = new ArrayList<Food>();
    this.queens = new ArrayList<QueenAnt>();
    this.beetles = new ArrayList<Beetle>();
    this.beetlesToBeRemoved = new ArrayList<Beetle>();
    
    this.camera = new Camera(5, 1.1, (xBoundary - width)/2, (yBoundary - height)/2);
    
    this.colonies = new ArrayList<Colony>();
    this.newColonies = new ArrayList<Colony>();
    this.coloniesToBeRemoved = new ArrayList<Colony>();
    
    Colony c = new Colony(1000, 500, 3, 7, 1, 100);
    this.colonies.add(c);
    
    if (startingColonyAmount > 1) {
      for (int i = 1; i < startingColonyAmount; i++) {
        Colony co = new Colony(random(0, xBoundary), random(0, yBoundary), 3, 7, 5, 100);
        this.colonies.add(co);
      }
    }
    
    this.foodSpawnRate = 0.4 * foodSpawnRateSlider.getValueF();
    this.queenSpawnRate = (5 - queenSpawnRateSlider.getValueF())*15 + 90;
    this.beetleSpawnRate = 0.1 * beetleSpawnRateSlider.getValueF();
  }
  
  void run() {
    background(0);
    fill(23, 191, 29);
    noStroke();
    // this rectangle serves as the terrain that everything takes place on
    rect(-this.camera.x, -this.camera.y, 2*width*this.camera.zoom, 2*height*this.camera.zoom); 
    this.updateCameraPos();
    this.PassFood();
    this.handleColonies();
    this.RandomFoodSpawning();
    this.displayFoods();
    this.handleBeetles();
  }
  
  void updateCameraPos() {
    this.camera.moveFromKeys();
    this.camera.moveFromMouse();
  }
  
  void handleColonies() {
    for (Colony colony : this.colonies) {
      if (colony.dead) this.coloniesToBeRemoved.add(colony);
      else {
        colony.display(this.camera.x, this.camera.y, this.camera.zoom);
        colony.handleAnts(this.camera.x, this.camera.y, this.camera.zoom);
        colony.birthAnt(this.queenSpawnRate);
        float r = random(0, 100);
        if (r < 10) {
          colony.emergeAnt();
        }
        Colony c = colony.handleQueens(this.camera.x, this.camera.y, this.camera.zoom, this.colonies);
        if (c != null) {
          this.newColonies.add(c);
        }
        if (colony.inNeedOfAnts()) colony.emergeAnt();
      }
    }
    for (Colony c : this.newColonies) {
      this.colonies.add(c);
    }
    this.newColonies.clear();
    for (Colony c : this.coloniesToBeRemoved) {
      this.colonies.remove(c);
    }
    this.coloniesToBeRemoved.clear();
  }

  void addNewQueen(QueenAnt qa) {
    this.queens.add(qa);
  }
  
  void RandomFoodSpawning(){
    float randomNum = random(0,100f/simulationSpeed);
    if(randomNum < this.foodSpawnRate){
      // This is so that food doesn't spawn too close to a colony.
      // If after 5 tries a suitable position still isn't found, food isn't spawned.
      int tries = 0;
      float x, y;
      while (tries < 5) {
        x = random(0, xBoundary);
        y = random(0, yBoundary);
        for (Colony c: this.colonies) {
          if (pow((x-c.position.x), 2) + pow((y-c.position.y), 2) > 900) {
            this.food.add(new Food(random(25,50), x, y));
            return;
          }
        }
        tries++;
      }
    }
  }
  
  void displayFoods() {
    for (Food f : this.food) {
      f.display(this.camera.x, this.camera.y, this.camera.zoom);
    }
  }
  
  void handleBeetles() {
    randomBeetleSpawning();
    
    for (Beetle b : this.beetlesToBeRemoved) {
      this.beetles.remove(b);
    }
    this.beetlesToBeRemoved.clear();
    
    for (Beetle b : this.beetles) {
      b.display(this.camera.x, this.camera.y, this.camera.zoom);
      b.age();
      for (Colony c : this.colonies) {
        b.destroyAnts(c.wanderingAnts);
      }
      b.move(this.camera.zoom);
      b.turn();
    }
  }
  
  void randomBeetleSpawning() {
    float r = random(0, 100f/simulationSpeed);
    if (r < this.beetleSpawnRate) {
      float h = random(80, 120);
      Beetle b = new Beetle(random(0, xBoundary), random(0, yBoundary), random(0.5, 1.5), h, 10, h/100, random(8, 12), 50);
      this.beetles.add(b);
    }
  }
  
  void PassFood() {
    for(Colony c: this.colonies){
      c.PassFoodToAnt(this.food);
    }
  }
  
}
