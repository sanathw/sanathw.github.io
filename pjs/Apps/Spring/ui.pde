//Container c1;
Button bMode;
Button bReset;
Button bRotate;
Button bShow;
ScrollBar s1;
ScrollBar s2;

Button b1;
Button b2;
Button b3;
//TextBox t1;
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
    
    
    bMode = addButton(.012, .1, .08, .7, "1");
    bReset = addButton(.11, .1, .1, .7, "Rst");
    bRotate = addButton(.22, .1, .1, .35, "T");
    bShow = addButton(.22, .5, .1, .35, "Shw");
    s1 = addScrollBar(0.35, 0.1, .45, .35, 0.1, 0.6, 0.25);
    s2 = addScrollBar(0.35, 0.5, .45, .35, 0.01, .11, 0.05);
    b1 = addButton(.81, .1, .1, .25, "1");
    b2 = addButton(.81, .4, .1, .25, "2");
    b3 = addButton(.81, .7, .1, .25, "3");
    
    //setContainer(null);
    //c1 = addContainer(0, 0.2, 1, 0.8);
    // add buttons to tab
   /* 
    //setContainer(c1);
    bT = addButton(.012, .1, .08, .5, "1");
    
    bM = addButton(.112, .1, .1, .31, "Mass"); bM.isOn = true;
    bK = addButton(.24, .1, .1, .31, "Spring");
    bC = addButton(.37, .1, .1, .31, "Damping"); //bC.isOn = true;
    s1 = addScrollBar(0.112, 0.6, .6, .25, 0.1, 10, mm.m);
    
    bM2 = addButton(.6, .1, .1, .31, "Mass2"); bM2.isDisabled = true;
    
    bG = addButton(.75, .1, .15, .31, "Gavity");
    bR = addButton(.75, .55, .15, .31, "Reset");
    //t1 = addTextBox(.012, .48, .76, .2, "");
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
    //s1.setRange(min, max, cur);*/
  }
  
  //resetData();
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

/*
void reset()
{
  w.gravity = 0;
  bG.isOn = false;
  
  bM.isOn = true;
  bK.isOn = false;
  bC.isOn = false;
  
  
  mm.m = 1;
  ss.k = 0.25;
  ss.c = 0.05;
  
  s1.setRange(0.1, 10, mm.m);
}*/

void processUI()
{
  if (bMode != null && bMode.doProcess == true)
  {
    if (demo == 1) 
    {
      demo2();
      bMode.txt = "2";
      bRotate.isDisabled = true;
      bShow.isDisabled = true;
      s1.isDisabled = true;
      s2.isDisabled = true;
      b1.isDisabled = false;
      b2.isDisabled = true;
      b3.isDisabled = false;
    }
    else
    {
      demo1();
      bMode.txt = "1";
      bRotate.isDisabled = false;
      bShow.isDisabled = false;
      s1.isDisabled = false;
      s2.isDisabled = false;
      b1.isDisabled = false;
      b2.isDisabled = false;
      b3.isDisabled = false;
    }
  }
  
  if (bReset != null && bReset.doProcess == true)
  {
    reset();
  }
  
  if (bRotate != null && bRotate.doProcess == true)
  {
    doTorque = !doTorque;
    bRotate.isOn = doTorque;
  }
  
  if (bShow != null && bShow.doProcess == true)
  {
    doShow = !doShow;
    bShow.isOn = doShow;
  }
  
  if (s1 != null && s1.doProcess == true) 
  {
    setSpringK(s1.curV);
  }
  
  if (s2 != null && s2.doProcess == true) 
  {
    setSpringC(s2.curV);
  }
  
  if (b1 != null && b1.doProcess == true)
  {
    //if (demo == 1)
    //{
      sel = m13;
      b1.isOn = true;
      b2.isOn = false;
      b3.isOn = false;
    //}
  }
  
  if (b2 != null && b2.doProcess == true)
  {
    //if (demo == 1)
    //{
      sel = m23;
      b1.isOn = false;
      b2.isOn = true;
      b3.isOn = false;
    //}
  }
  
  if (b3 != null && b3.doProcess == true)
  {
    //if (demo == 1)
    //{
      sel = m33;
      b1.isOn = false;
      b2.isOn = false;
      b3.isOn = true;
    //}
  }

 /* if (bT != null && bT.doProcess == true) 
  { 
    if (demoType == 1) 
    {
      demoType = 2;
      bT.txt = "2";
      bM2.isDisabled = false;
      demo2();
    }
    else
    {
      demoType = 1;
      bT.txt = "1";
      bM2.isDisabled = true;
      demo1();
    }
    
    reset();
  }
  
  if (bM != null && bM.doProcess == true) {bM.isOn = true; bK.isOn = false; bC.isOn = false; bM2.isOn = false; s1.setRange(0.1, 10, mm.m);}
  if (bK != null && bK.doProcess == true) {bM.isOn = false; bK.isOn = true; bC.isOn = false; bM2.isOn = false; s1.setRange(0.1, 0.75, ss.k);}
  if (bC != null && bC.doProcess == true) {bM.isOn = false; bK.isOn = false; bC.isOn = true; bM2.isOn = false; s1.setRange(0.01, 0.5, ss.c);}
  
  if (s1 != null && s1.doProcess == true) 
  {
    if (bM.isOn) mm.m = s1.curV;
    if (bK.isOn) ss.k = s1.curV;
    if (bC.isOn) ss.c = s1.curV;
    if (bM2.isOn) mm2.m = s1.curV;
  }
  
  if (bM2 != null && bM2.doProcess == true) {bM.isOn = false; bK.isOn = false; bC.isOn = false; bM2.isOn = true; s1.setRange(0.1, 10, mm2.m);}
  
  if (bG != null && bG.doProcess == true)
  {
    bG.isOn = !bG.isOn;
    if (bG.isOn) w.gravity = .5;
    else w.gravity = 0;
  }
  
  if (bR != null && bR.doProcess == true)
  {
    reset();
  }*/
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