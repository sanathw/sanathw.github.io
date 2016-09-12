// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................
// http://mathworld.wolfram.com/BarnsleysFern.html

class Attractor
{
  PMatrix2D M;
  PVector T;
}

ArrayList attractors = new ArrayList();
PVector p =  new PVector(0, 0);
float ss = 40;


PGraphics2D g;
void setup()
{
  setupAttractors();
  setSize(400, 400, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  g.gradientBackground3(VERTICAL, color(100,100,255), color(0,255,0), 0.8, color(255, 255, 255));
  //g.background(255, 210, 150);
}

void createG()
{
  int s = max(sw, sh); g = createGraphics(s, s, P2D); g.translate(s/2, (s/2)+(s/4));
  g.scale(1,-1);
  g.ellipseMode(CENTER);
}

void setupAttractors()
{
  Attractor a;
  
  a = new Attractor();
  a.M = new PMatrix2D(0.85, 0.04, 0, -0.04, 0.85, 0);
  a.T = new PVector(0.00, 1.60, 0);
  attractors.add(a);
  
  a = new Attractor();
  a.M = new PMatrix2D(-0.15, 0.28, 0, 0.26, 0.24, 0);
  a.T = new PVector(0.00, 0.44, 0);
  attractors.add(a);
  
  a = new Attractor();
  a.M = new PMatrix2D(0.20, -0.26, 0, 0.23, 0.22, 0);
  a.T = new PVector(0.00, 1.60, 0);
  attractors.add(a);
  
  a = new Attractor();
  a.M = new PMatrix2D(0.00, 0.00, 0, 0.00, 0.16, 0);
  a.T = new PVector(0, 0, 0);
  attractors.add(a);
  
  //a.M.print();
  //println(a.T);
}

void reset()
{
  g.background(0,0);
  //g.stroke(0, 20);
  g.noStroke();
  g.fill(0, 100, 0, 100);
}

void drawFractal()
{
  int i = (int) random(attractors.size());
  Attractor a = (PVector) attractors.get(i);
  
  PVector dest = new PVector();
  a.M.mult(p, dest);
  dest.add(a.T);
  p = dest;
  
  g.ellipse(p.x*ss, p.y*ss, 3, 3);
}

boolean start = false;
void draw()
{
  initDraw();
  
  if (g == null) {createG(); reset();}
  
  if (g != null)
  {
    if (start) drawFractal();
    
    imageMode(CENTER);
    image(g, 0, 0);
  }
}
