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

void draw() {
  rectMode(LEFT);
  fill(100, 100, 100, 20);
  rect(0, 0, 700, 500);
  fill(255);
  text(score, width / 2, height / 2);
  noStroke();
  fill(color3[0], color3[1], color3[2]);
  
  // Menggunakan satu bola
  ellipse(xPos, yPos, 50, 50);

  fill(0);
  yPos += ySpeed;
  xPos += xSpeed;

  if (xPos - 25 <= 0) {
    xSpeed *= -1.02;
  }
  if (yPos + 25 >= height || yPos - 25 <= 0) {
    ySpeed *= -1.02;
  }

  rectMode(CENTER);
  fill(color2[0], color2[1], color2[2]);
  if (key == 'a') fill(150, 150, 150, 20);
  if (key == 'b') fill(255, 0, 0, 20);
  rect(600, mouseY, 30, 90);

  if (abs(600 - xPos) < 40 && abs(mouseY - yPos) < 70 && xSpeed > 0) {
    score++;
    xSpeed *= -1.02;
    ySpeed = random(-15, 15);
  }

  if (xPos > width) {
    fill(255);
    rect(0, 0, 10000, 10000);
    fill(0);
    text("score = " + score + " lol", width / 2, height / 2);
    noLoop();
  }
}
