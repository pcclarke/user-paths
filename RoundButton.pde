//**********************************
//ROUND BUTTON
//**********************************
class RoundButton
{
  boolean state;
  color fillOnColour, fillOffColour;
  float x, y, radius;
  int id;
  String label;

  RoundButton (int inputId)
  {
    id = inputId;

    x = 0;
    y = 0;
    radius = 20;
    fillOnColour = color(150, 150, 255);
    fillOffColour = color(255);
    state = false;
  }
  
  void draw()
  {
    noStroke();
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
    ellipseMode(CENTER);
    ellipse(x, y, radius, radius);

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
    textAlign(CENTER);
    text(id + 1, x, y + (radius / 4));
  }
  
  void setPos(float inputx, float inputy) {
    x = inputx;
    y = inputy;
  }

  void setRad (float inRadius) {
    radius = inRadius;
  }
  
  void setState (boolean inputState) {
    state = inputState;
  }
  
  void flipState() {
    state = state ? false : true;
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

  boolean checkMouse() {
    if (sqrt((sq(mouseX - x) + sq(mouseY - y))) < radius - 5) {
      return true;
    } else {
      return false;
    }
  }

  String getLabel() {
    return label;
  }

  int getId() {
    return id;
  }
}