// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................


int segments = 200;
ArrayList[] pics = new ArrayList[4];
int disp = 0;
double per = 0;
boolean rst = false;
boolean morph = false;

ArrayList pic;

//PGraphics2D g;
void setup()
{
  pics[0] = new ArrayList();
  pics[1] = new ArrayList();
  pics[2] = new ArrayList();
  pics[3] = new ArrayList();
  disp = 0; per = 0; rst = true; morph = false; pic = pics[disp];
  
  setSize(400, 400, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  //g.background(255);
  g.background(255, 210, 150);
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


//##########
// Given an array list of points, it resamples it to a certain number of points
ArrayList getReSampledStroke(ArrayList A, int segments)
{
  ArrayList B = new ArrayList();

  if (A == null || segments < 1) return null;
  if (A.size() == 0) return B;
  if (A.size() == 1)
  {
    for (int i = 0; i <= segments; i++) B.add(A.get(0));
    return B;
  }

  // find the total length of the stroke
  float d = 0; PVector l;
  for (int i = 0;  i< A.size(); i++)
  {
    PVector p = (PVector) A.get(i);
    if (i > 0) d += dist(l.x, l.y, p.x, p.y);
    l = p;
  }
 
  if (d == 0) return B;

  // get the normalised length of a segment
  float nd = d / (float) segments;

  // step through and add the right sizes from A to B
  float rd = 0;
  for (int i = 0;  i< A.size(); i++)
  {
    PVector p = (PVector) A.get(i);

    if (i == 0) {B.add(p); }  // always add the first point
    else if (i > 0)
    {
      float d = dist(l.x, l.y, p.x, p.y); rd += d;

      if (rd == nd) { B.add(p); rd = 0; } // if the distance from the last point to current is the required distance, then add it
      else
      {
        while (rd >= nd) // if the remaining distance is greater than the normalised distance, then keep on adding
        {
          float r = d - (rd - nd);
          float a = r / d;

          // get the new pseudo point back from the current actual point
          float x = l.x + (p.x - l.x) * a;
          float y = l.y + (p.y - l.y) * a;
    
          l = new PVector(x, y); B.add(l);
          rd = d - r; // get the new remaining distance
          d = rd;
        }
  
        // at the end of the iteration, if there is still a point left over, then add the last point
        if (i == A.size() -1 && B.size() < segments + 1) B.add(A.get(i));
      }
    }

    l = p;
  }
  return B;
}
//##########



void draw()
{
  initDraw();
  
  //if (g == null) {createG();}
  //if (g != null)
  //{
  //  imageMode(CENTER);
  //  image(g, 0, 0);
  //}
  
  
 
  if (morph == true)
  {
    ArrayList pic1 = pics[disp];
    int disp2 = disp;
   
    for (int i = 0; i < 4; i++)
    {
      disp2 = disp2 + 1;
      if (disp2 > 3) disp2 = 0;
      if (pics[disp2].size() > 2) break;
    }
   
    ArrayList pic2 = pics[disp2];
   
    pic = new ArrayList();
    for (int i = 0; i < segments+1; i++)
    {
      PVector v1 = (PVector) pic1.get(i);
      PVector v2 = (PVector) pic2.get(i);
      double x = v1.x + (v2.x - v1.x) * per;
      double y = v1.y + (v2.y - v1.y) * per;
      pic.add(new PVector(x, y));
    }
   
    per = per + 0.01;
    if (per > 1)
    {
      per = 0;
     
      for (int i = 0; i < 4; i++)
      {
        disp = disp + 1;
        if (disp > 3) disp = 0;
        if (pics[disp].size() > 2) break;
      }
    }
  }
  else
  {

    // if mouse required
    if (mousePressed == true)
    {
      if (rst == true) pics[disp].clear();
      rst = false;
      pics[disp].add(new PVector(mouseX, mouseY));
    }
    
    //pic = pics[disp];
  
  }
  
  if (pic != null)
  {
    for (int i = 1; i < pic.size(); i++)
    {
      PVector v1 = (PVector) pic.get(i-1);
      PVector v2 = (PVector) pic.get(i);
     
      //stroke(255, 220, 180);
      stroke(135, 100, 60);
      strokeWeight(4);
      line(v1.x, v1.y, v2.x, v2.y);
    }
  }
}
