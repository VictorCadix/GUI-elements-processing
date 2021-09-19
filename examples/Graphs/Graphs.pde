
Graph graph_big, graph_small;
Graph_XY graph_xy;

int count = 0;
int last_count = 0;

void setup(){
  size(800,600);
  
  graph_big = new Graph(100,50,500,300);
  graph_big.nPoints = 200;
  graph_big.title = "Graph title";
  graph_big.xAxis = "xAxis";
  graph_big.yAxis = "yAxis";
  graph_big.set_Ylimits(-100,100);
  graph_big.background = color(0);
  graph_big.annotations_color = color(255);
  graph_big.set_dataColor(color(150,150,255));
  //second series
  graph_big.series.add(new GraphSeries());
  graph_big.series.get(1).data_color = color(250,0,0);
  
  graph_small = new Graph(100,400,300,150);
  graph_small.nPoints = 200;
  graph_small.title = "Graph title";
  graph_small.xAxis = "xAxis";
  graph_small.yAxis = "yAxis";
  graph_small.set_Ylimits(-100,100);
  
  graph_xy = new Graph_XY(450,400,300,150);
  graph_xy.nPoints = 100;
  graph_xy.title = "XY Graph";
  graph_xy.xAxis = "Value";
  graph_xy.yAxis = "dValue";
  graph_xy.set_Xlimits(-100,100);
  graph_xy.set_Ylimits(-100,100);
  graph_xy.series_XY.get(0).data_color = color(0,150,0);
}

void draw(){
  background(100);
  count++;
  if(count > 100){
    count = 0;
  }
  
  graph_big.addPoint(count);
  graph_big.addPoint(1, count-10);
  graph_big.draw();
  
  graph_small.addPoint(count);
  graph_small.draw();
  
  graph_xy.addPoint(float(count), float((count - last_count)*30));
  graph_xy.draw();
  
  last_count = count;
}
