//Container c1;
Button bNumCard;
Button bShuffle;
Button bOrdered;
Button bRandom;
Button bFlip;

Button bDelayOn;
Button bDelay1;
Button bDelay2;
Button bDelayOff;

Button bStart;
Button bEnd;

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
    bNumCard = addButton(.012, .1, .12, .7, "Cards");
    bShuffle = addButton(.15, .1, .12, .31, "Shuffle");
    bShuffle.isOn = true;
    bOrdered = addButton(.28, .1, .12, .31, "Ordered");
    bRandom = addButton(.28, .5, .12, .31, "Random");
    bFlip = addButton(.5, .1, .12, .7, "Flip");
    
    bDelayOn = addButton(.65, .1, .05, .31, "On");
    bDelay1 = addButton(.72, .1, .05, .31, "1");
    bDelay1.isOn = true;
    bDelay2 = addButton(.79, .1, .05, .31, "2");
    bDelayOff = addButton(.85, .1, .05, .31, "Off");
    
    bStart = addButton(.65, .5, .1, .31, "Start");
    bEnd = addButton(.8, .5, .1, .31, "End");
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

void processUI()
{
  if (bNumCard != null && bNumCard.doProcess == true) 
  {
    if (isCards)
    {
      bNumCard.txt = "Numbers";
      isCards = false;
      resetDisplay();
    }
    else
    {
      bNumCard.txt = "Cards";
      isCards = true;
      resetDisplay();
    }
  }
  
  if (bShuffle != null && bShuffle.doProcess == true) 
  {
    bShuffle.isOn = true;
    bOrdered.isOn = false;
    bRandom.isOn = false;
    isShuffle = true;
    isRandom = false;
    resetDisplay();
  }
  
  if (bOrdered != null && bOrdered.doProcess == true) 
  {
    bShuffle.isOn = false;
    bOrdered.isOn = true;
    bRandom.isOn = false;
    isShuffle = false;
    isRandom = false;
    resetDisplay();
  }
  
  if (bRandom != null && bRandom.doProcess == true) 
  {
    bShuffle.isOn = false;
    bOrdered.isOn = false;
    bRandom.isOn = true;
    isShuffle = false;
    isRandom = true;
    resetDisplay();
  }
  
  if (bFlip != null && bFlip.doProcess == true) 
  {
    showCard = !showCard;
    delay = 0;
    
    if (showCard) {ocrd = 255; otxt = 0;}
    else {ocrd = 0; otxt = 255;}
  }
  
  if (bDelayOn != null && bDelayOn.doProcess == true) 
  {
    bDelayOn.isOn = true;
    bDelay1.isOn = false;
    bDelay2.isOn = false;
    bDelayOff.isOn = false;
    delayT = 0;
    //resetDisplay();
    delay = 0;
    
    if (showCard) {ocrd = 255; otxt = 0;}
    else {ocrd = 0; otxt = 255;}
    
    
  }
  
  if (bDelay1 != null && bDelay1.doProcess == true) 
  {
    bDelayOn.isOn = false;
    bDelay1.isOn = true;
    bDelay2.isOn = false;
    bDelayOff.isOn = false;
    delayT = 40;
    //resetDisplay();
    delay = 0;
    
    if (showCard) {ocrd = 255; otxt = 0;}
    else {ocrd = 0; otxt = 255;}
  }
  
  if (bDelay2 != null && bDelay2.doProcess == true) 
  {
    bDelayOn.isOn = false;
    bDelay1.isOn = false;
    bDelay2.isOn = true;
    bDelayOff.isOn = false;
    delayT = 80;
    //resetDisplay();
    delay = 0;
    
    if (showCard) {ocrd = 255; otxt = 0;}
    else {ocrd = 0; otxt = 255;}
  }
  
  if (bDelayOff != null && bDelayOff.doProcess == true) 
  {
    bDelayOn.isOn = false;
    bDelay1.isOn = false;
    bDelay2.isOn = false;
    bDelayOff.isOn = true;
    delayT = -1;
    //resetDisplay();
    delay = 0;
    
    if (showCard) {ocrd = 255; otxt = 0;}
    else {ocrd = 0; otxt = 255;}
  }
  
  if (bStart != null && bStart.doProcess == true) 
  {
    i = 0;
    if (isCards) c = (Card) cards.get(i);
    else n = (Number) numbers.get(i);
    delay = 0;
    
    if (showCard) {ocrd = 255; otxt = 0;}
    else {ocrd = 0; otxt = 255;}
  }
  
  if (bEnd != null && bEnd.doProcess == true) 
  {
    i = maxI - 1;
    if (isCards) c = (Card) cards.get(i);
    else n = (Number) numbers.get(i);
    delay = 0;
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