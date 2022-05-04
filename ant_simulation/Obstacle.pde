class Obstacle {
  
  float weight;
  PVector position;
  float size;
  
  Obstacle(float q, float r, float s) {
    position= new PVector (r,s);
    this.weight = q;
    size= this.weight;
  }
  
  void display(float camX, float camY, float camZoom) {
    fill(260,497,152);
    noStroke();
    this.size = this.weight;
    arc(this.position.x * camZoom - camX, this.position.y * camZoom - camY, size*camZoom,size,PI+QUARTER_PI, CHORD);
  }
}
