// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

// mousePressed, mouseX, mouseY
// debug by println();

int massX = 0;
int massY = 0;
var p = new Array();

//PGraphics2D g;
void setup()
{
  for (int i = 0; i<100; i++)
  {
    p[i] = 110;
  }
  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(100, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(255);
}

//void createG()
//{
//  int s = max(sw, sh);
//  g = createGraphics(s, s, P2D);
//  g.strokeWeight(1);
//  g.noFill();
//  int ss = (s / 2) + (s/6);
//  g.translate(s/2, ss);
//}

void draw()
{
  initDraw();
  
  ellipseMode(CENTER);
  
  stroke(0); strokeWeight(1); fill(255 ,255 ,0);
  ellipse(0, -100, 5, 5);
  
  if (mousePressed)
  {
    massX = (int) (mouseX);
    massY = (int) (mouseY);
  }
  
  stroke(0); strokeWeight(1); fill(190);
  ellipse(massX, massY, 20, 20);
  
  for (int i= 0; i<100; i++)
  {
    float r1 = dist(i-50, 120, massX, 120);//massY);
    r1 = r1/20;
    r1 = r1 * r1;
    r1 = 50/(1 + r1);
    
    float r2 = dist(0, -100, massX, massY);
    r2 = r2/20;
    r2 = r2 * r2;
    r2 = 1 / (1 + r2);
    
    p[i] = 120 - (int) (r1 * r2);
  }
  
  stroke(0, 90); strokeWeight(1);
  line(-50, 120, 50, 120);
  int lastX = -50;
  int lastY = p[0];
  for (int i= 1; i<100; i++)
  {
    int x = i-50;
    int y = p[i];
    line(lastX, lastY, x, y);
    lastX = x;
    lastY = y;
  }
  
  //if (g == null) {createG();}
  //if (g != null)
  //{
  //  imageMode(CENTER);
  //  image(g, 0, 0);
  //}
}
