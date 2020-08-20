static final int _stars = 90;
static final int _speed = 5;

public class Star {
  float x, y, dx, dy, px, py;
  int lineUpdate;
  public Star(float x, float y) {
    this.x = x;
    this.y = y;
    px = x;
    py = y;
    lineUpdate = 0;
    updateSpeed();
  }
  public void draw() {
    stroke(255);
    strokeWeight(1.2);
    circle(x, y, 0.9);
    line(px, py, x, y);
  }
  public void move() {
    ++lineUpdate;
    if (lineUpdate == 3) {
      px = x;
      py = y;
      lineUpdate = 0;
    }

    x += dx;
    y += dy;
    
  }
  public void updateSpeed() {
    dy = map(y, 0, width, -_speed, _speed);
    dx = map(x, 0, width, -_speed, _speed);
  }
  public boolean isOut() {
    return (x < 0 || x > width || y < 0 || y > height);
  }
}

ArrayList<Star> arr;

void setup() {
  size(500, 500);
  arr = new ArrayList<Star>();
  for ( int i = 0; i < _stars; ++i ) {
    int x = (int)random(0, width);
    int y = (int)random(0, height);
    arr.add(arr.size(), new Star(x, y));
  }
}

void draw() {
  background(0);
  for ( int i = 0; i < _stars; ++i ) {
    Star s = arr.get(i);
    if (s.isOut()) {
      arr.remove(i);
      //System.out.println("OUT");
    }
    s.draw();
    s.move();
    s.updateSpeed();
    while(arr.size() != _stars) {
      int x = (int)random(0, width);
      int y = (int)random(0, height);
      arr.add(arr.size(), new Star(x, y));
    }
  }
}
