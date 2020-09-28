int x,y,type,rotation,lastPress;
int w = 400, h = 640;
int [][] T = {{},{15,4369,15,4369},
              {116,785,23,2188},
              {54,1122,54,1122},
              {99,612,99,612},
              {113,275,71,1604},
              {51,51,51,51},
              {114,610,39,562}};
color [] colorList = {#B9FFF0,#B9FFF0,#FFCA00,#A5FF00,#FF0D00,#6384FF,#F9FF35,#B279FF};
//Declares a blank matrix 2D of bytes
byte[][] matrixBoard = new byte[16][10];

void settings(){
    size(w,h);
}

void setup(){
  frameRate(2);
  newTetromino();    
}

void draw(){
  drawBoard();
  drawAll();
  drawTetromino();
  if(verifyMovement("drop",y+40)){
    dropTetromino();
  }else{
    addTetromino();
    //verifyAndDropRows();
    newTetromino();
  }
  if(keyPressed & (millis()-lastPress>250)){
        tetrominoModify(keyCode);
        lastPress = millis();
  }
}

void drawTetromino(){
  fill(colorList[type]);
  for(int i=0; i<=15;i++){ 
    if((T[type][rotation] & (1<<15 - i)) != 0){
      square(x-(((15-i)%4)*40),y-((15-i)/4)*40,40);
    }
  }
}

void dropTetromino(){
  y = y + 40;
}

void newTetromino(){
  x=200;
  y=0;
  type = (int) random(1,7);
}

boolean verifyMovement(String type,int newValue){
  boolean correctMovement=false;
  switch(type){
    case "drop":
      if(positionVerify(rotation,newValue)){
        correctMovement=true;
      }
      break;
    case "right":
      if(xMinMax(x+40)[1]<=w-40){
        correctMovement=true;
      }
      break;
    case "left":
      if(xMinMax(x-40)[0]>=0){
        correctMovement=true;
      }
      break;
    case "rotation":
      if(positionVerify(newValue,y)){
        correctMovement=true;
      }
      break;
  }
  return correctMovement;
}

boolean positionVerify(int newRotation,int newY){
  boolean available = true, yLimit = true;
  int[][] arrayPos = new int[2][4];
  int pos=0;
  for(int i=0; i<=15;i++){ 
  if((T[type][newRotation] & (1<<15 - i)) != 0){
    arrayPos[0][pos]=x-(((15-i)%4)*40);
    arrayPos[1][pos]=newY-(((15-i)/4)*40);
    pos++;
  }
  }
  for(pos=0; pos<=3;pos++){
    if(arrayPos[1][pos]>h-40){
      available = false;
    }if(arrayPos[0][pos]>w-40){
      available = false;
    }if(arrayPos[0][pos]<0){
      available = false;
    }if(arrayPos[1][pos]<0){
      yLimit = false;
    }
  }
  if(yLimit & available){
    for(pos=0; pos<=3;pos++){
      println(arrayPos[1][pos]/40,arrayPos[0][pos]/40);
      if(matrixBoard[arrayPos[1][pos]/40][arrayPos[0][pos]/40]!=0){
        available = false;
      }
    }
  }
  return available;
}

void tetrominoModify(int keyCode){
        switch(keyCode){
          case UP:
              if(verifyMovement("rotation",(rotation+1)%4)){
                rotation = (rotation+1)%4;
              }
              break;
          case DOWN:
              if(verifyMovement("drop",y+1)){
                y = y+1;
              }
              break;
          case LEFT:
              if(verifyMovement("left",x-40)){
                x = x-40;
              }
              break;
          case RIGHT:
              if(verifyMovement("right",x+40)){
                x = x+40;
              }
              break;
       }
}
//Function that draws the grid
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
}

void addTetromino(){
  for(int i=0; i<=15;i++){ 
    if((T[type][rotation] & (1<<15 - i)) != 0){
      matrixBoard[(y-((15-i)/4)*40)/40][(x-(((15-i)%4)*40))/40] = (byte) type;
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
