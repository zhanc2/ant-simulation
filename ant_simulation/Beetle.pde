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
    rect(-12*camZoom, -16*camZoom, 24*camZoom, 32*camZoom);
    popMatrix();
  }
  
  void move(float zoom) {
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
    position.x += speed * (cos(radians(rotation - 90))) * zoom * simulationSpeed;
    position.y += speed * (sin(radians(rotation - 90))) * zoom * simulationSpeed;
  }
  
  void turn() {
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

    if (!this.lunging) {
      this.rotation += this.rotationSpeed * this.turning * simulationSpeed;
      this.rotation = (this.rotation + 360) % 360;
    }
  }
  
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
  
  void lungeAtAnt(Ant a) {
    float alpha, xDiff, yDiff;
    xDiff = a.PosX - this.position.x;
    yDiff = a.PosY - this.position.y;
    
    if (xDiff != 0) {
      alpha = degrees(atan(abs(yDiff / xDiff)));
      
      if (yDiff == 0) {
        if (xDiff > 0) alpha = 0;
        else alpha = 180;
      }
      
      else if (xDiff < 0 && yDiff < 0)
        alpha = 180 - alpha;
      else if (xDiff < 0 && yDiff > 0)
        alpha = 180 + alpha;
      else if (xDiff > 0 && yDiff > 0)
        alpha = 360 - alpha;
    }
    else {
      alpha = 90;
      if (yDiff > 0) alpha = 270;
    }
    
    this.lunging = true;
    this.lungeDirection = alpha;
    this.lungeTime = 0;  
  }
  
}
