class Simulation {
  
  ArrayList<Colony> colonies;
  ArrayList<Colony> newColonies;
  ArrayList<Food> food;
   ArrayList<Beetle> beetles;
  // ArrayList<Obstacle> obstacles;
  ArrayList<QueenAnt> queens;
  
  Camera camera;
  
  Simulation() {
    this.food = new ArrayList<Food>();
    this.queens = new ArrayList<QueenAnt>();
    this.beetles = new ArrayList<Beetle>();
    
    this.camera = new Camera(5, 1.1, (xBoundary - width)/2, (yBoundary - height)/2);
    this.colonies = new ArrayList<Colony>();
    this.newColonies = new ArrayList<Colony>();
    
    Colony c = new Colony(1000, 500, 3, 5, 5, 5);
    this.colonies.add(c);
  }
  
  void updateCameraPos() {
    this.camera.moveFromKeys();
    this.camera.moveFromMouse();
  }
  
  void updateCameraPos(float x, float y) {
    this.camera.x = x - width/2;
    this.camera.y = y - height/2;
  }
  
  void handleColonies() {
    for (Colony colony : this.colonies) {
      colony.display(this.camera.x, this.camera.y, this.camera.zoom);
      colony.handleAnts(this.camera.x, this.camera.y, this.camera.zoom);
      colony.birthAnt();
      float r = random(0, 100);
      if (r < 10) {
        colony.emergeAnt();
      }
      Colony c = colony.handleQueens(this.camera.x, this.camera.y, this.camera.zoom, this.colonies);
      if (c != null) {
        this.newColonies.add(c);
        println("new colony?");
      }
    }
    for (Colony c : this.newColonies) {
      this.colonies.add(c);
    }
    this.newColonies.clear();
  }

  void addNewQueen(QueenAnt qa) {
    this.queens.add(qa);
  }
  
  void RandomFoodSpawning(){
    float randomNum = random(0,100);
    if(randomNum >= 99.9){
      this.food.add(new Food(random(25,50), random(0, width), random(0, height)));
    }
  }
  
  void displayFoods() {
    for (Food f : this.food) {
      f.display(this.camera.x, this.camera.y, this.camera.zoom);
    }
  }
  
  void handleBeetles() {
    randomBeetleSpawning();
    for (Beetle b : this.beetles) {
      b.display(this.camera.x, this.camera.y, this.camera.zoom);
      for (Colony c : this.colonies) {
        b.destroyAnts(c.wanderingAnts);
      }
      b.move(this.camera.zoom);
      b.turn();
    }
  }
  
  void randomBeetleSpawning() {
    float r = random(0, 100);
    if (r < 1) {
      float h = random(80, 120);
      //float xP, yP;
      //int tries = 0;
      //while (tries < 3) {
      //  xP = random(0, xBoundary);
      //  yP = random(0, yBoundary);
      //}
      Beetle b = new Beetle(random(0, xBoundary), random(0, yBoundary), random(0.5, 1.5), h, 10, h/100, random(8, 12), 50);
      this.beetles.add(b);
      println("new beetle?");
    }
  }
  
  void PassFood() {
    for(Colony c: this.colonies){
      c.PassFoodToAnt(food);
    }
  }
  
}
