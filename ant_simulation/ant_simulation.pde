Ant Anthony;
Colony Test;
Simulation s;

void setup() {
  size(1000,500);
  s = new Simulation();
  Anthony = new Ant(50, 50, 3, 5, 5, 5, Test);
}
  
void draw() {
  background(255);
  Anthony.DrawAnt();
  
}
