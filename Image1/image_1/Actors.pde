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
  int i0 = 0, j0 = 0, i, j;
  int step;
  int rectWidth;
  
  ArrayList<Point> paintedRects = new ArrayList<Point>();
  
  ActorRectPainter(Rect border, int i, int j, int step, int rectWidth, int rate) {
    super(rate);
    
    this.border = border; //<>//
    this.i0 = i;
    this.j0 = j;
    this.i = this.i0;
    this.j = this.j0;
    this.step = step;
    this.rectWidth = rectWidth;
  }
  
  public final void work() {
    
    for (Point p : paintedRects) {
        rect(p.x, p.y, rectWidth, rectWidth);
    }
      
    if (!this.isRunning()) {
      return;
    }
    
    if (this.framesActed >= this.rate && this.framesActed % this.rate == 0) {
      stroke(255);
        
      rect(i, j, rectWidth, rectWidth);
      paintedRects.add(new Point(i, j));
      
      if (j + step >= border.h + border.y) {
        j = j0;
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
    }

    ++this.framesActed;
  }
}
