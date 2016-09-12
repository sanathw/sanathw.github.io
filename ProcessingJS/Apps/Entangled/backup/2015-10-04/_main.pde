// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

int experimentId = 0;
Experiment experiment;

ProbabilityAngle C = new ProbabilityAngle();
ProbabilityAngle Ca = new ProbabilityAngle();
ProbabilityAngle Cb = new ProbabilityAngle();

ProbabilityAngle A = new ProbabilityAngle();
ProbabilityAngle B = new ProbabilityAngle();

// using same random for A and B 
float rnd = 0; 

int isSyncOppRandom = 0;
int isClassicalQuantum = 0;
int isStandardSnap = 0;

void setup()
{
  C.showT = false;
  Ca.showT = false;
  Cb.showT = false;
  
  A.colorT = color(255,0,0);
  B.colorT = color(0,255,0);
  
  createExperiment();

  setSize(200, 200, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g) { g.background(255); }

void draw()
{
  initDraw();
  fill(0); ellipseMode(CENTER); text("Bell's Inequality", -20, -80);

  experiment.updatePolarizer();
  A.t = experiment.angleA;
  B.t = experiment.angleB;
  
  rnd = random(0, 1);
  
   if (!mousePressed)
   {      
     // Photon To Alice
     float rA = random(0, PI*2);
     C.p = rA;
     Ca.p = rA;
     A.p = rA;
     
     // Photon To Bob
     float rB;
     if (isSyncOppRandom == 0) rB = rA; // same
     if (isSyncOppRandom == 1) rB = rA + (PI / 2); // opposite
     if (isSyncOppRandom == 2) rB = random(0, PI*2); // random
     Cb.p = rB;
     B.p = rB;
   }
  
  // Photon At Alice
   DrawProbabilityAngle(C, -40, -60, 0.5);
   DrawProbabilityAngle(Ca, -40, -40, 0.5);
   DrawProbabilityAngle(A, -40, 0, 1);
  
  // Photon At Bob
  if (isClassicalQuantum == 0) {B.p = B.p;}
  if (isClassicalQuantum == 1) {if (A.fire) B.p = A.t; else B.p = A.t + PI / 2;}
  DrawProbabilityAngle(Cb, -20, -40, 0.5);
  DrawProbabilityAngle(B, 40, 0, 1);
  
  //textMode(LEFT, CENTER);
  fill(200); translate(0,-20); scale(0.5, 0.5);
  text("source", -100, -100);
  text("A", -80, 90);
  text("B", 80, 90);
  text("(always 50%)", -35, 120);
  text("(always 50%)", 125, 120);
  
  
  experiment.calculate(A.fire, B.fire);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  text(experiment.displayText1, 0, 150);
  text(experiment.displayText2, 0, 170);
  scale(2,2);
  text(experiment.displayText3, 0, 100);
  
  
  // if (isQED)
  // {
    // if (A.fire) B.p = A.t;
    // else B.p = A.t + PI / 2;
  // }
   
  
  // if (doBell)
  // // {
  // // //count++;
  // // //if (ar1 != ar2)
  // // //{
    // // count++;
    
    
    // // // VERSION 1 - 50% for Quantum
    // // /////////////////////////////
    // // // http://skepticsplay.blogspot.com.au/2009/03/bells-theorem-explained.html
    // // // See Evernote: 'Bell's Inequality'
    // // // Black section - Bell's Theorem Explained
    // // // https://www.evernote.com/shard/s3/nl/226168/5e0a4680-63e4-46d4-beb6-dc3b1f01d255
    // // // A and not B
    // // if ((ar1 == 0 && ar2 == 1) || (ar1 == 1 && ar2 == 0))
    // // {
      // // if (A.fire != B.fire) AnotB++; //0.15 (~15%) obsereved
    // // }
    
    // // // B and not C
    // // if ((ar1 == 1 && ar2 == 2) || (ar1 == 2 && ar2 == 1))
    // // {
      // // if (A.fire != B.fire) BnotC++; //0.15 (~15%) obsereved
    // // }
    
    // // // A and not C
    // // if ((ar1 == 0 && ar2 == 2) || (ar1 == 2 && ar2 == 0))
    // // {
      // // if (A.fire != B.fire) AnotC++; //0.15 (~15%) observed
    // // }
    
    // // if 
    // // (
    // // ((ar1 == 0 && ar2 == 1) || (ar1 == 1 && ar2 == 0))
    // // ||
    // // ((ar1 == 1 && ar2 == 2) || (ar1 == 2 && ar2 == 1))
    // // ||
    // // ((ar1 == 0 && ar2 == 2) || (ar1 == 2 && ar2 == 0))
    // // )
    // // {
      // // if (A.fire != B.fire) ABC++; // cannot be > 0.3 (~30%) if classical
                                   // // // but is actually 0.5 (~50%) for Quantum
    // // }
    // // /////////////////////////////
    
    
    // // // VERSION 2 - 25% for Quantum
    // // /////////////////////////////
    // // // http://www.drchinese.com/David/Bell_Theorem_Easy_Math.htm
    // // // https://www.youtube.com/watch?v=qd-tKr0LJTM
    // // // See Evernote: 'My Quantum Entanglement'
    // // // LOOKUP TABLE at the bottom 
    // // // https://www.evernote.com/shard/s3/nl/226168/19680cde-7af5-4291-9319-aa56c8fb0a3f
    // // // http://www.drchinese.com/David/Bell_Theorem_Easy_Math.htm
    // // // See Evernote: 'Bell's Inequality'
    // // // 'Bell's Theorem with Easy Math' at the bottom
    // // // https://www.evernote.com/shard/s3/nl/226168/5e0a4680-63e4-46d4-beb6-dc3b1f01d255
    // // // A and B same
    // // if ((ar1 == 0 && ar2 == 1) || (ar1 == 1 && ar2 == 0))
    // // {
      // // if (A.fire == B.fire) clicks++;
    // // }
    
    // // // B and C same
    // // if ((ar1 == 1 && ar2 == 2) || (ar1 == 2 && ar2 == 1))
    // // {
      // // if (A.fire == B.fire) clicks++;
    // // }
    
    // // // A and C same
    // // if ((ar1 == 0 && ar2 == 2) || (ar1 == 2 && ar2 == 0))
    // // {
      // // if (A.fire == B.fire) clicks++;
    // // }
    // // // expect total > 0.333 (~1/3) if classical
    // // // but is actually 0.25 (~1/4) for Quantum
    
    
    // // /*if ((A.fire == B.fire))
    // // {
    // // //clicks++;
    
    // // // don't know why I need to 2 times the clicks (i.e. double the probability)
    // // //if ((ar1 == 0 && ar2 == 1) || (ar1 == 1 && ar2 == 2) || (ar1 == 0 && ar2 == 2)) {clicks++;clicks++;}
    // // //(AB) (BC) (AC)
    
    // // //if (ar1 == 0 && ar2 != 2) clicks--;
    // // }
    // // }*/
    // // /////////////////////////////
    
    
    // // /*
    // // // VERSION 3 - A!B + B!C >= A!C for Classical
    // // /////////////////////////////
    // // // A and not B
    // // if ((ar1 == 0 && ar2 == 1))
    // // {
      // // if (A.fire && !B.fire) Left++;
    // // }
    // // if ((ar1 == 1 && ar2 == 0))
    // // {
      // // if (!A.fire && B.fire) Left++;
    // // }
    
    // // // B and not C
    // // if ((ar1 == 1 && ar2 == 2))
    // // {
      // // if (A.fire && !B.fire) Left++;
    // // }
    // // if ((ar1 == 2 && ar2 == 1))
    // // {
      // // if (!A.fire && B.fire) Left++;
    // // }
    
    // // // A and not C
    // // if ((ar1 == 0 && ar2 == 2))
    // // {
      // // if (A.fire && !B.fire) Right++;
    // // }
    // // if ((ar1 == 2 && ar2 == 0))
    // // {
      // // if (!A.fire &&B.fire) Right++;
    // // }
    // // /////////////////////////////
    // // */
    
    
    // // // VERSION 3 - >2 for Quantum
    // // /////////////////////////////
    // // //http://qudev.ethz.ch/content/courses/QSIT10/presentations/QSIT-BellsInequality.pdf
    
    // // // A and B same
    // // if ((ar1 == 0 && ar2 == 1) || (ar1 == 1 && ar2 == 0))
    // // {
      // // if (A.fire == B.fire) clicks2++;
      // // else clicks2--;
    // // }
    
    // // // B and C different
    // // if ((ar1 == 1 && ar2 == 2) || (ar1 == 2 && ar2 == 1))
    // // {
      // // if (A.fire != B.fire) clicks2++;
      // // else clicks2--;
    // // }
    
    // // // A and C same
    // // if ((ar1 == 0 && ar2 == 2) || (ar1 == 2 && ar2 == 0))
    // // {
      // // if (A.fire == B.fire) clicks2++;
      // // else clicks2--;
    // // }
    // // /////////////////////////////
    
    
    // // /*
    // // // VERSION 3 - >2 for Quantum
    // // /////////////////////////////
    // // // A and B same
    // // if ((ar1 == 0 && ar2 == 1) || (ar1 == 1 && ar2 == 0))
    // // {
      // // if (A.fire == B.fire) clicks2++;
    // // }
    
    // // // B and C different
    // // if ((ar1 == 1 && ar2 == 2) || (ar1 == 2 && ar2 == 1))
    // // {
      // // if (A.fire != B.fire) clicks2++;
    // // }
    
    // // // A and C same
    // // if ((ar1 == 0 && ar2 == 2) || (ar1 == 2 && ar2 == 0))
    // // {
      // // if (A.fire == B.fire) clicks2++;
    // // }
    // // /////////////////////////////
    // // */
  

  // // }
  // // else
  // // {
    // // count++;
    // // //if (A.fire != B.fire) clicks++; // produces 0.6666 classical and 1  for  Quantum
    // // if (A.fire && !B.fire) clicks++; // produces 0.3333 classical and 0.5 for Quantum
  // // }
  
  // // float f = clicks / count;
  
  // // float fAnotB = AnotB / count;
  // // float fBnotC = BnotC / count;
  // // float fAnotC = AnotC / count;
  // // float fABC = ABC / count;
  
  // // float f2 = clicks2;// / count;
  
  // // float fLeft = Left / count;
  // // float fRight = Right / count;
  
  // // string s = "";
  
  // // if (doBell)
  // // {
    // // s = "A!B=" + fAnotB.toFixed(2) + " B!C=" + fBnotC.toFixed(2) + " A!C=" + fAnotC.toFixed(2) + "   ABC=" + fABC.toFixed(2) + "   f=" + f.toFixed(2) + "   f2=" + f2.toFixed(2) + "   Left " + fLeft.toFixed(2) + " >  Right " + fRight.toFixed(2);
  // // }
  // // else
  // // {
    // // s = "" + f.toFixed(2);
  // // }
  
  // // fill(255,0,0); text(s, 0, -30);
  
  // // fill(200); translate(0,-20); scale(0.5, 0.5);
  
  // // if (doBell)
  // // {
    // // if (isQED) text("(0.25 (<0.333) if B Entangled to A)", 0, 0);
    // // else text("(>= 0.333 with hidden variables)", 0, 0);
  // // }
  // // else
  // // {
    // // if (isQED) text("(0.5 if B Entangled to A)", 0, 0);
    // // else text("(0.333 with hidden variables)", 0, 0);
  // // }
  
  
  
   

}

////////////////////////////////////////////////////////////////////
void DrawProbabilityAngle(ProbabilityAngle p, int x, int y, float s)
{
  pushMatrix();
  translate(x,y);
  scale(s,s);
  p.draw();
  popMatrix();
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
      
      if (isClassicalQuantum == 1) {fire = (prob > rnd);}
      else
      {
        if (isStandardSnap == 0) { fire = (prob > rnd); }
        if (isStandardSnap == 1) { fire = (prob > 0.5); }
      }
      
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
////////////////////////////////////////////////////////////////////

class Experiment
{
  var anglesA;
  var anglesB;
  
  int angleAId;
  int angleBId;
  float angleA;
  float angleB;
  
  string displayText1;
  string displayText2;
  string displayText3;
  
  void updatePolarizer()
  {
    int angleAId = (int) (random(0, anglesA.length));
    int angleBId = (int) (random(0, anglesB.length));
    angleA = anglesA[angleAId];
    angleB = anglesB[angleBId];
  }
  
  void calculate(boolean aFire, boolean bFire) {};
  
  void reset() {};
}

class Sanath1 extends Experiment
{
  int count = 0;
  int clicks = 0;
  
  Sanath1()
  {
    anglesA = [(PI/2)];
    anglesB = [0];
  }
  
  void calculate(boolean aFire, boolean bFire) 
  {
    count++;
    
    if (aFire && !bFire) clicks++;
    
    float f = clicks / count;
    
    displayText1 = "A & !B";
    displayText2 = "0.333 clasical, 0.5 quantum";
    displayText3 = "" + f.toFixed(3);
  };
  
  void reset()
  {
    count = 0;
    clicks = 0;
  }
}

class Sanath2 extends Experiment
{
  int count = 0;
  int clicks = 0;
  
  Sanath2()
  {
    anglesA = [(PI/2)];
    anglesB = [(PI/4)];
  }
  
  void calculate(boolean aFire, boolean bFire) 
  {
    count++;
    
    if (aFire && !bFire) clicks++;
    
    float f = clicks / count;
    
    displayText1 = "A & !B";
    displayText2 = "0.166 clasical, 0.25 quantum";
    displayText3 = "" + f.toFixed(3);
  };
  
  void reset()
  {
    count = 0;
    clicks = 0;
  }
}

class Bell1 extends Experiment
{
  Bell1()
  {
  }

  void calculate(boolean aFire, boolean bFire) 
  {
  };
  
  void reset()
  {
  }
}

class Bell2 extends Experiment
{
  Bell2()
  {
  }
  
  void calculate(boolean aFire, boolean bFire) 
  {
  };
  
  void reset()
  {
  }
}

class Bell3 extends Experiment
{
  Bell3()
  {
  }
  
  void calculate(boolean aFire, boolean bFire) 
  {
  };
  
  void reset()
  {
  }
}




