// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

// mousePressed, mouseX, mouseY
// debug by println();
//PVector lightStart = new PVector(-150, 150);
PVector lightPosV = new PVector(-150, 150);
PVector lightPosH = new PVector(-150, 150);
int lightRadiusV = 0;
int lightRadiusH = 0;
float speedX = 0;
float speedY = 0;
float speed = 0;
int tick = 1;
RelativityClock clockStartV = new RelativityClock(200, 200, speedX, speedY, false, tick);
RelativityClock clockStartH = new RelativityClock(200, 200, speedX, speedY, false, tick);
RelativityClock clockEndV = new RelativityClock(200, 200, speedX, speedY, false, tick);
RelativityClock clockEndH = new RelativityClock(200, 200, speedX, speedY, false, tick);

PVector vStartV = new PVector(-150, 150); 
PVector vStartH = new PVector(-150, 150);
PVector vEndV = new PVector(-150, -140); 
PVector vEndH = new PVector(140, 150);
PVector vEndVorig = new PVector(-150, -140); 
PVector vEndHorig = new PVector(140, 150);
boolean start = false;
boolean VStartstopped = false;
boolean HStartstopped = false;
boolean VEndstopped = false;
boolean HEndstopped = false;
float a;
float d;
float lengthContaction = 0;

//PGraphics2D g;
void setup()
{
  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(510, 510, P2D, FIT_INSIDE, this); // this has to be the last line in this function
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
  stroke(255,0,0, 50); line(vStartV.x, vStartV.y, -150, 210);
  stroke(0,0,255, 50); line(vStartH.x, vStartH.y, -210, 150);
  
  strokeWeight(1); //stroke(190);
  stroke(255,0,0); line(vStartV.x, vStartV.y, vEndV.x, vEndV.y);
  stroke(0,0,255); line(vStartH.x, vStartH.y, vEndH.x, vEndH.y);


  if (mousePressed)
  {
    speedX = mouseX / 200.0;
    speedY = mouseY / 200.0;
    speed = mag(speedX, speedY);
    clockStartV.SetEtherSpeed(speedX, speedY);
    clockStartH.SetEtherSpeed(speedX, speedY);
    clockEndV.SetEtherSpeed(speedX, speedY);
    clockEndH.SetEtherSpeed(speedX, speedY);
    a = atan2(mouseY, mouseX);
    d = dist(0, 0, mouseX, mouseY);
    
    PVector vEndV_temp = new PVector(vEndVorig.x, vEndVorig.y);
    PVector vEndH_temp = new PVector(vEndHorig.x, vEndHorig.y);
    vEndV_temp.x -= vStartV.x; vEndV_temp.y -= vStartV.y;
    vEndH_temp.x -= vStartH.x; vEndH_temp.y -= vStartH.y;
    
    var a2 = atan2(speedX, speedY);
    // LENGHT CONTRACTION
     float r = sqrt(1 - (speed * speed) / 1);//(tick * tick));
     lengthContaction = r;
     
     PMatrix2D m = new PMatrix2D();
     m.rotate(-a2);
     m.scale(1,r);
     m.rotate(a2);
     
     m.mult(vEndV_temp, vEndV);
     m.mult(vEndH_temp, vEndH);
     
     vEndV.x += vStartV.x; vEndV.y += vStartV.y;
     vEndH.x += vStartH.x; vEndH.y += vStartH.y;
  }
  
  if (start)
  {
    lightRadiusV += tick;
    lightRadiusH += tick;
    
    lightPosV.x += speedX*tick;
    lightPosV.y += speedY*tick;
    lightPosH.x += speedX*tick;
    lightPosH.y += speedY*tick;
    
    
    float rStartV = lightPosV.dist(vStartV);
    float rStartH = lightPosH.dist(vStartH);
    float rEndV = lightPosV.dist(vEndV);
    float rEndH = lightPosH.dist(vEndH);
    
    
    
    if (VStartstopped == false && VEndstopped == true && lightRadiusV >= rStartV) VStartstopped = true;
    else if (VStartstopped == false) clockStartV.Update();
    
    if (HStartstopped == false && HEndstopped == true && lightRadiusH >= rStartH) HStartstopped =  true;
    else if (HStartstopped == false) clockStartH.Update();
    
    
    if (VEndstopped == false && lightRadiusV >= rEndV)
    {
      lightPosV = new PVector(vEndV.x, vEndV.y);
      lightRadiusV = 0;
      VEndstopped = true;
    }
    else if (VEndstopped == false) clockEndV.Update();
    
    
    if (HEndstopped == false && lightRadiusH >= rEndH)
    {
      HEndstopped =  true;
      lightPosH = new PVector(vEndH.x, vEndH.y);
      lightRadiusH = 0;
    }
    else if (HEndstopped == false) clockEndH.Update();
  
    if (VStartstopped && HStartstopped && VEndstopped && HEndstopped)
    {
      start = false;
      bStart.isOn = false;
      lightRadiusV = 0;
      lightRadiusH = 0;
      lightPosV = new PVector(vStartV.x, vStartV.y);
      lightPosH = new PVector(vStartV.x, vStartV.y);
      //vEndV = new PVector(vEndVorig.x, vEndVorig.y);
      //vEndH = new PVector(vEndHorig.x, vEndHorig.y);
    }
  
  }
  
  
  
  ellipseMode(RADIUS);
  
  if (frameCount % 2 == 0)
  {
    if (VStartstopped == false || VEndstopped == false) 
    {
      stroke(255,0,0); 
      noFill(); ellipse(lightPosV.x, lightPosV.y, lightRadiusV, lightRadiusV); 
      fill(255, 0, 0, 50); ellipse(lightPosV.x, lightPosV.y, 10, 10);
    }
    if (HStartstopped == false || HEndstopped == false) 
    {
      stroke(0,0,255);
      noFill(); ellipse(lightPosH.x, lightPosH.y, lightRadiusH, lightRadiusH);
      fill(0, 0, 255, 50); ellipse(lightPosH.x, lightPosH.y, 10, 10);
    }
  }
  else
  {
    if (HStartstopped == false || HEndstopped == false) 
    {
      stroke(0,0,255);
      noFill(); ellipse(lightPosH.x, lightPosH.y, lightRadiusH, lightRadiusH);
      fill(0, 0, 255, 50); ellipse(lightPosH.x, lightPosH.y, 10, 10);
    }
    if (VStartstopped == false || VEndstopped == false) 
    {
      stroke(255,0,0); 
      noFill(); ellipse(lightPosV.x, lightPosV.y, lightRadiusV, lightRadiusV); 
      fill(255, 0, 0, 50); ellipse(lightPosV.x, lightPosV.y, 10, 10);
    }
  }
  
  
  imageMode(CENTER);
  image(clockStartV.Draw(), -150, 210, 60, 60);
  image(clockStartH.Draw(), -210, 150, 60, 60);
  image(clockEndV.Draw(), vEndV.x, vEndV.y-30, 60, 60);
  image(clockEndH.Draw(), vEndH.x+30, vEndH.y, 60, 60);
  
  if (VStartstopped == true) {stroke(200,200,0); fill(0, 255, 0); ellipse(-110, 210, 10, 10); }
  if (HStartstopped == true) {stroke(200,200,0); fill(0, 255, 0); ellipse(-210, 110, 10, 10);}
  if (VEndstopped == true) {stroke(200,200,0); fill(255, 255,0); ellipse(vEndV.x+40, vEndV.y-30, 10, 10); }
  if (HEndstopped == true) {stroke(200,200,0); fill(255, 255,0); ellipse(vEndH.x+30, vEndH.y-40, 10, 10);}
  
  noFill();
  strokeWeight(1);
  rectMode(CENTER);
  stroke(255,0,0); rect(-150, 210, 60, 60);
  stroke(0,0,255); rect(-210, 150, 60, 60);
  stroke(255,0,0); rect(vEndV.x, vEndV.y-30, 60, 60);
  stroke(0,0,255); rect(vEndH.x+30, vEndH.y, 60, 60);
  
  fill(0);
  textAlign(CENTER, CENTER);
  text(clockStartV.Count, -110, 210);
  text(clockStartH.Count, -210, 110);
  text(clockEndV.Count, vEndV.x+40, vEndV.y-30);
  text(clockEndH.Count, vEndH.x+30, vEndH.y-40);
  
  text("Relative Speed: " + nf(speed, 0, 2), 0, -8);
  text("Length contraction: " + nf(lengthContaction, 0, 2), 0, 8);
  
  pushMatrix();
  translate(0, -220);
  scale(2);
  text("Sanath's", 0, 0);
  scale(0.6);
  text("Michelson Morley experiment", 0, 20);
  text("(with Eather!)", 0, 40);
  popMatrix();
  
  fill(0, 120, 0);
  text("The two times are always the same here!!!", -130, 255);
  
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
