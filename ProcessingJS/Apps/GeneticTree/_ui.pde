Button b1; Button b2;
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
    
    b1 = addButton(.02, .1, .15, .41, "Random");
    b2 = addButton(.75, .1, .15, .41, "Clear");
    t1 = addTextBox(.2, .1, .515, .41, "");
     
    kbContainer = addKeyboardContainer(.02, .6, .88, .3);
    kbctrl1 = addKeyboardCtrl(0, 0, 1, 1, null);
    kbctrl1.addLine("0123456789");
    t1.attachKeyboard(kbctrl1, kbContainer);
    kbContainer.setKeyboard(kbctrl1, t1); // to start off with a keyboard
    
    createRndDna();
  }
  
  resetData();
}



void processUI()
{
  if (b1 != null && b1.doProcess == true)
  {
    createRndDna();
  }
  
  if (b2 != null && b2.doProcess == true)
  {
    t1.clear();
  }
  
  if (t1 != null && t1.doProcess == true)
  {
    resetDNA = true;
  }
}



void drawHUD(var g)
{   
  /*g.beginText(.5, 0, color(0), CENTER, CENTER);
  g.translate(0, g.getCharSize() / 2); // starting posintion on screen
  g.text("Title", 0,0);
  g.endText();
  
  
  g.beginText(0, 0, color(255), LEFT, TOP);
  g.translate(g.getCharSize() / 2, g.getCharSize() / 2); // starting posintion on screen
  g.scale(0.7);
  g.text("MouseX = " + mouseX.toFixed(2), 0,0);
  g.translate(0, g.getCharSize());
  g.text("MouseY = " + mouseY.toFixed(2), 0,0);
  g.endText();*/
}

void resetData()
{
  //use data
  //alert(data);
  //var l = data.split('\n');
  //l1.txt = l[0];
}

void saveData()
{
  //save into data
}