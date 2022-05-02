class Particle {
  
  PVector position;
  float speed;
  float direction;
  color c;
  
  float opacity;
  float rotation;
  
  Particle(float x, float y, float s, float d, color C) {
    this.position = new PVector(x, y);
    this.speed = s;
    this.direction = d;
    this.c = C;
    
    this.opacity = 255;
    
    this.rotation = random(0, 2*PI);
  }
  
  void display(float camX, float camY, float camZoom) {
    //println("DO SOMETHING");
    pushMatrix();
    translate(this.position.x * camZoom - camX, this.position.y * camZoom - camY);
    rotate(this.rotation);
    fill(this.c, this.opacity);
    noStroke();
    triangle(-1.5*camZoom, 3*camZoom, 0, -3*camZoom, 1.5*camZoom, 3*camZoom);
    popMatrix();
    this.opacity -= 15;
  }
  
  void move(float zoom) {
    this.position.x += this.speed * (cos(radians(this.direction - 90))) * zoom;
    this.position.y += this.speed * (sin(radians(this.direction - 90))) * zoom;
  }
  
  
}
