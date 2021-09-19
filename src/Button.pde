class Button {
  //Position
  float posX;
  float posY;
  //Size
  float sizeX;
  float sizeY;
  
  PFont font;
  String text;
  int textSize;
  
  color btn_color;
  float scale;
  int vertex;
  boolean wasPressed;
  boolean mouseOver;
  
  int timesPressed;
  
  //Functions
  
  Button(float posx, float posy, float sizex, float sizey){
    this.posX = posx;
    this.posY = posy;
    this.sizeX = sizex;
    this.sizeY = sizey;
    this.text = "";
    
    this.scale = 1;
    this.wasPressed = false;
    this.mouseOver = false;
    this.timesPressed = 0;
    this.vertex = 15;
    this.textSize = 20;
    font = createFont("Arial",textSize,true);
  }
  
  void setColor(int red, int green, int blue){
    btn_color = color(red, green, blue);
  }
  
  void setColor(color c){
    btn_color = c;
  }
  
  void setName(String txt){
    text = txt;
  }
  
  void setVertex(int dim){
    this.vertex = dim;
  }
  
  void draw(){
    fill(btn_color);
    //noStroke();
    isMouseOver();
    isPressed();
    isReleased();
    rectMode(CENTER);
    rect(posX,posY,sizeX*scale,sizeY*scale, vertex);
    fill(0);
    textAlign(CENTER,CENTER);
    textFont(font,textSize*scale);
    text(text, posX, posY);
  }
  
  boolean isMouseOver(){
    if (mouseX > posX-sizeX/2 && mouseX < posX+sizeX/2){
      if (mouseY >posY-sizeY/2 && mouseY < posY+sizeY/2){
        //change transparency
        mouseOver = true;
        return true;
      }
    }
    mouseOver = false;
    return false;
  }
  
  boolean isPressed(){
    if (mousePressed == true && mouseOver){
      scale = 0.95;
      wasPressed = true;
      return true;
    }
    else{
      return false;
    }
  }
  
  boolean isReleased(){
    if(mousePressed == false && wasPressed){
      wasPressed = false;
      timesPressed++;
      scale = 1;
      return true;
    }
    return false;
  }
}
