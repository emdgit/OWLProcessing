float toRadian(float x) {
  return x * PI / 180;
}

float toDegree(float x) {
  return x * 180 / PI % 360;
}

int W = 500;
int H = 500;
int w = 30;  // box width

float angle = PI / 2;
float x_rotation;
float y_rotation;
float z_rotation;
float w_translation;
float h_translation;
float z_translation;
float maxD = dist(0, 0, 550, 550);

void setup() {
  size(700, 700, P3D);
  W = 700;
  H = 700;
  x_rotation = Magic.xRot;
  y_rotation = Magic.yRot;
  z_rotation = Magic.zRot;
  w_translation = Magic.wTrn;
  h_translation = Magic.hTrn;
  z_translation = Magic.zTrn;
}

void draw() {
  background(100);
  ortho();

  //translate(w_translation, h_translation, z_translation);
  //rotateX(x_rotation);
  //rotateY(y_rotation);
  //rotateZ(z_rotation);
  
  translate(150, 200, -200);
  rotateX(x_rotation);
  rotateY(y_rotation);
  
  float s = W * 0.75;
  
  for (float z = 0; z < s; z += w) {
    for (float x = 0; x < s; x += w) {
      push();
      float d = dist(z, x, s/2, s/2);
      float offset = map(d, 0, maxD/2, -2, 2);
      float a = angle + offset;
      float h = map(sin(a), -1, 1, 50, 300);
      translate(x, 0, z - height / 2);
      box(w, h, w);
      pop();
    }
  }

  angle += 0.1;
  
}

void keyPressed() {
  if (key != CODED) {
    switch (key) {
      case 'w': { x_rotation += toRadian(10); break; }
      case 's': { x_rotation -= toRadian(10); break; }
      case 'a': { y_rotation -= toRadian(10); break; }
      case 'd': { y_rotation += toRadian(10); break; }
      case 'q': { z_rotation -= toRadian(10); break; }
      case 'e': { z_rotation += toRadian(10); break; }
    }
  }
  else {
    switch(keyCode) {
      case UP: { h_translation -= 50; break; }
      case DOWN: { h_translation += 50; break; }
      case LEFT: { w_translation -= 50; break; }
      case RIGHT: { w_translation += 50; break; }
    }
  }
  printInfo();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  z_translation += 100 * e;
  printInfo();
}

void printInfo() {
  String str = 
    "xRotation: " + toDegree(x_rotation) + 
    "\nyRotation: " + toDegree(y_rotation) + 
    "\nzRotation: " + toDegree(z_rotation) + 
    "\nwTranslate: " + w_translation + 
    "\nhTranslate: " + h_translation + 
    "\nzTranslate: " + z_translation + "\n\n";
  System.out.println(str);
}
