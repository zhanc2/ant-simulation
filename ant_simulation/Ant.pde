class Ant {
  
  private float age;
  private Colony colony;

  float speed;
  float strength;
  float nutritionLevel;
  float upkeepCost;
  float visionRadius;
  
  float PosX;
  float PosY;
  private int Rotation = round(random(0, 360));
  private int Turning = 0;
  ArrayList<Food> FoodToFind;
  
  String type;
  
  color c;
  
  Ant(float X, float Y, float Sp, float St, float Up, float Vi, Colony Mine, color C){
    PosX = X;
    PosY = Y;
    speed = Sp;
    strength = St;
    upkeepCost = Up;
    visionRadius = Vi;
    age = 0;
    colony = Mine;
    type = "regular";
    this.c = C;
  }
  
  void DrawAnt(float camX, float camY, float camZoom){
    Aging();
    pushMatrix();
    translate(PosX * camZoom - camX, PosY * camZoom - camY);
    Wandering(camZoom);
    rotate(radians(Rotation));
    this.MoveAnt(camZoom);
    stroke(0);
    fill(this.c);
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
    if(PosX <= 25){ 
      if(Rotation >= 270 && Rotation <= 360){
        Turning = 1;
      }
      if(Rotation <= 270 && Rotation >= 180){
        Turning = -1;
      }
    }
    if(PosY <= 25){
      if(Rotation >= 0 && Rotation <= 90){
        Turning = 1;
      }
      if(Rotation <= 360 && Rotation >= 270){
        Turning = -1;
      }
    }
    
    if(PosX >= (xBoundary - 25)){ 
      if(Rotation >= 90 && Rotation <= 180){
        Turning = 1;
      }
      if(Rotation <= 90 && Rotation >= 0){
        Turning = -1;
      }
    }
    if(PosY >= (yBoundary - 25)){
      if(Rotation >= 180 && Rotation <= 270){
        Turning = 1;
      }
      if(Rotation <= 180 && Rotation >= 90){
        Turning = -1;
      }
    }
    
    //for(Food f: FoodToFind){
      //if(f.position.x <= (PosX + visionRadius) && f.position.x >= (PosX - visionRadius) && f.position.y <= (PosY + visionRadius) && f.position.y >= (PosY + visionRadius)){
        
      //}
    //}
    
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
  
  void KnowFood(ArrayList tempFood) {
    FoodToFind = tempFood;
  }
}
