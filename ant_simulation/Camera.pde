class Camera {
  
  float x;
  float y;
  float zoom;
  boolean[] moving; // up down left right
  
  float cameraSpeed;
  float zoomAmount;
  
  boolean beingDragged;
  PVector draggedLastPosition;
  
  Camera(float cs, float za, float xStart, float yStart) {
    this.x = xStart;
    this.y = yStart;
    this.zoom = 1;
    
    this.cameraSpeed = cs;
    this.zoomAmount = za;
    
    moving = new boolean[4];
    for (int i = 0; i < 4; i++)
      moving[i] = false;
    
    this.beingDragged = false;
    this.draggedLastPosition = new PVector(0, 0);
  }
  
  void moveFromKeys() {
    // true = 1, false = 0, if they are both true or false, no movement, otherwise move in whatever direction
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
  
  void zoomInOut(int val) {
    
    // the zoom changes based on the zoomAmount variable, but the camera also has to move to be centered on the user's mouse
    // the camera's position is based on the top left, not the center, so some repositioning is needed
    
    float xShift = xBoundary/this.zoom;
    float yShift = yBoundary/this.zoom;
    if (val > 0) {
      this.zoom /= this.zoomAmount;
    }
    else if (val < 0) {
      this.zoom *= this.zoomAmount;
    } else {
      return;
    }
    xShift -= xBoundary/(this.zoom);
    yShift -= yBoundary/(this.zoom);
    
    this.x += xShift*(float(mouseX)/float(width));
    this.y += yShift*(float(mouseY)/float(height));
  }
  
}
