//Container c1;
Button b1;
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
    b1 = addButton(.3, .2, .4, .4, "Spin");
    //t1 = addTextBox(.012, .48, .76, .2, "");
    //kbContainer = addKeyboardContainer(.14, .78, .632, .2);
    //kbctrl1 = addKeyboardCtrl(0, 0, 1, 1, null);
    //kbctrl1.addLine("1234567890");
    //t1.attachKeyboard(kbctrl1, kbContainer);
    //kbContainer.setKeyboard(kbctrl1, t1); // to start off with a keyboard
    
    //b.isOn = true;
    //x.isDisabled = true;
    //x.isVisible = false;
  }
  
  resetData();
}

void processUI()
{
  if (b1 != null && b1.doProcess == true) {doSpin = !doSpin; b1.isOn = doSpin;}
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