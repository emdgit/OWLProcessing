abstract class IArray {
  
  abstract int get(int index);
  abstract void set(int index, int value);
  abstract void reserve(int count);
  abstract void swap(int i, int j);
  
  void replace(int from, int to) { if (from == to) {} }
  
  public final void initialize(int count) {
    reserve(count); //<>//
    
    int max = height; //<>//
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





public class ListNode {
  public ListNode() {}
  public ListNode(int val) {
    this.value = val;
  }
  public ListNode(int val, ListNode prev) {
    prev.next = this;
    this.prev = prev;
    this.value = val;
  }
  public final boolean hasNext() {
    return next != null;
  }
  public final ListNode next() {
    return next;
  }
  public final void setNext(ListNode next) {
    this.next = next;
  }
  public final ListNode prev() {
    return prev;
  }
  public final void setPrev(ListNode prev) {
    this.prev = prev;
  }
  public final int value() {
    return value;
  }
  public final void setValue(int val) {
    value = val;
  }
  private ListNode next = null;
  private ListNode prev = null;
  private int value = 0;
}


public class MList extends IArray {
  
  public MList() { 
    super();
  }
  
  @Override
  public final int get(int index) {
    return getNode(index).value();
  }
  
  @Override
  public final void set(int index, int value) {
    ListNode n = getNode(index);
    n.setValue(value);
  }
  
  @Override
  public final void swap(int i, int j) {
    if (i == j) {
      return;
    }
    ListNode nodeI = getNode(i);
    ListNode nodeJ = getNode(j);
    ListNode nodeIPrev = nodeI.prev();
    ListNode nodeINext = nodeI.next();
    ListNode nodeJPrev = nodeJ.prev();
    ListNode nodeJNext = nodeJ.next();
    
    if (abs(i - j) == 1) {
      // * * L R * * 
      ListNode left = i < j ? nodeI : nodeJ;
      ListNode leftPrev = i < j ? nodeIPrev : nodeJPrev;
      ListNode right = i > j ? nodeI : nodeJ;
      ListNode rightNext = i > j ? nodeINext : nodeJNext;
      
      right.setNext(left);
      left.setPrev(right);
      
      right.setPrev(leftPrev);
      if (leftPrev != null) {
        leftPrev.setNext(right);
      }
      
      left.setNext(rightNext);
      if (rightNext != null) {
        rightNext.setPrev(left);
      }
      
    } else { 
      if (nodeIPrev != null) {
        nodeIPrev.setNext(nodeJ);
      }
      nodeJ.setPrev(nodeIPrev);
      
      if (nodeINext != null) {
        nodeINext.setPrev(nodeJ);
      }
      nodeJ.setNext(nodeINext);
      
      if (nodeJPrev != null) {
        nodeJPrev.setNext(nodeI);
      }
      nodeI.setPrev(nodeJPrev);
      
      if (nodeJNext != null) {
        nodeJNext.setPrev(nodeI);
      }
      nodeI.setNext(nodeJNext);
    }
    
    if (i == 0) {
      this.node = nodeJ;
    } else if (j == 0) {
      this.node = nodeI;
    }
  }
  
  @Override
  void reserve(int count) {
    node = new ListNode(0);
    ListNode local = node;
    for (int i = 1; i < count; ++i) {
      ListNode n = new ListNode(0, local);
      local = n;
    }
    this.count = count;
  }
  
  @Override
  public final void replace(int from, int to) {
    if (from == to) {
      return;
    }
    // * * * T * * F * * * 
    ListNode nodeF = getNode(from);
    ListNode nodeT = getNode(to);
    ListNode nodeFPrev = nodeF.prev();
    ListNode nodeFNext = nodeF.next();
    ListNode nodeTPrev = nodeT.prev();
    
    if (nodeFPrev != null) {
      nodeFPrev.setNext(nodeFNext);
    }
    if (nodeFNext != null) {
      nodeFNext.setPrev(nodeFPrev);
    }
    if (nodeTPrev != null) {
      nodeTPrev.setNext(nodeF);
    }
    nodeF.setPrev(nodeTPrev);
    nodeF.setNext(nodeT);
    nodeT.setPrev(nodeF);
    
    if (from == 0) {
      this.node = nodeT;
    } else if (to == 0) {
      this.node = nodeF;
    }
  }
  
  private final ListNode getNode(int index) {
    if (index >= count) {
      return null;
    }
    ListNode local = node;
    for (int i = 0; i < index; ++i) {
      local = local.next();
    }
    return local;
  }
  
  ListNode node;
}
