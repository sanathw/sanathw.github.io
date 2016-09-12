// http://localhost:5050/0_Sandbox/TestOverlay4/main.html
//.......................................................................
var cvs;
var ctx;
var pjs;

void setup()
{
  sizeChanged() ;
  cvs = document.getElementById("mySketch");
  ctx = externals.context;
  pjs = Processing.getInstanceById("mySketch"); 
}

void sizeChanged() 
{
  size(document.body.clientWidth, document.body.clientHeight, P2D);
}

void doBackspace()
{
}

void mousePressed()
{
  pjs.mousePressed = true;
  pjs.mouseButton = mouseButton;
}

void mouseReleased()
{
  pjs.mousePressed = false;
}

void draw()
{
  //background(255, 250, 250);
  
  float s = max( (width/pjs.width), (height/pjs.height) );
  float nWidth = pjs.width*s;
  float nHeight = pjs.height*s;
  pjs.setScale(1/s);
  
  
  ctx.drawImage(cvs, (width-nWidth)/2, (height-nHeight)/2, nWidth, nHeight);
  
  
  if (mousePressed == true) line(0, 0, mouseX, mouseY);
  
  pjs.mouseX = mouseX;
  pjs.mouseY = mouseY;
  
}

