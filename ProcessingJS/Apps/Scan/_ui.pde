//Container c1;
Button b1;
TextBox t1;
KeyboardContainer kbContainer;
KeyboardCtrl kbctrl1;

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
    b1 = addButton(.75, .1, .15, .5, "Scan");
    t1 = addTextBox(.1, .1, .1, .3, "");
    t1.isAutoClear = true;
    kbContainer = addKeyboardContainer(.1, .5, .6, .4);
    kbctrl1 = addKeyboardCtrl(0, 0, 1, 1, null);
    kbctrl1.isContinous = true;
    kbctrl1.addLine("qweraszx ");
    t1.attachKeyboard(kbctrl1, kbContainer);
    kbContainer.setKeyboard(kbctrl1, t1); // to start off with a keyboard
    
    //b.isOn = true;
    //x.isDisabled = true;
    //x.isVisible = false;
  }
  
  resetData();
}

void processUI()
{
  if (b1 != null && b1.doProcess == true) 
  {
    if (doScan == true)
    {
      //ix1 = -1; iy1 = -1; ix2 = -1; iy2 = -1; 
      //cx = 0; cy =0; ss = 1; rr =0;
      selecting = false;
      b1.txt = "Track"
      doScan = false;
    }
    else
    {
      //ix1 = -1; iy1 = -1; ix2 = -1; iy2 = -1; 
      //cx = 0; cy =0; ss = 1; rr =0;
      selecting = false;
      b1.txt = "Scan";
      doScan = true;
    }
  }
  
  if (t1 != null && t1.doProcess == true) 
  {
    if (t1.txt == "q") cx = cx - 1;
    if (t1.txt == "w") cx = cx + 1;
    if (t1.txt == "e") cy = cy - 1;
    if (t1.txt == "r") cy = cy + 1;
    if (t1.txt == "a") ss = ss / 1.05;
    if (t1.txt == "s") ss = ss * 1.05;
    if (t1.txt == "z") rr = rr - 0.05;
    if (t1.txt == "x") rr = rr + 0.05;
    if (t1.txt == " ") {cx = 0; cy =0; ss = 1; rr =0;}
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