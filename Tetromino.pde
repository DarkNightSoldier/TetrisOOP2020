class Tetromino{
    private int [][][] rotationMap0;
    private int [][][] rotationMap1 = {{{-80,-40,0,40},{0,0,0,0}},
                                       {{0,0,0,0},{0,-40,-80,-120}},
                                       {{-80,-40,0,40},{0,0,0,0}},
                                       {{0,0,0,0},{0,-40,-80,-120}}};
    private int [][][] rotationMap2 = {{{0,-40,+40,-40},{0,0,0,-40}},
                                       {{0,0,0,40},{0,-40,-80,-80}},
                                       {{0,0,-40,-80},{0,-40,-40,-40}},
                                       {{0,-40,0,0},{0,0,-40,-80}}};
    private int [][][] rotationMap3 = {{{0,-40,40,40},{0,0,0,-40}},
                                       {{40,0,0,0},{0,0,-40,-80}},
                                       {{0,0,40,80},{0,-40,-40,-40}},
                                       {{0,0,0,-40},{0,-40,-80,-80}}};
    private int [][][] rotationMap4 = {{{0,-40,0,-40},{0,0,-40,-40}},
                                       {{0,-40,0,-40},{0,0,-40,-40}},
                                       {{0,-40,0,-40},{0,0,-40,-40}},
                                       {{0,-40,0,-40},{0,0,-40,-40}}};
    private int [][][] rotationMap5 = {{{0,-40,0,40},{0,0,-40,-40}},
                                       {{0,0,-40,-40},{0,-40,-40,-80}},
                                       {{0,-40,0,40},{0,0,-40,-40}},
                                       {{0,0,-40,-40},{0,-40,-40,-80}}};
    private int [][][] rotationMap6 = {{{0,-40,40,0},{0,0,0,-40}},
                                       {{0,0,40,0},{0,-40,-40,-80}},
                                       {{0,0,-40,40},{0,-40,-40,-40}},
                                       {{0,0,-40,0},{0,-40,-40,-80}}};
    private int [][][] rotationMap7 = {{{0,40,0,-40},{0,0,-40,-40}},
                                       {{0,0,40,40},{0,-40,-40,-80}},
                                       {{0,40,0,-40},{0,0,-40,-40}},
                                       {{0,0,40,40},{0,-40,-40,-80}}};
                               
    //Array that contains the possible rotations of the diferent tetrominos and its rotations
    private int[][][][] rotationMap = {rotationMap0,rotationMap1,rotationMap2,rotationMap3,rotationMap4,rotationMap5,rotationMap6,rotationMap7};
    
    protected boolean isDropping = true;
    protected byte[][] matrixBoard = new byte[16][10];
    int type;
    int x;
    int y;
    int rotation;
    
    //Boolean attribute to determine if game is over
    private boolean stateGame = true;
                              
    //Builder method of the class Tetromino
    public Tetromino(byte[][] matrixBoard){
        this.type = (int)(Math.random()*(7))+1;
        this.x = 200;
        this.y = 25;
        this.rotation = 0;
        this.matrixBoard = matrixBoard;
    }
    
    //Method to modify tetromino atributes by the use of keyboard
    void drawModify(int keyCode){
        switch(keyCode){
          case UP:
              if(correctMovement(this.x,this.y,(this.rotation+1)%4)){
                  this.rotation = (this.rotation + 1) % 4;
              }
              break;
          case DOWN:
              dropTetromino();
              dropTetromino();
              break;
          case LEFT:
              if(correctMovement((this.x)-40,this.y,this.rotation)){
                this.x = this.x-40;
              }
              break;
          case RIGHT:
              if(correctMovement((this.x)+40,this.y,this.rotation)){
                this.x = this.x+40;
              }
              break;
       }
    }
    
    //Method to control the dropping of the tetromino figure
    void dropTetromino(){
      if(correctMovement(this.x,this.y+1,this.rotation)){
        this.y = this.y+1;
      }else{
        isDropping = false;
        addFigure();
      }
    }
    
    //Method to determine if a movement of a tetromino figure is correct
    private boolean correctMovement(int x, int y, int rotation){
       boolean correct = true;
       int [][] positions = positionArray(x,y,rotation);
       if((maxArray(positions[1])>600)|(minArray(positions[0])<0)|(maxArray(positions[0])>360)){
          correct = false;
       }else if(this.matrixBoard[maxArray(positions[1])/40][x/40]!=0){
         correct = false;
       }else{
         for(int i=0;i<4;i++){
           if((this.matrixBoard[(positions[1][i]/40)][(positions[0][i]/40)]==0)&correct){
             correct = true;
           }else{
             correct = false;
             break;
           }
         }
       }
       return correct;
    }
    
    //Method to generate an array of integers with the positions of Tetromino figure
    private int[][] positionArray(int x, int y, int rotation){
         int[][] arrayPos = new int[2][4];
         for(int axis=0;axis<2;axis++){
           for(int pos=0;pos<4;pos++){
             if(axis==0){
               arrayPos[axis][pos] = x+this.rotationMap[this.type][rotation][axis][pos];
             }else{
               arrayPos[axis][pos] = y+this.rotationMap[this.type][rotation][axis][pos];
             }
           }
         }
         return arrayPos;
    }
    
    //Method to add a tetromino figure to the matrix 2D dimensional array of bytes
    private void addFigure(){
      int [][] positions = positionArray(this.x,this.y,this.rotation);
      if(min(positions[1])<=0){
        stateGame = false;
      }
      for(int i=0;i<4;i++){
          this.matrixBoard[(int)(positions[1][i]/40)][(int)(positions[0][i]/40)] = (byte) this.type;
       }
    }
    
    // Method to draw the tetromino
    void drawTetromino(){
        int [][] posToDraw = positionArray(this.x,this.y,this.rotation);
        colorSelector(this.type);
        for(int i = 0;i<4;i++){
          square(posToDraw[0][i],posToDraw[1][i],40);
        }
    }
    
    // Function to select the color of the tetromino's blocks
    private void colorSelector(int type){
      switch(type){
        case 1:
          //Fill with cyan
          fill(0,255,255);
          break;
        case 2:
          //Fill with blue
          fill(0,0,128);
          break;
        case 3:
          //Fill with orange
          fill(255,127,80);
          break;
        case 4:
          //Fill with yellow
          fill(255,255,0);
          break;
        case 5:
          //Fill with lime green
          fill(127,255,0);
          break;
        case 6:
          //Fill with purple
          fill(128,0,128);
          break;
        case 7:
          //Fill with red
          fill(255,0,0);
          break;
      }
   }
   
   //Method to draw all the tetromino figures of the matrix of Bytes
   protected void drawAll(){
      for (int row = 0; row < this.matrixBoard.length;row++){
        for (int col = 0; col < this.matrixBoard[row].length;col++){
           if(this.matrixBoard[row][col]!=0){
             colorSelector(matrixBoard[row][col]);
             square(col*40,row*40,40);
           }
        }
      }
   }
   
   //Public version for draw Tetris Blocks with a 2D matrix of Bytes 
   public void drawBlocks(byte[][] matrix, int size){
      for (int row = 0; row < matrix.length;row++){
        for (int col = 0; col < matrix[row].length;col++){
           if(matrix[row][col]!=0){
             colorSelector(matrix[row][col]);
             square(col*size,row*size,size);
           }
        }
      }
   }
   
   // Function to get the min of an array of integers
   private int minArray(int [] array){
     int min = 0;
      for(int i=0; i<array.length; i++ ) {
         if(array[i]<min) {
            min = array[i];
         }
      }
      return min;    
   }
   // Function to get the max of an array of integers
   private int maxArray(int [] array){
     int max = 0;
      for(int i=0; i<array.length; i++ ) {
         if(array[i]>max) {
            max = array[i];
         }
      }
      return max;    
   }
}
