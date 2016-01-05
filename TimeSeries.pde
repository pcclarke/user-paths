class TimeSeries
{
  boolean visible;
  color colour;
  float page[];
  float time[];
  float success[];
  float violation[];
  int rowCount;
  int count;
  String name;
  String[] rowNames;
  
  TimeSeries (color inputColour, float inputPage[], float inputTime[], String inputName, int inputCount)
  {
    colour = inputColour;
    page = inputPage;
    time = inputTime;
    name = inputName;
    count = inputCount;

    rowCount = page.length;
    visible = true;
  }
  
  void drawData(float start, float stop, float valueMax) {
    if (visible) {
      int shift = count * 4;

      noFill();
      stroke(colour);

      for (int row = 0; row < rowCount - 1; row++) {
        float pagePos = plotY1 + 10 + shift + ((page[row] - 1) * interval);

        float land = time[row];
        float leave = (row == rowCount - 1) ? land : time[row + 1];

        float x1 = map(land, 0, dataMax, plotX1, plotX2);
        float x2 = map(leave, 0, dataMax, plotX1, plotX2);

        strokeWeight(2);
        line(x1, pagePos, x2, pagePos);

        if (row < rowCount - 2) {
          float pagePos2 = plotY1 + 10 + shift + ((page[row + 1] - 1) * interval);
          strokeWeight(.5);
          line(x2, pagePos, x2, pagePos2);
        }
      }
    }
  }

  void show() {
    visible = true;
  }

  void hide() {
    visible = false;
  }
  
  /*boolean drawDataHighlight() 
  {
    for (int row = rowMin; row < rowCount; row++) {
      if (data.isValid(row, column)) {
        if (row % detail == 0) 
        {
          float value = data.getFloat(row, column);
            float x = map(row, rowMin, rowCount, plotX1, plotX2);
            float y = map(value, dataMin, dataMax, plotY2, plotY1);
          if (dist(mouseX, mouseY, x, y) < 3) {
            colour = color(0, 100, 255);
            stroke(colour);
            strokeWeight(10);
            point(x, y);
            fill(0);
            textSize(10);
            textAlign(CENTER);
            text(nf(value, 0, 2) + " (" + dates[row] + ")", x, y-8);
            return true;
          }
        }
      }
    }
    colour = color(200, 0, 0);
    return false;
  }*/
  
  /*void setHighlight(boolean inputHigh)
  {
    colour = inputHigh ? color(0, 100, 255) : color(200, 0, 0);
  }*/
  
  /*boolean isValid(int row) {
    if (row < 0) return false;
    if (row >= rowCount) return false;
    //if (col >= columnCount) return false;
    if (col >= data[row].length) return false;
    if (col < 0) return false;
    return !Float.isNaN(data[row][col]);
  }*/
}