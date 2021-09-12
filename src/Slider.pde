class Slider{
  int posX;
  int posY;
  int size;
  int max;
  int min;
  float value;
  
  //Circle variables
  float circlePosX;
  int circleSize;
  float scale;
  boolean wasPressed;
  boolean mouseOver;
  
  PFont font;
  String text;
  int textSize;  
  
  Slider(int pX, int pY, int size){
    this.posX = pX;
    this.posY = pY;
    this.size = size;
    this.circleSize = 25;
    this.scale = 1;
    
    this.text = str(int(value));
    this.textSize = 20;
    font = createFont("Arial",textSize,true);
  }
  
  void setLimits(int minValue, int maxValue){
   this.min = minValue;
   this.max = maxValue;
  }
  
  void draw(){
    isMouseOver();
    isPressed();
    isReleased();
    update();
    
    strokeWeight(5);
    line(posX, posY, posX + size, posY);
    strokeWeight(1);
    circlePosX = map(value, min, max, posX, posX + size);
    fill(255,165,0);
    circle(circlePosX, posY, circleSize * scale);
    
    fill(0);
    this.text = str(int(value));
    textAlign(CENTER,CENTER);
    textFont(font,textSize);
    text(text,(posX+posX+size)/2, posY-30);
  }
  
  boolean isMouseOver(){
    float dist2circle = sqrt((mouseX - circlePosX)*(mouseX - circlePosX) + (mouseY - posY)*(mouseY - posY));
    if (dist2circle <= circleSize/2){
      mouseOver = true;
      return true;
    }
    mouseOver = false;
    return false;
  }
  
  boolean isPressed(){
    if (mousePressed == true && mouseOver){
      wasPressed = true;
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
      scale = 1;
      return true;
    }
    return false;
  }
  
  void update(){
    if (wasPressed){
      value = map(mouseX, posX, posX + size, min, max);
      if (value > max){value = max;}
      else if (value < min){value = min;}
    }
  }
}
