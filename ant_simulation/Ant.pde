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
  private int Turning = 0;
  
  Ant(float X, float Y, float Sp, float St, float Up, float Vi, Colony Mine){
    PosX = X;
    PosY = Y;
    speed = Sp;
    strength = St;
    upkeepCost = Up;
    visionRadius = Vi;
  }
  
  void DrawAnt(){
    pushMatrix();
    translate(PosX, PosY);
    Wandering();
    rotate(radians(Rotation));
    this.MoveAnt();
    triangle(-3, 5, 0, -5, 3, 5);
    popMatrix();
  }
  
  void MoveAnt(){
    PosX += speed * (cos(radians(Rotation - 90)));
    PosY += speed * (sin(radians(Rotation - 90)));
  }
  
  void Wandering(){
    float Random = random(0, 100);
    if(Turning == 0){
      if(Random <= 10){
        Turning = -1;
      }
      if(Random >= 90){
        Turning = 1;
      }
    }
    else if(Turning == -1 || Turning == 1){
      if(Random <= 95){
        Turning = 0;
      }
    }
    if(Turning == -1){
      Rotation += -10;
    }
    if(Turning == 1){
      Rotation += 10;
    }
  }
  
}
