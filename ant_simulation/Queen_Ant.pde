// Queen Ants share many traits with regular Ants, so this class extends the Ant class

class QueenAnt extends Ant {
  
  float satisfactoryDistance;
  
  float timeSinceLastCheck = 0;
  
  // The Queen Ant has some additional fields, so the super constructor is used.
  QueenAnt(float X, float Y, float Sp, float St, float Up, float Vi, Colony Mine) {
    super(X, Y, Sp, St, Up, Vi, Mine, color(0));
    this.satisfactoryDistance = 500;
    this.visionRadius = Vi;
    this.type = "queen";
  }
 
  // The Queen Ant doesn't need all the methods used in the Ant draw method, so the DrawAnt method is overloaded.
  void DrawAnt(float camX, float camY, float camZoom){
    pushMatrix();
    translate(PosX * camZoom - camX, PosY * camZoom - camY);
    Wandering();
    rotate(radians(getRotation()));
    this.MoveAnt(camZoom);
    stroke(0);
    fill(0);
    triangle(-4*camZoom, 6*camZoom, 0, -6*camZoom, 4*camZoom, 6*camZoom);
    popMatrix();
  }
  
  boolean checkIfGoodSpot(ArrayList<Colony> colonies) {
    for (Colony c : colonies) {
      // Since the square root function takes relatively long for a computer to do, this is a faster way to check if the queen is within a satisfactory distance.
      if ((this.PosX-c.position.x)*(this.PosX-c.position.x) + (this.PosY-c.position.y)*(this.PosY-c.position.y) < this.satisfactoryDistance*this.satisfactoryDistance) {
        return false;
      }
    }
    return true;
  }
  
}
