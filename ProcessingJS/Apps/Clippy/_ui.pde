//Container c1;
Button b1;
Button b2;
Button b3;
Button b4;

Button b5;
Button b6;
Button b7;

Button bAgent;


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
    
    b1 = addButton(.01, .01, .2, .4, "Hide");
    b2 = addButton(.22, .01, .2, .4, "Thinking");
    b3 = addButton(.43, .01, .2, .4, "GestureLeft");
    b4 = addButton(.64, .01, .2, .4, "Congratulate");
    
    b5 = addButton(.01, .5, .2, .4, "FINISH");
    b6 = addButton(.22, .5, .2, .4, "BRANCH"); b6.isOn = true;
    b7 = addButton(.43, .5, .2, .4, "RANDOM");
    
    bAgent = addButton(.64, .5, .2, .4, "Rover");
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
  if (b1 != null && b1.doProcess == true) {action = "Hide"; step =0; t = 0; animate = true;}
  if (b2 != null && b2.doProcess == true) {action = "Thinking"; step =0; t = 0; animate = true;}
  if (b3 != null && b3.doProcess == true) {action = "GestureLeft"; step =0; t = 0; animate = true;}
  if (b4 != null && b4.doProcess == true) {action = "Congratulate"; step =0; t = 0; animate = true;}
  
  if (b5 != null && b5.doProcess == true) {doBranching = true; b6.isOn = doBranching; finishNow = true;}
  if (b6 != null && b6.doProcess == true) {doBranching = !doBranching; b6.isOn = doBranching;}
  if (b7 != null && b7.doProcess == true) 
  {
    var actions = [];
    for (var i in O[agent].animations)
    {
      actions.push(i);
    }
    int r = (int) random(actions.length);
    action = actions[r];
    
    step =0; t = 0; animate = true;
  }
  
  if (bAgent != null && bAgent.doProcess == true) 
  {
    agentId++;
    if (agentId >= agents.length) agentId = 0;
    
    agent = agents[agentId];
    bAgent.txt = agent;
    img = null;
    img = loadImage("./_resources/" + agent + "-map.png");
    g = null;
    action = "Hide"; step =0; t = 0; animate = false;
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