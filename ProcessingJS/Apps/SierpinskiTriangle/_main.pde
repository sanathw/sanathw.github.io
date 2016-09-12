// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................
// mathworld.wolfram.com/ChaosGame.html

float r = 50;
float dr = 1/2;
ArrayList points = new ArrayList();
PVector p =  new PVector(0, 0);

PGraphics2D g;


void setup()
{
  setSize(100, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(255,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(255);
}

void createG()
{
  int s = max(sw, sh);
  g = createGraphics(s, s, P2D);
  //g.strokeWeight(0.01);
  g.noStroke();
  g.fill(0, 200);
  g.translate(s/2, s/2);
}

void clearPolygon()
{
  nextIndex = 0;
  g.background(0,0);
}

//boolean doReset = false;
void resetPolygon()
{
  nextIndex = 0;
  points.clear();// = new ArrayList();
  g.background(0,0);
}

void setupPolygon(int n)
{
  resetPolygon();
  
  float da = TWO_PI/n;
  PMatrix2D m = new PMatrix2D();
  PVector s = new PVector(0, -r);
  
  for (int i = 0; i < n; i++)
  {
    PVector d = new PVector();
    m.mult(s, d);
    points.add(d);
    
    m.rotate(da);
  }
  
  getNextIndex();
}

int nextIndex = 0;

int ii = 0;
void getNextIndex()
{
  if (isRnd)
  {
    nextIndex = (int) random(points.size());
  }
  else
  {
    if (t1.txt.length > 0)
    {
      if (ii >= t1.txt.length) ii = 0;
      int t_nextIndex = parseInt(t1.txt[ii]) - 1;
      ii++;
      if (nextIndex < points.size()) nextIndex = t_nextIndex;
    }
  }
}

void setNextPoint()
{
  g.beginDraw();
  
  
  
  PVector v = (PVector) points.get(nextIndex);
  //p.x = p.x + (v.x - p.x) * dr;
  //p.y = p.y + (v.y - p.y) * dr;
  p.x = v.x + (p.x - v.x) * dr;
  p.y = v.y + (p.y - v.y) * dr;
  
  g.fill(0);
  g.ellipse(p.x, p.y, 1, 1);
  g.endDraw();
  
  getNextIndex();
}

void drawPolygon()
{
  if (points.size() > 0)
  {
    //pushMatrix();
    //translate(width/2, height/2);
    //noFill();
    fill(255,190);
    
    PVector firstPoint; PVector lastPoint;
    for (int i = 0; i < points.size(); i++)
    {
      PVector v = (PVector) points.get(i);
      if (i == 0) firstPoint = v;
      else line(lastPoint.x, lastPoint.y, v.x, v.y); 
      
      if (isChaos) ellipse(v.x, v.y, 10, 10);
      lastPoint = v;
    }
    line(lastPoint.x, lastPoint.y, firstPoint.x, firstPoint.y); 
    if (isChaos) ellipse(firstPoint.x, firstPoint.y, 10, 10);
    
    //popMatrix();
    
    PVector v = (PVector) points.get(nextIndex);
    fill(90);
    if (isChaos) ellipse(v.x, v.y, 10, 10);
  }
  
  fill(0, 255, 0, 90);
  if (isChaos) ellipse(p.x, p.y, 10, 10);
  
  if (isRnd == false)
  {
    for (int i = 0; i < points.size(); i++)
    {
      PVector v = (PVector) points.get(i);
      fill(255,0,0);
      textAlign(CENTER, CENTER)
      text(i+1, v.x, v.y);
    }
  }
}

void resetFractal()
{
  setupPolygon(3);
  fractalLength = 0;
  
  PVector v1 = (PVector) points.get(0);
  PVector v2 = (PVector) points.get(1);
  PVector v3 = (PVector) points.get(2);
  fractalLength++;
  
  g.beginDraw();
  
  g.noStroke();
  g.fill(0);
  g.beginShape(TRIANGLES);
  g.vertex(v1.x, v1.y);
  g.vertex(v2.x, v2.y);
  g.vertex(v3.x, v3.y);
  g.endShape();
  
  g.endDraw();
}

int fractalLength = 0;
void startFractal()
{
  PVector v1 = (PVector) points.get(0);
  PVector v2 = (PVector) points.get(1);
  PVector v3 = (PVector) points.get(2);
  
  drawFractalTriangle(v1, v2, v3, fractalLength);
  fractalLength++;
}

void drawFractalTriangle(PVector v1, PVector v2, PVector v3, int l)
{
  l = l - 1;
  if (l < 0) return;
  
  PVector nv1 =  new PVector((v1.x + v2.x)/2, (v1.y + v2.y)/2);
  PVector nv2 =  new PVector((v2.x + v3.x)/2, (v2.y + v3.y)/2);
  PVector nv3 =  new PVector((v3.x + v1.x)/2, (v3.y + v1.y)/2);
  
  g.beginDraw();
  
  g.noStroke();
  g.fill(255);
  g.beginShape(TRIANGLES);
  g.vertex(nv1.x, nv1.y);
  g.vertex(nv2.x, nv2.y);
  g.vertex(nv3.x, nv3.y);
  g.endShape();
  
  g.endDraw();
  
  drawFractalTriangle(v1, nv1, nv3, l);
  drawFractalTriangle(nv1, v2, nv2, l);
  drawFractalTriangle(nv3, nv2, v3, l);
  
}


boolean isChaos = true;
int selIndex = -1;
boolean start = false;
boolean step = false;
boolean isAny = false;
boolean setP0 = false;
boolean isRnd = true;
boolean hideOverlay = false;
void draw()
{
  initDraw();
  
  if (g == null) {createG(); setupPolygon(3);}
  
  if (g != null)
  {
    //if (doReset)
    //{
    //  resetPolygon();
    //}
    //doReset = false;
    
    if (isChaos)
    {
    if (isAny)
    {
      if (mousePressed && pmousePressed != mousePressed)
      {
        //println(""+mouseX + " " + mouseY + " " + points);
        PVector d = new PVector(0,0);
        d.x = mouseX;
        d.y = mouseY;
        //println("" + d + " " + d.x + " " + d.y + " " + points.size());
        //points = new ArrayList();
        points.add(d);
        //println(points.size());
      }
    }
    else
    {
    
      if (start || step) 
      {
        setNextPoint();
        step = false;
      }
      else
      {
        if (!setP0)
        {
          if (mousePressed && pmousePressed != mousePressed)
          {
            // find the losest point
            float minDist = 99999999999;
            selIndex = -1;
            for (int i = 0; i < points.size(); i++)
            {
              PVector v = (PVector) points.get(i);
              float d = abs(dist(mouseX, mouseY, v.x, v.y));
              if (d < minDist) {selIndex = i; minDist = d;}
            }
          }
          
          if (mousePressed && selIndex > -1)
          {
            PVector v = (PVector) points.get(selIndex);
            v.x = mouseX;
            v.y = mouseY;
          }
        }
        else
        {
          if (mousePressed)
          {
            p.x = mouseX;
            p.y = mouseY;
          }
        }
      }
    }
    
    }
    /*else
    {
      if (mousePressed && pmousePressed != mousePressed)
      {
        PVector v1 = (PVector) points.get(0);
        PVector v2 = (PVector) points.get(1);
        PVector v3 = (PVector) points.get(2);
        fractalLength++;
        drawFractalTriangle(v1, v2, v3, fractalLength);
      }
    }*/
    
    imageMode(CENTER);
    image(g, 0, 0);
    
    if (hideOverlay == false || isChaos == false) drawPolygon();
  }
}
