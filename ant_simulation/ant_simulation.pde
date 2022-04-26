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
  rect(-s.camera.x, -s.camera.y, width, height); // a border the size of the screen
  Anthony.DrawAnt(s.camera.x, s.camera.y);
  s.updateCameraPos(); // arrow keys and dragging the screen moves the camera
  //s.updateCameraPos(Anthony.PosX, Anthony.PosY); // this makes the camera follow anthony
  
}
