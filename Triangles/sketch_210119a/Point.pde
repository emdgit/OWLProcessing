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

public class Point {
  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public final float distance() {
    return (float)Math.sqrt(x*x + y*y);
  }
  
  public final float distanceTo(Point p) {
    float dx = p.x - x;
    float dy = p.y - y;
    return (float)Math.sqrt(dx * dx + dy * dy);
  }
  
  public final void print() {
    System.out.println("Point(" + Float.toString(x) + ", " + Float.toString(y) + ")");
  }
  
  public float x = 0.0, y = 0.0;
}
