//Declare global variables associated with Tetromino Figure parameters
int x,y,type,rotation,score,lastPress,linesAtTime,lines,nextFigure=(int) random(1,7);
//Declare the size of the board
int w = 400, h = 640;
//Declare global variable of the state of the game and button variable
boolean stateGame=true,buttonIsPressed;
//Array that contains the different rotations of tetromino figure
int [][] T = {{},{15,4369,15,4369},
              {116,785,23,2188},
              {54,1122,54,1122},
              {99,612,99,612},
              {113,275,71,1604},
              {51,51,51,51},
              {114,610,39,562}};
//colorList by type of tetromino figure
color [] colorList = {#B9FFF0,#B9FFF0,#FFCA00,#A5FF00,#FF0D00,#6384FF,#F9FF35,#B279FF};
//Declares a blank matrix 2D of bytes
byte[][] matrixBoard = new byte[16][10];

void settings(){
    size(w+200,h);
}

void setup(){
  newTetromino();    
}

void draw(){
  if(buttonIsPressed){
     game();
   }else{
     startScreenDisplay();
   }
}

//Main Function of the Game
void game(){
    if(stateGame){
      drawBoard();
      drawAll();
      drawTetromino();
      if(positionVerify(rotation,x,y+1)){
          dropTetromino();
      }else{
          addTetromino();
          verifyAndDrop();
          newTetromino();
          score++;
      }
      if(keyPressed & (millis()-lastPress>500)){
          tetrominoModify(keyCode);
          lastPress = millis();
      }
    }else{
        fill(0,0,0,1);
        rect(0,0,width,height);
        fill(0);
        textAlign(CENTER);
        textSize(36);
        text("Gracias por jugar",w/2,h/2); 
    }
}

//Function to draw active tetromino figure
void drawTetromino(){
  fill(colorList[type]);
  for(int i=0; i<=15;i++){ 
    if((T[type][rotation] & (1<<15 - i)) != 0){
      square(x-(((15-i)%4)*40),y-((15-i)/4)*40,40);
    }
  }
}

//Method to drop tetromino
void dropTetromino(){
  y = y + 1;
}

//Method to restart tetromino's values
void newTetromino(){
  x=200;
  y=0;
  type = nextFigure;
  nextFigure = (int) random(1,7);
}

//Function to get the key of the keyboard and apply modifications
void tetrominoModify(int keyCode){
        switch(keyCode){
          case UP:
              if(positionVerify((rotation+1)%4,x,y)){
                rotation = (rotation+1)%4;
              }
              break;
          case DOWN:
              if(positionVerify(rotation,x,y+1)){
                y = y+4;
              }
              break;
          case LEFT:
              if(positionVerify(rotation,x-40,y)){
                x = x-40;
              }
              break;
          case RIGHT:
              if(positionVerify(rotation,x+40,y)){
                x = x+40;
              }
              break;
       }
}

//Function to verify existing blocks
boolean positionVerify(int newRotation, int newX, int newY){
  boolean available = true, yLimit = true;
  int[][] arrayPos = new int[2][4];
  int pos=0;
  for(int i=0; i<=15;i++){ 
    if((T[type][newRotation] & (1<<15 - i)) != 0){
      arrayPos[0][pos]=newX-(((15-i)%4)*40);
      arrayPos[1][pos]=newY-(((15-i)/4)*40);
      pos++;
    }
  }
  for(pos=0; pos<=3;pos++){
    if(arrayPos[1][pos]>h-40){
      available = false;
      break;
    }if(arrayPos[0][pos]>w-40){
      available = false;
      break;
    }if(arrayPos[0][pos]<0){
      available = false;
      break;
    }if(arrayPos[1][pos]<0){
      yLimit = false;
    }
  }
  if(yLimit & available){
    for(pos=0; pos<=3;pos++){
      if(matrixBoard[(int)Math.ceil(arrayPos[1][pos]/40.0)][(int)Math.ceil(arrayPos[0][pos]/40.0)]!=0){
        available = false;
      }
    }
  }
  return available;
}

//Function that draws the board and its grid
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
    fill(38,114,237);
    rect(400,0,200,640);
    textSize(24);
    fill(255);
    textAlign(LEFT);
    text("Score",460,60);
    text(score,480,100);
    showNextFigure();
}

void showNextFigure(){
    //square(420,160,160);
    fill(colorList[nextFigure]);
    for(int i=0; i<=15;i++){ 
      if((T[nextFigure][0] & (1<<15 - i)) != 0){
        square(520-(((15-i)%4)*30),240-((15-i)/4)*30,30);
      }
    }
}

//Method to add tetromino figure to the 2D Matrix of bytes
void addTetromino(){
  for(int i=0; i<=15;i++){ 
    if((T[type][rotation] & (1<<15 - i)) != 0){
      //Verify if the figure is in the roof of the board
      if((y-((15-i)/4)*40)<=0){
        stateGame=false;
      }if(stateGame){
        matrixBoard[(y-((15-i)/4)*40)/40][(x-(((15-i)%4)*40))/40] = (byte) type;
      }
    }
  }
}

void drawAll(){
  for (int row = 0; row < this.matrixBoard.length;row++){
    for (int col = 0; col < this.matrixBoard[row].length;col++){
     if(this.matrixBoard[row][col]!=0){
       fill(colorList[matrixBoard[row][col]]);
       square(col*40,row*40,40);
     }
   }
 }
}

int[] xMinMax(int x){
  int max=0,min=0;
  for(int i=0; i<=15;i++){ 
    if((T[type][rotation] & (1<<15 - i)) != 0){
      if(x-(((15-i)%4)*40)<min){
        min = x-(((15-i)%4)*40);
      }
      if(x-(((15-i)%4)*40)>max){
        max = x-(((15-i)%4)*40);
      }
    }
  }
  int[] array = {min,max};
  return array;
}

void startScreenDisplay(){
    background(255);
    fill(0);
    buttonDisplay(width/2,height/2);
    textSize(24);
    textAlign(CENTER);
    text("Alejandro Higuera Castro",width/2,2*height/3);
    text("Prof. JP Charalambos",width/2,2*height/3+50);
}

void buttonDisplay(int x,int y){
    pushStyle();
    fill(255);
    rect(x-60,y-20,100,40,7);
    popStyle();
    textSize(24);
    textAlign(CENTER);
    text("Play",x-10,y+10);
    if(mousePressed & (mouseX >= (x-60)) & (mouseX<=(x-60+100) & (mouseY>=(y-20)) & (mouseY<=(y-20+40)))){
        buttonIsPressed = true;
    }else{
        buttonIsPressed = false;
    }
}

//Function to verify if one row is full and delete row if is full
void verifyAndDrop(){
  for(int row=0;row<16;row++){
    boolean full = true;
    for(int pos=0;pos<10;pos++){
      if(matrixBoard[row][pos]==0){
        full = false;
        break;
      }
    }
    if(full){
      //Add 1 line to counter
      lines++;
      linesAtTime++;
      //Make a copy of the actual matrix
      byte[][] copyMB = matrixBoard;
      for(int nRow=row;nRow>=0;nRow--){
        if(nRow>0){
          matrixBoard[nRow] = copyMB[nRow-1];
        //To remove the row, we fill the row with 0's
        }if(nRow==0){
          for(int pos=0;pos<10;pos++){
            matrixBoard[nRow][pos] = 0;
          }
        }
      }
    }
  }
  addToScore();
}

//Function to increase the score according the number of lines
void addToScore(){
    switch(linesAtTime){
      case 1:
        score+=100;
        break;
      case 2:
        score+=400;
        break;
      case 3:
        score+=900;
        break;
      case 4:
        score+=1200;
        break;
    }
}
