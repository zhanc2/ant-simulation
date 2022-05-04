class Ant {
  
  private float age;
  private Colony colony;

  float speed;
  float strength;
  float nutritionLevel;
  float upkeepCost;
  float visionRadius;
  
  float foodLevel;
  
  float PosX;
  float PosY;
  private int Rotation = round(random(0, 360));
  private int Turning = 0;
  
  ArrayList<Food> FoodToFind = new ArrayList<Food>();
  
  int currentState; // finding food, going to the food, obtaining food, returning to colony, depositing food
  
  Food theLocatedFood;

  
  String type;
  
  color c;
  
  boolean fading;
  int fadeAmount;
  
  ArrayList<Particle> deathParticles;
  boolean exploding;
  int explodeTime;
  
  float carriedFoodAmount;
  
  Ant(float X, float Y, float Sp, float St, float Up, float Vi, Colony Mine, color C){
    this.PosX = X;
    this.PosY = Y;
    
    this.speed = Sp;
    this.strength = St;
    this.upkeepCost = Up;
    this.visionRadius = Vi;
    
    this.age = 0;
    this.colony = Mine;
    this.type = "regular";
    
    this.c = C;
    
    this.fading = false;
    this.fadeAmount = 255;
    
    this.deathParticles = new ArrayList<Particle>();
    this.exploding = false;
    this.explodeTime = 0;
    
    this.currentState = 0;

    this.carriedFoodAmount = 0;
    
    this.foodLevel = 100;
    
  }
  
  void DrawAnt(float camX, float camY, float camZoom){
    deathProcedures(camX, camY, camZoom);
    Aging();
    pushMatrix();
    translate(PosX * camZoom - camX, PosY * camZoom - camY);
    Wandering();
    //Rotation = 330;
    rotate(radians(Rotation));
    this.MoveAnt(camZoom);
    stroke(0);
    fill(this.c, this.fadeAmount);
    if (!this.exploding) triangle(-3*camZoom, 5*camZoom, 0, -5*camZoom, 3*camZoom, 5*camZoom);
    if (this.carriedFoodAmount > 0) {
      fill(247,197,142);
      circle(0, 0, this.carriedFoodAmount);
    }
    popMatrix();
  }
  

  void MoveAnt(float zoom){
    //makes sure ant moves in all directions
    this.foodLevel -= this.upkeepCost/6;
    if (this.foodLevel <= 0) die("hunger");
    if (this.currentState != 2 && this.currentState != 4) {
      PosX += speed * (cos(radians(Rotation - 90))) * zoom * simulationSpeed;
      PosY += speed * (sin(radians(Rotation - 90))) * zoom * simulationSpeed;
    }
  }
  
  void Wandering(){
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
    
    if (this.type.equals("regular")) {
      switch (this.currentState) {
        
        case 0:
          for(Food f : s.food){
            float TriX = f.position.x - PosX;
            float TriY = f.position.y - PosY;
            float TriH = (TriX * TriX) + (TriY * TriY);
            if(TriH <= this.visionRadius * this.visionRadius){
              this.currentState++;
              this.theLocatedFood = f;
              this.Rotation = round(getDirectionFromPosition(this.theLocatedFood.position)) + 90;
              this.Turning = 0;
              break;
            }
          }
          break;
          
        case 1:
          Turning = 0;
          if (dist(this.PosX, this.PosY, this.theLocatedFood.position.x, this.theLocatedFood.position.y) <= this.theLocatedFood.size/2) {
            this.currentState++; //<>//
            this.foodLevel = 100;
          }
          break;
          
        case 2:
          Turning = 0;
          float changeInCarrying = min(min(this.theLocatedFood.size, simulationSpeed/5), this.strength-this.carriedFoodAmount);
          if (this.carriedFoodAmount < this.strength) {
            this.carriedFoodAmount += changeInCarrying;
            this.theLocatedFood.reduceSize(changeInCarrying);
          }
          if (this.theLocatedFood.size == 0 || this.carriedFoodAmount >= this.strength) {
            this.currentState++;
            this.Rotation = round(getDirectionFromPosition(this.colony.position)) + 90;
          }
          break;
          
        case 3:
        Turning = 0;
          if (dist(this.PosX, this.PosY, this.colony.position.x, this.colony.position.y) <= this.colony.size) {
            this.currentState++;
            this.foodLevel = 100;
          }
          break;
          
        case 4:
          Turning = 0;
          float depositAmount = min(this.carriedFoodAmount, simulationSpeed/5);
          if (this.carriedFoodAmount > 0) {
            this.carriedFoodAmount -= depositAmount;
            this.colony.depositFood(depositAmount);
          } else {
            this.currentState=0;
          }
          break;
        
      }
      
    }
    
    this.Rotation += 10 * this.Turning * simulationSpeed;
    this.Rotation = (this.Rotation + 360) % 360;
    
    
  }
  
  void Aging(){
    age += simulationSpeed;
    if (age >= (45 * frameRate)){
      die("age");
      println("dead?");
    }
  }
  
  void die(String deathType) {
    if (deathType.equals("age") || deathType.equals("hunger")) {
      this.fading = true;
      return;
    } else if (deathType.equals("beetle")) {
      for (int i = 0; i < 14; i++) {
        Particle p = new Particle(this.PosX, this.PosY, 7, random(0, 360), this.c);
        deathParticles.add(p);
      }
      this.exploding = true;
      this.explodeTime = 0;
    }
  }
  
  void deathProcedures(float camX, float camY, float camZoom) {
    if (this.exploding) {
      if (this.explodeTime < 20) {
        for (Particle p : this.deathParticles) {
          p.display(camX, camY, camZoom);
          p.move(camZoom);
          p.speed *= pow(0.7, simulationSpeed);
        }
        this.explodeTime += simulationSpeed;
      } else {
        this.deathParticles.clear();
        this.colony.antsToBeRemoved.add(this);
      }
    }
    
    if (this.fading) {
      if (this.fadeAmount > 0) {
        this.fadeAmount -= 10 * simulationSpeed;
      } else {
        colony.antsToBeRemoved.add(this);
      }
    }
  }
  
  int getRotation() {
    return this.Rotation;
  }
  
  void KnowFood(ArrayList<Food> tempFood) {
    FoodToFind = new ArrayList<Food>(tempFood);
  }
  
  float getDirectionFromPosition(PVector p) {
    float alpha, xDiff, yDiff;
    xDiff = p.x - this.PosX;
    yDiff = p.y - this.PosY;
    
    alpha = (degrees(atan2(xDiff, yDiff)) + 360) % 360;
    
    return 90 - alpha; 
  }
}
