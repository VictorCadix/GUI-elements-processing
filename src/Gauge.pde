
class Gauge {
  float posX;
  float posY;
  float innerDiameter;
  float outerDiameter;
  float startAngle;
  float endAngle;
  
  float minValue;
  float maxValue;
  float value;
  
  int red;
  int green;
  int blue;
  
  String name;
  PFont text;
  int percent_textSize;
  int value_textSize;
  int name_textSize;
  
  Gauge(float posX, float posY){
    this.posX = posX;
    this.posY = posY;
    
    //Default
    innerDiameter = 110;
    outerDiameter = 150;
    startAngle = radians(150);
    endAngle = radians(390);
    red = 0;
    green = 255;
    blue = 0;
    
    text = createFont("Arial",14,true);
    percent_textSize = 16;
    value_textSize = 30;
    name_textSize = 20;
  }
  
  void setSize(float innerDiam, float outerDiam){
    this.innerDiameter = innerDiam;
    this.outerDiameter = outerDiam;
  }
  
  void setLimits(float min, float max){
    minValue = min;
    maxValue = max;
  }
  void setColor(int r, int g, int b){
    red = r;
    green = g;
    blue = b;
  }
  void setName(String str){
    name = str;
  }
  
  float getPercentage(float inVal){
    float result = map (inVal, minValue, maxValue, 0, 100);
    if (result < 0){
      return 0;
    }
    else if (result > 100){
      return 100;
    }
    return result;
  }
  
  void draw(float inputValue){
    value = map(inputValue,minValue,maxValue,startAngle,endAngle);
    if (value > endAngle){
      value = endAngle;
    }
    
    noStroke();
    fill(150);
    arc(posX, posY, outerDiameter, outerDiameter, startAngle, endAngle);
    fill(red,green,blue);
    arc(posX, posY, outerDiameter, outerDiameter, startAngle, value);
    noFill();
    stroke(0);
    strokeWeight(1.5);
    arc(posX, posY, outerDiameter, outerDiameter, startAngle, endAngle,PIE);
    arc(posX, posY, innerDiameter, innerDiameter, startAngle, endAngle);
    strokeWeight(1);
    arc(posX, posY, outerDiameter, outerDiameter, startAngle, value, PIE);
    fill(200);
    noStroke();
    ellipse(posX, posY, innerDiameter-1, innerDiameter-1);
    strokeWeight(1);
    stroke(0);
    
    //Text
    float percentage = getPercentage(inputValue);
    fill(0);
    textAlign(CENTER,CENTER);
    String p = nf(percentage, 0, 1);
    p += "%";
    textFont(text,percent_textSize);
    text(p, posX, posY-30);
    
    String v = nf(inputValue, 0, 1);
    textFont(text,value_textSize);
    text(v, posX, posY);
    
    textAlign(CENTER,TOP);
    textFont(text,name_textSize);
    text(name,posX, posY+50);
  }
}
