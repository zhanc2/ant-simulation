class Ant {
  
  PVector position;
  PVector velocity;
  float age;
  Colony colony;
  float direction;
  
  float speed;
  float strength;
  float nutritionLevel;
  float upkeepCost;
  float visionRadius;
  
  float PosX;
  float PosY;
  
  Ant(){
    PosX = 50;
    PosY = 50;
  }
  
  void DrawAnt(){
    pushMatrix();
    translate(PosX, PosY);
    triangle(-3, 5, 0, -5, 3, 5);
    popMatrix();
  }
  
}
