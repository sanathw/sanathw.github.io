// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

// mousePressed, mouseX, mouseY
// debug by println();

const MAX_DEPTH = 32;
const STARS = 500;

class starInfo
{
  float x;
  float y;
  float z;
}

var star = [];

void setup()
{
  for (int i = 0; i < STARS; i++)
  {
    var p = new starInfo();
    p.x = random(-200, 200);
    p.y = random(-200, 200);
    p.z = random(1, MAX_DEPTH);
    star[i] = p;
  }

  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(400, 400, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(0);
}

void draw()
{
  initDraw();
  
  
  //fill(190);
  strokeWeight(0.001);
  for (int i = 0; i<STARS; i++)
  {
    star[i].z = star[i].z - 0.1;
    
    if (star[i].z <= 0)
    {
      star[i].x = random(-200, 200);
      star[i].y = random(-200, 200);
      star[i].z = MAX_DEPTH;
    }
    
    //star[i].x = star[i].x + 0.05;
    
    var p = 15 / star[i].z;
    int x = (int) (star[i].x * p);
    int y = (int) (star[i].y * p);
    
    //var size = (1 - star[i].z / 32.0) * 5;
    //var shade = parseInt((1 - stars[i].z / 32.0) * 255);
    
    //var s = (int) ((1 / star[i].z) * 15);
    var s = (int) ((1 - (star[i].z / MAX_DEPTH)) * 5);
    
    var c = (int) ((1 - (star[i].z / MAX_DEPTH)) * 255);
    fill(c);
    
    rect(x, y, s, s);
  }
}
