
class Graph {
  int posX;
  int posY;

  int sizeX;
  int sizeY;

  int plotX;
  int plotY;
  int plotWidth;
  int plotHeight;

  String title;
  String xAxis;
  String yAxis;

  float y_min;
  float y_max;
  int zeroAxis;

  int margin_x;
  int margin_y;

  color background;
  color annotations_color;
  
  ArrayList <GraphSeries> series;
  int nPoints;

  Graph(int posX, int posY, int width, int height) {
    this.posX = posX;
    this.posY = posY;
    this.sizeX = width;
    this.sizeY = height;

    this.plotWidth = int(width*0.8);
    this.plotHeight = int(height*0.7);

    this.plotX = int(posX + (sizeX/2 - plotWidth/2) * 1.3); // factor for yaxis title space
    this.plotY = posY + sizeY/2 - plotHeight/2;

    title = new String();
    xAxis = new String();
    yAxis = new String();
    
    //Defaults
    background = color(250);
    annotations_color = color(0);
    
    y_min = 0;
    y_max = 100;
    
    margin_x = 20;
    margin_x = 20;
    
    series = new ArrayList <GraphSeries>();
    series.add(new GraphSeries());
  }

  void draw() {
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
    line(plotX, plotY, plotX, plotY+plotHeight);
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
      line(plotX, dy, plotX+5, dy);
      int div_val = round(map(dy, plotY+plotHeight, plotY, y_min, y_max)); 
      text(str(div_val), plotX-5, dy);
    }
    
    for (int i = 0; i < 6; i++) {
      float dy = zeroAxis + i*d;
      if (dy > plotY + plotHeight) { 
        break;
      }
      line(plotX, dy, plotX+5, dy);
      int div_val = int(map(dy, plotY+plotHeight, plotY, y_min, y_max)); 
      text(str(div_val), plotX-5, dy);
    }
    
    //data
    for (GraphSeries serie : series){
      serie.draw(this);
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

  void addPoint(float point) {
    series.get(0).addPoint(point, this);
  }
  
  void addPoint(int seriesIndex, float point) {
    series.get(seriesIndex).addPoint(point, this);
  }
  
  void set_dataColor(color c){
    series.get(0).data_color = c;
  }
}

class GraphSeries {
  
  int nPoints;
  FloatList points;
  
  color data_color;
  
  GraphSeries(){
    points = new FloatList();
    //Defaults
    data_color = color(0);
  }
  
  void addPoint(float point, Graph g) {
    point = (point > g.y_max) ? int(g.y_max) : point;
    point = (point < g.y_min) ? int(g.y_min) : point;
    points.append(point);

    if (points.size() > g.nPoints) {
      points.remove(0);
    }
  }
  
  void draw(Graph g){
    if (points.size() > 0){
      stroke(data_color);
      float prev_px = map(0, 0, g.nPoints, g.plotX, g.plotX+g.plotWidth);
      float prev_py = map(points.get(0), g.y_max, g.y_min, g.plotY, g.plotY+g.plotHeight);
  
      for (int i=1; i<points.size(); i++) {
        float px = map(i, 0, g.nPoints, g.plotX, g.plotX+g.plotWidth);
        float py = map(points.get(i), g.y_min, g.y_max, g.plotY+g.plotHeight, g.plotY);
        line(prev_px, prev_py, px, py);
        prev_px = px;
        prev_py = py;
      }
      
      stroke(0);
      fill(255);
    }    
  }
}
