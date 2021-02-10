final int S = 100;

boolean field[][];
boolean tmp[][];

void paintField() {
  stroke(1);

  int w = width / S;
  
  for (int i = 0; i < S; ++i) {
    for (int j = 0; j < S; ++j) {
      if (field[i][j]) {
        fill(150);
      } else {
        fill(255);
      }
      square(i*w, j*w, w);
    }
  }
}

void clearTmp() {
  for (int i = 0; i < S; ++i) {
    for (int j = 0; j < S; ++j) {
      tmp[i][j] = false;
    }
  }
}

void copyTmp() {
  for (int i = 0; i < S; ++i) {
    for (int j = 0; j < S; ++j) {
      field[i][j] = tmp[i][j];
    }
  }
}

void setup() {
  size(601, 601);
  field = new boolean[S][S];
  tmp = new boolean[S][S];
  for (int i = 0; i < S; ++i) {
    for (int j = 0; j < S; ++j) {
      field[i][j] = (int)random(100) % 2 == 0 ? true : false;
      tmp[i][j] = false;
      //field[i][j] = false;
    }
  }
  
  //frameRate(5);
  
  //field[0][1] = true;
  //field[5][2] = true;
}

void draw() {
  background(150);
  
  clearTmp();
  
  for (int i = 0; i < S; ++i) {
    for (int j = 0; j < S; ++j) {
      int alive = 0;
      for (int p = i - 1; p <= i + 1; ++p) {
        for (int k = j - 1; k <= j + 1; ++k) {
          if (p==i&&k==j) {
            continue;
          }
          if (field[p==-1?S-1:p==S?0:p][k==-1?S-1:k==S?0:k]) {
            ++alive;
          }
        }
      }
      if (!field[i][j]) {
        if (alive == 3) {
          tmp[i][j] = true;
        }
      } else {
        if (alive == 3 || alive == 2) {
          tmp[i][j] = true;
        } else {
          tmp[i][j] = false;
        }
      }
    }
  }
  
  copyTmp();
  
  paintField();
}
