// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

PImage img;
DoubleMotion linkLength;
double z = 60;

void setup()
{
  //doZoom = false; doTranslate = false; doRotate = false;
  linkLength = new DoubleMotion(random(1, 60), 1, 60, 0.04, 0.1, 0.01, LINEAR);
  int w = 100;
  int h = 100;
  img = new PImage(w, h);
  setSize(w, h, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(255);
}

void draw()
{
  initDraw();
  
  // clear
  for (int i = 0; i < img.pixels.length; i++) img.pixels[i] = color(90);
  
  set(20, 20, color(255, 90));
  drawLine( 40, 40, color(255), 60, z, color(255, 0));
  
  z = linkLength.GetNext();
  
  imageMode(CENTER);
  image(img, 0, 0);
}
