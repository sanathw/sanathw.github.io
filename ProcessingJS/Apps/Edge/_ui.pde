//Container c1;
Button bShow;
Button bT1;
Button bT2;
Button bT3;
Button bShowScale;
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
    setupCM(SHOW_AS_HORIZONTAL, SHOW_AT_BOTTOM, 3, START_CLOSED);
    //setupCM(SHOW_AS_VERTICAL, SHOW_AT_LEFT, 3, START_OPENED);
    //setupCM(SHOW_AS_VERTICAL, SHOW_AT_RIGHT, 3, START_OPENED);
    
    //setContainer(null);
    //c1 = addContainer(0, 0.2, 1, 0.8);
    // add buttons to tab
    
    //setContainer(c1);
    bShow = addButton(.01, .2, .2, .5, "Show"); bShow.txt = "Cam";
    bT1 = addButton(.22, .2, .2, .5, "T1"); bT1.isOn = true;
    bT2 = addButton(.43, .2, .2, .5, "T2");
    bT3 = addButton(.64, .2, .2, .5, "T3");
    bShowScale = addButton(.85, .2, .1, .5, "1");
    //t1 = addTextBox(.012, .48, .76, .2, "");
    //kbContainer = addKeyboardContainer(.14, .78, .632, .2);
    //kbctrl1 = addKeyboardCtrl(0, 0, 1, 1, null);
    //kbctrl1.addLine("1234567890");
    //t1.attachKeyboard(kbctrl1, kbContainer);
    //kbContainer.setKeyboard(kbctrl1, t1); // to start off with a keyboard
    
    //b.isOn = false;
    //b.isContinous = false;
    //b.isManualDraw = flase;
    //x.isDisabled = false;
    //x.isVisible = true;
    //t.isAutoClear = false;
    //t.isCaseSensistive = false;
    //kbctrl.isContinous = false;
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
  if (bShow != null && bShow.doProcess == true) 
  {
    if (state == 1)
    {
      showCur = true;
      showOut = true;
      state = 2;
      bShow.txt = "Cam+Edge";
    }
    else if (state == 2)
    {
      showCur = false;
      showOut = true;
      state = 3;
      bShow.txt = "Edge";
    }
    else if (state == 3)
    {
      showCur = true;
      showOut = false;
      state = 1;
      bShow.txt = "Cam";
    }
  }
  
  if (bT1 != null && bT1.doProcess == true) 
  {
    bT1.isOn = true;
    bT2.isOn = false;
    bT3.isOn = false;
    
    diff1 = 100;
    diff2 = 50;
    diff3 = 30;
  }
  
  if (bT2 != null && bT2.doProcess == true) 
  {
    bT1.isOn = false;
    bT2.isOn = true;
    bT3.isOn = false;
    
    diff1 = 200;
    diff2 = 150;
    diff3 = 130;
  }
  
  if (bT3 != null && bT3.doProcess == true) 
  {
    bT1.isOn = false;
    bT2.isOn = false;
    bT3.isOn = true;
    
    diff1 = 100;
    diff2 = 9999;
    diff3 = 99999;
  }
  
  if (bShowScale != null && bShowScale.doProcess == true) 
  {
    if (outScale == 1)
    {
      outScale = 4;
      imgOut = new PImage(camW/outScale, camH/outScale);
      bShowScale.txt = "4";
    }
    else if (outScale == 4)
    {
      outScale = 8;
      imgOut = new PImage(camW/outScale, camH/outScale);
      bShowScale.txt = "8";
    }
    else if (outScale == 8)
    {
      outScale = 20;
      imgOut = new PImage(camW/outScale, camH/outScale);
      bShowScale.txt = "20";
    }
    else if (outScale == 20)
    {
      outScale = 1;
      imgOut = new PImage(camW/outScale, camH/outScale);
      bShowScale.txt = "1";
    }
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