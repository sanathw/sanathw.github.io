Container c1;
Container c2;
Button bChaos;
Button bFractal;
Button brst;
Button bfstep;

Button b1; Button b2;
Button b3; Button b4;
Button bsp;
Button bs;
Button bstep;

TextBox t1;
KeyboardContainer kbContainer;
KeyboardCtrl kbctrl1;

Button bseq;
Button bclr;

Button bhd;

void setupUI()
{
  with (pjsCM)
  {
    //showLocation(SHOW_AS_HORIZONTAL, SHOW_AT_TOP);
    //showLocation(SHOW_AS_HORIZONTAL, SHOW_AT_BOTTOM);
    //showLocation(SHOW_AS_VERTICAL, SHOW_AT_LEFT);
    //showLocation(SHOW_AS_VERTICAL, SHOW_AT_RIGHT);
    //setupCM(SHOW_AS_HORIZONTAL, SHOW_AT_TOP, 3, START_OPENED);
    setupCM(SHOW_AS_HORIZONTAL, SHOW_AT_BOTTOM, 4, START_OPENED);
    //setupCM(SHOW_AS_VERTICAL, SHOW_AT_LEFT, 3, START_OPENED);
    //setupCM(SHOW_AS_VERTICAL, SHOW_AT_RIGHT, 3, START_OPENED);
    
    setContainer(null);
    
    c1 = addContainer(0, 0.2, 1, 0.8);
    c2 = addContainer(0, 0.2, 1, 0.8);
    bChaos = addButton(.012, .0, .12, .2, "Chaos");
    bFractal = addButton(.144, .0, .12, .2, "Fractal");
    
    //-----------------
    setContainer(c1);
    
    b1 = addButton(.012, .1, .12, .31, "Triangle");
    b2 = addButton(.14, .1, .12, .31, "Pentagon");

    b3 = addButton(.268, .1, .12, .31, "20");
    b4 = addButton(.396, .1, .12, .31, "Any");
    
    bsp = addButton(.524, .1, .12, .31, "Set Point");
    bstep = addButton(.652, .1, .12, .31, "Step");
    bs = addButton(.78, .1, .12, .31, "Start");
    
    t1 = addTextBox(.012, .48, .76, .2, "");
    kbContainer = addKeyboardContainer(.14, .78, .632, .2);
    kbctrl1 = addKeyboardCtrl(0, 0, 1, 1, null);
    kbctrl1.addLine("1234567890");
    t1.attachKeyboard(kbctrl1, kbContainer);
    
    bseq = addButton(.78, .48, .12, .2, "seq");
    //bseq.isOn = true;
    
    //kbctrl1.isDisabled = true;
    
    bclr = addButton(.012, .78, .12, .2, "clear");
    
    bhd = addButton(.78, .78, .12, .2, "hide");
    
    t1.isDisabled = true;
    kbContainer.isDisabled = true;
    bclr.isDisabled = true;
    //-----------------
    
    //-----------------
    setContainer(c2);
    brst = addButton(.05, .3, .4, .4, "Reset");
    bfstep = addButton(.5, .3, .4, .4, "Step");
    //-----------------
    
    c1.isVisible = true; bChaos.isOn = true;
    c2.isVisible = false;
  }
  
  resetData();
}



void processUI()
{
  if (bChaos != null && bChaos.doProcess == true) { setupPolygon(3); isChaos = true; c1.isVisible = true; c2.isVisible = false; bChaos.isOn = true; bFractal.isOn = false;}
  if (bFractal != null && bFractal.doProcess == true) {resetFractal(); isChaos = false; c2.isVisible = true; c1.isVisible = false; bChaos.isOn = false; bFractal.isOn = true;}
  
  if (b1 != null && b1.doProcess == true) {b4.isOn = false; isAny = false; setupPolygon(3);}
  if (b2 != null && b2.doProcess == true) {b4.isOn = false; isAny = false; setupPolygon(5);}
  if (b3 != null && b3.doProcess == true) {b4.isOn = false; isAny = false; setupPolygon(20);}
  if (b4 != null && b4.doProcess == true)
  {
    b4.isOn = true;
    isAny = true;
    
    //doReset = true;
    resetPolygon();
    
    
    bs.txt = "Start";
    start = false;
    bs.isOn = false;
  }
  
  if (bsp != null && bsp.doProcess == true)
  {
    b4.isOn = false;
    isAny = false;
  
    if (setP0)
    {
      setP0 = false;
      bsp.isOn = false;
    }
    else
    {
      setP0 = true;
      bsp.isOn = true;
      
      bs.txt = "Start";
      start = false;
      bs.isOn = false;
    }
  }
  
  if (bs != null && bs.doProcess == true)
  {
    b4.isOn = false;
    isAny = false;
  
    if (!start)
    {
      bs.txt = "Stop";
      start = true;
      bs.isOn = true;
      setP0 = false;
      bsp.isOn = false;
    }
    else
    {
      bs.txt = "Start";
      start = false;
      bs.isOn = false;
    }
  }
  
  if (bstep != null && bstep.doProcess == true)
  {
    b4.isOn = false;
    isAny = false;
  
    bs.txt = "Start";
    start = false;
    bs.isOn = false;
    setP0 = false;
    bsp.isOn = false;
    step = true;
  }
  
  if (bseq != null && bseq.doProcess == true)
  {
    clearPolygon();
    //doReset = true;
    if (isRnd)
    {
      t1.isDisabled = false;
      kbContainer.isDisabled = false;
      bclr.isDisabled = false;
      isRnd = false;
      bseq.isOn = true;
    }
    else
    {
      t1.isDisabled = true;
      kbContainer.isDisabled = true;
      bclr.isDisabled = true;
      isRnd = true;
      bseq.isOn = false;
    }
  }
  //if (pjs!= null && isRnd) brand.isOn = true;
  //else bseq.isOn = false;
  
  if (bclr != null && bclr.doProcess == true)
  {
    clearPolygon();
    t1.setText("");
  }
  
  if (bhd != null && bhd.doProcess == true)
  {
    if (hideOverlay)
    {
      bhd.isOn = false;
      hideOverlay = false;
    }
    else
    {
      bhd.isOn = true;
      hideOverlay = true;
    }
  }
  
  if (brst != null && brst.doProcess == true)
  {
    resetFractal();
  }
  
  if (bfstep != null && bfstep.doProcess == true)
  {
    startFractal();
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