Ant Anthony;
Colony Test;
Simulation s;

void setup() {
  size(1000,500);
  s = new Simulation();
  Anthony = new Ant(50, 50, 3, 5, 5, 5, Test);
}
  
void draw() {
  background(0);
  fill(255);
  pushMatrix();
  scale(s.camera.zoom);
  rect(-s.camera.x, -s.camera.y, width, height); // a border the size of the screen
  popMatrix();
  Anthony.DrawAnt(s.camera.x, s.camera.y, s.camera.zoom);
  s.updateCameraPos(); // arrow keys and dragging the screen moves the camera, scrolling up and down changes the zoom amount
  //s.updateCameraPos(Anthony.PosX, Anthony.PosY); // this makes the camera follow anthony
  
}
