class Food {
  
  float weight;
  PVector position;
  HashMap<Colony, ArrayList<Ant>> currentAnts; // ants that are currently at this food
  
  
  Food(float w, float x, float y) {
    this.weight = w;
    this.position.x = x;
    this.position.y = y;
    this.currentAnts = new HashMap<Colony, ArrayList<Ant>>();
  }
  
  void display() {
    
  }
  
}
