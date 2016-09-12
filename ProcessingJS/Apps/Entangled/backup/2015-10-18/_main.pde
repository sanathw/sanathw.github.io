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

boolean showTick = false;
PImage img;
void setup()
{
  img = loadImage("./_resources/Real.png");
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
  translate(0, -30);
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
  fill(255, 180, 180);
  textAlign(CENTER, CENTER);
  text(experiment.displayText1, 0, 145);
  text(experiment.displayText1info, 0, 158);
  fill(255, 0, 0);
  text(experiment.displayText2, 0, 175);
  scale(2,2);
  text(experiment.displayText3, 0, 100);
  
  fill(0, 0, 255);
  scale(0.4,0.4);
  text(experiment.displayText4, 0, 310);
  
  if (showTick) 
  {
    image(img, -100, 230);
    fill(230, 210, 0);
    rect(45, 240, 180, 25);
    fill(0);
    scale(1.5,1.5);
    text("REAL EXPERIMENT", 90, 168);
  }
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
      line(-15,0,15,0);
      popMatrix();
    }
    
    if (showT)
    {
      pushMatrix();
      rotate(t);
      stroke(colorT);
      strokeWeight(1);
      line(-15,0,15,0);
      popMatrix();
      
      /*float t1 = PI + t;
      float d1 = abs(p - t);
      float d2 = abs(p - t1);
      float d = d1;
      if (d2 < d1) d = d2;*/
      //float prob = abs(cos(p - t));
      //float prob = cos(d);
      float prob = cos(p - t);
      
      //prob = abs(prob); // this is the intestity when calculating
      // BUT
      // this is the intensity when FINALLY calculated...as in Feynman
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
  string displayText1info;
  string displayText2;
  string displayText3;
  string displayText4;
  
  void updatePolarizer()
  {
    angleAId = (int) (random(0, anglesA.length));
    angleBId = (int) (random(0, anglesB.length));
    angleA = anglesA[angleAId];
    angleB = anglesB[angleBId];
  }
  
  void calculate(boolean aFire, boolean bFire) {showTick = false;};
  
  void reset() {};
}

class Sanath_1 extends Experiment
{
  int count = 0;
  int clicks = 0;
  
  Sanath_1()
  {
    anglesA = [(PI/2)];
    anglesB = [0];
  }
  
  void calculate(boolean aFire, boolean bFire) 
  {
    count++;
    
    if (aFire != bFire) clicks++;
    
    float f = clicks / count;
    
    displayText1 = "A != B";
    displayText1info = "["+f.toFixed(3)+"]";
    displayText2 = "Quantum expect: 1";
    displayText3 = "" + f.toFixed(3);
    displayText4 = "";
    if (isClassicalQuantum == 1) showTick = true; else showTick = false;
  };
  
  void reset()
  {
    count = 0;
    clicks = 0;
  }
}

class Sanath_2 extends Experiment
{
  int count = 0;
  int clicks = 0;
  
  Sanath_2()
  {
    anglesA = [(PI/2)];
    anglesB = [(PI/4)];
  }
  
  void calculate(boolean aFire, boolean bFire) 
  {
    count++;
    
    if (aFire != bFire) clicks++;
    
    float f = clicks / count;
    
    displayText1 = "A != B";
    displayText1info = "["+f.toFixed(3)+"]";
    displayText2 = "If Quantum, should be different from Classical with Snap";
    displayText3 = "" + f.toFixed(3);
    displayText4 = "";
    showTick = false;
  };
  
  void reset()
  {
    count = 0;
    clicks = 0;
  }
}

class Bell_1_a extends Experiment
{
  // VERSION 1 - 15% for Quantum
  /////////////////////////////
  // http://skepticsplay.blogspot.com.au/2009/03/bells-theorem-explained.html
  // See Evernote: 'Bell's Inequality'
  // Black section - Bell's Theorem Explained
  // https://www.evernote.com/shard/s3/nl/226168/5e0a4680-63e4-46d4-beb6-dc3b1f01d255
  
  /*
  http://skepticsplay.blogspot.com.au/2009/03/bells-theorem-explained.html
  
  So let's say that we set the first detector to setting A and the second one to setting C. 
  How often is the answer to A different from the answer to C? 
  That is, how often do the electron pairs fall into the shaded region shown in figure (a)? 
  The answer is about 15% of the time, or (1-cos(45°))/2. 
  This can be predicted by quantum theory, but just as importantly, it can be directly observed with experiments.
  */
  
  int count = 0;
  int clicks = 0;
  
  Bell_1_a()
  {
     anglesA = [0];
     anglesB = [(PI/4)];
  }
  
  void calculate(boolean aFire, boolean bFire) 
  {
    count++;
    
    // SHOULD be this, but web site confuses different to fire and not the same.
    // but if it is this then you also need
    // count++;
    //if (aFire != bFire) clicks++;
    if (aFire && !bFire) clicks++;
    
    float f = clicks / count;
    
    displayText1 = "A && !C";
    displayText1info = "["+f.toFixed(3)+"]";
    displayText2 = "Quantum expect: 0.15";
    displayText3 = "" + f.toFixed(3);
    displayText4 = "http://skepticsplay.blogspot.com.au/2009/03/bells-theorem-explained.html";
    if (isClassicalQuantum == 1) showTick = true; else showTick = false;
  };
  
  void reset()
  {
    count = 0;
    clicks = 0;
  }
}

class Bell_1_b extends Experiment
{
  // VERSION 1 - 15% for Quantum
  /////////////////////////////
  // http://skepticsplay.blogspot.com.au/2009/03/bells-theorem-explained.html
  // See Evernote: 'Bell's Inequality'
  // Black section - Bell's Theorem Explained
  // https://www.evernote.com/shard/s3/nl/226168/5e0a4680-63e4-46d4-beb6-dc3b1f01d255
  
  /*
  http://skepticsplay.blogspot.com.au/2009/03/bells-theorem-explained.html
  
  What happens if we set the first detector to B, 
  and the second detector to C, 
  and we ask how often the two detectors give different answers? 
  That is, how often do the electron pairs fall into the shaded region in figure (b)? 
  Again, the answer is 15%.
  */
  
  int count = 0;
  int clicks = 0;
  
  Bell_1_b()
  {
     anglesA = [(PI/2)];
     anglesB = [(PI/4)];
  }
  
  void calculate(boolean aFire, boolean bFire) 
  {
    count++;
    
    // SHOULD be this, but web site confuses different to fire and not the same.
    // but if it is this then you also need
    // count++;
    //if (aFire != bFire) clicks++;
    if (aFire && !bFire) clicks++;
    
    float f = clicks / count;
    
    displayText1 = "B && !C";
    displayText1info = "["+f.toFixed(3)+"]";
    displayText2 = "Quantum expect: 0.15";
    displayText3 = "" + f.toFixed(3);
    displayText4 = "http://skepticsplay.blogspot.com.au/2009/03/bells-theorem-explained.html";
    if (isClassicalQuantum == 1) showTick = true; else showTick = false;
  };
  
  void reset()
  {
    count = 0;
    clicks = 0;
  }
}

class Bell_1_c extends Experiment
{
  // VERSION 1 - 50% for Quantum
  /////////////////////////////
  // http://skepticsplay.blogspot.com.au/2009/03/bells-theorem-explained.html
  // See Evernote: 'Bell's Inequality'
  // Black section - Bell's Theorem Explained
  // https://www.evernote.com/shard/s3/nl/226168/5e0a4680-63e4-46d4-beb6-dc3b1f01d255
  
  /*
  http://skepticsplay.blogspot.com.au/2009/03/bells-theorem-explained.html
  
  To summarize:
  (a) Detectors A and C give different answers: 15%
  (b) Detectors B and C give different answers: 15%
  (c) The union of (a) and (b): At most 30%

  Now, what happens if we set the first detector to A and the second detector to B? 
  How often will the two detectors give different answers? 
  If they give different answers, then the electron pair must fall somewhere in the shaded region of (c). 
  Therefore, it couldn't happen more than 30%, right? 
  Wrong! 
  Both quantum theory and experiment show that the answers to A and B are different 50% of the time. 
  We've run into a mathematical contradiction!
  */
  
  int count = 0;
  int clicks = 0;
  
  Bell_1_c()
  {
     anglesA = [0];
     anglesB = [(PI/2)];
  }
  
  void calculate(boolean aFire, boolean bFire) 
  {
    count++;
    
    // SHOULD be this, but web site confuses different to fire and not the same.
    // but if it is this then you also need
    // count++;
    //if (aFire != bFire) clicks++;
    if (aFire && !bFire) clicks++;
    
    float f = clicks / count;
    
    displayText1 = "A && !B";
    displayText1info = "["+f.toFixed(3)+"]";
    displayText2 = "Quantum expect: 0.5";
    displayText3 = "" + f.toFixed(3);
    displayText4 = "http://skepticsplay.blogspot.com.au/2009/03/bells-theorem-explained.html";
    if (isClassicalQuantum == 1) showTick = true; else showTick = false;
  };
  
  void reset()
  {
    count = 0;
    clicks = 0;
  }
}

class Bell_2 extends Experiment
{
    // VERSION 2 - 25% for Quantum
    /////////////////////////////
    // http://www.drchinese.com/David/Bell_Theorem_Easy_Math.htm
    // https://www.youtube.com/watch?v=qd-tKr0LJTM
    // See Evernote: 'My Quantum Entanglement'
    // LOOKUP TABLE at the bottom 
    // https://www.evernote.com/shard/s3/nl/226168/19680cde-7af5-4291-9319-aa56c8fb0a3f
    // http://www.drchinese.com/David/Bell_Theorem_Easy_Math.htm
    // See Evernote: 'Bell's Inequality'
    // 'Bell's Theorem with Easy Math' at the bottom
    // https://www.evernote.com/shard/s3/nl/226168/5e0a4680-63e4-46d4-beb6-dc3b1f01d255
    // A and B same
  
  
  /*
  The fact that the matches should occur greater than or equal to 1/3 of the time is called Bell's Inequality. 
  More specifically, the value of Bell's Inequality at 120 degrees is 1/3 (at least in this formulation 
  - there are other formulations that accomplish the same basic result). 
  We have deduced this requirement simply from assuming simultaneous Hidden Variables per a. above. 
  (In fact, this minimum value actually applies to ANY 3 angles that we could choose, not just the 0/120/240 degree cases shown above. 
  However, we chose these angles for a reason which will become clear below.) 

  c. Importantly, Bell also noticed that QM predicts that the actual value will be .250, 
  which is LESS than the "Hidden Variables" predicted value of at least .333. 
  It doesn't really matter where the QM predicted value of .250 comes from, but I'll tell you anyway: 
  it is the square of the cosine of the angle between the 2 polarizer settings, 
  which is 120 degrees (regardless of whether we are talking about [AB], [BC], or [AC]). 
  The cosine of 120 degrees is -.500 
  (you can look that up on your computer's calculator - type in 120 and press COS); 
  and that squared (-.500 x -.500) is .250 (or 1/4). Not too hard! 
  */
  
  int count = 0;
  int ABclicks = 0;
  int BCclicks = 0;
  int ACclicks = 0;
  
  Bell_2()
  {
    anglesA = [0, (PI * 2 /3), (PI * 4 /3)];
    anglesB = [0, (PI * 2 /3), (PI * 4 /3)];
  }
  
  void calculate(boolean aFire, boolean bFire) 
  {
    count++;
    
    //AB
    if ((angleAId == 0 && angleBId == 1) || (angleAId == 1 && angleBId == 0))
    {
      if (aFire == bFire) ABclicks++;
    }
    
    //BC
    if ((angleAId == 1 && angleBId == 2) || (angleAId == 2 && angleBId == 1))
    {
      if (aFire == bFire) BCclicks++;
    }
    
    //AC
    if ((angleAId == 0 && angleBId == 2) || (angleAId == 2 && angleBId == 0))
    {
      if (aFire == bFire) ACclicks++;
    }
    
    float fAB = ABclicks / count;
    float fBC = BCclicks / count;
    float fAC = ACclicks / count;
    float f = fAB + fBC + fAC;
    
    displayText1 = "AB + BC + AC";
    displayText1info = "["+fAB.toFixed(3)+"] + " + "["+fBC.toFixed(3)+"] + " + "["+fAC.toFixed(3)+"]";
    displayText2 = "Classical expect: > 0.3333, Quantum expect: 0.25";
    displayText3 = "" + f.toFixed(3);
    displayText4 = "http://www.drchinese.com/David/Bell_Theorem_Easy_Math.htm";
    if (isClassicalQuantum == 1) showTick = true; else showTick = false;
  };
  
  void reset()
  {
    count = 0;
    ABclicks = 0;
    BCclicks = 0;
    ACclicks = 0;
  }
}

class Bell_3 extends Experiment
{
  int count = 0;
  int ABclicks = 0;
  int BCclicks = 0;
  int ACclicks = 0;
  
  Bell_3()
  {
    anglesA = [0,        (PI / 3), 0];
    anglesB = [(PI / 3), (PI / 9), (PI / 9)];
  }
  
  void updatePolarizer()
  {
    angleAId = (int) (random(0, 3));
    angleBId = angleAId;
    angleA = anglesA[angleAId];
    angleB = anglesB[angleBId];
  }
  
  void calculate(boolean aFire, boolean bFire) 
  {
    count++;
    
    //AB
    if (angleAId == 0)
    {
      if (aFire && bFire) ABclicks++;
    }
    
    //B != C
    if (angleAId == 1)
    {
      if (!aFire && bFire) BCclicks++;
    }
    
    //AC
    if (angleAId == 2)
    {
      if (aFire && bFire) ACclicks++;
    }
    
    float fAB = ABclicks / count;
    float fBC = BCclicks / count;
    float fAC = ACclicks / count;
    float f = fAB + fBC - fAC;
    
    displayText1 = "[AB] + [B != C] - [AC]";
    displayText1info = "["+fAB.toFixed(3)+"] + " + "["+fBC.toFixed(3)+"] - " + "["+fAC.toFixed(3)+"]";
    displayText2 = "Classical expect: > 0, Quantum expect: -ve";
    displayText3 = "" + f.toFixed(3);
    displayText4 = "Book: Quantum Physics - Illusion or Reality, Second Edition, Alastair Rae p40-p44";
    if (isClassicalQuantum == 1) showTick = true; else showTick = false;
  };
  
  void reset()
  {
    count = 0;
    ABclicks = 0;
    BCclicks = 0;
    ACclicks = 0;
  }
}

class Bell_4_a extends Experiment
{
// Evernote:
// https://www.evernote.com/shard/s3/nl/226168/614ce523-2101-435c-bdd3-2d815f2dc9c1
// Entanglement - Bell's Inequality
// Jim Al-Khalili:
// https://www.youtube.com/watch?v=inO8v0lTsjE
//Albert Einstein The Secrets of Quantum Physics Science Full
  int ACcount = 0;
  int BAcount = 0;
  int BCcount = 0;
    
  int ACclicks = 0;
  int BAclicks = 0;
  int BCclicks = 0;
  
  Bell_4_a()
  {   
    anglesA = [(PI / 2), 0       , 0];
    anglesB = [(PI / 3), (PI / 2), (PI / 3)];
  }
  
  void updatePolarizer()
  {
    angleAId = (int) (random(0, 3));
    angleBId = angleAId;
    angleA = anglesA[angleAId];
    angleB = anglesB[angleBId];
  }
  
  void calculate(boolean aFire, boolean bFire) 
  {
    //AC
    if (angleAId == 0)
    {
      ACcount++;
      if (aFire == bFire) ACclicks++;
    }
    
    //BA
    if (angleAId == 1)
    {
      BAcount++;
      if (aFire == bFire) BAclicks++;
    }
    
    //BC
    if (angleAId == 2)
    {
      BCcount++;
      if (aFire == bFire) BCclicks++;
    }
    
    float f = 0;
    float fAC = 0;
    float fBA = 0;
    float fBC = 0;
    
    if (ACcount > 0 && BAcount > 0 && BCcount > 0)
    {
      fAC = ACclicks / ACcount;
      fBA = BAclicks / BAcount;
      fBC = BCclicks / BCcount;
      f = fAC - fBA - fBC;
    }
    
    displayText1 = "[AC] - [BA] - [BC]";
    displayText1info = "["+fAC.toFixed(3)+"] - " + "["+fBA.toFixed(3)+"] - " + "["+fBC.toFixed(3)+"]";
    displayText2 = "Classical expect: < 1, Quantum expect: +ve";
    displayText3 = "" + f.toFixed(3);
    displayText4 = "Jim Al-Khalili: https://www.youtube.com/watch?v=inO8v0lTsjE  46:36";
    if (isClassicalQuantum == 1) showTick = true; else showTick = false;
  };
  
  void reset()
  {
    ACcount = 0;
    BAcount = 0;
    BCcount = 0;
    ACclicks = 0;
    BAclicks = 0;
    BCclicks = 0;
  }
}

class Bell_4_b extends Experiment
{
// Evernote:
// https://www.evernote.com/shard/s3/nl/226168/614ce523-2101-435c-bdd3-2d815f2dc9c1
// Entanglement - Bell's Inequality
// Jim Al-Khalili:
// https://www.youtube.com/watch?v=inO8v0lTsjE
//Albert Einstein The Secrets of Quantum Physics Science Full

  int A0B0count = 0;
  int A0B1count = 0;
  int A1B0count = 0;
  int A1B1count = 0;

  int A0B0clicks = 0;
  int A0B1clicks = 0;
  int A1B0clicks = 0;
  int A1B1clicks = 0;
  
  Bell_4_b()
  {
    anglesA = [0,        0,    ((PI /2)+(PI / 7)), ((PI /2)+(PI / 7))];
    anglesB = [(PI / 4), -0.4, (PI / 4),           -0.4];
  }
  
  void updatePolarizer()
  {
    angleAId = (int) (random(0, 4));
    angleBId = angleAId;
    angleA = anglesA[angleAId];
    angleB = anglesB[angleBId];
  }
  
  void calculate(boolean aFire, boolean bFire) 
  {
    //A0B0
    if (angleAId == 0)
    {
      A0B0count++;
      if (aFire == bFire) A0B0clicks++;
      else A0B0clicks--;
    }
    
    //A0B1
    if (angleAId == 1)
    {
      A0B1count++;
      if (aFire == bFire) A0B1clicks++;
      else A0B1clicks--;
    }
    
    //A1B0
    if (angleAId == 2)
    {
      A1B0count++;
      if (aFire == bFire) A1B0clicks++;
      else A1B0clicks--;
    }
    
    //A1B1
    if (angleAId == 3)
    {
      A1B1count++;
      if (aFire == bFire) A1B1clicks++;
      else A1B1clicks--;
    }
    
    float fA0B0 = 0;
    float fA0B1 = 0;
    float fA1B0 = 0;
    float fA1B1 = 0;
    float f = 0;
    
    
    if (A0B0count > 0 && A0B1count > 0 && A1B0count > 0 && A1B1count > 0)
    {
      fA0B0 = A0B0clicks / A0B0count;
      fA0B1 = A0B1clicks / A0B1count;
      fA1B0 = A1B0clicks / A1B0count;
      fA1B1 = A1B1clicks / A1B1count;
      f = fA0B0 + fA0B1 - fA1B0 + fA1B1;
    }
    
    displayText1 = "[A0B0] + [A0B1] - [A1B0] + [A1B1]";
    displayText1info = "["+fA0B0.toFixed(3)+"] + " + "["+fA0B1.toFixed(3)+"] - " + "["+fA1B0.toFixed(3)+"] + " + "["+fA1B1.toFixed(3)+"]";
    displayText2 = "Classical expect: < 2, Quantum expect: > 2";
    displayText3 = "" + f.toFixed(3);
    displayText4 = "Jim Al-Khalili: https://www.youtube.com/watch?v=inO8v0lTsjE  52:08";
    if (isClassicalQuantum == 1) showTick = true; else showTick = false;
  };
  
  void reset()
  {
    A0B0count = 0;
    A0B1count = 0;
    A1B0count = 0;
    A1B1count = 0;

    A0B0clicks = 0;
    A0B1clicks = 0;
    A1B0clicks = 0;
    A1B1clicks = 0;
  }
}

class Bell_5 extends Experiment
{
  int count = 0;
  int ABclicks = 0;
  int BCclicks = 0;
  int ACclicks = 0;
  
  Bell_5()
  {
    anglesA = [0,        (PI / 4), 0];
    anglesB = [(PI / 4), (PI / 2), (PI / 2)];
  }
  
  void updatePolarizer()
  {
    angleAId = (int) (random(0, 3));
    angleBId = angleAId;
    angleA = anglesA[angleAId];
    angleB = anglesB[angleBId];
  }
  
  void calculate(boolean aFire, boolean bFire) 
  {
    count++;
    
    //AB
    if (angleAId == 0)
    {
      if (aFire != bFire) ABclicks++;
    }
    
    //B != C
    if (angleAId == 1)
    {
      if (aFire != bFire) BCclicks++;
    }
    
    //AC
    if (angleAId == 2)
    {
      if (aFire != bFire) ACclicks++;
    }
    
    float fAB = ABclicks / count;
    float fBC = BCclicks / count;
    float fAC = ACclicks / count;
    float f = fAB + fBC - fAC;
    
    // Same as A!B + B!C >= A!C
    displayText1 = "[A !B] + [B !C] - [A !C]";
    displayText1info = "["+fAB.toFixed(3)+"] + " + "["+fBC.toFixed(3)+"] - " + "["+fAC.toFixed(3)+"]";
    displayText2 = "Classical expect: > 0, Quantum expect: -ve";
    displayText3 = "" + f.toFixed(3);
    displayText4 = "Bell's original equation";
    if (isClassicalQuantum == 1) showTick = true; else showTick = false;
  };
  
  void reset()
  {
    count = 0;
    ABclicks = 0;
    BCclicks = 0;
    ACclicks = 0;
  }
}



