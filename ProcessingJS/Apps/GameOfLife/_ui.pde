//Container c1;
Button bclr;
Button bRnd;
Button bCenter;


Button bMatt;
Button bWall;
Button bLife;
Button bSplit;
Button bStartStop;

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
    
    //setContainer(null);
    //c1 = addContainer(0, 0.2, 1, 0.8);
    // add buttons to tab
    
    //setContainer(c1);
    bMatt = addButton(.012, .1, .12, .7, "Matt");
    bLife = addButton(.144, .1, .12, .7, "Life"); bLife.isOn = true;
    
    
    
    bclr = addButton(.28, .1, .12, .31, "Clear");
    bCenter = addButton(.42, .1, .12, .31, "Center");
    bRnd = addButton(.56, .1, .12, .7, "Rnd");
    
    
    bWall = addButton(.28, .5, .12, .31, "Wall");
    bSplit = addButton(.42, .5, .12, .31, "Split");
    
    
    
    bStartStop = addButton(.7, .1, .21, .7, "Start");
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
  if (bclr != null && bclr.doProcess == true) { clearFabric(); }
  if (bRnd != null && bRnd.doProcess == true) { addRandom(); }
  if (bCenter != null && bCenter.doProcess == true) { addCenter(); }
  
  if (bMatt != null && bMatt.doProcess == true) 
  {
    start = false; bStartStop.txt = "Start"
    bMatt.isOn = true;
    bLife.isOn = false;
    bk = true;
    controller = new GravityWaveController();
    createFabric();
    controller.initialiseFabric()
  }
  
  if (bLife != null && bLife.doProcess == true) 
  {
    start = false; bStartStop.txt = "Start"
    bMatt.isOn = false;
    bLife.isOn = true;
    bk = false;
    controller = new GameOfLifeController();
    createFabric();
    controller.initialiseFabric()
  }
  
  if (bWall != null && bWall.doProcess == true) 
  {
    isWall = !isWall;
    bWall.isOn = isWall;
  }
  
  
  if (bSplit != null && bSplit.doProcess == true) { doSplit(); }
  
  if (bStartStop != null && bStartStop.doProcess == true) 
  {
    if (start) { start = false; bStartStop.txt = "Start" }
    else { start = true; bStartStop.txt = "Stop" } 
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