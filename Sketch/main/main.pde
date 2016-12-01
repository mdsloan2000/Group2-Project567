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
  size(800,460);
  background(#FAF7BB);
    
  //  Create plot corner coordinates.
  plotX1 = 50;
  plotX2 = width - 125;                   // Added extra space on the left to hold statistic specific legends.
  plotY1 = 50;
  plotY2 = height - plotY1;

  fill(255);                              // Sets background for plot area.
  rectMode(CORNERS);                      // Plots rectangle by corner values.
  noStroke( );                            // Removes bounding line.
  rect(plotX1, plotY1, plotX2, plotY2);   // Sets corner coordintes.

  // Optional Image background
  mapImage = loadImage("WorldReligion.png");  // Add Licensed worldreligion image.
  mapImage.resize(625,0);                     // Resize image to match target width.
  image(mapImage, plotX1, plotY1+40);
  
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
 
  // adds X Interval and Tickmarks
  xinterval = ((plotX2)/rowCount);
  for (int counter = 0; counter < rowCount ; counter++) {
    xticks = xticks + xinterval;
    stroke(#460FF0);
    line(xticks, plotY2+1, xticks, plotY2+6);
    textAlign(CENTER,TOP);
    fill(#0F0F01);
    text(years[counter], xticks, plotY2+10);
  }
  // adds Y Interval and Tickmarks
  yinterval = ((plotY2-plotY1)/10);
  yticks=0+plotY1;
  for (int counter = 10; counter > 0 ; counter--) {
    line(plotX1-1, yticks, plotX1-6, yticks);
    textAlign(RIGHT,CENTER);
    text(str(counter*10)+"%", plotX1-8, yticks);
    yticks=yticks+yinterval; 
  }
}

void draw(){
  displayStatistic();
  
}
   