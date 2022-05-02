class QueenAnt extends Ant {
  
  float satisfactoryDistance;
  
  float timeSinceLastCheck = 0;
  
  QueenAnt(float X, float Y, float Sp, float St, float Up, float Vi, Colony Mine) {
    super(X, Y, Sp, St, Up, Vi, Mine, color(0));
    this.satisfactoryDistance = 500;
    this.visionRadius = Vi;
    this.type = "queen";
  }
 
  void DrawAnt(float camX, float camY, float camZoom){
    pushMatrix();
    translate(PosX * camZoom - camX, PosY * camZoom - camY);
    Wandering();
    rotate(radians(getRotation()));
    this.MoveAnt(camZoom);
    stroke(0);
    fill(255);
    triangle(-4*camZoom, 6*camZoom, 0, -6*camZoom, 4*camZoom, 6*camZoom);
    popMatrix();
  }
  
  boolean checkIfGoodSpot(ArrayList<Colony> colonies) {
    for (Colony c : colonies) {
      if ((this.PosX-c.position.x)*(this.PosX-c.position.x) + (this.PosY-c.position.y)*(this.PosY-c.position.y) < this.satisfactoryDistance*this.satisfactoryDistance) {
        return false;
      }
    }
    return true;
  }
  
}
