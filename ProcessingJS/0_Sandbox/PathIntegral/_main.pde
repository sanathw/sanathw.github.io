// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

PVector lightPos = new PVector(0, -100); int lightRadius = 2;
PVector bendPos = new PVector(0, 0); int bendRadius = 10;
PVector detectorPos = new PVector(0, 100); int detectorRadius = 2;
int paths = 10;
float seperation = 1.5;

void setup()
{
  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(200, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  g.background(255);
}


float CalProbB()
{  
  PVector d1v1 = new PVector(0, 0);
  float d1p = 0;

  int lastX = 0;
  int lastY = 0;
  
  float innerSeperation = 0;
  if (paths > 1) innerSeperation = seperation / (paths - 1);
  
  for (int h = -paths/2; h < paths/2; h++)
  {
    float r = 0.0;
    
    PVector d1vT = new PVector(0, 1);
    //d1vT.div(paths);
    
    
    
    float xtemp = (float) (bendPos.x - (h * innerSeperation * 25));
    float x = (float) (bendPos.x - (h * innerSeperation));
    float y = (float) (bendPos.y);
    
    r = dist(lightPos.x, lightPos.y, x, y);
    r = r + dist(x, y, detectorPos.x, detectorPos.y);
    
    stroke(0, 0, 255, 50); strokeWeight(1);
    line(lightPos.x, lightPos.y, (int) xtemp, (int) y);
    line((int) xtemp, (int) y, detectorPos.x, detectorPos.y);
    

    float d = r*r/20.0; // controls the number of interference lines // 50 bigger less
    
    
    d1vT.x = 1 * sin(d);
    d1vT.y = 1 * cos(d);
    d1vT.div(paths);
    
    //PVector v2_orig = new PVector(0, 1);
    //PMatrix2D m = new PMatrix2D();
    //m.rotate(d);
    //m.mult(v2_orig, d1vT);
    
    d1v1.add(d1vT);
    
    
    int newX = (int) (d1v1.x * 100.0);
    int newY = (int) (d1v1.y * 100.0);
    
    stroke(0); strokeWeight(1);
    line(lastX, lastY, newX, newY);
    
    lastX = newX;
    lastY = newY;
  }
  
  d1p = (d1v1.x * d1v1.x) + (d1v1.y * d1v1.y);
  
  
  return d1p;
}


void draw()
{
  initDraw();
  
  ellipseMode(RADIUS);
  
  stroke(0, 50); strokeWeight(1); fill(0 ,255 ,0, 150);
  ellipse(lightPos.x, lightPos.y, lightRadius, lightRadius);
  
  if (mousePressed)
  {
    bendPos.x = (int) (mouseX);
    bendPos.y = (int) (mouseY);
  }
  
  stroke(0, 50); strokeWeight(1); fill(0, 0, 255, 50);
  ellipse(bendPos.x, bendPos.y, bendRadius, bendRadius);
  
  stroke(255, 255, 0, 150); strokeWeight(1);
  line(lightPos.x, lightPos.y, detectorPos.x, detectorPos.y);
  
  float prob = CalProbB();
  
  stroke(0, 50); strokeWeight(1); fill(255, 0, 0, 150);
  ellipse(detectorPos.x, detectorPos.y, detectorRadius, detectorRadius);
  
  fill(0);
  text(""+prob.toFixed(4), 50, 0);
  
}
