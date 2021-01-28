StepDrive mainDrive;

void setup() {
  size(1000, 450);
  mainDrive = new StepDrive();
  //mainDrive.addStepper(new BubbleStapper(50));
  mainDrive.addStepper(new ShakerStapper(100));
   //<>//
  //frameRate(5);
}

void draw() {
  background(150);
  mainDrive.work();
}
