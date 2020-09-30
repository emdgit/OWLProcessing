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
      
    if (!this.isRunning()) {
      return;
    }
    
    for (Point p : paintedRects) {
        rect(p.x, p.y, rectWidth, rectWidth);
    }
      
    rect(i, j, rectWidth, rectWidth);
    paintedRects.add(new Point(i, j));
      
    if (j + step + 2 * rectWidth > border.h + border.y) {
      j = step + (int)border.y;
      if (i + step + 2 * rectWidth >border.w + border.x) {
        this.status = ActorStatus.Finished;
        return;
      }
      else {
        i += step + rectWidth;
      }
    }
    else {
      j += step + rectWidth;
    }

    ++this.framesActed;
  }
}





// Делает 2D сетку из PImage
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
    
    int w = img.width / (step + rw);
    int h = img.height / (step + rw);
    
    grid.initGrid(h, w);
    
    for (int i = 0; i < w; ++i) {  // columns
      for (int j = 0; j < h; ++j) {  // rows
        // topleft cell coords
        int x = step + i * step + i * rw + topLeft.x;
        int y = step + j * step + j * rw + topLeft.y;
        
        PImage cellImg = new PImage(rw, rw);
        grid.setImage(cellImg, j, i, x, y);
        
        cellImg.copy(img, x - topLeft.x, y - topLeft.y, rw, rw, 0, 0, rw, rw);
      }
    }
    
    this.status = ActorStatus.Finished;
  }
}






public enum GPState { Starting, Moving, Finishing }

public class GridPainter extends ActorBase {
  
  private final Grid  grid;
  private GPState     state           = GPState.Starting;
  private Point       origPoint[][];
  private int         moveSteps       = 50;
  private int         moveSteps_i     = 1;
  
  GridPainter(Grid g) { 
    super(1);
    
    grid = g;
  }
  
  public final void work() {
    switch (state) {
      case Starting:
        onStarting();
        state = GPState.Moving;
        break;
      case Moving:
        if (onMoving()) {
          state = GPState.Finishing;
        }
        break;
      case Finishing:
        onFinish();
        break;
      default: break;
    }
    
    this.status = ActorStatus.Finished;
  }
  
  protected void onStarting() {
    final int r = grid.rows;
    final int c = grid.columns;
    
    origPoint = new Point[grid.rows][grid.columns];
    
    for (int i = 0; i < c; ++i) {
      for (int j = 0; j < r; ++j) { //<>//
        origPoint[j][i] = grid.image(j, i).p;
      }
    }
    
    drawGrid();
  }

  // Вернет true, если фаза закончила работу
  protected boolean onMoving() {
    if (moveSteps_i > moveSteps) {
      return true;
    }
    
    final int r = grid.rows;
    final int c = grid.columns;
    final int rw = grid.image(0, 0).img.width;  // Ширина ячейки
    final int fr_w = c * rw;                    // Ширина финального прямоугольника
    final int fr_h = r * rw;                    // Высота финального прямоугольника
    final int fr_x = width / 2 - fr_w / 2;
    final int fr_y = height / 2 - fr_h / 2;
    
    for (int i = 0; i < c; ++i) {
      for (int j = 0; j < r; ++j) {
        int x1 = origPoint[j][i].x;
        int y1 = origPoint[j][i].y;
        int x2 = fr_x + i * rw;
        int y2 = fr_y + j * rw;
        grid.setX(j, i, (int)map(moveSteps_i, 1, moveSteps, x1, x2));
        grid.setY(j, i, (int)map(moveSteps_i, 1, moveSteps, y1, y2));
      }
    }
    
    drawGrid();
    
    ++moveSteps_i;
    return false;
  }
  
  protected void onFinish() {
    drawGrid();
  }
  
  protected void drawGrid() {
    final int r = grid.rows;
    final int c = grid.columns;
    
    for (int i = 0; i < c; ++i) {
      for (int j = 0; j < r; ++j) {
        PointedImage img = grid.image(j, i);
        image(img.img, img.p.x, img.p.y);
      }
    }
  }
  
}
