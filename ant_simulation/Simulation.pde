class Simulation {
  
  ArrayList<Colony> colonies;
  ArrayList<Food> food;
  // ArrayList<Beetle> beetles;
  // ArrayList<Obstacle> obstacles;
  
  Camera camera;
  
  Simulation() {
    this.camera = new Camera(5, 1.1);
  }
  
  void updateCameraPos() {
    this.camera.moveFromKeys();
    this.camera.moveFromMouse();
  }
  
  void updateCameraPos(float x, float y) {
    this.camera.x = x - width/2;
    this.camera.y = y - height/2;
  }
  
}
