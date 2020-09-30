public class Grid {
  
  public PointedImage grid[][];
  
  public int rows;
  public int columns;
  
  public final void initGrid(int r, int c) {
    grid = new PointedImage[r][c];
    
    rows = r;
    columns = c;
  }
  
  public final PointedImage image(int r, int c) {
    return grid[r][c];
  }
  
  public final void setImage(PImage img, int r, int c, int x, int y) {
    grid[r][c] = new PointedImage(img, (new Point(x, y)));
  }
  
}
