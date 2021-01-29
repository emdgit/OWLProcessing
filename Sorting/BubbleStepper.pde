public class BubbleStapper extends SortStapper {
  BubbleStapper(int count) {
    super(count, new MArray());
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
    
    if (array.get(k) < array.get(k - 1)) {
      array.swap(k, k - 1);
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
