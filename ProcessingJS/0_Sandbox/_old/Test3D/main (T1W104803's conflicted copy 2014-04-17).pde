// http://localhost:5050/0_Sandbox/Test3D/main.html
//.......................................................................


float mobileS = 1;
float windowTx = 0;
float windowTy = 0;
int screenSize = 0;

void setup()
{
  if (isMobile == true) 
  {
    //screenSize = 1274;//max(document.body.clientWidth*1, document.body.clientHeight*1);// max(screen.width*2, screen.height*2);//
    screenSize = (screen.height * document.body.clientWidth) / screen.width;
  }
  else screenSize = max(screen.width, screen.height);
  
  size(screenSize, screenSize, P3D);
  sizeChanged();
}

void sizeChanged() 
{
  if (isMobile == true)
  {
    float s = max(document.body.clientWidth, document.body.clientHeight);
    mobileS = s / screenSize;
    windowTx = -(screenSize * mobileS - document.body.clientWidth) / 2;
    windowTy = -(screenSize * mobileS - document.body.clientHeight) / 2;
  }
  else
  {
    windowTx = -(screenSize - document.body.clientWidth) / 2;
    windowTy = -(screenSize - document.body.clientHeight) / 2;
    //alert (screenSize);noLoop();
  }
  //size(document.body.clientWidth, document.body.clientHeight, P2D);
  //alert("" + screen.width + ", " + screen.height + " (" + document.body.clientWidth + ", " + document.body.clientHeight + ")" );
  //alert("" + screen.availWidth + ", " + screen.availHeight + " (" + window.outerWidth + ", " + window.outerHeight + ")" );
  //alert("" + deviceWidth );
}

void draw()
{
  background(240);
  lights();
  
  translate(windowTx, windowTy);
  scale(mobileS);
  translate(width/2, height/2);
  
  //fill(255, 0, 0);
  //rectMode(CORNERS);
  //rect(0, 0, width, height);
  
  
  
  //rotateX(mouseY/100);
  //rotateY(mouseX/100);
  
  fill(255);
  box(100);
  //rectMode(CENTER);
  //rect(0, 0, 100, 100);
}

