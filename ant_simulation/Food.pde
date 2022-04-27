class Food {
  
  float weight;
  PVector position;
  HashMap<Colony, ArrayList<Ant>> currentAnts; // ants that are currently at this food
  float size;
  
  Food(float w, float x, float y) {
    position= new PVector (x,y);
    this.weight = w;
    this.currentAnts = new HashMap<Colony, ArrayList<Ant>>();
    size= this.weight+4;
  }
  
  void display() {
    fill(247,197,142);
    circle(this.position.x,this.position.y,size);
  }
  
}
