abstract class IStepper {
  /// Returns true if there're still some steps to do
  abstract boolean step();
}

class StepDrive {
  void addStepper(IStepper st) {
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
