// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

boolean doBell = false;
boolean isQED = false;
int inputType = 0;

float rnd = 0;
float r;
ProbabilityAngle C = new ProbabilityAngle();
ProbabilityAngle Ca = new ProbabilityAngle();
ProbabilityAngle Cb = new ProbabilityAngle();
ProbabilityAngle A = new ProbabilityAngle();
ProbabilityAngle B = new ProbabilityAngle();

var angles = [(PI/2), (PI/2)+(PI*2/3), (PI/2)-(PI*2/3)];
int ar1 = 0;
int ar2 = 0;

int count = 0;
int clicks = 0;

//PGraphics2D g;
void setup()
{
  //doZoom = false; doTranslate = false; doRotate = false;
  A.colorT = color(255,0,0);
  B.colorT = color(0,255,0);
  C.showT = false;
  Ca.showT = false;
  Cb.showT = false;
  
  setSize(200, 200, P2D, FIT_INSIDE, this); // this has to be the last line in this function
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
  
  //if (g == null) {createG();}
  //if (g != null)
  //{
  //  imageMode(CENTER);
  //  image(g, 0, 0);
  //}
  
  fill(0);
  text("Bell's Inequality", -20, -80);
  
  ellipseMode(CENTER);
  if (doBell)
  {
    ar1 = (int) random(0, 3);
    ar2 = (int) random(0, 3);
    
    A.t = angles[ar1];//PI/2;
    //A.t = PI/2;
    //B.t = -((PI*2)/3);// PI/4;
    B.t = angles[ar2];//PI/4;
  }
  else
  {
    A.t = PI/2;
    //B.t = -((PI*2)/3);// PI/4;
    //B.t = PI/4;
    //B.t = A.t - PI/8;
    B.t = 0;
  }  
  //A.t = angles[ar1];//PI/2;
  //B.t = -((PI*2)/3);// PI/4;
  //B.t = angles[ar2];//PI/4;
  
  //rnd = random(0, 1.25);
  rnd = random(0, 1);
  
  if (!mousePressed)
  {  
    r = random(0, PI*2);
    //r = r+0.01;
    C.p = r;
    Ca.p = r;
    A.p = r;
    
    if (inputType == 1) r = r - (PI / 2);
    if (inputType == 2) r = random(0, PI*2);
    
    Cb.p = r;
    B.p = r;
  }
  
  pushMatrix();
  translate(-40,-60);
  scale(0.5,0.5);
  C.draw();
  popMatrix();
  
  pushMatrix();
  translate(-40,-40);
  scale(0.5,0.5);
  Ca.draw();
  popMatrix();
  
  pushMatrix();
  translate(-20,-40);
  scale(0.5,0.5);
  Cb.draw();
  popMatrix();
  
  pushMatrix();
  translate(-40,0);
  A.draw();
  popMatrix();
  
  if (isQED)
  {
    if (A.fire) B.p = A.t;
    else B.p = 0;//A.t + PI / 2;
  }
  
  pushMatrix();
  translate(40,0);
  B.draw();
  popMatrix();
  
  
  //if (A.fire) 
  count++;
  //if (A.fire != B.fire) clicks++; // produces 0.6666 classical and 1  for  Quantum
  if (A.fire && !B.fire) clicks++; // produces 0.3333 classical and 0.5 for Quantum
  
  float f = clicks / count;
  
  fill(255,0,0);
  text(f, 0, -30);
  
  fill(200);
  
  translate(0,-20);
  scale(0.5, 0.5);
  if (isQED) text("(0.5 if B Entangled to A)", 0, 0);
  else text("(0.333 with hidden variables)", 0, 0);
  
  text("(always 50%)", -35, 120);
  text("(always 50%)", 125, 120);
  
  text("source", -100, -100);
  text("A", -80, 90);
  text("B", 80, 90);
}


class ProbabilityAngle
{
  boolean fire = false;
  
  boolean showP = true;
  boolean showT = true;
  
  color colorP = color(90);
  color colorT = color(255,0,0, 90);
  
  float p = 0;
  float t = 0;
  
  int count = 0;
  int clicks = 0;
  
  void draw()
  {
    pushMatrix();
    scale(1,-1);
    
    stroke(200);
    fill(240);
    strokeWeight(0.5);
    ellipse(0,0,30,30);
    
    if (showP)
    {
      pushMatrix();
      rotate(p);
      stroke(colorP);
      strokeWeight(1);
      line(0,0,15,0);
      popMatrix();
    }
    
    if (showT)
    {
      pushMatrix();
      rotate(t);
      stroke(colorT);
      strokeWeight(1);
      line(0,0,15,0);
      popMatrix();
      
      /*float t1 = PI + t;
      float d1 = abs(p - t);
      float d2 = abs(p - t1);
      float d = d1;
      if (d2 < d1) d = d2;*/
      //float prob = abs(cos(p - t));
      //float prob = cos(d);
      float prob = cos(p - t);
      prob = prob * prob;
      
      fill(colorT);
      strokeWeight(0.01);
      rect(20,-15, 10,30*prob);
      noFill();
      stroke(0);
      strokeWeight(0.5);
      rect(20,-15, 10,30);
      
      if (prob > rnd) fire = true;
      else fire = false;
      
      count++;
      if (fire) {fill(255, 255, 0); clicks++;}
      else fill(0);
      
      stroke(200, 200, 0);
      ellipse(38, 0, 10, 10);
      
      scale(1,-1);
      float f = clicks / count;
      fill(0);
      text(f, 20, 30);
    }
    
    
    
    popMatrix();
  }
}