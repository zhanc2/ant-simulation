import g4p_controls.*;

float simulationSpeed = 1;
boolean paused = false;
String[] pausePlayStrings = {"Pause", "Play"};
int startingColonyAmount = 1;

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
    s.run();
  }
}
