float xPos, yPos;
float xSpeed = -5, ySpeed = 1;

// Color
float[] color1 = {random(0, 255), random(0, 255), random(0, 255)};
float[] color2 = {random(0, 255), random(0, 255), random(0, 255)};
float[] color3 = {random(0, 255), random(0, 255), random(0, 255)};

float score = 0;

void setup() {
  size(700, 500);
  xPos = width / 2;
  yPos = height / 2;
  background(100, 100, 100, 0);
}
