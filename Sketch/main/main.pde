/* 
 Main PDE File
 Group2 Project 5/6/7
 Date of Final Submission
 
 Added PDEs
 -  FloatTable
 -  Integrator
 
 */
PImage mapImage;
PImage checkMark;

FloatTable data;
float dataMin;
float dataMax;

float plotX1, plotY1;
float plotX2, plotY2;

int currentColumn = 0;
int columnCount;
int rowCount;
int check=0;
IntList currentColumns;

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

float[] tabLeft, tabRight;
float tabTop, tabBottom;
float tabPad = 10;

void setup ()
{
  //  Set size of screen and background.
  size(800, 500);


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

  currentColumns = new IntList();
  currentColumns.append(6);

  dataMin = 0;
  dataMax = data.getTableMax();
  // plotFont = createFont("SansSerif", 20);
  plotFont = loadFont("Calibri-20.vlw");
  textFont(plotFont);
}

void draw() {
  background(#9da0a5);

  fill(255);                              // Sets background for plot area.
  rectMode(CORNERS);                      // Plots rectangle by corner values.
  noStroke( );                            // Removes bounding line.
  rect(plotX1, plotY1, plotX2, plotY2);   // Sets corner coordintes.

  // Optional Image background
  mapImage = loadImage("WorldReligion.png");  // Add Licensed worldreligion image.
  mapImage.resize(650, 0);                     // Resize image to match target width.
  image(mapImage, plotX1, plotY1+40);

  checkMark = loadImage("Check mark.png"); 
  checkMark.resize(50, 0);   

  //check box
  //stroke(#000000); 
  rect(480, 467, 490, 477);
  fill(#000000); 
  textSize(20);
  text("Multiple time series", 580, 480); 
  if (check ==1) {
    image(checkMark, 462, 445);
  }


  drawTitleTabs();


  drawTitle( );
  // adds X Interval and Tickmarks
  drawYearLabels( );
  drawPercent();
  drawGrid();

  noFill();
  drawDataPoints(currentColumn, check);
  

if (check == 0 ){
  drawDataLine(currentColumn);
  }
else {
  for (int val =0; val< columnCount; val++) {
      if (currentColumns.hasValue(0) && val ==0) {
      stroke(#0053df);
      smooth();
      drawDataLine(0);
    } else if (currentColumns.hasValue(1) && val ==1 ) {
      stroke(#ab1300);
      drawDataLine(1);
    } else if (currentColumns.hasValue(2) && val ==2) {
      stroke(#01854d);
      drawDataLine(2);
   } else if (currentColumns.hasValue(3) && val ==3) {
      stroke(#858987);
      drawDataLine(3);
    } else if (currentColumns.hasValue(4) && val ==4) {
      stroke(#89019a);
      drawDataLine(4);
    } else if (currentColumns.hasValue(5) && val ==5) {
      stroke(#909a01);
      drawDataLine(5);
    } else if (currentColumns.hasValue(6) && val ==6) {
      stroke(#09b0d4);
      drawDataLine(6);
    } else {
      stroke(#000000);
      drawDataLine(val);
    }
     
  }
}

    
  drawDataHighlight(currentColumn, check);
  drawAxisLabels();
}

void keyPressed( ) {
  //resetPlotArea();

  if (key == '-') {
    //text ("YES",120,120);
    if (dash < 1) {
      dash++;
    } else {
      dash = 0;
    }
  }
}

void drawTitle( ) {
  fill(0);
  textSize(20);
  textAlign(LEFT);
  textSize(25);
  String title2 = "Religeous Observation by Percent of World Population";
  text(title2, 150, 25);
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


void drawPercent() {
  //int counter = 0;
  textSize(12);
  for (float v = dataMin; v <= dataMax; v+=volumeInterval) {
    float y = map(v, dataMin, dataMax, plotY2, plotY1);
    textAlign(RIGHT, CENTER);
    //if (counter > 0) {
    text(floor(v*100)+"%", plotX1-5, y);
    line(plotX1, y, plotX1-5, y); // suppresses line zero
    // }
  }
}

void drawAxisLabels( ) {
  fill(0);
  textSize(15);
  textLeading(15);
  textAlign(CENTER, CENTER);
  // Use \n (aka enter or linefeed) to break the text into separate lines.
  //rotate(radians(180));
  //text("Percent\nof World\nPopulation", 50, (plotY1+plotY2)/2);
  textAlign(CENTER);
  text("Year", (plotX1+plotX2)/2, height-40);
  textAlign(LEFT);
  text("Press '-' to toggle gridlines", plotX1, height - 25);
   translate(width/2,height/2);
   rotate(radians(270));
   textAlign(CENTER);
    text("Percent of\nWorld Population", 0,-340);
}

void drawGrid() {
  fill(0);
  stroke(224);
  strokeWeight(1);
  //textSize(10);
  textAlign(RIGHT, CENTER);
  if (dash == 0) {
    for (int row=0; row < rowCount; row++) {
      float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
      line(x, plotY1, x, plotY2);
    }
    for (float v = dataMin; v <= dataMax; v+=volumeInterval) {
      float y = map(v, dataMin, dataMax, plotY2, plotY1);
      line(plotX1, y, plotX2, y);
    }
  }
}
// Draw the data as a series of points.
void drawDataPoints(int col, int multi) {
  stroke(#5679C1);
  strokeWeight(5);
  int rowCount = data.getRowCount( );
  for (int row = 0; row < rowCount; row++) {
    //Check box not checked.
    if (data.isValid(row, col) && multi ==0) {
      float value = data.getFloat(row, col);
      float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
      point(x, y);
    } else {
      //plots all the graphs 
      for (int val =0; val< columnCount; val++) {
        float value = data.getFloat(row, val);
        float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
        float y = map(value, dataMin, dataMax, plotY2, plotY1);

        //Sets the color for the points
        if (currentColumns.hasValue(0) && val ==0) {
          stroke(#0053df);
        } else if (currentColumns.hasValue(1) && val ==1) {
          stroke(#ab1300);
        } else if (currentColumns.hasValue(2) && val ==2) {
          stroke(#01854d);
        } else if (currentColumns.hasValue(3) && val ==3) {
          stroke(#858987);
        } else if (currentColumns.hasValue(4) && val ==4) {
          stroke(#89019a);
        } else if (currentColumns.hasValue(5) && val ==5) {
          stroke(#909a01);
        } else if (currentColumns.hasValue(6) && val ==6) {
          stroke(#09b0d4);
        } else {
          stroke(#000000);
        }

        point(x, y);
      }
    }
  }
}

void drawDataLine(int col) {
 // stroke(#5679C1);
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
 


void drawDataHighlight(int col, int multi) {
  for (int row = 0; row < rowCount; row++) {
    if (data.isValid(row, col) && multi==0) {
      float value = data.getFloat(row, col);
      float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
      if (dist(mouseX, mouseY, x, y) < 5) {
        strokeWeight(10);
        point(x, y);
        fill(0);
        textSize(13);
        textAlign(CENTER);
        text(nf(value*100, 0, 2)+ "%" +"\n" + " (" + years[row] + ")", x, y-18);
        textAlign(LEFT);
      }
    } else {
      for (int val =0; val< columnCount; val++) {
        float value = data.getFloat(row, val);
        float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
        float y = map(value, dataMin, dataMax, plotY2, plotY1);
        if (dist(mouseX, mouseY, x, y) < 5) {
          stroke(#000000);
          strokeWeight(10);
          point(x, y);
          fill(0);
          textSize(13);
          textAlign(CENTER);
          text(nf(value*100, 0, 2)+ "%" +"\n" + " (" + years[row] + ")", x, y-18);
          textAlign(LEFT);
        }
      }
    }
  }
}

//Generate tabs above the graph
void drawTitleTabs( ) {
  rectMode(CORNERS);
  noStroke( );
  textSize(20.85);
  textAlign(LEFT);
  // On first use of this method, allocate space for an array
  // to store the values for the left and right edges of the tabs.
  if (tabLeft == null) {
    tabLeft = new float[columnCount];
    tabRight = new float[columnCount];
  }
  float runningX = plotX1;
  tabTop = plotY1 - textAscent( ) - 15;
  tabBottom = plotY1;
  for (int col = 0; col < columnCount; col++) {
    String title = data.getColumnName(col);
    tabLeft[col] = runningX;
    float titleWidth = textWidth(title);
    tabRight[col] = tabLeft[col] + tabPad + titleWidth + tabPad;
    //Checks to see if the multiple time series is checked.
    if ( check==0) {
      // If the current tab, set its background white; otherwise use pale gray.
      fill(col == currentColumn  ? 255 : 224);
      rect(tabLeft[col], tabTop, tabRight[col], tabBottom);
      // If the current tab, use black for the text; otherwise use dark gray.
      fill(col == currentColumn ? 0 : 64);
      text(title, runningX + tabPad, plotY1 - 10);
      runningX = tabRight[col];
    } else {

      // If multiple tabs selected, set its background to white; otherwise use pale gray.
      fill(224);
      //Checks if the column was selected.
      for (int x = 0; x< currentColumns.size(); x++) {
        if (col== currentColumns.get(x)) {
          fill(255);
        }
      }
      rect(tabLeft[col], tabTop, tabRight[col], tabBottom);
      // If the current tab, use black for the text; otherwise use dark gray.
      fill(col == currentColumn ? 0 : 64);
      text(title, runningX + tabPad, plotY1 - 10);
      runningX = tabRight[col];
    }
  }
}
void mousePressed( ) {
  if (mouseY > tabTop && mouseY < tabBottom) {
    for (int col = 0; col < columnCount; col++) {
      if (mouseX > tabLeft[col] && mouseX < tabRight[col]) {
        if (check ==0) {
          currentColumn = col;
          //     resetPlotArea();
        } else {
          // add or remove the column for the currentColumns list/
          if (currentColumns.hasValue(col)) {
            currentColumns.removeValue(col);
            //       resetPlotArea();
          } else {
            currentColumns.append(col);
            //       resetPlotArea();
          }
        }
      }
    }
    //check box clicked
  } else if (mouseY > 457 && mouseY < 487 && mouseX >470 && mouseX <500) {
    if (check ==0 ) {
      //add a check mark
      image(checkMark, 462, 445); 
      check =1;
    } else {
      check = 0;
    }
  }
}