//Container c1;
Button bDesignTrack;
Button bCapture;
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
    bDesignTrack = addButton(.01, .2, .2, .5, "Tracking");
    bCapture = addButton(.22, .2, .2, .5, "Capture"); bCapture.isOn = true;
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
  if (bDesignTrack != null && bDesignTrack.doProcess == true) 
  {
    captureMode = false;
    
    if (designMode)
    {
      bDesignTrack.txt = "Design";
      designMode = false;
      bCapture.isDisabled = true;
    }
    else
    {
      bDesignTrack.txt = "Tracking";
      designMode = true;
      bCapture.isDisabled = false;
    }
  }
  
  if (bCapture != null && bCapture.doProcess == true) 
  {
    captureMode = !captureMode;
    bCapture.isOn = captureMode;
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