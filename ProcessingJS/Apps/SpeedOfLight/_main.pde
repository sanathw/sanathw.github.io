// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

// mousePressed, mouseX, mouseY
// debug by println();
PVector lightStart = new PVector(-150, 150);
PVector lightPosV = new PVector(-150, 150);
PVector lightPosH = new PVector(-150, 150);
int lightRadiusV = 0;
int lightRadiusH = 0;
float speedX = 0;
float speedY = 0;
float speed = 0;
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
  
  
  /*strokeWeight(1);
  stroke(255,0,0, 90); 
  int qy = abs(((int) lightPosV.y) % 20);
  for (int i = qy; i < sh; i+=20)
  {
    line(-h_sw, -h_sh + i, h_sw, -h_sh + i);
  }
  int qx = abs(((int) lightPosV.x) % 20);
  for (int i = qx; i < sw; i+=20)
  {
    line(-h_sw + i, -h_sh, -h_sw + i, h_sh);
  }
  stroke(0,0,255, 90); 
  qy = abs(((int) lightPosH.y) % 20);
  for (int i = qy; i < sh; i+=20)
  {
    line(-h_sw, -h_sh + i, h_sw, -h_sh + i);
  }
  qx = abs(((int) lightPosH.x) % 20);
  for (int i = qx; i < sw; i+=20)
  {
    line(-h_sw + i, -h_sh, -h_sw + i, h_sh);
  }*/
  
  strokeWeight(1);
  stroke(255,0,0, 50); 
  line(lightPosV.x, lightPosV.y, lightStart.x, lightStart.y);
  stroke(0,0,255, 50); 
  line(lightPosH.x, lightPosH.y, lightStart.x, lightStart.y);
  
  strokeWeight(1); //stroke(190);
  stroke(255,0,0); line(-150, 150, -150, -200);
  stroke(0,0,255); line(-150, 150, 200, 150);


  if (mousePressed)
  {
    speedX = mouseX / 200.0;
    speedY = mouseY / 200.0;
    speed = mag(speedX, speedY);
    clockV.SetEtherSpeed(speedX, speedY);
    clockH.SetEtherSpeed(speedX, speedY);
    a = atan2(mouseY, mouseX);
    d = dist(0, 0, mouseX, mouseY);
  }
  
  if (start)
  {
    lightRadiusV += tick;
    lightRadiusH += tick;
    
    lightPosV.y += speed*tick;
    lightPosH.x -= speed*tick;
    
    
    
    float rV = lightPosV.dist(vV);
    float rH = lightPosH.dist(vH);
    
    
    
    if (lightRadiusV < rV) clockV.Update();
    else Vstopped = true;
    if (lightRadiusH < rH) clockH.Update();
    else Hstopped =  true;
  
    if (Vstopped && Hstopped)
    {
      start = false;
      bStart.isOn = false;
      lightRadiusV = 0;
      lightRadiusH = 0;
      lightPosV = new PVector(lightStart.x, lightStart.y);
      lightPosH = new PVector(lightStart.x, lightStart.y);
    }
  
  }
  
  
  noFill();
  ellipseMode(RADIUS);
  
  if (frameCount % 2 == 0)
  {
    stroke(255,0,0); ellipse(lightPosV.x, lightPosV.y, lightRadiusV, lightRadiusV);
    stroke(0,0,255); ellipse(lightPosH.x, lightPosH.y, lightRadiusH, lightRadiusH);
  }
  else
  {
    stroke(0,0,255); ellipse(lightPosH.x, lightPosH.y, lightRadiusH, lightRadiusH);
    stroke(255,0,0); ellipse(lightPosV.x, lightPosV.y, lightRadiusV, lightRadiusV);
  }
  
  
  imageMode(CENTER);
  image(clockV.Draw(), -150, -170, 60, 60);
  image(clockH.Draw(), 170, 150, 60, 60);
  
  if (Vstopped == true) {stroke(200,200,0); fill(255, 255,0); ellipse(-110, -170, 10, 10); }
  if ( Hstopped == true) {stroke(200,200,0); fill(255, 255,0); ellipse(170, 110, 10, 10);}
  
  noFill();
  strokeWeight(1);
  rectMode(CENTER);
  stroke(255,0,0); rect(-150, -170, 60, 60);
  stroke(0,0,255); rect(170, 150, 60, 60);
  
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
