class StartScreen{
  int w;
  int h;
  Tetris.Button button;
  Tetris.Tetromino tetromino;
  private byte[][] bk = new byte[17][25];
  
  //Builder method of the class StartScreen
  public StartScreen(int w, int h, Tetris.Tetromino tetromino){
    this.w = w;
    this.h = h;
    this.button = new Tetris.Button(w/2,h/2);
    this.tetromino = tetromino;
    }
  
  //Method that displays the home screen of the game
  void display(){
    background(255);
    button.display();
    textSize(24);
    fill(0);
    textAlign(CENTER);
    text("Alejandro Higuera Castro",w/2,2*h/3);
    text("Ciencias de la computación",w/2,2*h/3+25);
    text("Prof. JP Charalambos",w/2,2*h/3+50);
    drawBackground();
  }
  
  //Method to display START letters with style TETRIS
  void drawBackground(){
    drawS(10,4);
    drawT(10,8);
    drawA(10,12);
    drawR(10,16);
    drawT(10,20);
    tetromino.drawBlocks(bk,15);
    noFill();
  }
  
  void drawS(int y,int x){
    bk[y][x] = 7;
    bk[y][x+1] = 7;
    bk[y][x+2] = 7;
    bk[y+1][x] = 7;
    bk[y+2][x+1] = 7;
    bk[y+3][x+2] = 7;
    bk[y+4][x+2] = 7;
    bk[y+4][x+1] = 7;
    bk[y+4][x] = 7;
  }
  void drawT(int y, int x){
    bk[y][x] = 1;
    bk[y][x+1] = 1;
    bk[y][x+2] = 1;
    bk[y+1][x+1] = 1;
    bk[y+2][x+1] = 1;
    bk[y+3][x+1] = 1;
    bk[y+4][x+1] = 1;
  }
  void drawA(int y, int x){
    bk[y][x+1] = 4;
    bk[y][x+2] = 4;
    bk[y+1][x] = 4;
    bk[y+1][x+2] = 4;
    bk[y+2][x] = 4;
    bk[y+2][x+1] = 4;
    bk[y+2][x+2] = 4;
    bk[y+3][x] = 4;
    bk[y+3][x+2] = 4;
    bk[y+4][x] = 4;
    bk[y+4][x+2] = 4;
  }
  void drawR(int y, int x){
    bk[y][x] = 5;
    bk[y][x+1] = 5;
    bk[y][x+2] = 5;
    bk[y+1][x] = 5;
    bk[y+1][x+2] = 5;
    bk[y+2][x] = 5;
    bk[y+2][x+1] = 5;
    bk[y+3][x] = 5;
    bk[y+3][x+2] = 5;
    bk[y+4][x] = 5;
    bk[y+4][x+2] = 5;
  }
}
