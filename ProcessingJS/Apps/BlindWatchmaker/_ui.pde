//Container c1;
Button bStartStop;
Button bStep;
Button bReset;
Button bClear;
TextBox t1;
KeyboardContainer kbContainer;
KeyboardCtrl kbctrl1;

Button bFastSlow;
ScrollBar s1;
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
    setupCM(SHOW_AS_HORIZONTAL, SHOW_AT_BOTTOM, 5, START_OPENED);
    //setupCM(SHOW_AS_VERTICAL, SHOW_AT_LEFT, 3, START_OPENED);
    //setupCM(SHOW_AS_VERTICAL, SHOW_AT_RIGHT, 3, START_OPENED);
    
    //setContainer(null);
    //c1 = addContainer(0, 0.2, 1, 0.8);
    // add buttons to tab
    
    //setContainer(c1);
    //b1 = addButton(.012, .1, .12, .31, "Triangle");
    //s1 = addScrollBar(0.012, 0.4, .7, .31, 0, 100, 50);
    
    bStartStop = addButton(.85, .1, .1, .21, "Start");
    bStep = addButton(.74, .1, .1, .21, "Step"); bStep.isOn = true;
    bReset = addButton(.012, .1, .1, .21, "Reset");
    bClear = addButton(.125, .1, .1, .21, "Clear");
    
    t1 = addTextBox(.25, .1, .45, .25, "Methinks it is like a weasel."); t1.isCaseSensistive = true;
    kbContainer = addKeyboardContainer(.012, .4, .9, .3);
    kbctrl1 = addKeyboardCtrl(0, 0, 1, 1, null);
    kbctrl1.addLine("qwertyuiop");
    kbctrl1.addLine("asdfghjkl");
    kbctrl1.addLine("zxcvbnm");
    kbctrl1.addLine("QWERTYUIOP");
    kbctrl1.addLine("ASDFGHJKL");
    kbctrl1.addLine("ZXCVBNM");
    kbctrl1.addLine(".? ");
    t1.attachKeyboard(kbctrl1, kbContainer);
    kbContainer.setKeyboard(kbctrl1, t1); // to start off with a keyboard
    
    
    bFastSlow = addButton(.012, .8, .1, .15, "Fast");
    s1 = addScrollBar(0.135, 0.8, .65, .15, 1, 29, 1);
    l1 = addLabelBox(.8, .8, .1, .15, "1");
    
    //c.hasBorder = true;
    //b.isOn = false;
    //b.isContinous = false;
    //b.isManualDraw = flase;
    //x.isDisabled = false;
    //x.isVisible = true;
    //t.isAutoClear = false;
    //t.isCaseSensistive = false;
    //kbctrl.isContinous = false;
    //s.setRange(min, max, cur);
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
  if (bStartStop != null && bStartStop.doProcess == true) 
  {
    doContinue = !doContinue;
    if (doContinue) 
    {
      start = true;
      bStartStop.txt = "Stop";
    }
    else 
    {
      start = false;
      bStartStop.txt = "Start";
    }
  }
  
  if (bStep != null && bStep.doProcess == true) 
  {
    doStep = !doStep;
    bStep.isOn = doStep;
    //update();
  }
  
  if (bReset != null && bReset.doProcess == true) 
  {
    reset(t1.txt);
    s1.setRange(.5, t1.txt.length+.4, .5);
    NN = (int) (s1.curV + 0.5);
    l1.txt = "" + NN;
  }
  
  if (bClear != null && bClear.doProcess == true) 
  {
    t1.clear();
  }
  
  if (bFastSlow != null && bFastSlow.doProcess == true) 
  {
    fast = !fast;
    if (fast) bFastSlow.txt = "Slow";
    else bFastSlow.txt = "Fast";
  }
  
  if (s1 != null && s1.doProcess == true) 
  {
    NN = (int) (s1.curV + 0.5);
    l1.txt = "" + NN;
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