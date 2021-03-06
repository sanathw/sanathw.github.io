Container c1;
Button bStart;
Button bFast;
LabelBox bFirstMirror;
Button bFirstMirrorBackReflect;
Button bSecondMirror;
Button bSecondMirrorBackReflect;
Button bGraph;
ScrollBar s1;
//TextBox t1;

//KeyboardContainer kbContainer;
//KeyboardCtrl kbctrl1;

Button bDetectorA;
Button bDetectorB;

Container c2;
LabelBox l2;
ScrollBar s2;
LabelBox l3;
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
    
    bFirstMirror = addLabelBox(0.18, 0.1, .12, .25, "Mirror1");
    bFirstMirrorBackReflect = addButton(.18, .4, .12, .2, "B-Reflect");
    
    bSecondMirror = addButton(.32, .1, .12, .25, "Mirror2");
    bSecondMirrorBackReflect = addButton(.32, .4, .12, .2, "B-Reflect");
    bSecondMirrorBackReflect.isVisible = false;
    bSecondMirrorBackReflect.isOn = true;
    
    bGraph = addButton(.46, .1, .12, .35, "Graph");
    bFast = addButton(.595, .1, .12, .35, "Fast");
    s1 = addScrollBar(0.012, 0.6, .7, .31, 0, 59, 0);
    
    
    bDetectorA = addButton(.74, .1, .1, .35, "DA");
    bDetectorB = addButton(.74, .6, .1, .35, "DB");
    
    
    c2 = addContainer(0.85, 0, 0.5, 0.95);
    setContainer(c2);
    l2 = addLabelBox(0.05, 0.1, .4, .31, "Reflect");
    s2 = addScrollBar(0.05, 0.6, .4, .31, 0, PI*2, PI);
    
    l3 = addLabelBox(0.55, 0.1, .4, .31, "Through");
    s3 = addScrollBar(0.55, 0.6, .4, .31, 0, PI*2, 0.085);
    
    
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
  
  if (bFirstMirrorBackReflect != null && bFirstMirrorBackReflect.doProcess == true) 
  {
    firstMirrorBackReflect = !firstMirrorBackReflect;
    bFirstMirrorBackReflect.isOn = firstMirrorBackReflect;
  }
  
  if (bSecondMirror != null && bSecondMirror.doProcess == true) 
  {
    useMirror = !useMirror;
    bSecondMirror.isOn = useMirror;
    
    bSecondMirrorBackReflect.isVisible = bSecondMirror.isOn;
  }
  
  if (bSecondMirrorBackReflect != null && bSecondMirrorBackReflect.doProcess == true) 
  {
    secondMirrorBackReflect = !secondMirrorBackReflect;
    bSecondMirrorBackReflect.isOn = secondMirrorBackReflect;
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
  
  
  if (bDetectorA != null && bDetectorA.doProcess == true) 
  {
    useDetectorA = !useDetectorA;
    bDetectorA.isOn = useDetectorA;
  }
  
  if (bDetectorB != null && bDetectorB.doProcess == true) 
  {
    useDetectorB = !useDetectorB;
    bDetectorB.isOn = useDetectorB;
  }
  
  
  
  if (s1 != null && s1.doProcess == true) 
  {
    detectorDistance = (int) s1.curV;
  }
  
  if (s2 != null && s2.doProcess == true) 
  {
    Front_reflect = (float) s2.curV;
  }
  
  if (s3 != null && s3.doProcess == true) 
  {
    through = (float) s3.curV;
    Back_reflect = through + through;
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