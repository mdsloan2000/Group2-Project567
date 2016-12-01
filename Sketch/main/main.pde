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
float volumeInterval = 0.05;
int dash = 0;

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
  yearMax = years[years.length-1];
   
  dataMin = 0;
  dataMax = data.getTableMax();
 
  // adds X Interval and Tickmarks
  
  
  stroke(#460FF0);
  fill(#0F0F01);
  for (int row=1; row < rowCount; row++){
       float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
       line(x, plotY2, x, plotY2+5);
       textAlign(CENTER,TOP);
       text(years[row],x, plotY2+6);
     }
  
  
  
  // adds Y Interval and Tickmarks
  
  int counter = 0;
  for (float v = dataMin; v <= dataMax; v+=volumeInterval){
       float y = map(v, dataMin, dataMax, plotY2, plotY1);
       textAlign(RIGHT, CENTER);
       if (counter > 0) {
         text(str(counter*10)+"%", plotX1-5, y);
         line(plotX1, y, plotX1-5, y); // suppresses line zero
       }
       counter++;
     } 
}

void keyPressed( ) {
  resetPlotArea();
  ;
  if (key == '-') {
    text ("YES",120,120);
    if (dash < 1){
      dash++;
    }
    else {
      dash = 0;
    }
  }
}

void draw(){
  drawGrid();
  displayStatistic();
  
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