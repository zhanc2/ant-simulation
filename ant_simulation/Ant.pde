class Ant {
  
  private PVector position;
  private PVector velocity;
  private float age;
  private Colony colony;
  private float direction;

  private float speed;
  private float strength;
  private float nutritionLevel;
  private float upkeepCost;
  private float visionRadius;
  
  private float PosX;
  private float PosY;
  private int Rotation = 180;
  
  Ant(float X, float Y, float Sp, float St, float Up, float Vi, Colony Mine){
    PosX = X;
    PosY = Y;
    speed = Sp;
    strength = St;
  }
  
  void DrawAnt(){
    pushMatrix();
    translate(PosX, PosY);
    rotate(radians(Rotation));
    this.MoveAnt();
    triangle(-3, 5, 0, -5, 3, 5);
    popMatrix();
  }
  
  void MoveAnt(){
    PosX += speed * (cos(radians(Rotation - 90)));
    PosY += speed * (sin(radians(Rotation - 90)));
  }
  
}
