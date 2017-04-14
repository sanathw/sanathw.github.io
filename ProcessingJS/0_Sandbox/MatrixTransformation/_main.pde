// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

Matrix2D M;
Matrix2D Ma = new Matrix2D();
Matrix2D Mb = new Matrix2D();

var d = 2.5;
Matrix2D_Translation MT_Left = new Matrix2D_Translation(-d, 0);
Matrix2D_Translation MT_Right = new Matrix2D_Translation(d, 0);
Matrix2D_Translation MT_Up = new Matrix2D_Translation(0, -d);
Matrix2D_Translation MT_Down = new Matrix2D_Translation(0, d);

var a = 0.04;
Matrix2D_Rotation MR_Clockwise = new Matrix2D_Rotation(a);
Matrix2D_Rotation MR_AntiClockwise = new Matrix2D_Rotation(-a);

var s = 1.1;
Matrix2D_Scale MS_Bigger = new Matrix2D_Scale(s, s);
Matrix2D_Scale MS_Smaller = new Matrix2D_Scale(1/s, 1/s);

boolean isX = true;
int transformType = 0;

void setup()
{
  setSize(300, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  g.gradientBackground2(VERTICAL, color(255), color(255,255,100));//, 0.5, color(255, 0, 0));
  //g.background(255);
}

void draw()
{
  initDraw();
  
  M = Ma;
  drawGrid(color(0,255,0,60), 10);
  
 // Mb = Mb.multiply(MS_Smaller);
  //Mb.scale(1.01, 1.01);
  M = Mb;
  drawGrid(color(255,0,0,100), 10);
}

void drawGrid(color c, int step)
{
  stroke(c); strokeWeight(1);
  
  // outside box
  lineM(-150, -150, 150, -150); lineM(-150, 150, 150, 150);
  lineM(-150, -150, -150, 150); lineM(150, -150, 150, 150);
  
  // verticle lines
  for (int x=0; x<150; x+=step) { lineM(x, -150, x, 150); lineM(-x, -150, -x, 150); }
  
  // horizontal lines
  for (int y=0; y<150; y+=step) { lineM(-150, y, 150, y); lineM(-150, -y, 150, -y); }
  
  // center lines
  lineM(0, -150, 0, 150); lineM(-150, 0, 150, 0);
}

void lineM(int x1, int y1, int x2, int y2)
{
   var xy1 = M.applyToPoint(x1, y1); var xy2 = M.applyToPoint(x2, y2);
   line(xy1[0], xy1[1], xy2[0], xy2[1]);
}



