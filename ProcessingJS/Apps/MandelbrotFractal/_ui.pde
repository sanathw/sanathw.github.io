Button b1;

TextBox t1;
KeyboardContainer kbContainer;
KeyboardCtrl kbctrl1;

LabelBox l1;

void setupUI()
{
  with (pjsCM)
  {
    //showLocation(SHOW_AS_HORIZONTAL, SHOW_AT_TOP);
    //showLocation(SHOW_AS_HORIZONTAL, SHOW_AT_BOTTOM);
    //showLocation(SHOW_AS_VERTICAL, SHOW_AT_LEFT);
    //showLocation(SHOW_AS_VERTICAL, SHOW_AT_RIGHT);
    //setupCM(SHOW_AS_HORIZONTAL, SHOW_AT_TOP, 3, START_OPENED);
    setupCM(SHOW_AS_HORIZONTAL, SHOW_AT_BOTTOM, 3, START_OPENED);
    //setupCM(SHOW_AS_VERTICAL, SHOW_AT_LEFT, 3, START_OPENED);
    //setupCM(SHOW_AS_VERTICAL, SHOW_AT_RIGHT, 3, START_OPENED);
    
    b1 = addButton(.3, .2, .4, .5, "Reset");
    
    t1 = addTextBox(.01, .1, .1, .25, "");
    t1.isAutoClear = true;
    kbContainer = addKeyboardContainer(.01, .4, .1, .25);
    kbctrl1 = addKeyboardCtrl(0, 0, 1, 1, null);
    kbctrl1.addLine("q w");
    t1.attachKeyboard(kbctrl1, kbContainer);
    
    kbContainer.setKeyboard(kbctrl1, t1); // to start off with a keyboard*/
    
    l1 = addLabelBox(.12, .1, .1, .25, "Manual");
    autoZoom = false;
  }
  
  resetData();
}



void processUI()
{
  if (b1 != null && b1.doProcess == true) {resetFractal();}
  
  if (t1 != null && t1.doProcess == true) 
  {
    if (t1.txt == " ") 
    { 
      if (autoZoom) { autoZoom = false; l1.txt = "Manual"; }
      else { autoZoom = true; l1.txt = "Auto"; }
    }
    
    if (t1.txt == "w") 
    { 
      if (isMobile)
      {
        //zoomPhoneFractal(1);
      }
      else zoomFractal(1);
    }
    
    if (t1.txt == "q") 
    { 
      if (isMobile)
      {
        //zoomPhoneFractal(-1);
      }
      else zoomFractal(-1);
    }
  }
}



void drawHUD(var g)
{   
  /*g.beginText(.5, 0, color(0), CENTER, CENTER);
  g.translate(0, g.getCharSize() / 2); // starting posintion on screen
  g.text("Title", 0,0);
  g.endText();
  
  
  g.beginText(0, 0, color(255), LEFT, TOP);
  g.translate(g.getCharSize() / 2, g.getCharSize() / 2); // starting posintion on screen
  g.scale(0.7);
  g.text("MouseX = " + mouseX.toFixed(2), 0,0);
  g.translate(0, g.getCharSize());
  g.text("MouseY = " + mouseY.toFixed(2), 0,0);
  g.endText();*/
}

void resetData()
{
  //use data
}

void saveData()
{
  //save into data
}