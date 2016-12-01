/* 
  Main PDE File
  Group2 Project 5/6/7
  Date of Final Submission
  
  Added PDEs
    -  FloatTable
    -  Integrator
  
*/
PImage mapImage;

FloatTable data;
float dataMin;
float dataMax;

float plotX1, plotY1;
float plotX2, plotY2;

int currentColumn = 0;
int columnCount;
int rowCount;

int yearMin;
int yearMax;
int[] years;

float xticks=0;
float xinterval;
float yticks=0;
float yinterval;

PFont plotFont;

void setup ()
{
  //  Set size of screen and background.
  size(730,410);
  background(#FAF7BB);
    
  //  Create plot corner coordinates.
  plotX1 = 50;
  plotX2 = width - plotX1;
  plotY1 = 50;
  plotY2 = height - plotY1;

  fill(255);                              // Sets background for plot area.
  rectMode(CORNERS);                      // Plots rectangle by corner values.
  noStroke( );                            // Removes bounding line.
  rect(plotX1, plotY1, plotX2, plotY2);   // Sets corner coordintes.

  // Optional Image background
  // mapImage = loadImage("WorldReligion.png");
  
  //  Place General Main Title on screen.

  // Set DataSource Table  
  data = new FloatTable("religmod1.tsv");
  columnCount = data.getColumnCount( );
  rowCount=data.getRowCount();
   
  years = int(data.getRowNames());
  yearMin = years[1];
  yearMax = years[years.length - 1];
   
  dataMin = 0;
  dataMax = data.getTableMax();
 
  xinterval = ((plotX2)/rowCount);
  text(xinterval, 50,50);
  for (int counter = 0; counter < rowCount ; counter++) {
    xticks = xticks + xinterval;
    stroke(#460FF0);
    line(xticks, plotY2, xticks, plotY2-10);
    textAlign(CENTER,TOP);
    fill(#0F0F01);
    text(years[counter], xticks, plotY2+10);
  }
 
  // Adds Tickmarks
  
  
  // x-Axis - Years
  
  // y-Axis - Percent Practicing
  
 
  
 
 plotFont = createFont("SansSerif", 20);
 textFont(plotFont); 
  
  smooth( );
  
}

void draw()
{
  // Create the Plot Area
  
  
  
  
  /*
  text(yearMin,20,20);
  text(yearMax,20,40);
  */
  
 // image(mapImage, 0, 0);
  
}

{
  
  // Show the plot area as a white box.
  /*
  noFill();
  rectMode(CORNERS);
  noStroke( );
  rect(plotX1, plotY1, plotX2, plotY2);
  */
  /*
  // Draw the title of the current plot.
  fill(0);
  textSize(20);
  String title = data.getColumnName(currentColumn);
  text(title, plotX1, plotY1 - 10);
  stroke(#5679C1);
  strokeWeight(5);
  drawDataPoints(currentColumn);
  */
}
/*
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
*/