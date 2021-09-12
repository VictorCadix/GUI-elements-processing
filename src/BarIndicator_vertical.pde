
class BarIndicator_vertical{
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
  
  String name;
  PFont text;
  int limitText_size;
  int value_size;
  
  BarIndicator_vertical(float posx, float posy){
    this.posX = posx;
    this.posY = posy;
    this.startPos = posY;
    this.endPos = posY + sizeY;
    
    text = createFont("Arial",14,true);
    limitText_size = 16;
    value_size = 22;
  }
  BarIndicator_vertical(float posx, float posy, float sizex, float sizey){
    this.posX = posx;
    this.posY = posy;
    this.sizeX = sizex;
    this.sizeY = sizey;
    //defaults
    this.red = 0;
    this.green = 100;
    this.blue = 100;
    
    this.startPos = posY;
    this.endPos = posY + sizeY;
    
    text = createFont("Arial",14,true);
    limitText_size = 16;
    value_size = 22;
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
  void setName(String inString){
    this.name = inString;
  }
  
  void draw(float inputValue){
    value = map(-inputValue,minValue,maxValue,startPos,endPos);
    if (value > endPos){
      value = endPos;
    }else if (value < startPos){
      value = startPos;
    }
    
    boolean isPositive;
    float reff = map(0,minValue,maxValue,startPos,endPos);
    
    noStroke();
    fill(150);
    rect(posX,posY,sizeX,sizeY);
    stroke(0);
    strokeWeight(1);
    fill(red,green,blue);
    rectMode(CORNERS);
    rect(posX,reff, posX + sizeX, value);
    rectMode(CORNER);
    
    strokeWeight(1.5);
    noFill();
    rect(posX,posY,sizeX,sizeY);
    strokeWeight(1);
    
    //Text
    fill(0);
    textAlign(LEFT,CENTER);
    String str = str(minValue);
    textFont(text,limitText_size);
    text(str, posX + sizeX + 5, posY + sizeY);
    str = str(maxValue);
    text(str, posX + sizeX + 5, posY);
    
    textAlign(RIGHT,CENTER);
    str = nf(inputValue,0,1);
    textFont(text,value_size);
    text(str, posX - 5, value);
    
    textAlign(CENTER,TOP);
    textFont(text,20);
    text(name, posX + sizeX/2, posY + sizeY + 10);
  }
}
