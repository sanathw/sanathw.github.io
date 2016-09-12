Button b1; Button b2; Button b3;
Button b4;
LabelBox b1;
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
    b1 = addButton(.8, .03, .1, .25, "Reset");
    b2 = addButton(.8, .338, .1, .25, "Rnd");
    b3 = addButton(.8, .675, .1, .25, "Clear");
    
    b4 = addButton(.7, .25, .08, .4, "Default");
    
    l1 = addLabelBox(.025, .1, .1, .3, "F -> ");
    t1 = addTextBox(.125, .1, .55, .3, "F[+F][-F]");
    kbContainer = addKeyboardContainer(.025, .5, .65, .3);
    kbctrl1 = addKeyboardCtrl(0, 0, 1, 1, null);
    kbctrl1.addLine("F+-[]");
    t1.attachKeyboard(kbctrl1, kbContainer);
    
    kbContainer.setKeyboard(kbctrl1, t1); // to start off with a keyboard
  }
  
  resetData();
}



void processUI()
{
  if (b1 != null && b1.doProcess == true)
  {
    //resetSeq = true;
    setSeq();
  }
  
  if (b2 != null && b2.doProcess == true)
  {
    string s = "";
    for (int i = 0; i < 10; i++)
    {
      int r = (int) random(5);
      if (r == 0) s = s + "F";
      if (r == 1) s = s + "+";
      if (r == 2) s = s + "-";
      if (r == 3) s = s + "[";
      if (r == 4) s = s + "]";
    }
    t1.txt = s;
    //t1.isDisabled = false;
    //kbContainer.isDisabled = false;
    //resetSeq = true;
    setSeq();
  }
  
  if (b3 != null && b3.doProcess == true)
  {
    t1.txt = "";
    //t1.isDisabled = false;
    //kbContainer.isDisabled = false;
    //resetSeq = true;
  }
  
  if (b4 != null && b4.doProcess == true)
  {
    t1.txt = "F[+F][-F]";
    setSeq();
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
}

void saveData()
{
  //save into data
}