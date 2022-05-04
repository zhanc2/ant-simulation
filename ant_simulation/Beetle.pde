class Beetle {
  
  PVector position;
  int rotation;
  float speed;
  int turning;
  
  float health;
  float antKillRate;
  float size;
  
  float attackRadius;
  
  float rotationSpeed;
  
  boolean lunging;
  int lungeTime;
  float lungeDirection;
  float timeSinceLastLunge;
  
  int age;
  boolean fading;
  float fadeAmount;
  
  Beetle(float x, float y, float speed, float h, float aKR, float s, float rS, float aR) {
    this.position = new PVector(x, y);
    this.rotation = round(random(0, 360));
    this.speed = speed;
    this.health = h;
    this.antKillRate = aKR;
    this.size = s;
    this.rotationSpeed = rS;
    this.attackRadius = aR;
    this.lunging = false;
    this.lungeTime = 0;
    this.lungeDirection = 0;
    this.timeSinceLastLunge = 0;
    this.fading = false;
    this.fadeAmount = 255;
  }
  
  void display(float camX, float camY, float camZoom) {
    pushMatrix();
    stroke(0);
    fill(255);
    translate(this.position.x * camZoom - camX, this.position.y * camZoom - camY);
    if (this.lunging)
      rotate(radians(this.lungeDirection));
    else
      rotate(radians(this.rotation));
    if (this.fading) {
      if (this.fadeAmount > 0) {
        this.fadeAmount -= 10 * simulationSpeed;
      } else {
        s.beetlesToBeRemoved.add(this);
      }
    }
    fill(255, this.fadeAmount);
    rect(-12*camZoom, -16*camZoom, 24*camZoom, 32*camZoom);
    popMatrix();
  }
  
  void move(float zoom) {
    // If the beetle is lunging, for half of the lunge time, it is moving forwards, then it is moving backwards.
    // At the end of the time, the lunge is done
    if (this.lunging) {
      if (this.lungeTime < 8f/simulationSpeed) {
        position.x += speed*5*simulationSpeed * (cos(radians(this.lungeDirection - 90))) * zoom;
        position.y += speed*5*simulationSpeed * (sin(radians(this.lungeDirection - 90))) * zoom;
      } else if (this.lungeTime < 16f/simulationSpeed) {
        position.x -= speed*5*simulationSpeed * (cos(radians(this.lungeDirection - 90))) * zoom;
        position.y -= speed*5*simulationSpeed * (sin(radians(this.lungeDirection - 90))) * zoom;
      } else {
        this.lunging = false;
      }
      this.lungeTime++;
      this.timeSinceLastLunge = 0;
      return;
    }
    // same movement as the ant
    position.x += speed * (cos(radians(rotation - 90))) * zoom * simulationSpeed;
    position.y += speed * (sin(radians(rotation - 90))) * zoom * simulationSpeed;
  }
  
  void turn() {
    // same turning as the ant
    float Random = random(0, 100);
    if(turning == 0){
      if(Random <= 5){
        turning = -1;
      }
      if(Random >= 95){
        turning = 1;
      }
    }
    else if(turning == -1 || turning == 1){
      if(Random <= 50){
        turning = 0;
      }
    }
    
    // rewritten code of the ant's wall detection (basically the same thing)
    if(this.position.x <= 25)
      if (180 <= rotation && rotation <= 360 && rotation != 270)
        turning = (rotation-270)/abs(rotation-270);
      if (rotation == 270)
        turning = round((random(0, 1)*2)-1);
        
    if(this.position.y <= 25)
      if(rotation >= 0 && rotation <= 90 || rotation <= 360 && rotation >= 270)
        turning = (360-this.rotation-91)/abs(360-rotation-91);
    
    if(this.position.x >= (xBoundary - 25))
      if(rotation >= 0 && rotation <= 180 && rotation != 90)
        turning = (rotation-90)/abs(rotation-90);
      if (rotation == 90)
        turning = round((random(0, 1)*2)-1);
        
    if(this.position.y >= (yBoundary - 25))
      if(rotation >= 90 && rotation <= 270 || rotation != 180)
        turning = (rotation-180)/abs(rotation-180);
      if(rotation == 180)
        turning = round((random(0, 1)*2)-1);

    // If it is not lunging, rotate it according to its turning (same as ants).
    if (!this.lunging) {
      this.rotation += this.rotationSpeed * this.turning * simulationSpeed;
      this.rotation = (this.rotation + 360) % 360;
    }
  }
  
  /* 
  If an ant is close enough to the beetle, it will attack it, as long as these conditions are met:
  1. The beetle is not currently attacking
  2. The time since the last attack is sufficient
  3. The targetted ant is not currently dying
  */
  void destroyAnts(ArrayList<Ant> ants) {
    if (this.timeSinceLastLunge > (simulationSpeed)*frameRate) {
      if (!this.lunging) {
        for (Ant a : ants) {
          if (!a.fading && !a.exploding) {
            if ((this.position.x-a.PosX)*(this.position.x-a.PosX) + (this.position.y-a.PosY)*(this.position.y-a.PosY) < (this.attackRadius*this.attackRadius)) {
              a.die("beetle");
              this.lungeAtAnt(a);
              break;
            }
          }
        }
      }
    } else {
      this.timeSinceLastLunge++;
    }
  }
  
  // same angle finding as the ants
  void lungeAtAnt(Ant a) {
    float alpha, xDiff, yDiff;
    xDiff = a.PosX - this.position.x;
    yDiff = a.PosY - this.position.y;
    
    alpha = (degrees(atan2(xDiff, yDiff)) + 360) % 360;
    alpha = 90 - alpha;
    
    this.lunging = true;
    this.lungeDirection = alpha + 90;
    this.lungeTime = 0;  
  }
  
  // aging the beetle
  void age() {
    age += simulationSpeed;
    if (age > 40 * frameRate) this.fading = true;
  }
  
}
