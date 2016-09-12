// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................


class DNA
{
  string dna = "";
  int index = -1;
 
  DNA(String i_dna)
  {
      dna = i_dna
  }
  
  int getInt(int min, int max)
  {
      return (int)(getDouble(min, max));
  }
 
  double getDouble(int min, int max)
  {
    if (dna.length > 0)
    {
      int M = 9;
      index++;
      if (index >= dna.length) index = 0;
      return (double)(((float) parseInt(dna[index]) / (float)M) * (float)(max - min)) + min;
    }
    else
    {
      return min;
    }
  }
  
  string toString()
  {
    return dna;
  }
}


class F
{
  int age = 0;
  int segment = 0;
  int angle = 0;
  int length = 0;
  ArrayList branches = new ArrayList();
 
  int ageBeforeSplit;
  DNA dna;
  int z;
  int c;
 
  F(int iAge, int iSegment, double iAngle, int iLength, int iAgeBeforeSplit, DNA iDna)
  {
    age = iAge;
    segment = iSegment;
    angle = (PI/180) * iAngle;
    length = iLength;
   
    dna = iDna;
    ageBeforeSplit = iAgeBeforeSplit;
  }
 
  boolean checkGrow()
  {
    age = age + 1;
   
    if (age == ageBeforeSplit) z = dna.getInt(1, 10);

   
    c = c + z;
   
    if (c > 120000) return false;
   
    for (int i = 0; i < branches.size(); i++)
    {
      F f = (F) branches.get(i);
      if (f.checkGrow() == false) return false;
    }
   
    return true;
  }
 
  void grow()
  {
    for (int i = 0; i < branches.size(); i++)
    {
      F f = (F) branches.get(i);
      f.grow();
    }
   
    if (age == ageBeforeSplit)
    {
      for (int i = 0; i < z; i++)
      {
        double a = dna.getDouble(-60, 60);
        double l = dna.getDouble(5, 40) / (segment + 1);
        int abs = dna.getInt(1, 3);
        F f1 = new F(0, segment+1, a, l, abs, dna);
        branches.add(f1);
      }
    }
  }
 
  void draw(double x, double y, double a)
  {
    a = a + angle;
    double scaleLength = length * (age / (5 + age));
   
    double x2 = x + scaleLength * sin(a);
    double y2 = y - scaleLength * cos(a);
   
   
    float q = 1f - (1f / (1f + (float) segment/2f));
    int e = (int) (255f * q);
    int e1 = (int) ((double)e * m_r);
    int e2 = (int) ((double)e * m_g);
   
    int e4 = 255; //(int) (255 * (1 / (1 + (segment * 2))));
    int e5 =  1;  //(int) (4 * (1 / (1 + (segment * 0.5))));
   
    g.stroke(e1, e2, 255 - e);//, e4); 
    g.strokeWeight(e5);
    g.line(x*3, y*3, x2*3, y2*3);
   
    for (int i = 0; i < branches.size(); i++)
    {
      F f = (F) branches.get(i);
      f.draw(x2, y2, a);
    }
  }
}


double m_r;
double m_g;


boolean resetDNA = false;

DNA dna = new DNA();
F f;


PGraphics2D g = null;

PImage imgHills;

void setup()
{
  imgHills = loadImage("./_resources/hills.png");
  setSize(100, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}


void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(255, 210, 150), color(155, 110, 50) );//, 0.5, color(255, 0, 0));
  //g.background(255, 210, 150);
  
  if (imgHills.width > 0 && imgHills.height > 0)
  {
    //println(dh);
    g.imageMode(CENTER);
    g.pushMatrix();
    g.translate(g.width/2, g.height/2);
    float sx = g.width / imgHills.width;
    float sy = g.height / imgHills.height;
    float ss = max(sx, sy);
    //println(ss);
    g.scale(ss);
    g.image(imgHills, 0, 0);
    g.popMatrix();
  }
  
  //if (resetDNA == true)
  //{
  //  g.background(255);
  //}
}

void createG()
{
  int s = max(sw, sh);
  g = createGraphics(s, s, P2D);
  g.textFont(loadFont("arials"), 30);
  g.background(0,0);
  g.translate(s/2, (s/2) + (s/4));
}

void createRndDna()
{
  t1.clear();
    
  string s = "";
  for (int i = 0; i < 8; i++)
  {
    s = s + (int)(random(10));
  }
  
  t1.setText(s);
}

boolean growing = false;

void draw()
{
  initDraw();
  
  //imageMode(CENTER);
  //pushMatrix();
  //
  //g.translate(g.width/2, g.height/2);
  //float sx = g.width / imgHills.width;
  //float sy = g.height / imgHills.height;
  //int ss = (int) (max(sx, sy));
  //scale(ss);
  //image(imgHills, 0, 0);
  //popMatrix();
  
  
  if (g == null) createG();
  
  if (g != null)
  {
    if (resetDNA == true)
    {
      g.background(0,0);
      growing = false;
      
      resetDNA = false;
      dna = new DNA(t1.txt);
      
      int x = dna.getInt(0, 100);

      if (x < 40)
      {
          m_r = 0;
          m_g = 1;
      }
      else if (x < 50)
      {
          double k = dna.getDouble(.2, .7);
          m_r = 0;
          m_g = k;
      }
      else if (x < 80)
      {
          double k = dna.getDouble(.5, 1);
          m_r = k;
          m_g = k;
      }
      else
      {
          double k = dna.getDouble(.5, 1);
          m_r = k;
          m_g = 0;
      }
      
      double l = dna.getDouble(15, 60);
      int abs = dna.getInt(1, 3);
      f = new F(0, 0, 0, l, abs, dna);
    }
    
      
    if (mousePressed == true && mousePressed != pmousePressed)
    {
      g.background(0,0);
      
      growing = true;
      if (f != null && f.checkGrow() == true)
      {
        f.grow();
      }
      f.draw(0, 0, 0);
     
      //background(255, 210, 240);
    }
    
    //if (f != null) {translate(0, 60); f.draw(0, 0, 0);}
    imageMode(CENTER);
    image(g, 0, 0);
  }
  
  /*if (growing == false)
  {
    fill(90, 50); textAlign(CENTER, CENTER);
    pushMatrix();
    scale(2);
    text("Press here to grow", 0, -50);
    popMatrix();
  }*/
  
  fill(0, 100); textAlign(CENTER, CENTER);
  pushMatrix();
  translate(0, 80);
  scale(1.5);
  text(dna.toString(), 0, 10);
  popMatrix();
}
