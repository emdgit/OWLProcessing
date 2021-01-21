ArrayList<Point> points;
ArrayList<Triangle> triangles;

static final int circleR = 5;
static final int pointCount = 150;
float localS = Float.MAX_VALUE;
int a = 0, b = 1, c = 2;
int aMin = 0, bMin = 0, cMin = 0;
int movingAngle = 0;
Stack aStack, bStack, cStack;
Triangle localT;

boolean pointsUsed[] = new boolean[pointCount];

boolean checkIfAllUsed() {
  for (boolean b : pointsUsed) {
    if (!b) {
      return false;
    }
  }
  return true;
}

void tStep() {
  switch(movingAngle) {
    case 0:
      
    break;
  }
}

void setup() {
  size(600, 600);

  points = new ArrayList<Point>();
  triangles = new ArrayList<Triangle>();
  aStack = new Stack();
  bStack = new Stack();
  cStack = new Stack();
  
  final int rd2 = circleR / 2 + 1;

  for (int i = 0; i < pointCount; ++i) {
    points.add(new Point(random(rd2, width - rd2), random(rd2, height - rd2)));
    pointsUsed[i] = false;
  }
 
  points.sort(new PointNullDistanceComparator()); 
  localT = new Triangle(points.get(a), points.get(b), points.get(c));
  
  frameRate(3);
}

void draw() {
  background(12);
  for (int i = 0; i < pointCount; ++i) {
    noStroke();
    fill(50, 190, 0);
    circle(points.get(i).x, points.get(i).y, circleR);
  }
  
  for (Triangle t : triangles) {
    t.paint();
  }
  
  if (!checkIfAllUsed()) {
    stroke(12, 200, 20);
    localT.paint();
    if (localT.square() < localS) {
      localS = localT.square();
      aMin = a;
      bMin = b;
      cMin = c;
    }
    if (a != pointCount && a != b && a != c) {
      tStep();
    }
  }
}
