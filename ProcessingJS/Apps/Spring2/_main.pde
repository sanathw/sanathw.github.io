// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

/*int demoType = 1;

WallHook hh;// = new WallHook(-150, 0, 0);
Mass mm;// = new Mass(10, 0, 0, 0);
Mass mm2;
Spring ss;// = new Spring(hh, mm, 0.25, 0.05);*/

PhysicalObjectBase sel = null;

Mass m22 = null;
RigidObject ro = null;

Mass m13 = null;
Mass m23 = null;
Mass m33 = null;


Spring  s11_12 = null;
Spring  s12_13 = null;
Spring  s13_23 = null;
Spring  s23_33 = null;
Spring  s33_32 = null;
Spring  s32_31 = null;
Spring  s31_21 = null;
Spring  s21_11 = null;
  
Spring  s12_22 = null;
Spring  s22_32 = null;
Spring  s21_22 = null;
Spring  s22_23 = null;
  
  
Spring  s11_22 = null;
Spring  s12_21 = null;
  
Spring  s12_23 = null;
Spring  s13_22 = null;
  
Spring  s22_33 = null;
Spring  s23_32 = null;
  
Spring  s21_32 = null;
Spring  s22_31 = null;

World w = new World();

PImage imgPaper;
void setup()
{
  //doZoom = false; doTranslate = false; doRotate = false;  
  imgPaper = loadImage("./_resources/paper3.jpg");
  
  demo1();
  
    /*PVector v1 = new PVector(10, 0);
    v1.normalize();
    PVector v2 = new PVector(0, 2);
    PVector v3 = v1.cross(v2);
    println(v3);
    println(v3.mag());
    float vv = v1.cross(v2);
    println(vv);*/

  setSize(400, 400, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void demo1()
{
  demo = 1;
  w = new World();
  
  Mass m11 = new Mass(1, new PVector(-180,-180), new PVector(0,0), new PVector(0,0));
  Mass m12 = new Mass(1, new PVector(-120,-180), new PVector(0,0), new PVector(0,0));
       m13 = new Mass(1, new PVector(-60,-180), new PVector(0,0), new PVector(0,0));
  
  Mass m21 = new Mass(1, new PVector(-180,-120), new PVector(0,0), new PVector(0,0));
       m22 = new Mass(1, new PVector(-120,-120), new PVector(0,0), new PVector(0,0));
       m23 = new Mass(1, new PVector(-60,-120), new PVector(0,0), new PVector(0,0));
  
  Mass m31 = new Mass(1, new PVector(-180,-60), new PVector(0,0), new PVector(0,0));
  Mass m32 = new Mass(1, new PVector(-120,-60), new PVector(0,0), new PVector(0,0));
       m33 = new Mass(1, new PVector(-60,-60), new PVector(0,0), new PVector(0,0));
  
  
  s11_12 = new Spring(m11, m12, 0.25, 0.05); w.add(s11_12);
  s12_13 = new Spring(m12, m13, 0.25, 0.05); w.add(s12_13);
  s13_23 = new Spring(m13, m23, 0.25, 0.05); w.add(s13_23);
  s23_33 = new Spring(m23, m33, 0.25, 0.05); w.add(s23_33);
  s33_32 = new Spring(m33, m32, 0.25, 0.05); w.add(s33_32);
  s32_31 = new Spring(m32, m31, 0.25, 0.05); w.add(s32_31);
  s31_21 = new Spring(m31, m21, 0.25, 0.05); w.add(s31_21);
  s21_11 = new Spring(m21, m11, 0.25, 0.05); w.add(s21_11);
  
  s12_22 = new Spring(m12, m22, 0.25, 0.05); w.add(s12_22);
  s22_32 = new Spring(m22, m32, 0.25, 0.05); w.add(s22_32);
  s21_22 = new Spring(m21, m22, 0.25, 0.05); w.add(s21_22);
  s22_23 = new Spring(m22, m23, 0.25, 0.05); w.add(s22_23);
  
  
  s11_22 = new Spring(m11, m22, 0.25, 0.05); w.add(s11_22);
  s12_21 = new Spring(m12, m21, 0.25, 0.05); w.add(s12_21);
  
  s12_23 = new Spring(m12, m23, 0.25, 0.05); w.add(s12_23);
  s13_22 = new Spring(m13, m22, 0.25, 0.05); w.add(s13_22);
  
  s22_33 = new Spring(m22, m33, 0.25, 0.05); w.add(s22_33);
  s23_32 = new Spring(m23, m32, 0.25, 0.05); w.add(s23_32);
  
  s21_32 = new Spring(m21, m32, 0.25, 0.05); w.add(s21_32);
  s22_31 = new Spring(m22, m31, 0.25, 0.05); w.add(s22_31);
  
  
  w.add(m11);
  w.add(m12);
  w.add(m13);
  
  w.add(m21);
  w.add(m22);
  w.add(m23);
  
  w.add(m31);
  w.add(m32);
  w.add(m33);
  
  
  ro = new RigidObject(9, new PVector(-120,-120), new PVector(0,0), new PVector(0,0),   43000, 0, 0, 0, 120, 120);
  w.add(ro);
}

void demo2()
{
  demo = 2;
  w = new World();
  
  m13 = new Mass(2, new PVector(-10,-180), new PVector(0,0), new PVector(0,0)); m13.isPlaceHolder = true;
  m33 = new Mass(1, new PVector(-60,-60), new PVector(0,0), new PVector(0,0)); m33.isPlaceHolder = true;
  RigidRod rr = new RigidRod(m13, m33);
  
  
  w.add(m13);
  w.add(m33);
  
  w.add(rr);
}

void setSpringK(float k)
{
  springK = k;
  
  if (demo == 1)
  {
    s11_12.k = k;
    s12_13.k = k;
    s13_23.k = k;
    s23_33.k = k;
    s33_32.k = k;
    s32_31.k = k;
    s31_21.k = k;
    s21_11.k = k;

    s12_22.k = k;
    s22_32.k = k;
    s21_22.k = k;
    s22_23.k = k;


    s11_22.k = k;
    s12_21.k = k;

    s12_23.k = k;
    s13_22.k = k;

    s22_33.k = k;
    s23_32.k = k;

    s21_32.k = k;
    s22_31.k = k;
  }
}

void setSpringC(float c)
{
  springC = c;
  
  if (demo == 1)
  {
    s11_12.c = c;
    s12_13.c = c;
    s13_23.c = c;
    s23_33.c = c;
    s33_32.c = c;
    s32_31.c = c;
    s31_21.c = c;
    s21_11.c = c;

    s12_22.c = c;
    s22_32.c = c;
    s21_22.c = c;
    s22_23.c = c;


    s11_22.c = c;
    s12_21.c = c;

    s12_23.c = c;
    s13_22.c = c;

    s22_33.c = c;
    s23_32.c = c;

    s21_32.c = c;
    s22_31.c = c;
  }
}


int demo = 1;
boolean doTorque = false;
boolean doShow = false;
float springK = 0.25;
float springC = 0.05;
void reset()
{
  if (demo == 1) demo1();
  else demo2();
  
  setSpringK(springK);
  setSpringC(springC);
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


//boolean massSelected = false;
float startX = 0;
float startY = 0;

void draw()
{
  initDraw();
  
  w.calculate();
  w.update();
  
  //if (mousePressed && mousePressed != pmousePressed) { if (mm.isInside(mouseY)) massSelected = true; }
  //if (massSelected) { mm.d = mouseY; mm.v = 0; mm.a = 0; }
  if (mousePressed == false && mousePressed != pmousePressed) 
  {
    b1.isOn = false;
    b2.isOn = false;
    b3.isOn = false;
      
    if (sel != null)
    {
      float dx = (mouseX - startX)/4;
      float dy = (mouseY - startY)/4;
      PVector F = new PVector(dx, dy, 0);
      sel.F.add(F);
      if (demo == 1)
      {
        ro.F.add(F);
        if (doTorque) ro.calculateTorque(F, new PVector(startX - m22.d.x, startY - m22.d.y, 0))
      }
    }
    
    sel = null; 
  }
  
  
  if (sel != null && mousePressed && mousePressed != pmousePressed)
  {
    //sel.d.x = mouseX;
    //sel.d.y = mouseY;
    
    //sel.v.x = 0;
    //sel.v.y = 0;
    //sel.a.x = 0;
    //sel.a.y = 0;
    startX = sel.d.x;
    startY = sel.d.y;
  }
  
  if (sel != null && mousePressed)
  {
    pushMatrix();
    translate(startX, startY);
    stroke(255, 0, 0); strokeWeight(4);
    float k = dist(startX, startY, mouseX, mouseY);
    float a = atan2( (mouseX-startX), (mouseY-startY));
    rotate(-a);
    line(0, 0, 0, k);
    
    strokeWeight(6);
    line(0, k, -10, k-15);
    line(0, k, +10, k-15);
    popMatrix();
  }
  
  w.display();
}
