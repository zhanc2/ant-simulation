class Food {
  
  float weight;
  PVector position;
  HashMap<Colony, ArrayList<Ant>> currentAnts; // ants that are currently at this food
  
  
  Food(float w, float x, float y) {
    this.weight = w;
    position.x = x;
    position.y = y;
    currentAnts = new HashMap<Colony, ArrayList<Ant>>();
  }
  
  void display() {
    
  }
  
}
