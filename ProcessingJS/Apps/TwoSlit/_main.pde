// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................


// For the Time component see:
// QED
// Richard Feynmann
// Page 89 - 90
// Chapter 3
// Electrons and Their Interactions
// The speed of light can be faster or slower....with Probablity!
// If I the 'Interval' (x^2) - (t^2) = 0...the probability = 1


// mousePressed, mouseX, mouseY
// debug by println();

PImage o; 
int laserOffset = 0;
var holes;
var holesTemp;
int detectorHoleY;

boolean useTime = true;
int time = 20;

int test = 1;
boolean showQuantum = true;
boolean showClassical = true;
boolean useDetector = false;
int detectorHole = 0;

int getIndex(int x, int y) { return (o.width*y)+x; }

//PGraphics2D g;
void setup()
{
  o = new PImage(83, 83);
  
  ResetTest();
  
  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(83, 83, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void ResetTest()
{
  holes = new ArrayList();
  
  switch (test)
  {
    case 1:
      holes.add(41);
      break;
    
    case 2:
      holes.add(31);
      holes.add(51);
      break;
      
   case 3:
      holes.add(31);
      holes.add(41);
      holes.add(51);
      break;
      
  case 4:
      holes.add(39);
      holes.add(40);
      holes.add(41);
      holes.add(42);
      holes.add(43);
      break;
  
  case 5:
      holes.add(36);
      holes.add(37);
      holes.add(38);
      holes.add(39);
      holes.add(40);
      holes.add(41);
      holes.add(42);
      holes.add(43);
      holes.add(44);
      holes.add(45);
      holes.add(46);
      break;
  }
  
  holesTemp = holes;

  
  if (useDetector)
  {
    //detectorHole = (int) random(holes.size());
    detectorHole++;
    if (detectorHole >= holes.size()) detectorHole = 0;
    
    holesTemp = new ArrayList();
    detectorHoleY = (int) holes.get(detectorHole);
    holesTemp.add(detectorHoleY);
  }
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(190,190,190);
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

void draw()
{
  initDraw(); imageMode(CENTER);
  
  int lazerY = 41 + laserOffset;
  
  for (int y = 0; y < 83; y++)
  {
    for (int x = 0; x < 83; x++)
    {
      color c;
      if (x == 0) 
      {
        if (y == lazerY) c = color(255, 100, 0);
        else c = color(120, 120, 255);
      }
      else if (x == 41) 
      {
        if (holes.contains(y)) c = color(255);
        else c = color(0, 0, 255);
      }
      else if (x == 82) 
      {
        //c = color(120, 120, 255);
        
        if (showQuantum)
        {
          float f = CalProbB(x, y, lazerY, holesTemp, time, false);
          int f1 = (int) (f * 255.0);
          if (f1 > 255) f1 = 255;
          //if (f1 < 240)
          //{
          //  c = color(120, 120, 255);
          //}
          //else
          //{
            c = color(f1, 0, 0);
          //}
        }
        else
        {
          c = color(120, 120, 255);
        }
      }
      else if (x < 41)
      {
        float d = (float)(detectorHoleY-lazerY);
        d = d*d;
        d = d+(41.0 * 41.0);
        d = sqrt(d);
        d = d* 1.0;
      
        if (showQuantum && !(useDetector && time > d))
        {
          float f = CalProbA(x, y, lazerY, time, useTime);
          int f1 = (int) (f * 255.0);
          c = color(f1);
        }
        else
        {
          c = color(0);
        }
      }
      else if (x > 41)
      {      
        if (showQuantum)
        {
          float f = CalProbB(x, y, lazerY, holesTemp, time, useTime);
          int f1 = (int) (f * 255.0);
          if (f1 > 255) f1 = 255;
          c = color(f1);
        }
        else
        {
          c = color(0);
        }
      }
      
      if (y == 0 || y == 82) c = color(0, 0, 255);
      
      o.pixels[getIndex(x, y)] = c;
    }
  }
  
  
  image(o, 0, 0);
  
  //if (g == null) {createG();}
  //if (g != null)
  //{
  //  imageMode(CENTER);
  //  image(g, 0, 0);
  //}
  
  if (useDetector)
  {
    stroke(255, 0, 0, 220);
    strokeWeight(1);
    fill(255, 0, 0, 220);
    rectMode(CENTER);
    rect(0, detectorHoleY-41, 1, 2);
  }
  
  if (showClassical)
  {
    stroke(255, 255, 0, 100);
    strokeWeight(1);
    
    switch (test)
    {
      case 1:
        //holes.add(41);
        line(-41, laserOffset, 41, ((41-lazerY)*2)+laserOffset);
        break;
      
      case 2:
        /*holes.add(31);
        holes.add(51);*/
        line(-41, laserOffset, 41, ((31-lazerY)*2)+laserOffset);
        line(-41, laserOffset, 41, ((51-lazerY)*2)+laserOffset);
        break;
        
     case 3:
        /*holes.add(31);
        holes.add(41);
        holes.add(51);*/
        line(-41, laserOffset, 41, ((31-lazerY)*2)+laserOffset);
        line(-41, laserOffset, 41, ((41-lazerY)*2)+laserOffset);
        line(-41, laserOffset, 41, ((51-lazerY)*2)+laserOffset);
        break;
        
    case 4:
        /*holes.add(39);
        holes.add(40);
        holes.add(41);
        holes.add(42);
        holes.add(43);*/
        line(-41, laserOffset, 41, ((39-lazerY)*2)+laserOffset);
        line(-41, laserOffset, 41, ((43-lazerY)*2)+laserOffset);
        break;
    
    case 5:
        /*holes.add(36);
        holes.add(37);
        holes.add(38);
        holes.add(39);
        holes.add(40);
        holes.add(41);
        holes.add(42);
        holes.add(43);
        holes.add(44);
        holes.add(45);
        holes.add(46);*/
        line(-41, laserOffset, 41, ((36-lazerY)*2)+laserOffset);
        line(-41, laserOffset, 41, ((46-lazerY)*2)+laserOffset);
        break;
    }
  }
  
  
}

float CalProbA(int xi, int yi, int lazerYi, int ti, boolean useTime)
{
  float y = (float) ((yi - lazerYi) * 100.0);
  float x = (float) (xi * 100.0);
  float t = (float) (ti * 100.0);
  
  float r = (x*x) + (y*y) - (t*t);
  
  if (useTime)
  {
    return 1.0/(1.0+(r*r/30000000000000.0));
  }
  else
  {
    return 1.0;
  }
  //return (1.0 / (1.0 + (r)));
  //return random();
}

float CalProbB(int xi, int yi, int lazerYi, ArrayList holes, int ti, boolean useTime)
{
  float t = (float) (ti * 100.0);
  
  PVector d1v1 = new PVector(0, 0);
  float d1p = 0;
  
  for (int h = 0; h<holes.size(); h++)
  {
    float r = 0.0;
    
    PVector d1vT = new PVector(0, 1);
    //d1vT.div(holes.size());
  
    int hy = (int) holes.get(h);
    
    
    
    float y = (float) ((hy - lazerYi) );//* 100.0);
    float x = (float) (41.0);// * 100.0);
    
    
    
    r = sqrt((x*x) + (y*y));
    
    
    
    y = (float) ((yi - hy));// * 100.0);
    x = (float) (xi-41.0);// * 100.0);
    
    
    
    r = r + sqrt((x*x) + (y*y));
    //r = (x*x) + (y*y) - (t*t);
    
    float d = r*r/80; // controls the number of interference lines // 50 bigger less
    
    r = r * 100.0;
    
    r = (r*r) - (t*t);
    
    float rp = 1.0/(1.0+(r*r/30000000000000.0));
    
    if (useTime)
    {
      d1vT.x = d1vT.x * rp;
      d1vT.y = d1vT.y * rp;
    }
    
    d1vT.x = d1vT.y * sin(d);
    d1vT.y = d1vT.y * cos(d);
    
    d1v1.add(d1vT);
  }
  
  d1p = (d1v1.x * d1v1.x) + (d1v1.y * d1v1.y);
  
  //float y = (float) ((yi - lazerYi) * 100.0);
  //float x = (float) (xi * 100.0);
  //float t = (float) (ti * 100.0);
  
  //float r = (x*x) + (y*y) - (t*t);
  
  return d1p;
}
