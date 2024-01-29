float xPos, yPos;
float xSpeed = -5, ySpeed = 1;

// Color
int[] color1 = {int(random(0, 255)), int(random(0, 255)), int(random(0, 255))};
int[] color2 = {int(random(0, 255)), int(random(0, 255)), int(random(0, 255))};
int[] color3 = {int(random(0, 255)), int(random(0, 255)), int(random(0, 255))};

int score = 0;
ArrayList<AnimatedText> animatedTexts = new ArrayList<AnimatedText>();

void setup() {
  size(700, 500);
  xPos = width / 2;
  yPos = height / 2;
  background(100, 100, 100, 0);
}

void draw() {
  background(100, 100, 100, 0); // Menggambar ulang latar belakang
  
  rectMode(CORNER);
  fill(100, 100, 100, 20);
  rect(0, 0, 700, 500);
  fill(255);
  textAlign(CENTER);
  textSize(32);
  
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
    animateText(score);
  }

  if (xPos > width) {
    fill(255);
    rect(0, 0, 10000, 10000);
    fill(0);
    textAlign(CENTER);
    textSize(32);
    text("Final Score: " + score, width / 2, height / 2);
    noLoop();
  }
  
  // Menampilkan skor di bawah
  fill(255);
  textAlign(CENTER);
  text("Score: " + score, width / 2, height - 20);
  
  // Memperbarui dan menampilkan animasi teks
  for (int i = animatedTexts.size() - 1; i >= 0; i--) {
    AnimatedText animatedText = animatedTexts.get(i);
    animatedText.update();
    animatedText.display();
    if (animatedText.isFaded()) {
      animatedTexts.remove(i);
    }
  }
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
