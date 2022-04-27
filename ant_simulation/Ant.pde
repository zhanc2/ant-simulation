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
  private int Rotation = 90;
  private int Turning = 0;
  
  Ant(float X, float Y, float Sp, float St, float Up, float Vi, Colony Mine){
    PosX = X;
    PosY = Y;
    speed = Sp;
    strength = St;
    upkeepCost = Up;
    visionRadius = Vi;
  }
  
  void DrawAnt(float camX, float camY, float camZoom){
    pushMatrix();
    translate(PosX - camX, PosY - camY);
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
    if(PosX <= 25 * zoomAmount){ 
      if(Rotation >= 270 && Rotation <= 360){
        Turning = 1;
      }
      if(Rotation <= 270 && Rotation >= 180){
        Turning = -1;
      }
    }
    if(PosY <= 25 * zoomAmount){
      if(Rotation >= 0 && Rotation <= 90){
        Turning = 1;
      }
      if(Rotation <= 360 && Rotation >= 270){
        Turning = -1;
      }
    }
    
    if(PosX >= ((width - 25) * zoomAmount)){ 
      if(Rotation >= 90 && Rotation <= 180){
        Turning = 1;
      }
      if(Rotation <= 90 && Rotation >= 0){
        Turning = -1;
      }
    }
    if(PosY >= ((height - 25) * zoomAmount)){
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
  
}
