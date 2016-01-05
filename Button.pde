//**********************************
//Button Class - This makes Buttons!
//**********************************
class Button
{
  boolean state;
  boolean showBorder;
  color fillOnColour;
  color fillOffColour;
  color textColour;
  color borderColour;
  float x, y, h, w;
  int id;
  String label, align;

  Button (String inputLabel, int inputId)
  {
    label = inputLabel;
    id = inputId;

    x = 0;
    y = 0;
    h = 15;
    w = 75;

    fillOffColour = color(255);
    fillOnColour = color(65, 109, 243);
    textColour = color(0);
    borderColour = color(220);

    state = false;
    showBorder = false;

    align = "CENTER";
  }

  // Set height and width
  void setDim(float inH, float inW) {
    h = inH;
    w = inW;
  }
  
  // Set x and y position
  void setPos(float inX, float inY) {
    x = inX;
    y = inY;
  }

  // Set alignment of button label
  void setAlign(String ali) {
    if (ali.equals("LEFT") || ali.equals("CENTER") || ali.equals("RIGHT")) {
      align = ali;  
    } else {
      align = "CENTER";
    }
  }
  
  // State stuff (is the button 'ON' or 'OFF')
  void flipState() {
    state = (state) ? false : true;
  }

  void setState (boolean inputState) {
    state = inputState;
  }

  boolean getState() {
    return state;
  }
  
  // Set button fill colour
  void setFillOnColour (color inColour) {
    fillOnColour = inColour;
  }

  void setFillOffColour(color inputColour) {
    fillOffColour = inputColour;
  }

  // Checks if cursor is inside button area
  boolean checkMouse() {
    if ((mouseX < x + w) && (mouseX > x) && (mouseY < y + h) && (mouseY > y)) {
      showBorder = true;
      return true;     
    } else {
      showBorder = false;
      return false;
    }
  }
  
  // Return button label
  String getLabel() {
    return label;
  }

  int getId()
  {
    return id;
  }
  
  void setBorder(boolean inputBorder)
  {
      showBorder = inputBorder;
  }

  void draw()
  {
    if (state) {
      if (checkMouse()) {
        fill(fillOffColour);
      } else {
        fill(fillOnColour);
      }
    } else { 
      if (checkMouse()) {
        fill(fillOnColour);
      } else {
        fill(fillOffColour);
      }
    }
    
    if (showBorder) {
      strokeWeight(1);
      stroke(borderColour);
    } else {
      noStroke();
    }   

    rectMode(CORNER);
    rect(x, y, w, h, 30);

    if (state) {
      if (checkMouse()) {
        fill(0);
      } else {
        fill(255);
      }
    } else { 
      if (checkMouse()) {
        fill(255);
      } else {
        fill(0);
      }
    }
    textSize(14);

    if (align.equals("CENTER")) {
      textAlign(CENTER);
      text(label, x + (0.5 * (w)), y + 4 + (0.5 * h));
    } else if (align.equals("LEFT")) {
      textAlign(LEFT);
      text(label, x + 5, y + 4 + (0.5 * h));      
    } else {
      textAlign(RIGHT);
      text(label, x + w - 5, y + 4 + (0.5 * h));
    }
  }
}