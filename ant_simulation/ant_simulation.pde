Ant Anthony;
Colony Test;
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
}
