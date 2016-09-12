Container c1;
Button bStart;
Button bFast;
Button bSecondMirror;
Button bGraph;
ScrollBar s1;
//TextBox t1;
LabelBox l1;
//KeyboardContainer kbContainer;
//KeyboardCtrl kbctrl1;

Container c2;
ScrollBar s2;
ScrollBar s3;

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
    c1 = addContainer(0, 0, 0.7, 1);
    c1.hasBorder = false;
    // add buttons to tab
    
    setContainer(c1);
    bStart = addButton(.012, .1, .12, .35, "Start");
    bSecondMirror = addButton(.2, .1, .12, .35, "Mirror");
    bGraph = addButton(.4, .1, .12, .35, "Graph");
    bFast = addButton(.595, .1, .12, .35, "Fast");
    s1 = addScrollBar(0.012, 0.6, .7, .31, 0, 59, 0);
    
    c2 = addContainer(0.75, 0, 0.6, 0.95);
    setContainer(c2);
    l1 = addLabelBox(0.05, 0.1, .4, .31, "Reflect");
    s2 = addScrollBar(0.05, 0.6, .4, .31, 0, PI*4, PI*2);
    
    l1 = addLabelBox(0.55, 0.1, .4, .31, "Through");
    s3 = addScrollBar(0.55, 0.6, .4, .31, 0, .3, 0.085);
    
    
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
  if (bStart != null && bStart.doProcess == true) 
  {
    start = !start;
    bStart.isOn = start;
  }
  
  if (bSecondMirror != null && bSecondMirror.doProcess == true) 
  {
    useMirror = !useMirror;
    bSecondMirror.isOn = useMirror;
  }
  
  if (bGraph != null && bGraph.doProcess == true) 
  {
    graph = !graph;
    bGraph.isOn = graph;
  }
  
  if (bFast != null && bFast.doProcess == true) 
  {
    fast = !fast;
    bFast.isOn = fast;
  }
  
  if (s1 != null && s1.doProcess == true) 
  {
    detectorDistance = (int) s1.curV;
  }
  
  if (s2 != null && s2.doProcess == true) 
  {
    reflect = (float) s2.curV;
  }
  
  if (s3 != null && s3.doProcess == true) 
  {
    through = (float) s3.curV;
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