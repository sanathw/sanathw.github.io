// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

// mousePressed, mouseX, mouseY
// debug by println();
PVector lightStart = new PVector(-150, 150);
PVector lightPos = new PVector(-150, 150);
int lightRadius = 0;
float speedX = 0;
float speedY = 0;
int tick = 1;
RelativityClock clockV = new RelativityClock(200, 200, speedX, speedY, false, tick);
RelativityClock clockH = new RelativityClock(200, 200, speedX, speedY, false, tick);
PVector vV = new PVector(-150, -140); 
PVector vH = new PVector(140, 150);
boolean start = false;
boolean Vstopped = false;
boolean Hstopped = false;
float a;
float d;

//PGraphics2D g;
void setup()
{
  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(400, 400, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(255);
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
  initDraw();
  
  strokeWeight(1); stroke(190);
  line(-150, 150, -150, -200);
  line(-150, 150, 200, 150);
  

  if (mousePressed)
  {
    speedX = mouseX / 200.0;
    speedY = mouseY / 200.0;
    clockV.SetEtherSpeed(speedX, speedY);
    clockH.SetEtherSpeed(speedX, speedY);
    a = atan2(mouseY, mouseX);
    d = dist(0, 0, mouseX, mouseY);
  }
  
  if (start)
  {
    lightRadius += tick;
    
    lightPos.x = lightPos.x + speedX;
    lightPos.y = lightPos.y + speedY;
    
    
    
    float rV = lightPos.dist(vV);
    float rH = lightPos.dist(vH);
    
    
    
    if (lightRadius < rV) clockV.Update();
    else Vstopped = true;
    if (lightRadius < rH) clockH.Update();
    else Hstopped =  true;
  
    if (Vstopped && Hstopped)
    {
      start = false;
      bStart.isOn = false;
      lightRadius = 0;
      lightPos = new PVector(lightStart.x, lightStart.y);
    }
  
  }
  
  
  stroke(0); noFill();
  ellipseMode(RADIUS);
  ellipse(lightPos.x, lightPos.y, lightRadius, lightRadius);
  
  imageMode(CENTER);
  image(clockV.Draw(), -150, -170, 60, 60);
  image(clockH.Draw(), 170, 150, 60, 60);
  
  if (Vstopped == true) {stroke(200,200,0); fill(255, 255,0); ellipse(-110, -170, 10, 10); }
  if ( Hstopped == true) {stroke(200,200,0); fill(255, 255,0); ellipse(170, 110, 10, 10);}
  
  fill(0);
  textAlign(CENTER, CENTER);
  text(clockV.Count, -110, -170);
  text(clockH.Count, 170, 110);
  
  if (speedX != 0 || speedY != 0)
  {
    pushMatrix();
    //translate(0, -100);
    
    rotate(a);
    strokeWeight(1);
    stroke(255,0,0, 90);
    fill(255,0,0, 90);
    //rectMode(CORNER);
    //rect(-5,-5, (int)d, 10);
    triangle(0, 0, (int)d, -5, (int)d, 5);
    triangle((int)d, -10, (int)d, 10, (int)d+5, 0);
    popMatrix();
  }
}
