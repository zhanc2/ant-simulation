class Ant {
  
  private PVector velocity;
  private float age;
  private Colony colony;
  private float direction;
  private boolean Alive;

  float speed;
  float strength;
  float nutritionLevel;
  float upkeepCost;
  float visionRadius;
  
  float PosX;
  float PosY;
  private int Rotation = round(random(0, 360));
  private int Turning = 0;
  
  String type;
  
  Ant(float X, float Y, float Sp, float St, float Up, float Vi, Colony Mine){
    PosX = X;
    PosY = Y;
    speed = Sp;
    strength = St;
    upkeepCost = Up;
    visionRadius = Vi;
    age = 0;
    colony = Mine;
    Alive = true;
    type = "regular";
  }
  
  void DrawAnt(float camX, float camY, float camZoom){
    Aging();
    pushMatrix();
    translate(PosX * camZoom - camX, PosY * camZoom - camY);
    Wandering(camZoom);
    rotate(radians(Rotation));
    this.MoveAnt(camZoom);
    stroke(0);
    fill(255);
    triangle(-3*camZoom, 5*camZoom, 0, -5*camZoom, 3*camZoom, 5*camZoom);
    popMatrix();
  }
  

  void MoveAnt(float zoom){
    //makes sure ant moves in all directions
    PosX += speed * (cos(radians(Rotation - 90))) * zoom;
    PosY += speed * (sin(radians(Rotation - 90))) * zoom;
  }
  
  void Wandering(float zoomAmount){
    float Random = random(0, 100);
    if(Turning == 0){
      if(Random <= 15){
        Turning = -1;
      }
      if(Random >= 85){
        Turning = 1;
      }
    }
    else if(Turning == -1 || Turning == 1){
      if(Random <= 99.5){
        Turning = 0;
      }
    }
    //stop running into walls
    if(PosX <= xBoundaries.x + 25){ 
      if(Rotation >= 270 && Rotation <= 360){
        Turning = 1;
      }
      if(Rotation <= 270 && Rotation >= 180){
        Turning = -1;
      }
    }
    if(PosY <= yBoundaries.x + 25){
      if(Rotation >= 0 && Rotation <= 90){
        Turning = 1;
      }
      if(Rotation <= 360 && Rotation >= 270){
        Turning = -1;
      }
    }
    
    if(PosX >= (xBoundaries.y - 25)){ 
      if(Rotation >= 90 && Rotation <= 180){
        Turning = 1;
      }
      if(Rotation <= 90 && Rotation >= 0){
        Turning = -1;
      }
    }
    if(PosY >= (yBoundaries.y - 25)){
      if(Rotation >= 180 && Rotation <= 270){
        Turning = 1;
      }
      if(Rotation <= 180 && Rotation >= 90){
        Turning = -1;
      }
    }
    
    //left turn
    if(Turning == -1){
      Rotation += -10;
    }
    //right turn
    if(Turning == 1){
      Rotation += 10;
    }
    //resets rotation
    if(Rotation >= 360){
      Rotation += -360;
    }
    if(Rotation <= 0){
      Rotation += 360;
    }
  }
  
  void Aging(){
    age++;
    if (age >= (30 * frameRate)){
      colony.antsToBeRemoved.add(this);
      println("dead?");
    }
  }
  
  int getRotation() {
    return this.Rotation;
  }
  
}
