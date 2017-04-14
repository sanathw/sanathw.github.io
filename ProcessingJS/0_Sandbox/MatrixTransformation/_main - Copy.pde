// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

// mousePressed, mouseX, mouseY
// debug by println();

// setting matrix elements
//   Mb.set(1, 0, 13, 0, 1, 27);
//   Mb.elements[2] = 13;
// getting matrix elements
//   float[] v = Mb.array(); println(v[2]);
//   println(Mb.elements[2]);

PMatrix2D M;
PMatrix2D Ma = new PMatrix2D();
PMatrix2D Mb = new PMatrix2D();

// for add
PMatrix2D MT_Left_Add = new PMatrix2D();
PMatrix2D MT_Right_Add = new PMatrix2D();
PMatrix2D MT_Up_Add = new PMatrix2D();
PMatrix2D MT_Down_Add = new PMatrix2D();
PMatrix2D MR_Clockwise_Add = new PMatrix2D();
PMatrix2D MR_AntiClockwise_Add = new PMatrix2D();

// for multiply
PMatrix2D MT_Left_Mult = new PMatrix2D();
PMatrix2D MT_Right_Mult = new PMatrix2D();
PMatrix2D MT_Up_Mult = new PMatrix2D();
PMatrix2D MT_Down_Mult = new PMatrix2D();
PMatrix2D MR_Clockwise_Mult = new PMatrix2D();
PMatrix2D MR_AntiClockwise_Mult = new PMatrix2D();

var d = 1;
var a = 0.04;

void setup()
{
   MT_Left_Add.set(         0,              0, -d,        0,       0,  0);
   MT_Right_Add.set(        0,              0,  d,        0,       0,  0);
   MT_Up_Add.set(           0,              0,  0,        0,       0, -d);
   MT_Down_Add.set(         0,              0,  0,        0,       0,  d);
   MR_Clockwise_Add.set(    cos(a),   -sin(a),  0,   sin(a),  cos(a),  0); // roates properly, but must use Multiply
   //MR_Clockwise_Add.set(    0,   -sin(a),  0,   sin(a),  0,  0); // roates, but it GROWS as well if Add
   //MR_Clockwise_Add.set( -0.03999,-sin(a),  0,       sin(a), -0.03999, 0); // roates, but it GROWS as well if Add
   //MR_AntiClockwise_Add.set(cos(-a), -sin(-a),  0,  sin(-a), cos(-a),  0);
   
   
   MT_Left_Mult.set(1,0,-10,        0,1,0);
   
   
  //doZoom = false; doTranslate = false; doRotate = false;
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
  
  Ma.reset();
  M = Ma;
  
  drawGrid(color(0,255,0,60), 10);
  
  //Mb = addM(Mb, MT_Right_Add);
  //Mb = addM(Mb, MT_Left_Add);
  //Mb = addM(Mb, MT_Up_Add);
  //Mb = addM(Mb, MT_Down_Add);
  //Mb = addM(Mb, MR_Clockwise_Add);
  //Mb = multiplyM(Mb, MR_Clockwise_Add);
  Mb = multiplyM(Mb, MT_Left_Mult);
  M = Mb;//multiplyM(Mb, Mb);
  
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

PMatrix2D addM(PMatrix2D M1, PMatrix2D M2)
{
  PMatrix2D M3 = new PMatrix2D();
  var m1 = M1.elements;
  var m2 = M2.elements;
  M3.set
  (
    (m1[0]+m2[0]), (m1[1] + m2[1]), (m1[2] + m2[2]),
    (m1[3]+m2[3]), (m1[4] + m2[4]), (m1[5] + m2[5])
  );
  //println(M3.elements[2]);
  return M3;
}

PMatrix2D multiplyM(PMatrix2D M1, PMatrix2D M2)
{
  PMatrix2D M3 = new PMatrix2D();
  var m1 = M1.elements;
  var m2 = M2.elements;
  M3.set
  (
    (m1[0]*m2[0] + m1[1]*m2[3]), (m1[0]*m2[1] + m1[1]*m2[4]), (m1[0]*m2[2] + m1[1]*m2[5]),
    (m1[3]*m2[0] + m1[4]*m2[3]), (m1[3]*m2[1] + m1[4]*m2[4]), (m1[3]*m2[2] + m1[4]*m2[5])
  );
  //println(M3.elements[2]);
  return M3;
}

void lineM(int x1, int y1, int x2, int y2)
{
   var xy1 = applyM(x1, y1); var xy2 = applyM(x2, y2);
   line(xy1[0], xy1[1], xy2[0], xy2[1]);
}

int[] applyM(int x, int y)
{
  int[] result = new int[2];
  float[] xyA = new float[2];  
  float[] xyB = new float[2];
  xyA[0] = x; xyA[1] = y;
  M.mult(xyA, xyB);
  result[0] = (int) xyB[0]; result[1] = (int) xyB[1];
  return result;
}



