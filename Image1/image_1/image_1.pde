static final String file = "Cage.jpg";

PImage imgOrig;  // original
Point origCoord; // TopLeft coords of orig rect
Grid grid;

ActorBase rectPainter;
ActorBase gridMaker;
ActorBase gridPainter;

Rect origRect() {
  //return new Rect(0, 0, width, height);
  return new Rect(0, 0, 300, 300);
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
  size(800, 400);
  int step = 20;
  int cellRectWidth = 5;
  
  imgOrig = loadImage(file);
  Rect fr = fitImageToRect(imgOrig, origRect());
  imgOrig.resize((int)fr.w, (int)fr.h);
  origCoord = new Point((int)fr.x, (int)fr.y);
  grid = new Grid();
  
  rectPainter = new ActorRectPainter(fr, step, cellRectWidth, 1);
  gridMaker = new GridMaker(imgOrig, origCoord, grid, step, cellRectWidth);
  gridPainter = new GridPainter(grid);
  
  // resize image
  float w = imgOrig.width;
  float h = imgOrig.height;
  float dw = w / (width / 2);
  float dh = h / height;
  
  if (dw <= 1 && dh <= 1) {
    return;
  }
}

void drawImage(PImage img, Point p) {
  image(img, p.x, p.y);
}

void draw() {
  background(100);
  
  if (rectPainter.isRunning()) {
    drawImage(imgOrig, origCoord);
  
    rectPainter.work();
  }
  else {
    if (gridMaker.isRunning()) {
      gridMaker.work();
    }
    else {
      gridPainter.work();
    }
  }
    
}
