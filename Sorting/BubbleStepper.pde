public class BubbleStapper extends SortStapper {
  BubbleStapper(int count) {
    super(count);
    this.current = 0;
  }
  
  @Override
  boolean step() {
    this.current = k-1;
    printArray();
     //<>//
    if (this.p == this.count - 1) {
      return true;
    }
    
    if (array[k] < array[k-1]) {
      int tmp = array[k-1];
      array[k-1] = array[k];
      array[k] = tmp;
    }
    
    ++k;
    
    if (k == count - p) {
      k = 1;
      ++p;
    }
    
    return true;
  }
  
  private int p = 0;  // main loop
  private int k = 1;  // internal loop
}
