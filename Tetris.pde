int actualRotation, lastPress, score;
boolean figureisDropping = true;
//Declares a blank matrix 2D of bytes
byte[][] matrixBoard = new byte[16][10];
int w = 400, h = 640;
//Declares an instance of the class Tetromino with a blank Matrix 2D of bytes
Tetromino figure = new Tetromino(matrixBoard);
//Declares an instance of the home screen
StartScreen startScreen;

void settings(){
    size(w,h);
}

void setup(){
  startScreen = new StartScreen(w,h,figure);
}

void draw(){
   if(startScreen.button.isPressed){
     game();
   }else{
     startScreen.display();
   }
}

void game(){
    //While game hasn't been finished, the tetrominos will continue dropping.
    if(figure.stateGame){
      drawBoard();
      figure.drawTetromino();
      figure.dropTetromino();
      if(keyPressed & (millis()-lastPress>500)){
        figure.drawModify(keyCode);
        lastPress = millis();
      }
      if(!figure.isDropping & figure.stateGame){
        figure = new Tetromino(figure.matrixBoard);
        score++;
      }
    }else{
        fill(0,0,0,1);
        rect(0,0,400,640);
        fill(0);
        textAlign(CENTER);
        text("Gracias por jugar",width/2,100); 
        text("Tu puntaje es:",width/2,300); 
        text(score,width/2,350); 
    }
}

//Function that draws the grid and the tetromino blocks
void drawBoard(){
    fill(255);
    rect(0,0,400,640);
    noFill();
    for (int i = 0; i <400 ; i = i + 40){
        line(i,0,i,640);
    }
    for (int j = 0; j <640 ; j = j + 40){
        line(0,j,400,j);
    }
    figure.drawAll();
}
