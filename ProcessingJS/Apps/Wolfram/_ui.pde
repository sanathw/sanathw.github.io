Container c1;
Button b7; Button b6; Button b5; Button b4; Button b3; Button b2; Button b1; Button b0;

Container c2;
Button bBasic; Button b30; Button b110; Button bClr; 

Container c3;
Button bReset; Button bStartStop;
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
    c1 = addContainer(0.03, 0.1, .85, .4); //c1.hasBorder = false;
    c2 = addContainer(0.01, 0.6, .6, .35); c2.hasBorder = false;
    c3 = addContainer(0.65, 0.6, .25, .35); c3.hasBorder = false;
    // add buttons to tab
    
    setContainer(c1);
    float g = 0.025;
    float b = (1-(7 * g))/8;
    float x = 0;
    b7 = addButton(x, 0, b, 1, "111"); x += (g+b); 
    b6 = addButton(x, 0, b, 1, "110"); x += (g+b); b6.isOn = true;
    b5 = addButton(x, 0, b, 1, "101"); x += (g+b);
    b4 = addButton(x, 0, b, 1, "100"); x += (g+b); b4.isOn = true;
    b3 = addButton(x, 0, b, 1, "011"); x += (g+b); b3.isOn = true;
    b2 = addButton(x, 0, b, 1, "010"); x += (g+b);
    b1 = addButton(x, 0, b, 1, "001"); x += (g+b); b1.isOn = true;
    b0 = addButton(x, 0, b, 1, "000"); x += (g+b);
    
    setContainer(c2);
    float g = 0.025;
    float b = (1-(3 * g))/4;
    float x = 0;
    bBasic = addButton(x, 0, b, 1, "Basic"); x += (g+b); bBasic.isOn = true;
    b30 = addButton(x, 0, b, 1, "Rule30"); x += (g+b);
    b110 = addButton(x, 0, b, 1, "Rule110"); x += (g+b); 
    bClr = addButton(x, 0, b, 1, "Clear"); x += (g+b);    

    setContainer(c3);
    float g = 0.05;
    float b = (1-(1 * g))/2;
    float x = 0;
    bReset = addButton(x, 0, b, 1, "Reset"); x += (g+b); 
    bStartStop = addButton(x, 0, b, 1, "Start"); x += (g+b);
    
    //t1 = addTextBox(.012, .48, .76, .2, "");
    //kbContainer = addKeyboardContainer(.14, .78, .632, .2);
    //kbctrl1 = addKeyboardCtrl(0, 0, 1, 1, null);
    //kbctrl1.addLine("1234567890");
    //t1.attachKeyboard(kbctrl1, kbContainer);
    //kbContainer.setKeyboard(kbctrl1, t1); // to start off with a keyboard
    
    //c.hasBorder = true;
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

void updateRule()
{
  bBasic.isOn = false;
  b30.isOn = false;
  b110.isOn = false;
  
  b7.isOn = (rule[0] == 1);
  b6.isOn = (rule[1] == 1);
  b5.isOn = (rule[2] == 1);
  b4.isOn = (rule[3] == 1);
  b3.isOn = (rule[4] == 1);
  b2.isOn = (rule[5] == 1);
  b1.isOn = (rule[6] == 1);
  b0.isOn = (rule[7] == 1);
}

void processUI()
{
  if (b7 != null && b7.doProcess == true) { rule[0] = abs(rule[0]-1); updateRule(); }
  if (b6 != null && b6.doProcess == true) { rule[1] = abs(rule[1]-1); updateRule(); }
  if (b5 != null && b5.doProcess == true) { rule[2] = abs(rule[2]-1); updateRule(); }
  if (b4 != null && b4.doProcess == true) { rule[3] = abs(rule[3]-1); updateRule(); }
  if (b3 != null && b3.doProcess == true) { rule[4] = abs(rule[4]-1); updateRule(); }
  if (b2 != null && b2.doProcess == true) { rule[5] = abs(rule[5]-1); updateRule(); }
  if (b1 != null && b1.doProcess == true) { rule[6] = abs(rule[6]-1); updateRule(); }
  if (b0 != null && b0.doProcess == true) { rule[7] = abs(rule[7]-1); updateRule(); }
  
  if (bBasic != null && bBasic.doProcess == true) { doStart(false); rule = {0,1,0,1,1,0,1,0}; updateRule(); bBasic.isOn = true; }
  if (b30 != null && b30.doProcess == true) { doStart(false); rule = {0,0,0,1,1,1,1,0}; updateRule(); b30.isOn = true; }
  if (b110 != null && b110.doProcess == true) { doStart(false); rule = {0,1,1,0,1,1,1,0}; updateRule(); b110.isOn = true; }
  if (bClr != null && bClr.doProcess == true) { doStart(false); rule = {0,0,0,0,0,0,0,0}; updateRule(); }
  
  if (bReset != null && bReset.doProcess == true) { start = false; resetFabric(); updateRule(); }
  if (bStartStop != null && bStartStop.doProcess == true) { doStart(!start); }
}


void doStart(boolean s)
{
  start = s;
  if (start)
  {
    c1.isDisabled = true;
    c2.isDisabled = true;
    bReset.isDisabled = true;
    bStartStop.txt = "Stop";
  }
  else
  {
    c1.isDisabled = false;
    c2.isDisabled = false;
    bReset.isDisabled = false;
    bStartStop.txt = "Start";
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