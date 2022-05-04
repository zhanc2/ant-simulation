class Food {
  
  float weight;
  PVector position;
  float size;
  
  Food(float w, float x, float y) {
    position= new PVector (x,y);
    this.weight = w;
    size= this.weight;
  }
  
  void display(float camX, float camY, float camZoom) {
    fill(247,197,142);
    noStroke();
    this.size = this.weight;
    circle(this.position.x * camZoom - camX, this.position.y * camZoom - camY, size*camZoom);
  }
  
  void reduceSize(float amount) {
    this.weight -= amount;
  }
  
}
