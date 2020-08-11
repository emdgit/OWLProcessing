float toRadian(float x) {
  return x * PI / 180;
}

int W = 500;
int H = 500;
int w = 50;  // box width

void setup() {
  size(800, 800, P3D);
  W = 800;
  H = 800;
}

float angle = PI / 2;

void draw() {
  background(255);
  ortho();
  translate(0, H/2, 500);
  
  rotateX(PI / 8);
  
  float offset = 0;
  
  for (float i = w*0.5; i < W; i += w) {
    //push();
    pushMatrix();
    float a = angle;
    float h = map(sin(a + offset), -1, 1, 5, 100);
    translate(i, -PI/4, -100);
    box(w, h, w);
    popMatrix();
    //pop();
    offset += 0.2;
  }

  angle += 0.1;
  
}

void keyPressed() {
  switch (key) {
    case UP: {}
    case DOWN: {}
    case LEFT: {}
    case RIGHT: {}
    case VK_NUMPAD3: {}
  }
}
