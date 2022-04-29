class Food {
  
  float weight;
  PVector position;
  HashMap<Colony, ArrayList<Ant>> currentAnts; // ants that are currently at this food
  float size;
  
  Food(float w, float x, float y) {
    position= new PVector (x,y);
    this.weight = w;
    this.currentAnts = new HashMap<Colony, ArrayList<Ant>>();
    size= this.weight;
  }
  
  void display(float camX, float camY, float camZoom) {
    fill(247,197,142);
    noStroke();
    this.size = this.weight;
    circle(this.position.x * camZoom - camX, this.position.y * camZoom - camY, size*camZoom);
  }
  
}
