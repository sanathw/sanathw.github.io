//Container c1;
Button b1;
Button b2;
Button b3;
Button b4;

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
    float offset = 0.04;
    float buttonWidth = 0.12;
    float buttonHeight = 0.5;
    float buttonStart = 0;
    
    buttonStart = buttonStart + offset;
    b1 = addButton(buttonStart, .1, buttonWidth, buttonHeight, "1"); b1.isOn = true;
    buttonStart += buttonWidth + offset;
    b2 = addButton(buttonStart, .1, buttonWidth, buttonHeight, "2"); 
    buttonStart += buttonWidth + offset;
    b3 = addButton(buttonStart, .1, buttonWidth, buttonHeight, "3"); 
    buttonStart += buttonWidth + offset;
    b4 = addButton(buttonStart, .1, buttonWidth, buttonHeight, "4"); 
    buttonStart += buttonWidth + offset;
    
    bStartStop = addButton(.7, .1, .2, .8, "Start");
    
    //t1 = addTextBox(.012, .48, .76, .2, "");
    //kbContainer = addKeyboardContainer(.14, .78, .632, .2);
    //kbctrl1 = addKeyboardCtrl(0, 0, 1, 1, null);
    //kbctrl1.addLine("1234567890");
    //t1.attachKeyboard(kbctrl1, kbContainer);
    //kbContainer.setKeyboard(kbctrl1, t1); // to start off with a keyboard
    
    //b.isOn = false;
    //b.isContinous = false;
    //x.isDisabled = false;
    //x.isVisible = true;
    //t.isAutoClear = false;
    //t.isCaseSensistive = false;
    //kbctrl.isContinous = false;
  }
  
  resetData();
}

void clearButtons()
{
  b1.isOn = false;
  b2.isOn = false;
  b3.isOn = false;
  b4.isOn = false;
}

void processUI()
{
  //if (b1 != null && b1.doProcess == true) {}
 
  if (b1 != null && b1.doProcess == true) { clearButtons(); b1.isOn = true; disp = 0; per = 0; rst = true; morph = false; pic = pics[disp]; bStartStop.txt = "Start";}
  if (b2 != null && b2.doProcess == true) { clearButtons(); b2.isOn = true; disp = 1; per = 0; rst = true; morph = false; pic = pics[disp]; bStartStop.txt = "Start";}
  if (b3 != null && b3.doProcess == true) { clearButtons(); b3.isOn = true; disp = 2; per = 0; rst = true; morph = false; pic = pics[disp]; bStartStop.txt = "Start";}
  if (b4 != null && b4.doProcess == true) { clearButtons(); b4.isOn = true; disp = 3; per = 0; rst = true; morph = false; pic = pics[disp]; bStartStop.txt = "Start";}
  if (bStartStop != null && bStartStop.doProcess == true)
  {
    clearButtons();
    if (morph == false)
    {
      bStartStop.txt = "Stop";
      pics[0] = getReSampledStroke(pics[0], segments);
      pics[1] = getReSampledStroke(pics[1], segments);
      pics[2] = getReSampledStroke(pics[2], segments);
      pics[3] = getReSampledStroke(pics[3], segments);
    }
    else
    {
      bStartStop.txt = "Start";
    }
   
    //disp = 0;
    //per = 0;
    morph = !morph;
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