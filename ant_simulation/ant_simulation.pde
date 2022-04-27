Ant Anthony;
Colony Test;
<<<<<<< HEAD
Food f;

void setup() {
  size(500,1000);
  Anthony = new Ant(50, 50, 5, 5, 5, 5, Test);
  f= new Food(10,170,120);
}
  
void draw() {
  background(255);
  Anthony.DrawAnt();
  f.display();
=======
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
  
>>>>>>> e03b0ccc60399d18492cf59dd16e10431361d901
}
