

int fabricW = 50; int fabricH = 50;
var controller = new GameOfLifeController();

boolean start = false;
boolean isWall = false;

var a; var b; PImage o; 
void setup()
{
  o = new PImage(fabricW, fabricH);
  a = new Array(o.pixels.length);  
  b = new Array(o.pixels.length);
  createFabric();
  controller.initialiseFabric();
  
  setSize(fabricW, fabricH, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

boolean bk = false;
void drawBackground(var g) 
{ 
  //if (bk) 
  g.gradientBackground3(HORIZONTAL, color(90,90,190), color(0,0,190), 0.5, color(90, 190, 190));
  //else g.background(255); 
}

int getIndex(int x, int y) { return (o.width*y)+x; }
boolean isValid(int x, int y) { return ( x >= 0 && x < fabricW && y >=0 && y < fabricH); }
var getFrabricElement(int x, int y) { if (isValid(x, y)) return a[getIndex(x, y)]; else return null; }

void clearFabric()
{
  createFabric();
}

void addRandom()
{
  for (int i = 0; i < 30; i++)
  {
    int x = (int) random(fabricW-1);
    int y = (int) random(fabricH-1);
    controller.setFabricElement(x, y, isWall);
  }
}

void addCenter()
{
  controller.setFabricElement(fabricW/2, fabricH/2, isWall);
}


void doSplit()
{
  int y = 5;
  for (int i = 0; i < fabricW; i++) controller.setFabricElement(i, y, isWall);
  
  y = fabricH /2 - 5;
  int x = fabricW / 2 -10;
  for (int i = 0; i < x; i++) controller.setFabricElement(i, y, isWall);
  
  int x1 = fabricW / 2 -5;
  int x2 = fabricW / 2 +5;
  for (int i = x1; i < x2; i++) controller.setFabricElement(i, y, isWall);
  
  x = fabricW / 2 +10;
  for (int i = x; i < fabricW; i++) controller.setFabricElement(i, y, isWall);
}

void createFabric()
{
  for (int y = 0; y < fabricH; y++)
  {
    for (int x = 0; x < fabricW; x++)
    {
      int i = getIndex(x, y);
      a[i] = controller.createElement(); a[i].x = x; a[i].y = y;
      b[i] = controller.createElement(); b[i].x = x; b[i].y = y;
    }
  }
}

void updateFabric()
{
  for (int y = 0; y < fabricH; y++)
  {
    for (int x = 0; x < fabricW; x++)
    {
      getFrabricElement(x, y).compute(b[getIndex(x, y)]);
    }
  }
  
  for (int i = 0; i < o.pixels.length; i++) b[i].copyDataTo(a[i]);
}

void displayFabric()
{
  for (int y = 0; y < fabricH; y++)
  {
    for (int x = 0; x < fabricW; x++)
    {
      getFrabricElement(x, y).display(o);
    }
  }
}

void draw()
{
  initDraw(); imageMode(CENTER);
  
  if (mousePressed)
  {
    int x = (int) (mouseX + .5 + h_sw);
    int y = (int) (mouseY + .5 + h_sh);
    controller.setFabricElement(x, y, isWall);
  }
  
  if (start)
  {
    updateFabric();
    controller.modifyFabric();
  }
  displayFabric();
  
  image(o, 0, 0);
}
