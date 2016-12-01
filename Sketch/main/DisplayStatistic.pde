int displayStatistic()
{
  plotFont = createFont("SansSerif", 20);
  textFont(plotFont); 
  smooth( );
  fill(0);
  textSize(20);
  String title = data.getColumnName(currentColumn);
  textAlign(LEFT,BOTTOM);
  text(title, plotX1, plotY1 - 10);
  stroke(#5679C1);
  strokeWeight(5);
  drawDataPoints(currentColumn);
  
  return(0);
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