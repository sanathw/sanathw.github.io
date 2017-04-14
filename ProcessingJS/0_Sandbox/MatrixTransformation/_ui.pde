Button bReset;
Button bTransform;
Button bXY;
Button bMinus;
Button bPlus;


void setupUI()
{
  with (pjsCM)
  {
    setupCM(SHOW_AS_HORIZONTAL, SHOW_AT_BOTTOM, 3, START_OPENED);
    
    bReset = addButton(.01, .1, .15, .8, "Reset");
    bTransform = addButton(.18, .1, .2, .8, "Translate");
    bXY = addButton(.4, .1, .1, .8, "x");
    bMinus = addButton(.55, .1, .15, .8, "-");
    bPlus = addButton(.7, .1, .15, .8, "+");
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
  if (bReset != null && bReset.doProcess == true) 
  {
    Mb.reset();
  }
  
  if (bTransform != null && bTransform.doProcess == true) 
  {
    transformType = transformType+1;
    if (transformType >= 4) transformType = 0;
    
    if (transformType == 0) {bTransform.txt = "Translate"; bXY.isDisabled = false;}
    if (transformType == 1) {bTransform.txt = "Rotate"; bXY.isDisabled = true;}
    if (transformType == 2) {bTransform.txt = "Scale"; bXY.isDisabled = true;}
    if (transformType == 3) {bTransform.txt = "Manual Set XY"; bXY.isDisabled = false;}
  }
  
  if (bXY != null && bXY.doProcess == true) 
  {
    isX = !isX;
    if (isX) bXY.txt = "x";
    else bXY.txt = "y";
  }
  
  if (bMinus != null && bMinus.doProcess == true) 
  {
    if (transformType == 0)
    {
      if (isX) Mb = Mb.multiply(MT_Left);
      else Mb = Mb.multiply(MT_Down);
    }
    if (transformType == 1)
    {
      Mb = Mb.multiply(MR_AntiClockwise);
    }
    if (transformType == 2)
    {
      Mb = Mb.multiply(MS_Smaller);
    }
    if (transformType == 3)
    {
      if (isX) Mb.addDirectXY(-d, 0);
      else Mb.addDirectXY(0, d);
    }
  }
  
  if (bPlus != null && bPlus.doProcess == true) 
  {
    if (transformType == 0)
    {
      if (isX) Mb = Mb.multiply(MT_Right);
      else Mb = Mb.multiply(MT_Up);
    }
    if (transformType == 1)
    {
      Mb = Mb.multiply(MR_Clockwise);
    }
    if (transformType == 2)
    {
      Mb = Mb.multiply(MS_Bigger);
    }
    if (transformType == 3)
    {
      if (isX) Mb.addDirectXY(d, 0);
      else Mb.addDirectXY(0, -d);
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