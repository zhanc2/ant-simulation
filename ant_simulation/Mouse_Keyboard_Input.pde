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
  else if (key == ' ') {
    s.camera.recenter();
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
  s.camera.beingDragged = true;
  s.camera.updateDraggedLastPosition();
}

void mouseReleased() {
  s.camera.beingDragged = false;
}

void mouseWheel(MouseEvent e) {
  // if the mouse is scrolled up, e.getCount() will return -1, if it is scrolled down, it will return 1=
  s.camera.zoomInOut(e.getCount());
}
