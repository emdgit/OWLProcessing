class Triangle {
  public Triangle(float x1, float y1,
    float x2, float y2, float x3, float y3) {
      p1 = new Point(x1, y1);
      p2 = new Point(x2, y2);
      p3 = new Point(x3, y3);
    }
    
  public Triangle(Point p1, Point p2 ,Point p3) {
    reset(p1, p2, p3);
  }
  
  public final void paint() {
    line(p1.x, p1.y, p2.x, p2.y);
    line(p2.x, p2.y, p3.x, p3.y);
    line(p3.x, p3.y, p1.x, p1.y);
  }
  
  public final void reset(Point p1, Point p2 ,Point p3) {
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
  }
  
  public final void setP1(Point p) {
    p1 = p;
  }
  
  public final void setP2(Point p) {
    p2 = p;
  }
  
  public final void setP3(Point p) {
    p3 = p;
  }
  
  public final float square() {
    return 0.5 * (p1.x * (p2.y - p3.y) + p2.x * (p3.y - p1.y) + p3.x * (p1.y - p2.y));
  }
  
  public Point p1, p2, p3;
}
