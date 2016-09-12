//
Button b1;
Button b2;

Button b3;

Container c1;
Button bD0;
Button bD1;
Button bD2;
Button bD3;
Button bD4;

Button bPath;

ScrollBar s1;
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
    b1 = addButton(.012, .1, .12, .45, "Start");
    b2 = addButton(.15, .1, .12, .45, "Fast");
    b3 = addButton(.3, .1, .12, .45, "Graph");
    s1 = addScrollBar(0.012, 0.6, .79, .31, -50, 50, 0);
    bPath = addButton(.82, 0.6, .1, .31, "Path");
    
    c1 = addContainer(0.45, 0.1, 0.45, 0.45);
    c1.isVisible = false;
    setContainer(c1);
    bD0 = addButton(0, 0, 0.18, 1, "D0");
    bD0.isOn = true;
    bD1 = addButton(0.205, 0, 0.18, 1, "D0-D1");
    bD2 = addButton(0.41, 0, 0.18, 1, "D0-D2");
    bD3 = addButton(0.615, 0, 0.18, 1, "D0-D3");
    bD4 = addButton(0.82, 0, 0.18, 1, "D0-D4");
    
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
    start = !start;
    
    b1.isOn = start;
  }
  
  if (b2 != null && b2.doProcess == true) 
  {
    fast = !fast;
    
    b2.isOn = fast;
  }
  
  if (b3 != null && b3.doProcess == true) 
  {
    graph = !graph;
    
    c1.isVisible = graph;
    
    b3.isOn = graph;
  }
  
  if (bD0 != null && bD0.doProcess == true) 
  {
    bD0.isOn = false;
    bD1.isOn = false;
    bD2.isOn = false;
    bD3.isOn = false;
    bD4.isOn = false;
    
    allStates = true;
    state = -1;
    bD0.isOn = true;
  }
  
  if (bD1 != null && bD1.doProcess == true) 
  {
    bD0.isOn = false;
    bD1.isOn = false;
    bD2.isOn = false;
    bD3.isOn = false;
    bD4.isOn = false;
    
    allStates = false;
    state = 1;
    bD1.isOn = true;
  }
  
  if (bD2 != null && bD2.doProcess == true) 
  {
    bD0.isOn = false;
    bD1.isOn = false;
    bD2.isOn = false;
    bD3.isOn = false;
    bD4.isOn = false;
    
    allStates = false;
    state = 2;
    bD2.isOn = true;
  }
  
  if (bD3 != null && bD3.doProcess == true) 
  {
    bD0.isOn = false;
    bD1.isOn = false;
    bD2.isOn = false;
    bD3.isOn = false;
    bD4.isOn = false;
    
    allStates = false;
    state = 3;
    bD3.isOn = true;
  }
  
  if (bD4 != null && bD4.doProcess == true) 
  {
    bD0.isOn = false;
    bD1.isOn = false;
    bD2.isOn = false;
    bD3.isOn = false;
    bD4.isOn = false;
    
    allStates = false;
    state = 4;
    bD4.isOn = true;
  }
  
  if (s1 != null && s1.doProcess == true) 
  {
    d0X =  (int) s1.curV;
  }
  
  if (bPath != null && bPath.doProcess == true) 
  {
    showPath = !showPath;
    
    bPath.isOn = showPath;
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