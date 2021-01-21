public final class Stack {
  Stack() {
    this.list = new IntList();
  }
  
  public final void push(int val) {
    list.append(val);
  }
  
  public final void pop() {
    if (empty()) {
      return;
    }
    list.remove(list.size() - 1);
  }
  
  public final int top() {
    if (empty()) {
      return 0;
    }
    return list.get(list.size() - 1);
  }
  
  public final boolean empty() {
    return list.size() == 0;
  }
  
  private IntList list;
}
