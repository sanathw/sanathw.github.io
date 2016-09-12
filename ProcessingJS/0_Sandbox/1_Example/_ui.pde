Button b1;
TextBox t1; TextBox t2;
LabelBox l1;
KeyboardContainer kbContainer;
KeyboardCtrl kbctrl1; KeyboardCtrl kbctrl2;

Button d1; Button d2;
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
    b1 = addButton(.1, .1, .15, .41, "Hello");
    t1 = addTextBox(.3, .1, .15, .411, "Hello");
    t2 = addTextBox(.5, .1, .15, .411, "Hello"); t2.isCaseSensistive = true;
    
    l1 = addLabelBox(.01, .1, .15, .411, "Hello");
    
    d1 = addButton(.7, .1, .1, .41, "d1");
    d2 = addButton(.81, .1, .1, .41, "d2");
    
    
    kbContainer = addKeyboardContainer(.1, .6, .8, .3);
    
    kbctrl1 = addKeyboardCtrl(0, 0, 1, 1, null);
    kbctrl1.addLine("ABCD");
    kbctrl1.addLine("1234");
    t1.attachKeyboard(kbctrl1, kbContainer);

    kbctrl2 = addKeyboardCtrl(0, 0, 1, 1, null);
    kbctrl2.addLine("ZXY");
    kbctrl2.addLine("@$%#");
    t2.attachKeyboard(kbctrl2, kbContainer);
    
    kbContainer.setKeyboard(kbctrl2, t2); // to start off with a keyboard
  }
  
  resetData();
}



void processUI()
{
  if (b1 != null && b1.doProcess == true) t2.clear(); //l1.txt = "Hi";
  
  if (d1 != null && d1.doProcess == true) loadDataFile("./_resources/data1.txt");
  if (d2 != null && d2.doProcess == true) loadDataFile("./_resources/data2.txt");
}



void drawHUD(var g)
{   
  g.beginText(.5, 0, color(0), CENTER, CENTER);
  g.translate(0, g.getCharSize() / 2); // starting posintion on screen
  g.text("Title", 0,0);
  g.endText();
  
  
  g.beginText(0, 0, color(255), LEFT, TOP);
  g.translate(g.getCharSize() / 2, g.getCharSize() / 2); // starting posintion on screen
  g.scale(0.7);
  g.text("MouseX = " + mouseX.toFixed(2), 0,0);
  g.translate(0, g.getCharSize());
  g.text("MouseY = " + mouseY.toFixed(2), 0,0);
  g.endText();
}

void resetData()
{
  //use data
  //alert(data);
  var l = data.split('\n');
  l1.txt = l[0];
}

void saveData()
{
  //save into data
}