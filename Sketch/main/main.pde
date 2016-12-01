




FloatTable data;
float dataMin;
float dataMax;

float plotX1, plotY1;
float plotX2, plotY2;

int rowCount;
int currentColumn = 0;
int columnCount;

float volumeInterval = 0.05;

int yearMin;
int yearMax;
int[] years;
//int yearInterval = 1;

PFont plotFont;

int dash = 0;

void setup ()
{
  size(730,410);
  data = new FloatTable("religmod1.tsv");
  columnCount = data.getColumnCount( );
   
  years = int(data.getRowNames());
  yearMin = years[1];
  yearMax = years[years.length - 1];
   
  dataMin = 0;
  dataMax = data.getTableMax();
 
   // Corners of the plotted time series
  plotX1 = 50;
  plotX2 = width - plotX1;
  plotY1 = 60;
  plotY2 = height - plotY1;
 
 plotFont = createFont("SansSerif", 20);
 textFont(plotFont); 
  
  smooth( );
  
}

void draw()
{
  background(224);
  // Show the plot area as a white box.
  fill(255);
  rectMode(CORNERS);
  noStroke( );
  rect(plotX1, plotY1, plotX2, plotY2);
  rowCount = data.getRowCount( );
  // Draw the title of the current plot.
  fill(0);
  textSize(20);
  String title = data.getColumnName(currentColumn);
  text(title, plotX1, plotY1 - 10);
  
  drawGrid();
  
  stroke(#5679C1);
  strokeWeight(5);
  drawDataPoints(currentColumn);

}

// Draw the data as a series of points.
void drawDataPoints(int col) {
int rowCount = data.getRowCount( );
  for (int row = 0; row < rowCount; row++) {
    if (data.isValid(row, col)) {
    float value = data.getFloat(row, col);
    float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
    float y = map(value, dataMin, dataMax, plotY2, plotY1);
    point(x, y);
    }
  }
}

void drawGrid() {
  fill(0);
  stroke(224);
  strokeWeight(1);
 textSize(10);
textAlign(RIGHT, CENTER);
 if (dash == 0) {
   for (int row=0; row < rowCount; row++){
     float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
     line(x, plotY1, x, plotY2);
          }
   for (float v = dataMin; v <= dataMax; v+=volumeInterval){
     float y = map(v, dataMin, dataMax, plotY2, plotY1);
     line(plotX1, y, plotX2, y);
   }
  }
}

void keyPressed( ) {
  if (key == '-') {
    if (dash < 1){
      dash++;
    }
    else {
      dash = 0;
    }
  }
}