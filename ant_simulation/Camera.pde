class Camera {
  
  float x;
  float y;
  boolean[] moving;
  float cameraSpeed;
  
  Camera(float cs) {
    this.x = 0;
    this.y = 0;
    moving = new boolean[4];
    for (int i = 0; i < 4; i++)
      moving[i] = false;
    cameraSpeed = cs;
  }
  
  void moveFromKeys() {
    x += (int(moving[3]) - int(moving[2])) * cameraSpeed;
    y += (int(moving[1]) - int(moving[0])) * cameraSpeed;
  }
  
}
