float xPos, yPos;
float xSpeed = -5, ySpeed = 1;

float bonusX1, bonusY1;
float bonusX2, bonusY2;
float bonusSpeedX1, bonusSpeedY1;
float bonusSpeedX2, bonusSpeedY2;
float bonusSize = 30;
boolean bonus1Active = false;
boolean bonus2Active = false;

int[] color1 = {int(random(0, 255)), int(random(0, 255)), int(random(0, 255))};
int[] color2 = {int(random(0, 255)), int(random(0, 255)), int(random(0, 255))};
int[] color3;

color glowColor = color(0, 255, 0); // Neon green, adjust as needed

int score = 0;
ArrayList<AnimatedText> animatedTexts = new ArrayList<AnimatedText>();

boolean gameStarted = false;
boolean gameOver = false;
String gameName = "PING - PONG GAME";

void setup() {
  size(700, 500);
  xPos = width / 2;
  yPos = height / 2;
  color3 = new int[]{int(random(0, 255)), int(random(0, 255)), int(random(0, 255))};
  background(0);  // Set background color to pitch black
}

void draw() {
  if (!gameStarted) {
    drawStartScreen();
    return;
  }
  if (gameOver) {
    drawGameOverScreen();
    return;
  }
  
  background(0);  // Set background color to pitch black
  
  rectMode(LEFT);
  fill(100, 100, 100, 20);
  rect(0, 0, 700, 500);
  fill(255);
  textSize(24);
  text(score, width - 50, height - 50);
  noStroke();
  fill(color3[0], color3[1], color3[2]);
  ellipse(xPos, yPos, 50, 50);
  fill(0);
  yPos += ySpeed;
  xPos += xSpeed;

  if (xPos - 25 <= 0) {
    xSpeed *= -1.02;
    color3 = new int[]{int(random(0, 255)), int(random(0, 255)), int(random(0, 255))};  // Change color on bounce
  }
  if (yPos + 25 >= height || yPos - 25 <= 0) {
    ySpeed *= -1.02;
    color3 = new int[]{int(random(0, 255)), int(random(0, 255)), int(random(0, 255))};  // Change color on bounce
  }
  
  // Draw bonus item 1 with a glowing outline
if (bonus1Active) {
  strokeWeight(3);
  stroke(glowColor);
  fill(255, 0, 0);
  triangle(bonusX1, bonusY1 - bonusSize / 2, bonusX1 - bonusSize / 2, bonusY1 + bonusSize / 2, bonusX1 + bonusSize / 2, bonusY1 + bonusSize / 2);
  noStroke();

  // Cek tabrakan dengan bonus item 1
  float distance1 = dist(xPos, yPos, bonusX1, bonusY1);
  if (distance1 < bonusSize) {
    // Pemain mendapatkan bonus poin
    score += 5;  // Atur sesuai keinginan
    bonus1Active = false;
  }

  // Perbarui posisi bonus item 1
  bonusX1 += bonusSpeedX1;
  bonusY1 += bonusSpeedY1;

  // Pengecekan batas untuk pembalikan arah
  if (bonusX1 - bonusSize / 2 <= 0 || bonusX1 + bonusSize / 2 >= width) {
    bonusSpeedX1 *= -1;
  }
  if (bonusY1 - bonusSize / 2 <= 0 || bonusY1 + bonusSize / 2 >= height) {
    bonusSpeedY1 *= -1;
  }
}

// Draw bonus item 2 with a glowing outline
if (bonus2Active) {
  strokeWeight(3);
  stroke(glowColor);
  fill(0, 0, 255);
  ellipse(bonusX2, bonusY2, bonusSize, bonusSize);
  noStroke();

  // Cek tabrakan dengan bonus item 2
  float distance2 = dist(xPos, yPos, bonusX2, bonusY2);
  if (distance2 < bonusSize) {
    // Pemain mendapatkan bonus poin
    score += 10;  // Poin bonus lebih tinggi
    bonus2Active = false;
  }

  // Perbarui posisi bonus item 2
  bonusX2 += bonusSpeedX2;
  bonusY2 += bonusSpeedY2;

  // Pengecekan batas untuk pembalikan arah
  if (bonusX2 <= 0 || bonusX2 >= width) {
    bonusSpeedX2 *= -1;
  }
  if (bonusY2 <= 0 || bonusY2 >= height) {
    bonusSpeedY2 *= -1;
  }
}

// Draw the player's paddle with a glowing outline
rectMode(CENTER);
strokeWeight(5);
stroke(glowColor);
fill(color2[0], color2[1], color2[2]);
if (key == 'a') fill(150, 150, 150, 20);
if (key == 'b') fill(255, 0, 0, 20);
rect(600, mouseY, 30, 90);
noStroke();

  // Spawn bonus item 1 secara acak
  if (!bonus1Active && random(1) < 0.002) {
    bonusX1 = random(width);
    bonusY1 = random(height);
    bonusSpeedX1 = random(1, 3);
    bonusSpeedY1 = random(1, 3);
    bonus1Active = true;
  }

  // Spawn bonus item 2 secara acak
  if (!bonus2Active && random(1) < 0.001) {
    bonusX2 = random(width);
    bonusY2 = random(height);
    bonusSpeedX2 = random(1, 3);
    bonusSpeedY2 = random(1, 3);
    bonus2Active = true;
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
    animateText(score);
  }

  if (xPos > width ) {
    gameOver = true;
  }
  for (int i = animatedTexts.size() - 1; i >= 0; i--) {
    AnimatedText animatedText = animatedTexts.get(i);
    animatedText.update();
    animatedText.display();
    if (animatedText.isFaded()) {
      animatedTexts.remove(i);
    }
  }
}

void drawStartScreen() {
  background(100, 100, 100, 0);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(48);
  text(gameName, width / 2, height / 2 - 100); // Menampilkan nama game
  text("Click to Start", width / 2, height / 2);
}

void drawGameOverScreen() {
  background(100, 100, 100, 0);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(48);
  text("Game Over", width / 2, height / 2 - 50);
  textSize(24);
  text("Score: " + score, width / 2, height / 2);
  textSize(32);
  text("Click to Restart", width / 2, height / 2 + 50);
}

void mousePressed() {
  if (!gameStarted) {
    gameStarted = true;
  } else if (gameOver) {
    restartGame();
  }
}

void restartGame() {
  gameOver = false;
  score = 0;
  xPos = width / 2;
  yPos = height / 2;
  xSpeed = -5;
  ySpeed = 1;
  loop();
}

void animateText(int score) {
  textAlign(CENTER);
  textSize(64);
  fill(255);
  
  if (score % 3 == 0) {
    animatedTexts.add(new AnimatedText("Good", random(width), random(height)));
  } else if (score % 3 == 1) {
    animatedTexts.add(new AnimatedText("Wonderful", random(width), random(height)));
  } else {
    animatedTexts.add(new AnimatedText("Fantastic", random(width), random(height)));
  }
}

class AnimatedText {
  String text;
  float x, y;
  int opacity = 255;
  
  AnimatedText(String text, float x, float y) {
    this.text = text;
    this.x = x;
    this.y = y;
  }
  
  void update() {
    opacity -= 2;
  }
  
  void display() {
    fill(255, opacity);
    text(text, x, y);
  }
  
  boolean isFaded() {
    return opacity <= 0;
  }
}
