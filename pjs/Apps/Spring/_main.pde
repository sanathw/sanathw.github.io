// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

int demoType = 1;

WallHook hh;// = new WallHook(-150, 0, 0);
Mass mm;// = new Mass(10, 0, 0, 0);
Mass mm2;
Spring ss;// = new Spring(hh, mm, 0.25, 0.05);

World w;

PImage imgPaper;
void setup()
{
  //doZoom = false; doTranslate = false; doRotate = false;  
  imgPaper = loadImage("./_resources/paper2.jpg");
  
  demo1();
  
  setSize(400, 400, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void demo1()
{
  hh = new WallHook(-150, 0, 0, false, 60);
  mm = new Mass(1, 0, 0, 0, false);
  ss = new Spring(hh, mm, 0.25, 0.05);
  w = new World(); w.add(ss); w.add(hh); w.add(mm);
}

void demo2()
{
  mm = new Mass(1, -150, 0, 0, false);
  mm2 = new Mass(1, 0, 0, 0, true);
  ss = new Spring(mm, mm2, 0.25, 0.05);
  hh = new WallHook(150, 0, 0, true, 160);
  w = new World(); w.add(ss); w.add(mm); w.add(mm2); w.add(hh); w.floor = hh;
}


void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  //g.background(255);
  
  if (imgPaper.width > 0 && imgPaper.height > 0)
  {
    g.imageMode(CENTER);
    g.pushMatrix();
    g.translate(g.width/2, g.height/2);
    float sx = g.width / imgPaper.width;
    float sy = g.height / imgPaper.height;
    float ss = max(sx, sy);
    g.scale(ss);
    g.image(imgPaper, 0, 0);
    g.popMatrix();
  }
}


boolean massSelected = false;
void draw()
{
  initDraw();
  
  w.calculate();
  w.update();
  
  if (mousePressed && mousePressed != pmousePressed) { if (mm.isInside(mouseY)) massSelected = true; }
  if (massSelected) { mm.d = mouseY; mm.v = 0; mm.a = 0; }
  if (mousePressed == false && mousePressed != pmousePressed) { massSelected = false; }
  
  w.display();
}
