//Container c1;
Button bStart;
Button bReset;
ScrollBar s1;
//TextBox t1;
LabelBox l1;
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
    bStart = addButton(.1, .1, .15, .4, "Start");
    bReset = addButton(.3, .1, .15, .4, "Reset");
    s1 = addScrollBar(0.2, 0.6, .5, .35, 1, 8, 1);
    //t1 = addTextBox(.012, .48, .76, .2, "");
    l1 = addLabelBox(.012, .6, .1, .35, "tick rate");
    //kbContainer = addKeyboardContainer(.14, .78, .632, .2);
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
  if (bStart != null && bStart.doProcess == true) 
  {
    start = !start;
    bStart.isOn = start;
    Vstopped = false;
    Hstopped = false;
  }
  
  if (bReset != null && bReset.doProcess == true) 
  {
    clockV.Reset(false, 0, 0);
    clockH.Reset(false, 0, 0);
    lightRadiusV = 0;
    lightRadiusH = 0;
    lightPosV = new PVector(lightStart.x, lightStart.y);
    lightPosH = new PVector(lightStart.x, lightStart.y);
    Vstopped = false;
    Hstopped = false;
    speedX = 0;
    speedY = 0;
    speed = 0;
  }
  
  if (s1 != null && s1.doProcess == true) 
  {
    tick = s1.curV;
    clockV.tick = tick;
    clockH.tick = tick;
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