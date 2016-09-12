Button b1; Button b2;

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
    
    b1 = addButton(.2, .2, .2, .5, "Reset");
    b2 = addButton(.5, .2, .2, .5, "Start");
    
  }
  
  resetData();
}

void processUI()
{
  if (b1 != null && b1.doProcess == true) 
  {
    start = false;
    b2.txt = "Start";
    reset();
  }
  
  if (b2 != null && b2.doProcess == true)
  {
    if (start)
    {
      start = false;
      b2.txt = "Start";
    }
    else
    {
      start = true;
      b2.txt = "Stop";
    }
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