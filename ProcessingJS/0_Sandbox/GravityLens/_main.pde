// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

PVector lightPos = new PVector(0, -100); int lightRadius = 2;
PVector massPos = new PVector(0, 0); int massRadius = 10;
int screenY = 120;
var screenPropbaility = new Array();
float mass = 0;


void setup()
{
  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(200, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(255);
}

void calculateProbability()
{
  var holesTemp = new ArrayList();
  
  stroke(0,0,255, 200); strokeWeight(1);
  var dx = massPos.x-massRadius - lightPos.x;
  var dy = massPos.y - lightPos.y;
  var dy2 = screenY - massPos.y;
  var d = dy2 / dy;
  var x = (dx * d)+massPos.x-massRadius;
  line(lightPos.x, lightPos.y, x, screenY);
  
  dx = massPos.x+massRadius+1 - lightPos.x;
  var x = (dx * d)+massPos.x+massRadius+1;
  line(lightPos.x, lightPos.y, x, screenY);
  
  for (int xl = -h_sw; xl < (massPos.x-massRadius); xl+=2)
  {
    //line(lightPos.x, lightPos.y, xl, massPos.y);
    //line(xl, massPos.y, i, screenY);
    holesTemp.add(xl);
  }
  
  for (int xr = (massPos.x+massRadius)+1; xr < h_sw; xr+=2)
  {
    //line(lightPos.x, lightPos.y, xr, massPos.y);
    //line(xr, massPos.y, i, screenY);
    holesTemp.add(xr);
  }
  
  for (int i = -h_sw; i< h_sw; i++)
  {
    var p =  CalProbB(i, screenY, lightPos.x, lightPos.y, holesTemp);//, 0, false);
    screenPropbaility[i] = p * 50;
  }
}


float CalProbB(int xi, int yi, int lazerXi, int lazerYi, ArrayList holes)//, int ti, boolean useTime)
{
  //float t = (float) (ti * 100.0);
  
  PVector d1v1 = new PVector(0, 0);
  float d1p = 0;
  
  var shortestDist = dist(xi, yi, lazerXi, lazerYi);
  
  //fill(0);
  //text(holes.size(), 0,0);//);
  //var mindistDiff = 9999;
  
  //fill(0,0,255);stroke(0,0,255);
  //for (int h = 0; h<holes.size(); h++)
  //{
  //  int hx = (int) holes.get(h);
  //  ellipse(hx, massPos.y, 1,1);
  //}
  
  for (int h = 0; h<holes.size(); h++)
  {
    float r = 0.0;
    
    PVector d1vT = new PVector(0, 1);
    //d1vT.div(holes.size());
  
    
  
    int hx = (int) holes.get(h);
    
    
    float hxd = (hx - massPos.x) / (1+mass);
    hxd = hxd * hxd;
    hxd = ( 1+hxd);
    //hx = hx + (massPos.x-hx) / ((1+hxd)*1000) ;//* hxd;
    hx = hx + (massPos.x-hx)/hxd;
    
    
    float x = (float) ((hx - lazerXi) );//* 100.0);
    float y = (float) (massPos.y - lazerYi);// * 100.0);
    
    
    
    
    r = sqrt((x*x) + (y*y));
    
    
    
    x = (float) ((xi - hx));// * 100.0);
    y = (float) (yi-massPos.y);// * 100.0);
    
    
    
    r = r + sqrt((x*x) + (y*y));
    //r = (x*x) + (y*y) - (t*t);
    
    
    float distDiff = (r - shortestDist);
    
    distDiff = distDiff * 10.0;
    
    float popLoss = 1 / (1 + (distDiff * distDiff));
    
    //if (popLoss < mindistDiff) mindistDiff = popLoss;
    
    //r = r / 2.0;
    float d = r*r/20; // controls the number of interference lines // 50 bigger less
    
    //r = r * 100.0;
    
    //r = (r*r);// - (t*t);
    
    //float rp = 1.0/(1.0+(r*r/30000000000000.0));
    //
    //if (useTime)
    //{
    //  d1vT.x = d1vT.x * rp;
    //  d1vT.y = d1vT.y * rp;
    //}
    
    //if (frameCount == 1 && xi ==0)
    //{
    //  println(distDiff);
    //}
    
    //if (distDiff <= 10) popLoss = 1; else popLoss = 0;
    
    //d1vT.x = d1vT.y * sin(d) * popLoss;
    //d1vT.y = d1vT.y * cos(d) * popLoss;
    d1vT.x = 1*popLoss * sin(d);
    d1vT.y = 1*popLoss * cos(d);
    d1vT.div(holes.size());
    
    d1v1.add(d1vT);
  }
  
  //if (xi == -h_sw) text(mindistDiff, 0,0);//);
  
  d1p = (d1v1.x * d1v1.x) + (d1v1.y * d1v1.y);
  
  //float y = (float) ((yi - lazerYi) * 100.0);
  //float x = (float) (xi * 100.0);
  //float t = (float) (ti * 100.0);
  
  //float r = (x*x) + (y*y) - (t*t);
  
  //if (frameCount == 1)
  //{
  //  println(d1p);
  //}
  
  return d1p;
}


void draw()
{
  initDraw();
  
  ellipseMode(RADIUS);
  
  stroke(0); strokeWeight(1); fill(255 ,255 ,0);
  ellipse(lightPos.x, lightPos.y, lightRadius, lightRadius);
  
  if (mousePressed)
  {
    massPos.x = (int) (mouseX);
    massPos.y = (int) (mouseY);
  }
  
  stroke(0); strokeWeight(1); fill(190);
  ellipse(massPos.x, massPos.y, massRadius, massRadius);
  
  calculateProbability();
  
  stroke(0, 90); strokeWeight(1);
  int lastX = -h_sw;
  int lastY = (int) (screenY - (screenPropbaility[lastX] * 2000));
  for (int x= lastX+1; x<h_sw; x++)
  {
    int y = (int) (screenY - (screenPropbaility[x] * 2000));
    line(lastX, lastY, x, y);
    lastX = x; lastY = y;
  }
}
