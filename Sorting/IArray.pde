abstract class IArray {
  
  abstract int get(int index);
  abstract void set(int index, int value);
  abstract void reserve(int count);
  abstract void swap(int i, int j);
  
  void replace(int from, int to) {}
  
  public final void initialize(int count) {
    reserve(count);
    
    int max = height;
    int min = (int)(height * 0.05);
    int dh = (max - min) / count;
    
    // Initial fill
    for (int i = 0; i < count; ++i) {
      set(i, min);
      min += dh;
    }
    
    // Shuffle
    for (int i = 0; i < this.count; ++i) {
      int j;
      do {
        j = (int)random(0, this.count);
      } while (j == i);
      swap(i, j);
    }
  }
  
  public final int size() { return count; }
  
  protected int count = 0;
}










public class MArray extends IArray {
  
  public MArray() {
    super();
  }
  
  @Override
  public final int get(int index) {
    return array[index];
  }
  
  @Override
  public final void set(int index, int value) {
    array[index] = value;
  }
  
  @Override
  public final void swap(int i, int j) {
    int tmp = this.array[i];
    this.array[i] = this.array[j];
    this.array[j] = tmp;
  }
  
  @Override
  void reserve(int count) {
    array = new int[count];
    this.count = count;
  }
  
  private int array[];
}
