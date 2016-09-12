//Container c1;
Button b1;
Button b2;
Button b3;
Button b4;
Button b5;
ScrollBar s1;
ScrollBar s2;
//TextBox t1;
//LabelBox l1;
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
    b1 = addButton(.012, .5, .1, .35, "Time");
    b1.isOn = true;
    //b1.isVisible = false;
    s1 = addScrollBar(0.12, 0.5, .6, .35, 0, 100, 20);
    //s1.isVisible = false;
    
    b2 = addButton(0.75, .08, .15, .85, "Test 1");
    
    b3 = addButton(.15, .08, .13, .35, "Quantum");
    b3.isOn = true;
    b4 = addButton(.29, .08, .13, .35, "Classical");
    b4.isOn = true;
    
    b5 = addButton(.012, .08, .13, .35, "Detector");
    
    
    s2 = addScrollBar(0.44, 0.08, .28, .31, -30, 30, 0);
    
    //t1 = addTextBox(.012, .48, .76, .2, "");
    //l1 = addLabelBox(.8, .8, .1, .15, "24");
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
    useTime = !useTime;
    
    if (useTime) b1.isOn = true;
    else b1.isOn = false;
    
    s1.isVisible = useTime;
  }
  
  if (s1 != null && s1.doProcess == true) 
  {
    time = (int) s1.curV;
  }
  
  if (b2 != null && b2.doProcess == true) 
  {
    test++;
    if (test >= 6) test = 1;
    b2.txt = "Test " + test;
    ResetTest();
  }
  
  if (s2 != null && s2.doProcess == true) 
  {
    laserOffset = (int) s2.curV;
  }
  
  if (b3 != null && b3.doProcess == true) 
  {
    showQuantum = !showQuantum;
    b3.isOn = showQuantum;
  }
  
  if (b4 != null && b4.doProcess == true) 
  {
    showClassical = !showClassical;
    b4.isOn = showClassical;
    
    /*showLines++;
    if (showLines >=3) showLines = 0;
    
    if (showLines == 0)
    {
      b1.isVisible = false;
      s1.isVisible = false;
    }
    else
    {
      b1.isVisible = true;
      s1.isVisible = useTime;
    }*/
  }
  
  if (b5 != null && b5.doProcess == true) 
  {
    useDetector = !useDetector;
    b5.isOn = useDetector;
    ResetTest();
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