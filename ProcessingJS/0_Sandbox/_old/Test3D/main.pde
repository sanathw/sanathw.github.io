// http://localhost:5050/0_Sandbox/Test3D/main.html
//.......................................................................

PMatrix3D cam = new PMatrix3D();
PMatrix3D T = new PMatrix3D();
PMatrix3D R = new PMatrix3D();


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
  else screenSize = 400;//max(screen.width, screen.height);
  
  size(screenSize, screenSize, P3D);
  sizeChanged();
  
  //T.translate(200,200,0);
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
  //camera(mouseX+width/2, mouseY+height/2, 500.0, width/2, height/2, 0, 
  //     0.0, 1.0, 0.0);
  
  //camera(width/2, height/2, 500.0, -mouseX+width/2, -mouseY+height/2, 0, 
  //    0.0, 1.0, 0.0);
  
  
  camera(width/2, height/2, 400, width/2, height/2, 0, 
       0.0, 1.0, 0.0);
  
  lights();
  
  //translate(windowTx, windowTy);
  //scale(mobileS);
  translate(width/2, height/2);
  
  translate(100, 0);
  
  //fill(255, 0, 0);
  //rectMode(CORNERS);
  //rect(0, 0, width, height);
  
  
  
  //rotateX(mouseY/100);
  //rotateY(mouseX/100);
  
  
  /*cam.reset();
  cam.apply(T);
  
  float[] f = new float[16]; f = cam.array();
  applyMatrix(
       f[0], f[1], f[2], f[3],
       f[4], f[5], f[6], f[7],
       f[8], f[9], f[10], f[11],
       f[12], f[13], f[14], f[15]);*/
  
  //translate(width/2, height/2);
  
  fill(255);
  box(50);
  //rectMode(CENTER);
  //rect(0, 0, 100, 100);
}

