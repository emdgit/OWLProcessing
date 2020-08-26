static final String file = "Cage.jpg";

PImage imgOrig;  // original
PImage imgCust;  // custom

Rect origRect() {
  return new Rect(0, 0, width / 2, height);
}

Rect customRect() {
  return new Rect(width / 2, 0, width / 2, height);
}

void setup() {
  size(1200, 600);
  imgOrig = loadImage(file);
  imgCust = loadImage(file);
  imgCust.filter(GRAY);
  
  float w = imgOrig.width;
  float h = imgOrig.height;
  float dw = w / (width / 2);
  float dh = h / height;
  if (dw <= 1 && dh <= 1) {
    return;
  }
  float k = max(dw, dh);
  imgOrig.resize((int)(w / k), (int)(h / k));
  imgCust.resize((int)(w / k), (int)(h / k));
  int s = imgCust.pixelHeight * imgCust.pixelWidth;
  int minC = 0, maxC = 0;
  for(int i = 0; i < s; ++i) {
    int c = imgCust.pixels[i]; 
    int r=(c&0x00FF0000)>>16; // red part
    int g=(c&0x0000FF00)>>8; // green part
    int b=(c&0x000000FF); // blue part
    int grey=(r+b+g)/3; //<>//
    minC = min(minC, grey);
    maxC = max(maxC, grey);
    if (grey > 255 / 3) {
      imgCust.pixels[i] = color(255, 0, 0);
    }
  }
  System.out.println(minC);
  System.out.println(maxC);
}

void drawImage(PImage img, Rect rect) {
  image(img,
        rect.x_,
        rect.w_ / 2 - img.height / 2,
        img.width,
        img.height );
}

void draw() {
  background(100);
  drawImage(imgOrig, origRect());
  drawImage(imgCust, customRect());
  //imgOrig.p
}
