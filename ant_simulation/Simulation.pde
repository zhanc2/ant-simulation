class Simulation {
  
  ArrayList<Colony> colonies;
  ArrayList<Colony> newColonies;
  ArrayList<Food> food;
  // ArrayList<Beetle> beetles;
  // ArrayList<Obstacle> obstacles;
  ArrayList<QueenAnt> queens;
  
  Camera camera;
  
  Simulation() {
    this.food = new ArrayList<Food>();
    this.queens = new ArrayList<QueenAnt>();
    
    this.camera = new Camera(5, 1.1);
    this.colonies = new ArrayList<Colony>();
    this.newColonies = new ArrayList<Colony>();
    
    Colony c = new Colony(750, 250, 3, 5, 5, 5);
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
  
}
