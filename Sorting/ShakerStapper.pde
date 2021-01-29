public class ShakerStapper extends SortStapper {
  
  public ShakerStapper(int count) {
    super(count, new MArray());
    this.current = 0;
    left = 0;
    right = count - 1;
  }
  
  @Override
  boolean step() {
    
    this.current = k;
    this.printArray();
    
    if (left < right) {
      if (direction) {
        //lastSwap = left;
        if (array.get(k) > array.get(k + 1)) {
          array.swap(k, k + 1);
          lastSwap = k + 1;
        }
        ++k;
        if (k > right - 1) {
          right = lastSwap;
          direction = !direction;
          k = right - 1;
        }
      } else {
        //lastSwap = right;
        if (array.get(k) > array.get(k + 1)) {
          array.swap(k, k + 1);
          lastSwap = k;
        }
        --k;
        if (k < left) {
          left = lastSwap;
          direction = !direction;
          k = left;
        }
      }
      
    } else {
      return true;
    }
    
    return true;
  }
  
  private int k = 1;  // internal loop
  private int left, right;  // left/right borders
  private int lastSwap = 0;
  private boolean direction = true;  // 1 - toRight, 2 - toLeft
}
