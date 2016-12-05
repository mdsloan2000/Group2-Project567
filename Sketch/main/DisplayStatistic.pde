/*int displayStatistic()
{
  /*plotFont = createFont("SansSerif", 20);
  textFont(plotFont); 
  smooth( );
  fill(0);
  textSize(20);
  String title = data.getColumnName(currentColumn);
  textAlign(LEFT,BOTTOM);
  text(title, plotX1, plotY1 - 10);*/
  
  //drawGrid();
/*  
  stroke(#5679C1);
  strokeWeight(5);
  drawDataPoints(currentColumn);
  
  return(0);
}

// Draw the data as a series of points.
/*void drawDataPoints(int col) {
  stroke(#5679C1);
  strokeWeight(5);
int rowCount = data.getRowCount( );
  for (int row = 0; row < rowCount; row++) {
    if (data.isValid(row, col)) {
      float value = data.getFloat(row, col);
      float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
      point(x, y);
    }
  }
}*/
/*
void resetPlotArea() {
 fill(255);                              // Sets background for plot area.
  rectMode(CORNERS);                      // Plots rectangle by corner values.
  noStroke( );                            // Removes bounding line.
  rect(plotX1, plotY1, plotX2, plotY2);   // Sets corner coordintes.

  // Optional Image background
  mapImage = loadImage("WorldReligion.png");  // Add Licensed worldreligion image.
  mapImage.resize(705,0);                     // Resize image to match target width.
  image(mapImage, plotX1, plotY1); 
}


/*

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

*/