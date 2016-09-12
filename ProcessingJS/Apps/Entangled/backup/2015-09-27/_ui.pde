//Container c1;
Button b1;
Button b2;
Button b3;
//ScrollBar s1;
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
    b1 = addButton(.4, .1, .5, .8, "Classical");
    b2 = addButton(.1, .1, .15, .8, "Bell");
    b3 = addButton(.27, .1, .12, .8, "Sync");
    //s1 = addScrollBar(0.012, 0.4, .7, .31, 0, 100, 50);
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
    isQED = !isQED;
    
    if (doBell)
    {
      if (isQED) b1.txt = "Quantum 0.25";
      else b1.txt = "Classical 0.333";
    }
    else
    {
      if (isQED) b1.txt = "Quantum 0.5";
      else b1.txt = "Classical 0.333";
    }
    
    ResetData();
  }
  
  if (b2 != null && b2.doProcess == true) 
  {
    doBell = !doBell;
    
    if (doBell) b2.isOn = true;
    else b2.isOn = false;
    
    ResetData();
  }
  
  if (b3 != null && b3.doProcess == true) 
  {
    inputType++;
    if (inputType > 2) inputType = 0;
    
    if (inputType == 0) b3.txt = "Sync";
    if (inputType == 1) b3.txt = "Opp";
    if (inputType == 2) b3.txt = "Rnd";
    
    ResetData();
  }
}

void ResetData()
{
    count = 0;
    clicks = 0;
    
    A.count = 0;
    A.clicks = 0;
    B.count = 0;
    B.clicks = 0;
    
    AnotB = 0;
    BnotC = 0;
    AnotC = 0;
    ABC = 0;
    
    clicks2 = 0;
    
    Left = 0;
    Right = 0;
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