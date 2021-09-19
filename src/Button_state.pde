class StateButton extends Button{
  
  boolean on_state;
  color colorON, colorOFF;
  String on_text, off_text;
  
  StateButton(float posx, float posy, float sizex, float sizey){
    super(posx, posy, sizex, sizey);
    
    on_state = false;
    on_text = "";
    off_text = "";
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
      text = on_text;
    }
    else {
      setColor(colorOFF);
      text = off_text;
    }
  }
  
  void draw(){
    
    super.draw();
  }
  
}
