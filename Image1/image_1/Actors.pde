enum ActorStatus { Running, Finished }

public abstract class ActorBase {
  
  protected int rate;
  protected int framesActed = 0; 
  
  protected ActorStatus status = ActorStatus.Running;
  
  ActorBase(int rate){
    this.rate = rate;
  }
  
  public abstract void work();
  
  public boolean isRunning() {
    return this.status == ActorStatus.Running;
  }
}



public class ActorRectPainter extends ActorBase {

  Rect border;
  int i, j;
  int step;
  int rectWidth;
  
  ArrayList<Point> paintedRects = new ArrayList<Point>();
  
  ActorRectPainter(Rect border, int step, int rectWidth, int rate) {
    super(rate);
    
    this.border = border;      
    this.i = step + (int)border.x;
    this.j = step + (int)border.y;
    this.step = step;
    this.rectWidth = rectWidth;
  }
  
  public final void work() {
    stroke(255, 255, 255, 50);
    fill(255, 255, 255, 50);
    rectMode(CENTER);
      
    if (!this.isRunning()) {
      return;
    }
    
    for (Point p : paintedRects) {
        rect(p.x, p.y, rectWidth, rectWidth);
    }
      
    rect(i, j, rectWidth, rectWidth);
    paintedRects.add(new Point(i, j));
      
    if (j + step >= border.h + border.y) {
      j = step + (int)border.y;
      if (i + step >= border.w + border.x) {
        this.status = ActorStatus.Finished;
        return;
      }
      else {
        i += step;
      }
    }
    else {
      j += step;
    }

    ++this.framesActed;
  }
}





public class GridMaker extends ActorBase {
  
  private final PImage img;
  private final Point topLeft;
  private final Grid grid;
  private final int step;
  private final int rw; // размер ячейки грида
  
  GridMaker(PImage img_, Point topLeft_, Grid gr, int step_, int w_) { 
    super(1);
    
    img = img_;
    topLeft = topLeft_;
    grid = gr;
    step = step_;
    rw = w_;
  }
  
  public final void work() {
    if (this.status == ActorStatus.Finished) { 
      return; 
    }
    
    int w = img.width / step - (img.width % step != 0 ? 0 : 1); //<>//
    int h = img.height / step - (img.height % step != 0 ? 0 : 1);
    
    grid.initGrid(h, w);
    
    for (int i = 0; i < w; ++i) {  // columns
      for (int j = 0; j < h; ++j) {  // rows
        // topleft cell coords
        int x = step + step * i - rw / 2 + topLeft.x;
        int y = step + step * j - rw / 2 + topLeft.y;
        
        PImage cellImg = new PImage(rw, rw);
        grid.setImage(cellImg, j, i, x, y);
        
        cellImg.copy(img, x - topLeft.x, y - topLeft.y, rw, rw, 0, 0, rw, rw);
      }
    }
    
    this.status = ActorStatus.Finished;
  }
}


public class GridPainter extends ActorBase {
  
  private final Grid grid;
  
  GridPainter(Grid g) { 
    super(1);
    
    grid = g;
  }
  
  public final void work() {
    
    for (int i = 0; i < grid.columns; ++i) {
      for (int j = 0; j < grid.rows; ++j) {
        PointedImage img = grid.image(j, i);
        image(img.img, img.p.x, img.p.y);
      }
    }
    
    this.status = ActorStatus.Finished;
  }
  
}
