class Beetle {
  
  PVector position;
  float rotation;
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
  
  Beetle(float x, float y, float speed, float h, float aKR, float s, float rS, float aR) {
    this.position = new PVector(x, y);
    this.rotation = random(0, 360);
    this.speed = speed;
    this.health = h;
    this.antKillRate = aKR;
    this.size = s;
    this.rotationSpeed = rS;
    this.attackRadius = aR;
    this.lunging = false;
    this.lungeTime = 0;
    this.lungeDirection = 0;
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
      if (this.lungeTime < 7) {
        position.x += speed*7 * (cos(radians(this.lungeDirection - 90))) * zoom;
        position.y += speed*7 * (sin(radians(this.lungeDirection - 90))) * zoom;
      } else if (this.lungeTime < 14) {
        position.x -= speed*7 * (cos(radians(this.lungeDirection - 90))) * zoom;
        position.y -= speed*7 * (sin(radians(this.lungeDirection - 90))) * zoom;
      } else {
        this.lunging = false;
      }
      this.lungeTime++;
      return;
    }
    position.x += speed * (cos(radians(rotation - 90))) * zoom;
    position.y += speed * (sin(radians(rotation - 90))) * zoom;
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
    
    if(position.x <= 25){ 
      if(rotation >= 270 && rotation <= 360){
        turning = 1;
      }
      if(rotation <= 270 && rotation >= 180){
        turning = -1;
      }
    }
    if(position.y <= 25){
      if(rotation >= 0 && rotation <= 90){
        turning = 1;
      }
      if(rotation <= 360 && rotation >= 270){
        turning = -1;
      }
    }
    
    if(position.x >= (xBoundary - 25)){ 
      if(rotation >= 90 && rotation <= 180){
        turning = 1;
      }
      if(rotation <= 90 && rotation >= 0){
        turning = -1;
      }
    }
    if(position.y >= (yBoundary - 25)){
      if(rotation >= 180 && rotation <= 270){
        turning = 1;
      }
      if(rotation <= 180 && rotation >= 90){
        turning = -1;
      }
    }
    if (!this.lunging) {
      this.rotation += this.rotationSpeed * this.turning;
      this.rotation = (this.rotation + 360) % 360;
    }
  }
  
  void destroyAnts(ArrayList<Ant> ants) {
    if (!this.lunging) {
      for (Ant a : ants) {
        if ((this.position.x-a.PosX)*(this.position.x-a.PosX) + (this.position.y-a.PosY)*(this.position.y-a.PosY) < (this.attackRadius*this.attackRadius)) {
          //a.die();
          this.lungeAtAnt(a);
        }
      }
    }
  }
  
  void lungeAtAnt(Ant a) {
    float alpha, xDiff, yDiff;
    xDiff = a.PosX - this.position.x;
    yDiff = a.PosY - this.position.y;
    
    if (xDiff != 0)
      alpha = atan(abs(yDiff / xDiff));
    else
      alpha = PI/4;
    
    if (xDiff < 0 && yDiff > 0)
      alpha = PI/2 - alpha;
    else if (xDiff < 0 && yDiff < 0)
      alpha = PI/2 + alpha;
    else if (xDiff > 0 && yDiff < 0)
      alpha = PI - alpha;
      
    alpha = degrees(alpha);
    alpha = (alpha + 180) % 360;
    
    this.lunging = true;
    this.lungeDirection = alpha;
    this.lungeTime = 0;  
  }
  
}
