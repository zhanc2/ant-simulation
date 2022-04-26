class Camera {
  
  float x;
  float y;
  boolean[] moving;
  float cameraSpeed;
  
  boolean beingDragged;
  PVector draggedLastPosition;
  
  Camera(float cs) {
    this.x = 0;
    this.y = 0;
    moving = new boolean[4];
    for (int i = 0; i < 4; i++)
      moving[i] = false;
    this.cameraSpeed = cs;
    this.beingDragged = false;
    this.draggedLastPosition = new PVector(0, 0);
  }
  
  void moveFromKeys() {
    this.x += (int(moving[3]) - int(moving[2])) * cameraSpeed;
    this.y += (int(moving[1]) - int(moving[0])) * cameraSpeed;
  }
  
  void updateDraggedLastPosition() {
    this.draggedLastPosition.x = mouseX;
    this.draggedLastPosition.y = mouseY;
  }
  
  void moveFromMouse() {
    if (this.beingDragged) {
      float xDiff = this.draggedLastPosition.x - mouseX;
      float yDiff = this.draggedLastPosition.y - mouseY;
      
      this.x += xDiff;
      this.y += yDiff;
      
      updateDraggedLastPosition();
    }
  }
  
}
