import g4p_controls.*;

float simulationSpeed = 1;
boolean paused = false;
String[] pausePlayStrings = {"Pause", "Play"};
//Ant Anthony; You will be remembered
Simulation s;

float xBoundary;
float yBoundary;

void setup() {
  createGUI();
  size(1000, 500);
  xBoundary = 2000;
  yBoundary = 1000;
  s = new Simulation();
}

void draw() {
  if (!paused) {
    background(0);
    fill(23, 191, 29);
    noStroke();
    rect(-s.camera.x, -s.camera.y, 2*width*s.camera.zoom, 2*height*s.camera.zoom);
    s.updateCameraPos(); // arrow keys and dragging the screen moves the camera, scrolling up and down changes the zoom amount
    s.PassFood();
    s.handleColonies();
    s.RandomFoodSpawning();
    s.displayFoods();
    s.handleBeetles();
  }
}
