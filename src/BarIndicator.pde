class BarIndicator{
  //Position
  float posX;
  float posY;
  //Size
  float sizeX;
  float sizeY;
  
  float minValue;
  float maxValue;
  float value;
  
  float startPos;
  float endPos;
  
  int red;
  int green;
  int blue;
  
  boolean type;
  int nDecimals;
  
  String name;
  PFont text;
  int limitText_size;
  int value_size;
  
  BarIndicator(float posx, float posy){
    this.posX = posx;
    this.posY = posy;
    this.startPos = posY;
    this.endPos = posY + sizeY;
    
    text = createFont("Arial",14,true);
    limitText_size = 16;
    value_size = 22;
    nDecimals = 2;
  }
  BarIndicator(float posx, float posy, float sizex, float sizey){
    this.posX = posx;
    this.posY = posy;
    this.sizeX = sizex;
    this.sizeY = sizey;
    //defaults
    this.red = 0;
    this.green = 100;
    this.blue = 100;
    
    this.startPos = posX;
    this.endPos = posX + sizeX;
    
    text = createFont("Arial",14,true);
    limitText_size = 16;
    value_size = 22;
    nDecimals = 2;
  }
  void setSize(float sizex, float sizey){
    this.sizeX = sizex;
    this.sizeY = sizey;
  }
  void setColor(int red, int green, int blue){
    this.red = red;
    this.green = green;
    this.blue = blue;
  }
  void setLimits(float min, float max){
    this.minValue = min;
    this.maxValue = max;
  }
  
  void draw(float inputValue){
    value = map(inputValue,minValue,maxValue,startPos,endPos);
    if (value > endPos){
      value = endPos;
    }else if (value < startPos){
      value = startPos;
    }
    
    boolean isPositive;
    float reff = map(0,minValue,maxValue,startPos,endPos);
    if (value < reff){
      isPositive = false;
    }
    else{
      isPositive = true;
    }
    
    noStroke();
    fill(200);
    rect(posX,posY,sizeX,sizeY);
    stroke(0);
    strokeWeight(1);
    fill(red,green,blue);
    if (isPositive){
      rectMode(CORNERS);
      rect(reff,posY,value,posY + sizeY);
      rectMode(CORNER);
    }else{
      rectMode(CORNERS);
      rect(value,posY, reff, posY+sizeY);
      rectMode(CORNER);
    }
    strokeWeight(1.5);
    noFill();
    rect(posX,posY,sizeX,sizeY);
    strokeWeight(1);
    
    //Text
    fill(0);
    textAlign(CENTER,BOTTOM);
    String str = str(minValue);
    textFont(text,limitText_size);
    text(str, posX, posY);
    str = str(maxValue);
    text(str, posX + sizeX, posY);
    str = nf(inputValue,0,nDecimals);
    textFont(text,value_size);
    text(str, posX + sizeX/2, posY);
  }
}
