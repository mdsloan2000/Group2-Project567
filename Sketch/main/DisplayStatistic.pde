/*int displayStatistic()
{
  plotFont = createFont("SansSerif", 20);
  textFont(plotFont); 
  smooth( );
  fill(0);
  textSize(20);
  String title = data.getColumnName(currentColumn);
  textAlign(LEFT,BOTTOM);
  text(title, plotX1, plotY1 - 10);
  
  //drawGrid();
  
  stroke(#5679C1);
  strokeWeight(5);
  drawDataPoints(currentColumn, check);
  
  return(0);
}

// Draw the data as a series of points.
void drawDataPoints(int col, int multi) {
int rowCount = data.getRowCount( );
  for (int row = 0; row < rowCount; row++) {
    //Check box not checked.
    if (data.isValid(row, col) && multi ==0) {
      float value = data.getFloat(row, col);
      float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
      point(x, y);
    }
    
    else if (data.isValid(row, col) && multi ==1) {
      //plots all the graphs 
      for(int val =0; val< columnCount; val++){
      float value = data.getFloat(row, val);
      float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
      
      //Sets the color for the points
      if(currentColumns.hasValue(0) && val ==0){
      stroke(#0053df); //<>//
      }
 //<>//
      else if(currentColumns.hasValue(1) && val ==1){
       stroke(#ab1300);
       }

       else if(currentColumns.hasValue(2) && val ==2){
            stroke(#01854d);
        }

        else if(currentColumns.hasValue(3) && val ==3){
            stroke(#858987);
        }

        else if(currentColumns.hasValue(4) && val ==4){
            stroke(#89019a);
        }

      else if(currentColumns.hasValue(5) && val ==5){
            stroke(#909a01);
      }

    else if(currentColumns.hasValue(6) && val ==6){
            stroke(#09b0d4);
      }else{
      stroke(#000000);
      }
      
      point(x, y);

      }
    }
  }
}

void resetPlotArea() {

 fill(255);                              // Sets background for plot area.
  rectMode(CORNERS);                      // Plots rectangle by corner values.
  noStroke( );                            // Removes bounding line.
  rect(plotX1, plotY1, plotX2, plotY2);   // Sets corner coordintes.
  //background(#FAF7BB);

  // Optional Image background
  mapImage = loadImage("WorldReligion.png");  // Add Licensed worldreligion image.
  mapImage.resize(625,0);                     // Resize image to match target width.
  image(mapImage, plotX1, plotY1+40); 

}
*/

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