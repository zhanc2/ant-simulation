void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      s.camera.moving[0] = true;
    } else if (keyCode == DOWN) {
      s.camera.moving[1] = true;
    } else if (keyCode == LEFT) {
      s.camera.moving[2] = true;
    } else if (keyCode == RIGHT) {
      s.camera.moving[3] = true;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      s.camera.moving[0] = false;
    } else if (keyCode == DOWN) {
      s.camera.moving[1] = false;
    } else if (keyCode == LEFT) {
      s.camera.moving[2] = false;
    } else if (keyCode == RIGHT) {
      s.camera.moving[3] = false;
    }
  }
}

void mousePressed() {
  
}

void mouseDragged() {
  
}

void mouseReleased() {
  
}
