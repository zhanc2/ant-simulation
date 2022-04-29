class Simulation {
  
  ArrayList<Colony> colonies;
  ArrayList<Food> food;
  // ArrayList<Beetle> beetles;
  // ArrayList<Obstacle> obstacles;
  
  Camera camera;
  
  Simulation() {
    this.food = new ArrayList<Food>();
    
    this.camera = new Camera(5, 1.1);
    this.colonies = new ArrayList<Colony>();
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
    }
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
