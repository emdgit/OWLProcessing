public class Line {
  public Line(Point p1, Point p2) {
    this.p1 = p1;
    this.p2 = p2;
  }
  
  public final void fromLine(Line other) {
    this.p1 = other.p1;
    this.p2 = other.p2;
  }
  
  public final void setP1(Point p) { this.p1 = p; }
  public final void setP2(Point p) { this.p2 = p; }
  
  public final Point getP1() { return this.p1; }
  public final Point getP2() { return this.p2; }
  
  public final void setColor(int r, int g, int b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  public final void paint() {
    strokeWeight(3);
    stroke(r, g, b);
    line(p1.x, p1.y, p2.x, p2.y);
    p1.paint();
    p2.paint();
  }
  
  public final void print() {
    String line = "Line((";
    line += String.valueOf(p1.x) + ", " + String.valueOf(p1.y) + "), (";
    line += String.valueOf(p2.x) + ", " + String.valueOf(p2.y) + "))";
    System.out.println(line);
  }
  
  public final float len() {
    final float x = p2.getX() - p1.getX();
    final float y = p2.getY() - p1.getY();
    return (float)Math.sqrt( x * x + y * y );
  }
  
  public final boolean less(Line other) {
    return this.len() < other.len();
  }
  
  private Point p1, p2;
  private int r = 255, g = 255, b = 255;
}
