class Beetle {
  
  PVector position;
  float rotation;
  float speed;
  int turning;
  
  float health;
  float antKillRate;
  float size;
  
  float rotationSpeed;
  
  Beetle(float x, float y, float speed, float h, float aKR, float s, float rS) {
    this.position = new PVector(x, y);
    this.rotation = random(0, 360);
    this.speed = speed;
    this.health = h;
    this.antKillRate = aKR;
    this.size = s;
    this.rotationSpeed = rS;
  }
  
  void display(float camX, float camY, float camZoom) {
    pushMatrix();
    fill(255, 0, 0);
    translate(this.position.x * camZoom - camX, this.position.y * camZoom - camY);
    rotate(radians(this.rotation));
    noStroke();
    rect(-12*camZoom, -16*camZoom, 24*camZoom, 32*camZoom);
    popMatrix();
  }
  
  void move(float zoom) {
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
    this.rotation += this.rotationSpeed * this.turning;
    this.rotation = (this.rotation + 360) % 360;
  }
  
}
