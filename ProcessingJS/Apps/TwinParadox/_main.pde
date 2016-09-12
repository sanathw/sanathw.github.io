// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

// mousePressed, mouseX, mouseY
// debug by println();
float speedX = 0;
float speedY = 0;
int tick = 1;
RelativityClock clockTwinA = new RelativityClock(200, 200, 0, 0, false, tick);
RelativityClock clockTwinB = new RelativityClock(200, 200, speedX, speedY, false, tick);
boolean start = false;
boolean grid = true;
boolean info = true;
float a;
float d;

//PGraphics2D g;
void setup()
{
  clockTwinA.grid = grid;
  clockTwinB.grid = grid;
  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(200, 400, P2D, FIT_INSIDE, this); // this has to be the last line in this function
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
  
  background(0);
  
  imageMode(CORNER);
  
  if (mousePressed)
  {
    speedX = mouseX / 100.0;
    speedY = (mouseY+100) / 100.0;
    clockTwinB.SetEtherSpeed(speedX, speedY);
    a = atan2(mouseY+100, mouseX);
    d = dist(0, -100, mouseX, mouseY);
  }
  
  
  if (start)
  {
    clockTwinA.Update();
    clockTwinB.Update();
  }

  image(clockTwinB.Draw(), -100, -200, 200, 200);
  image(clockTwinA.Draw(), -100, 0, 200, 200);
  
  
  if (speedX != 0 || speedY != 0)
  {
    pushMatrix();
    translate(0, -100);
    rotate(a);
    strokeWeight(1);
    stroke(255,0,0, 90);
    fill(255,0,0, 90);
    //rectMode(CORNER);
    //rect(-5,-5, (int)d, 10);
    triangle(0, 0, (int)d, -5, (int)d, 5);
    triangle((int)d, -10, (int)d, 10, (int)d+5, 0);
    popMatrix();
  }
  
  if (info)
  {
    fill(0);
    text("Twin B clock (Ship)", -100, -185);
    text("Speed: " + nf(speedX, 0, 2) + ", " + nf(speedY, 0, 2), -100, -170);
    text("Time: " + clockTwinB.Count , 50, -10);
    
    text("Twin A clock (Earth)", -100, 15);
    text("Speed: 0, 0", -100, 30);
    text("Time: " + clockTwinA.Count , 50, 190);
  }
  
}
