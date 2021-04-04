// Find shortest line
  //   Make it current line
  // Find 3'rd point a triangle has minimum perimeter with
  // Remove used points & add new Triangle
public enum Phase {
  FIND_SHORTEST_LINE,
  FIND_THIRD_POINT,
  DONE
}

public enum ExitStatus {
  FINISHED,
  IN_WORK,
  ERROR
}

ArrayList<Point> points;
ArrayList<Triangle> triangles;

Triangle min_triangle;
Triangle current_triangle;

Line current_min_line;
Line current_searched_line;

int current_line_point = 0;
int current_searched_point = 1;
int current_3_point = 0;

Phase currentPhase = Phase.FIND_SHORTEST_LINE;

// Radius of point
static final int circleR = 5;
static int pointCount = 27;

final ExitStatus findShortestLine() {
  // Needs: 
  // - current minimum line
  // - current searched line (what are we now making a comparison with)
  // - current line point (The Point we're making line from)
  // - current check point
  
  current_min_line.paint();
  current_searched_line.paint();
  
  final float len = current_searched_line.len();
  
  if (len < current_min_line.len()) {
    current_min_line.fromLine(current_searched_line);
  }
  
  current_searched_point++;
  if (current_searched_point == current_line_point) {
    current_searched_point++;
  }
  if (current_searched_point >= pointCount) {
    current_searched_point = 0;
    current_line_point++;
    if (current_line_point >= pointCount) {
      return ExitStatus.FINISHED;
    }
  }
  
  current_searched_line.setP1(points.get(current_line_point));
  current_searched_line.setP2(points.get(current_searched_point));
  
  return ExitStatus.IN_WORK;
}

boolean isThirdPointOnLine() {
  if (current_3_point >= pointCount) {
    return false;
  }
  Point p = points.get(current_3_point);
  if (p.equals(current_min_line.p1)) {
    return true;
  }
  if (p.equals(current_min_line.p2)) {
    return true;
  }
  return false;
}
 //<>//
// Передвинуть 3ю точку. (Поиск треугольника)
boolean moveThirdPoint() {
  do {
    current_3_point++;
  } while (isThirdPointOnLine());
  if (current_3_point >= pointCount) {
      return false;
  }
  return true;
}

void moveThirdPointIfItOnLine() {
  while (isThirdPointOnLine()) {
    current_3_point++;
  } 
}

ExitStatus findThirdPoint() {
  // Needs:
  // - Minimum triangle
  // - Current 3'rd point
  // - Current triangle
  
  current_min_line.paint(); //<>//
  moveThirdPointIfItOnLine();
  
  if (current_triangle == null) {
    current_triangle = new Triangle(current_min_line.getP1(),
                                    current_min_line.getP2(),
                                    points.get(current_3_point));
    current_triangle.setColor(255, 255, 255);
  }
  if (min_triangle == null) {
    min_triangle = new Triangle(current_min_line.getP1(),
                                current_min_line.getP2(),
                                points.get(current_3_point));
    min_triangle.setColor(200, 123, 12);
  }
  
  min_triangle.paint();
  current_triangle.paint();
  
  boolean res = moveThirdPoint();
  
  if (!res) {
    triangles.add(min_triangle);
    min_triangle.print();
    return ExitStatus.FINISHED;
  }
  
  current_triangle.setP3(points.get(current_3_point));
  
  if (current_triangle.perimeter() < min_triangle.perimeter()) {
    min_triangle.setP3(current_triangle.p3);
  }
  
  return ExitStatus.IN_WORK;
}

void setup() {
  size(600, 600);

  points = new ArrayList<Point>();
  triangles = new ArrayList<Triangle>();
  
  final int rd2 = circleR / 2 + 1;

  for (int i = 0; i < pointCount; ++i) {
    points.add(new Point(random(rd2, width - rd2), random(rd2, height - rd2)));
  }
 
  points.sort(new PointNullDistanceComparator());
  
  current_min_line = new Line(points.get(0), points.get(1));
  current_min_line.setColor(12, 123, 200);
  current_searched_line = new Line(points.get(0), points.get(1));
  current_searched_line.setColor(255, 255, 255);
  
  //System.out.println(current_searched_point == null); //<>//
  
  //frameRate(6);
}

void draw() {
  // Find shortest line
  //   Make it current line
  // Find 3'rd point a triangle has minimum perimeter with
  // Remove used points & add new Triangle
  
  background(12);
  
  for (Point p : points) {
    p.paint();
  }
  
  for (Triangle t : triangles) {
    t.paint();
  }

  ExitStatus st;

  switch (currentPhase) {
    case FIND_SHORTEST_LINE: { //<>//
      st = findShortestLine();
      switch (st) {
        case FINISHED: {
          currentPhase = Phase.FIND_THIRD_POINT;
          break;
        }
        case IN_WORK: {
          break;
        }
        case ERROR: {
          currentPhase = Phase.DONE;
          break;
        }
      }
      break;
    }
    case FIND_THIRD_POINT: {
      st = findThirdPoint();
      switch (st) {
        case FINISHED: {
          currentPhase = Phase.FIND_SHORTEST_LINE;
          current_line_point = 0;
          current_searched_point = 1;
          current_3_point = 0;
          for (int i = 0; i < points.size();) {
            if (min_triangle.hasVertex(points.get(i))) {
              points.remove(i);
              pointCount--;
            } else {
              i++;
            }
          }
          min_triangle = null;
          current_triangle = null;
          
          if (pointCount == 0) {
            currentPhase = Phase.DONE;
            break;
          }
          
          current_min_line.setP1(points.get(0));
          current_min_line.setP2(points.get(1));
          
          current_searched_line.setP1(points.get(0));
          current_searched_line.setP1(points.get(1));
          break;
        }
        case IN_WORK: {
          break;
        }
        case ERROR: {
          currentPhase = Phase.DONE;
          break;
        }
      }
      break;
    }
    case DONE: {
      break;
    }
  }
  
}
