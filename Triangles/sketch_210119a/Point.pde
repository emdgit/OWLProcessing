import java.util.Comparator;

public class PointNullDistanceComparator implements Comparator<Point> {
  @Override
  public int compare(Point p1, Point p2) {
    // -1 if 'p1' is closer to (0, 0) than 'p2'
    float d1 = p1.distance();
    float d2 = p2.distance();
    if (d1 < d2) {
      return -1;
    } else if (d1 > d2) {
      return 1;
    } else {
      return 0;
    }
  }
}

public static final int default_point_radius = 5;

public class Point {
  public Point(float x, float y) {
    this.x = x;
    this.y = y;
    this.r = default_point_radius;
  }
  
  public Point(float x, float y, int r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }
  
  public final float getX() { return this.x; }
  public final float getY() { return this.y; }
  public final float getR() { return this.r; }
  
  public final void setX(int x) { this.x = x; }
  public final void setY(int y) { this.y = y; }
  public final void setR(int r) { this.r = r; }
  
  public final float distance() {
    return (float)Math.sqrt(x*x + y*y);
  }
  
  public final float distanceTo(Point p) {
    float dx = p.x - x;
    float dy = p.y - y;
    return (float)Math.sqrt(dx * dx + dy * dy);
  }
  
  public final void paint() {
    noStroke();
    fill(50, 190, 0);
    circle(this.x, this.y, circleR);
  }
  
  public final void print() {
    System.out.println("Point(" + Float.toString(x) + ", " + Float.toString(y) + ")");
  }
  
  @Override
  public boolean equals(Object obj) {
    if (obj == this) { //<>// //<>//
      return true;
    }
    if (!(obj instanceof Point)) {
      return false;
    }
    
    Point other = (Point)obj;
    return other.x == this.x && other.y == this.y;
  }
  
  public float x = 0.0, y = 0.0;
  private int r;
}
