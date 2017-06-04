//Container c1;
Button b1;
Button b2;
Button b3;
ScrollBar s1;
ScrollBar s2;
//TextBox t1;
LabelBox l1;
LabelBox l2;
//KeyboardContainer kbContainer;
//KeyboardCtrl kbctrl1;

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
    
    //setContainer(null);
    //c1 = addContainer(0, 0.2, 1, 0.8);
    // add buttons to tab
    
    //setContainer(c1);
    b1 = addButton(.012, .1, .2, .4, "Background");
    b2 = addButton(.3, .1, .2, .4, "Color");
    b3 = addButton(.6, .1, .2, .4, "Gradient");
    s1 = addScrollBar(0.1, 0.6, .3, .31, 1, 500, 500);
    s2 = addScrollBar(0.5, 0.6, .3, .31, 0, 0.5, 0.1);
    //t1 = addTextBox(.012, .48, .76, .2, "");
    l1 = addLabelBox(.012, .6, .1, .31, "Stars");
    l2 = addLabelBox(.4, .6, .1, .31, "Speed");
    //kbContainer = addKeyboardContainer(.14, .78, .632, .2);
    //kbctrl1 = addKeyboardCtrl(0, 0, 1, 1, null);
    //kbctrl1.addLine("1234567890");
    //t1.attachKeyboard(kbctrl1, kbContainer);
    //kbContainer.setKeyboard(kbctrl1, t1); // to start off with a keyboard
    
    //c.hasBorder = true;
    //b.isOn = false;
    //b.isContinous = false;
    //b.isManualDraw = flase;
    //x.isDisabled = false;
    //x.isVisible = true;
    //t.isAutoClear = false;
    //t.isCaseSensistive = false;
    //kbctrl.isContinous = false;
    //s.setRange(minV, maxV, curV);
  }
  
  resetData();
}

//void maualDraw(var o)
//{
//  var g = pjsCM;
//  if (o == bColor1)
//  {
//    if (o.isDisabled) {}
//    else
//    {
//      g.fill(255, 0, 0); g.noStroke();
//      if (o.isOn) {g.stroke(0); g.strokeWeight(4);}
//      if (o.isOver) {g.fill(255, 100, 100);}
//      if (o.isDown) {}
//      g.rectMode(CORNERS);
//      g.rect(o.x1, o.y1, o.x2, o.y2);
//    }
//  }
//}

void processUI()
{
  if (b1 != null && b1.doProcess == true) 
  {
    showBackground = !showBackground;
    b1.isOn = showBackground;
  }
  
  if (b2 != null && b2.doProcess == true) 
  {
    showColor = !showColor;
    b2.isOn = showColor;
  }
  
  if (b3 != null && b3.doProcess == true) 
  {
    showGradient = !showGradient;
    b3.isOn = showGradient;
  }
  
  if (s1 != null && s1.doProcess == true) 
  {
    showStars = s1.curV;
  }
  
  if (s2 != null && s2.doProcess == true) 
  {
    speed = s2.curV;
  }
}


void drawHUD(var g)
{   
}

void resetData()
{
  //use data
}

void saveData()
{
  //save into data
}