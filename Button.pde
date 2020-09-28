class Button{
  String text;
  int x;
  int y;
  boolean isPressed = false;
  
  //Builder method of the class Button
  public Button(int x, int y){
    this.x = x;
    this.y = y;
    this.isPressed = false;
    }
  
  //Method that displays the button in the screen
  void display(){
    pushStyle();
    rect(x-60,y-20,100,40,7);
    textSize(24);
    fill(0);
    textAlign(CENTER);
    text("Play",x-10,y+10);
    popStyle();
    if(mousePressed & (mouseX >= (x-60)) & (mouseX<=(x-60+100) & (mouseY>=(y-20)) & (mouseY<=(y-20+40)))){
        this.isPressed = true;
    }else{
        this.isPressed = false;
    }
  }
}
