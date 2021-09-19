
Button button_small;
Button button_big;
StateButton state_button;

void setup(){
  size(600,400);
  
  button_small = new Button(width/2,100,50,50);
  button_small.setName("B1");
  button_small.setColor(200,200,0);
  
  button_big = new Button(width/2,200,150,100);
  button_big.setName("BIG\nBUTTON");
  button_big.setColor(250,200,100);
  button_big.textSize = 25;
  button_big.vertex = 30;  //Radius of corners
  
  state_button = new StateButton(width/2,310,70,70);
  state_button.setName("STATE");  //This label only last until pressed
  state_button.on_text = "ON";
  state_button.off_text = "OFF";
  state_button.setColorON(0,255,0);
  state_button.setColorOFF(255,50,50);
  state_button.vertex = 35;
}

void draw(){
  background(200);
  
  button_small.draw();
  button_big.draw();
  state_button.draw();
}

void mousePressed(){
  //Do something when pressed
  if(button_small.isMouseOver()){
    println("small button pressed");
  }
  else if(button_big.isMouseOver()){
    println("big button pressed");
  }
  else if(state_button.isMouseOver()){
    state_button.toggleState();
    if(state_button.on_state){println("state button is ON");}
    else{println("state button is OFF");}
    
  }
}
