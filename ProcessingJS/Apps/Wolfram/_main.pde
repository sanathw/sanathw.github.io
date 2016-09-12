// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

//http://en.wikipedia.org/wiki/Cellular_automaton

int fabricW = 300; int fabricH = 300;
boolean start = false;
int y;

var a; var b; PImage o; 
void setup()
{
  o = new PImage(fabricW, fabricH);
  a = new Array(fabricW);  
  b = new Array(fabricW);
  resetFabric();
      
  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(fabricW, fabricH, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g) { g.background(255); }

void resetFabric()
{
  for (int i = 0; i < o.pixels.length; i++) o.pixels[i] = color(255);
  for (int x = 0; x < a.length; x++) { a[x] = 0; b[x] = 0; }
  
  int x = fabricW / 2;
  a[x] = 1; 
  y = 0;
  setFabric();
}

void setFabric()
{
  for (int x = 0; x < a.length; x++)
  {
    int c;
    if (a[x] == 1) c = 0; else c = 255;
    o.pixels[(o.width * y) + x] = color(c);
  }
}

void updateFabric()
{
  if (y < fabricH)
  {
    for (int x = 1; x < a.length-1; x++)
    {
      b[x] = evaluateRule(a[x-1], a[x], a[x+1]);
    }
    for (int x = 0; x < a.length; x++) a[x] = b[x];
    y++;
    setFabric();
  }
}

int[] rule = {0,1,0,1,1,0,1,0}; //simple
//int[] rule = {0,0,0,1,1,1,1,0}; //rule 30

int evaluateRule(int l, int m, int r)
{
  if (l == 1 && m == 1 && r == 1) return rule[0];
  if (l == 1 && m == 1 && r == 0) return rule[1];
  if (l == 1 && m == 0 && r == 1) return rule[2];
  if (l == 1 && m == 0 && r == 0) return rule[3];
  if (l == 0 && m == 1 && r == 1) return rule[4];
  if (l == 0 && m == 1 && r == 0) return rule[5];
  if (l == 0 && m == 0 && r == 1) return rule[6];
  if (l == 0 && m == 0 && r == 0) return rule[7];
  return 0;
}

void draw()
{
  initDraw(); imageMode(CENTER);
  
  if (start || (mousePressed && mousePressed != pmousePressed))
  {
    updateFabric();
  }
  
  image(o, 0, 0);
}
