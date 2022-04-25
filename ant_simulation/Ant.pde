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
  
  Ant(float X, float Y, float Sp, float St, float Up, float Vi, Colony Mine){
    PosX = 50;
    PosY = 50;
    speed = 5;
    strength = 5;
  }
  
  void DrawAnt(){
    pushMatrix();
    translate(PosX, PosY);
    triangle(-3, 5, 0, -5, 3, 5);
    popMatrix();
  }
  
  void MoveAnt(){
    
  }
  
}
