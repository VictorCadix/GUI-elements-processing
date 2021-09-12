class StateButton extends Button{
  
  boolean on_state;
  color colorON, colorOFF;
  
  StateButton(float posx, float posy, float sizex, float sizey){
    super(posx, posy, sizex, sizey);
    
    on_state = false;
  }
  
  void setColorON(color c){
    colorON = c;
  }
  
  void setColorON(int r, int g, int b){
    colorON = color(r,g,b);
  }
  
  void setColorOFF(color c){
    colorOFF = c;
    setColor(c);
  }
  
  void setColorOFF(int r, int g, int b){
    setColorOFF(color(r,g,b));
  }
  
  void toggleState(){
    on_state = !on_state;
    
    if (on_state == true){
      setColor(colorON);
    }
    else {
      setColor(colorOFF);
    }
  }
  
  void draw(){
    
    super.draw();
  }
  
}
