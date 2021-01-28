abstract class SortStapper extends IStepper {
  
  SortStapper(int count) {
    super();
    this.count = count;
    this.array = new int[count];
    this.initialize();
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
      rect(i * w, height - this.array[i], w, this.array[i]);
    }
  }
  
  final void initialize() {
    int max = height;
    int min = (int)(height * 0.05);
    int dh = (max - min) / count;
    
    // Initial fill
    for (int i = 0; i < count; ++i) {
      array[i] = min;
      min += dh;
    }
    
    // Shuffle
    for (int i = 0; i < this.count; ++i) {
      int j;
      do {
        j = (int)random(0, this.count);
      } while (j == i);
      int tmp = this.array[i];
      this.array[i] = this.array[j];
      this.array[j] = tmp;
    }
  }
  
  protected int array[]; 
  protected int count;
  protected int current = -1; // Active value. Will be painted with red color
}
