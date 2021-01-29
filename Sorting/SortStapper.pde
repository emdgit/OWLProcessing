abstract class SortStapper extends IStepper {
  
  SortStapper(int count, IArray arr) {
    super();
    this.count = count;
    this.array = arr;
    this.array.initialize(count);
  }
  
  public final void printArray() {
    int w = width / this.count;
    
    stroke(0, 255, 0);
    strokeWeight(1.5);
    
    for (int i = 0; i < count; ++i) {
      if (i == current) {
        fill(250, 0, 0);
      } else {
        fill(0,0,0);
      }
      rect(i * w, height - this.array.get(i), w, this.array.get(i));
    }
  }
  
  protected IArray array; 
  protected int count = 0;
  protected int current = -1; // Active value. Will be painted with red color
}
