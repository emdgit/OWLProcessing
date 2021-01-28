abstract class IStepper {
  /// Returns true if there're still some steps to do
  abstract boolean step();
}

class StepDrive {
  
  public StepDrive() {
    steppers = new ArrayList<IStepper>();
  }
  
  public final void addStepper(IStepper st) {
    if (st == null) {
      System.out.println("Got Null as IStepper");
      return;
    }
    steppers.add(st);
  }
  
  void work() {
    if (workIndex == steppers.size()) {
      return;
    }
    if (steppers.get(workIndex).step()) {
      return;
    } else {
      workIndex++;
    }
  }
  
  private ArrayList<IStepper> steppers;
  private int workIndex = 0;
}
