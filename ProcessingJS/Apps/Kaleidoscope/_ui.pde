Button bLinearAngular;
Button bClear;
Button bToggle;
Button bDots;

Container cSteps;
Button bStep1;
Button bStep2;
Button bStep3;
Button bStep4;
Button bStep5;
Button bStep6;
Button bStep7;
Button bStep8;

Button bShowUser;
Button bShowBack;


Container cColors;
Button bColor1;
Button bColor2;
Button bColor3;
Button bColor4;
Button bColor5;
Button bColor6;
Button bColor7;
Button bColor8;

Container cSizes;
Button bSize1;
Button bSize2;
Button bSize3;
Button bSize4;
Button bSize5;
Button bSize6;
Button bSize7;
Button bSize8;

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
    
    setContainer(null);
    bLinearAngular = addButton(.01, .01, .15, .3, "Linear");
    cSteps = addContainer(0.2, 0.01, .5, 0.25);
    
    bShowUser = addButton(.75, .1, .1, .4, "User"); bShowUser.isOn = true;
    bShowBack = addButton(.75, .55, .1, .4, "Back"); bShowBack.isOn = true;
    
    bClear = addButton(.01, .55, .06, .4, "C");
    bToggle = addButton(.1, .35, .06, .25, "B");
    bDots = addButton(.1, .7, .06, .25, "D"); bDots.isOn = true;
    
    cColors = addContainer(0.2, 0.35, .5, 0.25);
    cSizes = addContainer(0.2, 0.7, .5, 0.25);
    
    float g;
    float x;
    float dx;
    
    setContainer(cSteps);
    g = 0.01; x = 0; dx = (1 - (7 * g)) / 8;
    bStep1 = addButton(x, 0, dx, 1, "1"); x =  x+ dx + g;
    bStep2 = addButton(x, 0, dx, 1, "2"); x =  x+ dx + g;
    bStep3 = addButton(x, 0, dx, 1, "3"); x =  x+ dx + g;
    bStep4 = addButton(x, 0, dx, 1, "4"); x =  x+ dx + g; bStep4.isOn = true;
    bStep5 = addButton(x, 0, dx, 1, "5"); x =  x+ dx + g;
    bStep6 = addButton(x, 0, dx, 1, "6"); x =  x+ dx + g;
    bStep7 = addButton(x, 0, dx, 1, "7"); x =  x+ dx + g;
    bStep8 = addButton(x, 0, dx, 1, "8");
    
    
    setContainer(cColors);
    g = 0.01; x = 0; dx = (1 - (7 * g)) / 8;
    bColor1 = addButton(x, 0, dx, 1, ""); x =  x+ dx + g; bColor1.isManualDraw = true; 
    bColor2 = addButton(x, 0, dx, 1, ""); x =  x+ dx + g; bColor2.isManualDraw = true;
    bColor3 = addButton(x, 0, dx, 1, ""); x =  x+ dx + g; bColor3.isManualDraw = true;
    bColor4 = addButton(x, 0, dx, 1, ""); x =  x+ dx + g; bColor4.isManualDraw = true;
    bColor5 = addButton(x, 0, dx, 1, ""); x =  x+ dx + g; bColor5.isManualDraw = true;
    bColor6 = addButton(x, 0, dx, 1, ""); x =  x+ dx + g; bColor6.isManualDraw = true;
    bColor7 = addButton(x, 0, dx, 1, ""); x =  x+ dx + g; bColor7.isManualDraw = true;
    bColor8 = addButton(x, 0, dx, 1, ""); bColor8.isManualDraw = true; bColor8.isOn = true;
    
    
    setContainer(cSizes);
    g = 0.01; x = 0; dx = (1 - (7 * g)) / 8;
    bSize1 = addButton(x, 0, dx, 1, ""); x =  x+ dx + g; bSize1.isManualDraw = true; 
    bSize2 = addButton(x, 0, dx, 1, ""); x =  x+ dx + g; bSize2.isManualDraw = true;
    bSize3 = addButton(x, 0, dx, 1, ""); x =  x+ dx + g; bSize3.isManualDraw = true;
    bSize4 = addButton(x, 0, dx, 1, ""); x =  x+ dx + g; bSize4.isManualDraw = true; bSize4.isOn = true;
    bSize5 = addButton(x, 0, dx, 1, ""); x =  x+ dx + g; bSize5.isManualDraw = true;
    bSize6 = addButton(x, 0, dx, 1, ""); x =  x+ dx + g; bSize6.isManualDraw = true;
    bSize7 = addButton(x, 0, dx, 1, ""); x =  x+ dx + g; bSize7.isManualDraw = true;
    bSize8 = addButton(x, 0, dx, 1, ""); bSize8.isManualDraw = true;
    
    // add buttons to tab
    
    //
    //b1 = addButton(.012, .1, .12, .31, "Triangle");
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

void maualDraw(var o)
{
  var g = pjsCM;
  
  if (o == bColor1)
  {
    g.fill(255, 255, 255); g.noStroke();
    if (o.isOn) {g.stroke(0); g.strokeWeight(4);}
    g.rectMode(CORNERS);
    g.rect(o.x1, o.y1, o.x2, o.y2);
  }
  
  if (o == bColor2)
  {
    g.fill(255, 0, 0); g.noStroke();
    if (o.isOn) {g.stroke(0); g.strokeWeight(4);}
    g.rectMode(CORNERS);
    g.rect(o.x1, o.y1, o.x2, o.y2);
  }
  
  if (o == bColor3)
  {
    g.fill(0, 255, 0); g.noStroke();
    if (o.isOn) {g.stroke(0); g.strokeWeight(4);}
    g.rectMode(CORNERS);
    g.rect(o.x1, o.y1, o.x2, o.y2);
  }
  
  if (o == bColor4)
  {
    g.fill(0, 0, 255); g.noStroke();
    if (o.isOn) {g.stroke(0); g.strokeWeight(4);}
    g.rectMode(CORNERS);
    g.rect(o.x1, o.y1, o.x2, o.y2);
  }
  
  if (o == bColor5)
  {
    g.fill(255, 0, 255); g.noStroke();
    if (o.isOn) {g.stroke(0); g.strokeWeight(4);}
    g.rectMode(CORNERS);
    g.rect(o.x1, o.y1, o.x2, o.y2);
  }
  
  if (o == bColor6)
  {
    g.fill(0, 255, 255); g.noStroke();
    if (o.isOn) {g.stroke(0); g.strokeWeight(4);}
    g.rectMode(CORNERS);
    g.rect(o.x1, o.y1, o.x2, o.y2);
  }
  
  if (o == bColor7)
  {
    g.fill(255, 255, 0); g.noStroke();
    if (o.isOn) {g.stroke(0); g.strokeWeight(4);}
    g.rectMode(CORNERS);
    g.rect(o.x1, o.y1, o.x2, o.y2);
  }
  
  if (o == bColor8)
  {
    g.fill(0, 0, 0); g.noStroke();
    if (o.isOn) {g.stroke(0); g.strokeWeight(4);}
    g.rectMode(CORNERS);
    g.rect(o.x1, o.y1, o.x2, o.y2);
  }
  
  
  if (o == bSize1) drawPen(1, g, o);
  if (o == bSize2) drawPen(2, g, o);
  if (o == bSize3) drawPen(3, g, o);
  if (o == bSize4) drawPen(4, g, o);
  if (o == bSize5) drawPen(5, g, o);
  if (o == bSize6) drawPen(6, g, o);
  if (o == bSize7) drawPen(7, g, o);
  if (o == bSize8) drawPen(8, g, o);
}

void drawPen(int s, var g, var o)
{
  int cx = (o.x1 + o.x2)/2;
  int cy = (o.y1 + o.y2)/2;
  g.fill(0); g.noStroke();
  g.rectMode(CENTER);
  g.rect(cx, cy, s, s);
  
  g.noFill(); g.noStroke();
  if (o.isOn) {g.stroke(0); g.strokeWeight(4);}
  g.rectMode(CORNERS);
  g.rect(o.x1, o.y1, o.x2, o.y2);
}

void restSteps()
{
  bStep1.isOn = false;
  bStep2.isOn = false;
  bStep3.isOn = false;
  bStep4.isOn = false;
  bStep5.isOn = false;
  bStep6.isOn = false;
  bStep7.isOn = false;
  bStep8.isOn = false;
}

void restColors()
{
  bColor1.isOn = false;
  bColor2.isOn = false;
  bColor3.isOn = false;
  bColor4.isOn = false;
  bColor5.isOn = false;
  bColor6.isOn = false;
  bColor7.isOn = false;
  bColor8.isOn = false;
}

void restSizes()
{
  bSize1.isOn = false;
  bSize2.isOn = false;
  bSize3.isOn = false;
  bSize4.isOn = false;
  bSize5.isOn = false;
  bSize6.isOn = false;
  bSize7.isOn = false;
  bSize8.isOn = false;
}

void processUI()
{
  if (bStep1 != null && bStep1.doProcess == true) { restSteps(); bStep1.isOn = true; step = 1;}
  if (bStep2 != null && bStep2.doProcess == true) { restSteps(); bStep2.isOn = true; step = 2;}
  if (bStep3 != null && bStep3.doProcess == true) { restSteps(); bStep3.isOn = true; step = 3;}
  if (bStep4 != null && bStep4.doProcess == true) { restSteps(); bStep4.isOn = true; step = 4;}
  if (bStep5 != null && bStep5.doProcess == true) { restSteps(); bStep5.isOn = true; step = 5;}
  if (bStep6 != null && bStep6.doProcess == true) { restSteps(); bStep6.isOn = true; step = 6;}
  if (bStep7 != null && bStep7.doProcess == true) { restSteps(); bStep7.isOn = true; step = 7;}
  if (bStep8 != null && bStep8.doProcess == true) { restSteps(); bStep8.isOn = true; step = 8;}

  if (bColor1 != null && bColor1.doProcess == true) { restColors(); bColor1.isOn = true; setColor(1);}
  if (bColor2 != null && bColor2.doProcess == true) { restColors(); bColor2.isOn = true; setColor(2);}
  if (bColor3 != null && bColor3.doProcess == true) { restColors(); bColor3.isOn = true; setColor(3);}
  if (bColor4 != null && bColor4.doProcess == true) { restColors(); bColor4.isOn = true; setColor(4);}
  if (bColor5 != null && bColor5.doProcess == true) { restColors(); bColor5.isOn = true; setColor(5);}
  if (bColor6 != null && bColor6.doProcess == true) { restColors(); bColor6.isOn = true; setColor(6);}
  if (bColor7 != null && bColor7.doProcess == true) { restColors(); bColor7.isOn = true; setColor(7);}
  if (bColor8 != null && bColor8.doProcess == true) { restColors(); bColor8.isOn = true; setColor(8);}
  
  if (bToggle != null && bToggle.doProcess == true) 
  { 
    colorBack = !colorBack;
    bToggle.isOn = colorBack;
    selectColor();
  }
  
  if (bDots != null && bDots.doProcess == true) 
  { 
    dots = !dots;
    bDots.isOn = dots;
  }
  
  if (bSize1 != null && bSize1.doProcess == true) { restSizes(); bSize1.isOn = true; setPenSize(1);}
  if (bSize2 != null && bSize2.doProcess == true) { restSizes(); bSize2.isOn = true; setPenSize(2);}
  if (bSize3 != null && bSize3.doProcess == true) { restSizes(); bSize3.isOn = true; setPenSize(3);}
  if (bSize4 != null && bSize4.doProcess == true) { restSizes(); bSize4.isOn = true; setPenSize(4);}
  if (bSize5 != null && bSize5.doProcess == true) { restSizes(); bSize5.isOn = true; setPenSize(5);}
  if (bSize6 != null && bSize6.doProcess == true) { restSizes(); bSize6.isOn = true; setPenSize(6);}
  if (bSize7 != null && bSize7.doProcess == true) { restSizes(); bSize7.isOn = true; setPenSize(7);}
  if (bSize8 != null && bSize8.doProcess == true) { restSizes(); bSize8.isOn = true; setPenSize(8);}
  
  if (bLinearAngular != null && bLinearAngular.doProcess == true) 
  { 
    if (isLinear)
    {
      isLinear = false;
      bLinearAngular.txt = "Angular";
    }
    else
    {
      isLinear = true;
      bLinearAngular.txt = "Linear";
    }
    
    clearDisplay();
  }
  
  if (bClear != null && bClear.doProcess == true) {clearDisplay();}
  
  if (bShowUser != null && bShowUser.doProcess == true) 
  {
    showUser = !showUser;
    bShowUser.isOn = showUser;
  }
  
  if (bShowBack != null && bShowBack.doProcess == true) 
  {
    showBack = !showBack;
    bShowBack.isOn = showBack;
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