float dataMin, dataMax;
float plotX1, plotY1;
float plotX2, plotY2;
float labelX, labelY;

int count = 8;
int coloursUsed = 0;
int interval;

String[] pages;
String[] students;

PFont plotFont, titleFont;

Button hs, ps;

RoundButton[] plotSelect;

TimeSeries[] plots;

void setup() {  
  size(1024, 768);

  students = loadStrings("students.txt");
  pages = loadStrings("pages.txt");
  
  plots = new TimeSeries[count];
  plotSelect = new RoundButton[count];
  
  int hsX = 240;
  int psX = 655;
  for (int i = 0; i < count; i++) {    
    populate("s1_participant" + (i+1) + ".csv", i);

    plotSelect[i] = new RoundButton(i);
    plotSelect[i].flipState();
    plotSelect[i].setFillOnColour(setupColours(i));
    if (students[i].equals("hs")) {
      plotSelect[i].setPos(hsX, 60);
      hsX += 30;
    } else {
      plotSelect[i].setPos(psX, 60);
      psX += 30;
    }
  }

  // High School Students button
  hs = new Button("HIGH SCHOOL STUDENTS", 0);
  hs.setDim(20, 200);
  hs.setPos(10, 50);
  hs.flipState();

  // Post Secondary (Transfer) Students button
  ps = new Button("POST-SECONDARY STUDENTS", 1);
  ps.setDim(20, 225);
  ps.setPos(400, 50);
  ps.flipState();

  dataMin = 0;
  
  // Corners of the plotted time series
  plotX1 = 180;
  plotX2 = width - 15;
  labelX = 170;
  plotY1 = 100;
  plotY2 = height - 30;
  labelY = height - 15;
  
  interval = 52;

  titleFont = createFont("Futura Book BT.ttf", 30); 
  plotFont = createFont("Futura Book BT.ttf", 20);
  
  smooth();
}

void draw() {
  background(234);

  drawTitle();
  drawVertLabels();
  drawPlotArea();

  hs.draw();
  ps.draw();
  
  for(int i = 0; i < count; i++)
  {
    plots[i].drawData(0, dataMax, 11);
    plotSelect[i].draw();
  }
}

void drawTitle() {
  fill(0);
  textAlign(LEFT);
  textFont(titleFont);
  textSize(30);
  text("ApplyBC SFU User Test November 2012", 10, 30);
}

void drawVertLabels() {
  fill(0);
  textAlign(RIGHT);
  textFont(plotFont);
  textSize(14);

  for (int i = 0; i < 12; i++) {
    text(pages[i], labelX, 130 + (i * interval));  
  }
}

void drawPlotArea() {
  fill(255);
  rectMode(CORNERS);
  noStroke();
  rect(plotX1, plotY1, plotX2, plotY2);

  fill(245, 245, 250);
  for (int i = 0; i < 12; i++) {
    rect(plotX1, plotY1 + 10 + (i * interval), plotX2, plotY1 + 40 + (i * interval));
  }
}

void mousePressed() {
  // If high school students button is pressed
  if (hs.checkMouse()) {
    hs.flipState();

    if (hs.getState()) {
      for (int i = 0; i < count; i++) {
        if (students[i].equals("hs")) {
          plots[i].show();
          plotSelect[i].setState(true);
        }
      }
    } else {
      for (int i = 0; i < count; i++) {
        if (students[i].equals("hs")) {
          plots[i].hide();
          plotSelect[i].setState(false);
        }
      }
    }
  }
  // If post secondary students button pressed 
  else if (ps.checkMouse()) {
    ps.flipState();

    if (ps.getState()) {
      for (int i = 0; i < count; i++) {
        if (students[i].equals("ps")) {
          plots[i].show();
          plotSelect[i].setState(true);
        }
      }
    } else {
      for (int i = 0; i < count; i++) {
        if (students[i].equals("ps")) {
          plots[i].hide();
          plotSelect[i].setState(false);
        }
      }
    }
  }
  // Check round buttons 
  else {
    for (int i = 0; i < count; i++) {
      if (plotSelect[i].checkMouse()) {
        plotSelect[i].flipState();
        if (plotSelect[i].getState()) {
          plots[i].show();
        } else {
          plots[i].hide();
        }
        continue;
      }
    }
  }
}


//
// Following functions all relate to pulling data from CSV spreadsheets

void populate(String filename, int participant) {
  String[] rows = loadStrings(filename);
  
  // pulls out column title
  String[] columns = split(rows[0], ',');
  String columnName = columns[1]; // upper-left corner ignored

  int rowCount = 0;
  color colour = color(0);

  // time of arrival on page
  float[] times = new float[rows.length-1];
  // page arrived on
  float[] pages = new float[rows.length-1];

  // start reading at row 1, because the first row was only the column headers
  for (int i = 1; i < rows.length; i++) {
    if (trim(rows[i]).length() == 0) {
      continue; // skip empty rows
    }
    if (rows[i].startsWith("#")) {
      continue;  // skip comment lines
    }

    // split the row on the tabs
    String[] pieces = split(rows[i], ',');
    scrubQuotes(pieces);
    
    // copy row title
    times[rowCount] = Float.parseFloat(pieces[0]);

    // copy data into the table starting at pieces[1]
    pages[rowCount] = Float.parseFloat(pieces[1]);

    // increment the number of valid rows found so far
    rowCount++;      
  }
  
  dataMax = getMax(times, dataMax);

  colour = setupColours(coloursUsed);
  coloursUsed++;
  
  //println(times[times.length - 1]);
  
  // sort data into plots
  plots[participant] = new TimeSeries(colour, pages, times, columnName, participant);   
  
}

void scrubQuotes(String[] array) {
  for (int i = 0; i < array.length; i++) {
    if (array[i].length() > 2) {
      // remove quotes at start and end, if present
      if (array[i].startsWith("\"") && array[i].endsWith("\"")) {
        array[i] = array[i].substring(1, array[i].length() - 1);
      }
    }
    // make double quotes into single quotes
    array[i] = array[i].replaceAll("\"\"", "\"");
  }
}

float getMax(float[] values, float oldMax) {
  float max = values[0];
  for (int i = 1; i < values.length; i++) {
    if (max < values[i]) {
     max =  values[i];
    }
  }
  if (max > oldMax) {
    return max;
  }
  else {
    return oldMax;
  } 
}

color setupColours(int participant) {
  color setColour = color(0);

  switch(participant) {
    case 0:
      setColour = color(81, 206, 96);
      break;
    case 1:
      setColour = color(206, 72, 130);
      break;
    case 2:
      setColour = color(88, 92, 206);        
      break;
    case 3:
      setColour = color(205, 89, 74);
      break;
    case 4:
      setColour = color(206, 203, 105);
      break;
    case 5:
      setColour = color(76, 139, 206);
      break;
    case 6:
      setColour = color(205, 62, 206);
      break;
    case 7:
      setColour = color(204, 158, 70);
      break;
    case 8:
      setColour = color(105, 162, 85);
      break;
    case 9:
      setColour = color(202, 151, 183);
      break;
  }
  return setColour;
}