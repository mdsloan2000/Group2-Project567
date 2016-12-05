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

int currentColumn = 6;
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
  size(800,500);
  
    
  //  Create plot corner coordinates.
  plotX1 = 125;
  plotX2 = width - 25;                   // Added extra space on the left to hold statistic specific legends.
  plotY1 = 75;
  plotY2 = height - plotY1;

 
   // Set DataSource Table  
  data = new FloatTable("religmod1.tsv");
  columnCount = data.getColumnCount( );
  rowCount=data.getRowCount();
   
  years = int(data.getRowNames());
  yearMin = years[0];
  yearMax = years[years.length-1];
   
  dataMin = 0;
  dataMax = data.getTableMax();
 // plotFont = createFont("SansSerif", 20);
  plotFont = loadFont("Calibri-20.vlw");
  textFont(plotFont); 
  
}

void draw(){
   background(#9da0a5);
  
  fill(255);                              // Sets background for plot area.
  rectMode(CORNERS);                      // Plots rectangle by corner values.
  noStroke( );                            // Removes bounding line.
  rect(plotX1, plotY1, plotX2, plotY2);   // Sets corner coordintes.
  
   // Optional Image background
  mapImage = loadImage("WorldReligion.png");  // Add Licensed worldreligion image.
  mapImage.resize(650,0);                     // Resize image to match target width.
  image(mapImage, plotX1, plotY1+40);
   
  drawTitle( );
  // adds X Interval and Tickmarks
  drawYearLabels( );
  drawPercent();
  drawGrid();
 
  noFill();
  drawDataPoints(currentColumn);
  drawDataLine(currentColumn);
  drawDataHighlight(currentColumn);
  drawAxisLabels();

  
}

void keyPressed( ) {
  //resetPlotArea();
  
  if (key == '-') {
    //text ("YES",120,120);
    if (dash < 1){
      dash++;
    }
    else {
      dash = 0;
    }
  }
}

void drawTitle( ) {
fill(0);
textSize(20);
textAlign(LEFT);
String title = data.getColumnName(currentColumn);
text(title, plotX1, plotY1 - 10);
textSize(20);
textAlign(LEFT);
textSize(25);
String title2 = "Religeous Observation by Percent of World Population";
text(title2, 150,25);
}


void drawYearLabels( ) {
fill(0);
textSize(12);
textAlign(CENTER, TOP);
// Use thin, gray lines to draw the grid.
stroke(224);
strokeWeight(1);
for (int row = 0; row < rowCount; row++) {
//if (years[row] % yearInterval == 0) {
  float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
  text(years[row], x, plotY2 + 10);
//line(x, plotY1, x, plotY2);
}
}


void drawPercent(){
//int counter = 0;
textSize(12);
  for (float v = dataMin; v <= dataMax; v+=volumeInterval){
       float y = map(v, dataMin, dataMax, plotY2, plotY1);
       textAlign(RIGHT, CENTER);
       //if (counter > 0) {
         text(floor(v*100)+"%", plotX1-5, y);
         line(plotX1, y, plotX1-5, y); // suppresses line zero
      // }
       //counter++;
     } 
}

void drawAxisLabels( ) {
fill(0);
textSize(13);
textLeading(15);
textAlign(CENTER, CENTER);
// Use \n (aka enter or linefeed) to break the text into separate lines.
text("Percent\nof World\nPopulation", 50, (plotY1+plotY2)/2);
textAlign(CENTER);
text("Year", (plotX1+plotX2)/2, height-40);
textAlign(LEFT);
text("Press '-' to toggle gridlines", plotX1, height - 25); 
}

void drawGrid() {
  fill(0);
  stroke(224);
  strokeWeight(1);
  //textSize(10);
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

void drawDataPoints(int col) {
  stroke(#5679C1);
  strokeWeight(5);
int rowCount = data.getRowCount( );
  //beginShape( );
  for (int row = 0; row < rowCount; row++) {
    if (data.isValid(row, col)) {
      float value = data.getFloat(row, col);
      float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
     point(x, y);
    }
  }
  //endShape( );
}

void drawDataLine(int col) {
  stroke(#5679C1);
  strokeWeight(1);
int rowCount = data.getRowCount( );
  beginShape( );
  for (int row = 0; row < rowCount; row++) {
    if (data.isValid(row, col)) {
      float value = data.getFloat(row, col);
      float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
      curveVertex(x, y);
      // Double the curve points for the start and stop
      if ((row == 0) || (row == rowCount-1)) {
      curveVertex(x, y);
      }
      //point(x, y);
    }
  }
  endShape( );
}

void drawDataHighlight(int col) {
  for (int row = 0; row < rowCount; row++) {
    if (data.isValid(row, col)) {
      float value = data.getFloat(row, col);
      float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
      if (dist(mouseX, mouseY, x, y) < 5) {
        strokeWeight(10);
        point(x, y);
        fill(0);
        textSize(10);
        textAlign(CENTER);
        text(nf(value*100, 0, 2)+ "%" +"\n" + " (" + years[row] + ")", x, y-18);
        textAlign(LEFT);
      }
    }
  }
}