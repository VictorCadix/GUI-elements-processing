class Graph_XY extends Graph {
  float x_min;
  float x_max;
  float zeroAxis_x;
  
  ArrayList <GraphSeries_XY> series_XY;
  
  Graph_XY(int posX, int posY, int width, int height){
    super(posX, posY, width, height);
    x_min = -100;
    x_max = 100;
    y_min = -100;
    y_max = 100;
    
    series_XY = new ArrayList <GraphSeries_XY>();
    series_XY.add(new GraphSeries_XY());
  }
  
  void set_Xlimits(float min, float max) {
    x_min = min;
    x_max = max;
    if (0 > x_max) {
      zeroAxis_x = plotY;
    } else if (0 < x_min) {
      zeroAxis_x = plotY+plotHeight;
    } else {
      zeroAxis_x = int(map(0, x_min, x_max, plotX, plotX+plotWidth));
    }
  }
  
  void set_Ylimits(int min, int max) {
    y_min = min;
    y_max = max;
    if (0 > y_max) {
      zeroAxis = plotY;
    } else if (0 < y_min) {
      zeroAxis = plotY+plotHeight;
    } else {
      zeroAxis = int(map(0, y_max, y_min, plotY, plotY+plotHeight));
    }
    margin_x = sizeX/25;
    margin_y = sizeY/15;
  }
  
  void addPoint(float pX, float pY) {
    series_XY.get(0).addPoint(pX, pY, this);
  }
  
  void addPoint(int seriesIndex, float pX, float pY) {
    series_XY.get(seriesIndex).addPoint(pX, pY, this);
  }
  
  void set_dataColor(color c){
    series_XY.get(0).data_color = c;
  }
  
  void draw(){
    //window
    fill(background);
    rectMode(CORNER);
    rect(posX, posY, sizeX, sizeY, 10);
    
    //Annotations
    fill(annotations_color);
    stroke(annotations_color);
    
    //  Text
    textAlign(CENTER, CENTER);
    textSize(18);
    text(title, posX + sizeX/2, posY + margin_y);
    textSize(14);
    text(xAxis, posX + sizeX/2, posY + sizeY - margin_y);
    rotate(-PI/2);
    text(yAxis, -posY - sizeY/2, posX + margin_x);
    rotate(PI/2);

    //  axes
    strokeWeight(1.5);
    line(plotX, zeroAxis, plotX+plotWidth, zeroAxis);
    line(zeroAxis_x, plotY, zeroAxis_x, plotY+plotHeight);
    strokeWeight(1);

    //  subdivisions
    textSize(10);
    textAlign(RIGHT, CENTER);
    int d = (plotHeight) / 5;
    for (int i = 0; i < 6; i++) {
      float dy = zeroAxis - i*d;
      if (dy < plotY) { 
        break;
      }
      line(zeroAxis_x, dy, zeroAxis_x+5, dy);
      int div_val = round(map(dy, plotY+plotHeight, plotY, y_min, y_max)); 
      text(str(div_val), zeroAxis_x-5, dy);
    }
    for (int i = 0; i < 6; i++) {
      float dy = zeroAxis + i*d;
      if (dy > plotY + plotHeight) { 
        break;
      }
      line(zeroAxis_x, dy, zeroAxis_x+5, dy);
      int div_val = int(map(dy, plotY+plotHeight, plotY, y_min, y_max)); 
      text(str(div_val), zeroAxis_x-5, dy);
    }
    
    //  X subdivisions
    textAlign(CENTER, CENTER);
    d = (plotWidth) / 5;
    for (int i = 0; i < 6; i++) {
      float dx = zeroAxis_x - i*d;
      if (dx < plotX) {
        break;
      }
      line(dx, zeroAxis, dx, zeroAxis-5);
      int div_val = round(map(dx, plotX, plotX+plotWidth, x_min, x_max)); 
      text(str(div_val), dx, zeroAxis+5);
    }
    for (int i = 0; i < 6; i++) {
      float dx = zeroAxis_x + i*d;
      if (dx > plotX + plotWidth) { 
        break;
      }
      line(dx, zeroAxis, dx, zeroAxis-5);
      int div_val = int(map(dx, plotX, plotX+plotWidth, x_min, x_max)); 
      text(str(div_val), dx, zeroAxis+5);
    }
    
    //data
    for (GraphSeries_XY serie : series_XY){
      serie.draw(this);
    }
  }
}


class GraphSeries_XY {
  
  int nPoints;
  FloatList points_x;
  FloatList points_y;
  
  color data_color;
  
  GraphSeries_XY(){
    points_x = new FloatList();
    points_y = new FloatList();
    //Defaults
    data_color = color(0);
  }
  
  void addPoint(float pX, float pY, Graph_XY g) {
    pY = (pY > g.y_max) ? g.y_max : pY;
    pY = (pY < g.y_min) ? g.y_min : pY;
    points_y.append(pY);
    
    pX = (pX > g.x_max) ? g.x_max : pX;
    pX = (pX < g.x_min) ? g.x_min : pX;
    points_x.append(pX);

    if (points_y.size() > g.nPoints) {
      points_y.remove(0);
      points_x.remove(0);
    }
  }
  
  void draw(Graph_XY g){
    if (points_y.size() > 0){
      stroke(data_color);
      float prev_px = map(points_x.get(0), g.x_min, g.x_max, g.plotX, g.plotX+g.plotWidth);
      float prev_py = map(points_y.get(0), g.y_max, g.y_min, g.plotY, g.plotY+g.plotHeight);
  
      for (int i=1; i<points_y.size(); i++) {
        float px = map(points_x.get(i), g.x_min, g.x_max, g.plotX, g.plotX+g.plotWidth);
        float py = map(points_y.get(i), g.y_max, g.y_min, g.plotY, g.plotY+g.plotHeight);
        line(prev_px, prev_py, px, py);
        prev_px = px;
        prev_py = py;
      }
      
      float px = map(points_x.get(points_y.size()-1), g.x_min, g.x_max, g.plotX, g.plotX+g.plotWidth);
      float py = map(points_y.get(points_y.size()-1), g.y_max, g.y_min, g.plotY, g.plotY+g.plotHeight);
      fill(data_color);
      circle(px, py, 5);
      
      stroke(0);
      fill(255);
    }    
  }
}
