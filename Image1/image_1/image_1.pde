static final String file = "Cage.jpg";

PImage imgOrig;  // original
PImage imgCust;  // custom

ActorBase actor1;

Rect origRect() {
  return new Rect(0, 0, width / 2, height);
}

Rect customRect() {
  return new Rect(width / 2, 0, width / 2, height);
}

Rect fitImageToRect(PImage img, Rect rect) {
  int w = img.width, h = img.height;
  
  if (img.width > rect.w || img.height > rect.h) {
    float dw = rect.w / img.width;
    float dh = rect.h / img.height;
  
    w = (int)(img.width * min(dw, dh));
    h = (int)(img.height * min(dw, dh));
  }
  
  float x = rect.x + (rect.w / 2 - w / 2);
  float y = rect.y + (rect.h / 2 - h / 2);
  
  return new Rect(x, y, w, h);
}

void setup() {
  size(1200, 600);
  frameRate(60);
  imgOrig = loadImage(file);
  imgCust = loadImage(file);
  imgCust.filter(GRAY);
  
  Rect fr = fitImageToRect(imgOrig, origRect());
  
  actor1 = new ActorRectPainter(fr,
                                (int)(fr.x + 20), (int)(fr.y + 20), 
                                20, 5, 
                                1);
  
  float w = imgOrig.width;
  float h = imgOrig.height;
  float dw = w / (width / 2);
  float dh = h / height;
  if (dw <= 1 && dh <= 1) {
    return;
  }
  int s = imgCust.pixelHeight * imgCust.pixelWidth;

  for(int i = 0; i < s; ++i) {
    int c = imgCust.pixels[i]; 
    int r=(c&0x00FF0000)>>16; // red part
    int g=(c&0x0000FF00)>>8; // green part
    int b=(c&0x000000FF); // blue part
    int grey=(r+b+g)/3;

    if (grey > 255 / 3) {
      imgCust.pixels[i] = color(255, 0, 0);
    }
  }
}

void drawImage(PImage img, Rect rect) {
  Rect r = fitImageToRect(img, rect);
  image(img, r.x, r.y, r.w, r.h);
}

void draw() {
  background(100);
  drawImage(imgOrig, origRect());
  //drawImage(imgCust, customRect());
  
  actor1.work();
}
