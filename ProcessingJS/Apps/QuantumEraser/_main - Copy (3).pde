// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................


// NOTE: This is a MACH-ZEHNDER Inteferometer
// Reflecting from the FRONT or BACK of the glass MATTERS!!!
// A normal mirror reflects from the front
// A semi-transparent mirror (in this experiment) reflects from the back.
// 1) When reflecting...Add a Phase change (based on wavelength...e.g. 0.5 wavelwngth).
//   The amount depends the difference in refractive index between the mirror material
//   and the materal behind it.
//   A normal mirror has material behind it...so it changes phase by 180 degrees (PI)
//   A semi-transparent mirror (if reflected from the back) has NO material...so 0 phase change.
// 2) When going through glass add a constant k
//   A normal ideal mirror has no glass...so no k
//   A semi-transparent mirror (if reflected from the back has) has 2*k phase shift
//   because it needs to go through the lass twice.
// So phase shift for:
// For a Normal Mirror Front Reflection = 0.5 * wavelength  (i.e. PI if frequency is 2PI...as used in sin or cos below)
// For a Semi Transparent Back Reflection = 2 * k (i.e. going through the glass twice...and not dependent on frequency...since no back to mirror)
// For a Semi Transparent Through = k (i.e. going through the glass once)
// (Semi Transparent Front Reflection = same as Front Reflection)
//
// This is why when the second semi-transparent mirror is there, 
// D2 is 0 all the time!
//   Because it cancells out - due to INTERFERENCE
//   The blue path is F F B
//   The red path is  T F T
//   (And if we ignore T - i.e. by assuming k = 0, then the T's dissapear and B - which is 2*k also disspears,
//    Then the difference between the two baths becomes F (i.e PI, i.e. 180 degrees)....therefore CANCELLING OUT!)
// D1 is 1 all the time!
//   Because the two paths ADD together:
//   The blue path is F F T
//   The red path is  T F F
//   (Which is the SAME....so it ADDS UP!)
//
// If the second semi-transparent mirror is not there, 
// then there is only one path to each detector...so no interference in either.
// Therefore the probability vecotrs (reduced at the begining) only just spin.
// Resulting in 50% 50% for each detector.
//
// See Wikipedia for 'MACH-ZEHNDER Inteferometer'
// Also see: 
// Grover’s Quantum Search Algorithm
// posted by Craig Gidney on March 5, 2013
// http://twistedoakstudios.com/blog/Post2644_grovers-quantum-search-algorithm
// See Evernote:
//Quantum Physics - Two Slit Experiment
//Quantum Eraser
// https://en.wikipedia.org/wiki/Delayed_choice_quantum_eraser


// mousePressed, mouseX, mouseY
// debug by println();

//PGraphics2D g;

int detectorDistance = 0;
boolean start = false;
boolean useMirror = false;
boolean graph = false;
boolean fast = false;
boolean secondMirrorBackReflect = true; // If true, then Transparent value makes a difference..otherwise it doesn't.
                                          // The normal setup is back reflect

boolean firstMirrorBackReflect = false;
                                          
boolean fire = false;
float d1p = 0;
float d2p = 0;
boolean detector2On = false;

float[] d1Data = new float[60];
float[] d2Data = new float[60];

// ################################################################
// ##### THIS IS WHAT GIVES THE INTERFERENCE
// Otherwise it is symetrical to both detectors
// and the distance is the same!
float Front_reflect = PI;//0.5;  // #######  CHANGES WAVE PHASE by 180 degrees (offset)
float through = 0.085;//0.3; // #######  CHANGES WAVE FREQUENCY
float Back_reflect = through + through;

// 1. Clock Shrink = Probability / SQRT(OutcomeCount)
// 2. Clock Rotation = (m x^2) / (2ht) 
// 3. New Propbability = sum of the vectors above then square

// We are going to ignore m, h ad t.
// Time is not important because we will just wait for the detector go off or not.
// m and h are not important because they are constants.
// ################################################################


void setup()
{
  clearGraphs();
  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(300, 200, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void clearGraphs()
{
  for (int i = 0; i < 60; i++)
  {
    d1Data[i] = 0;
    d2Data[i] = 0;
  }
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
  
  /////////////////////////////////////////////////////
  // possible vectors to detectors 1 and 2 when mirror there
  PVector d1v1 = new PVector(0, 1);
  PVector d1v2 = new PVector(0, 1);
  PVector d2v1 = new PVector(0, 1);
  PVector d2v2 = new PVector(0, 1);
  float d1x1 = 0;
  float d1x2 = 0;
  float d1a1 = 0;
  float d1a2 = 0;

  float d2x1 = 0;
  float d2x2 = 0;
  float d2a1 = 0;
  float d2a2 = 0;

  // possible vectors to detectors 1 and 2 when mirror not there
  PVector d1v0 = new PVector(0, 1);
  PVector d2v0 = new PVector(0, 1);
  float d1x0 = 0;
  float d1a0 = 0;

  float d2x0 = 0;
  float d2a0 = 0;
  
  // 1. shrink to the 2 possible outcomes with 2 paths (if mirror is there);
  // see in Evernote: 'Quantum Physics - Two Slit Experiment'
  d1v1.div(sqrt(2)); d1v1.div(2);
  d1v2.div(sqrt(2)); d1v2.div(2);
  
  d2v1.div(sqrt(2)); d2v1.div(2);
  d2v2.div(sqrt(2)); d2v2.div(2);
  
  // 1. shrink to the 2 possible outcomes  with 1 path(if mirror is not there);
  // see in Evernote: 'Quantum Physics - Two Slit Experiment'
  d1v0.div(sqrt(2));
  d2v0.div(sqrt(2));
  ////////////////////////////////
  
  
  int d1x = 80+detectorDistance;
  int d2y = -40-detectorDistance;
  
  fire = false;
  
  if (start)
  {
  
    stroke(255, 190, 0);
    strokeWeight(1);
    line(-85,60, -70, 60 + -20);
    line(-85,60, -70, 60 + -10);
    line(-85,60, -70, 60 + 10);
    line(-85,60, -70, 60 + 20);
  
    if (fast) fire = true;
    else
    {
      if (frameCount % 10 == 0) fire = true;
    }
  }
  
  if (fire)
  {
    
  
    ///////////////////////////////
    // D1
    // blue
    //       X(laser-semimirror)     + Front_reflect
    //     + Y(semimirror-topmirror) + Front_reflect
    //     + X(topmirror-semimirror) + through
    //     + X(semimirror-detector)
    d1x1 =   80 //+ Front_reflect
           + 60 //+ Front_reflect
           + 60 //+ through
           + (d1x-40);
    
    //d1a1 = Front_reflect + Front_reflect + through;
    if (firstMirrorBackReflect) d1a1 += Back_reflect;
    else d1a1 += Front_reflect;
    d1a1 += Front_reflect;
    d1a1 += through;
    
    // red
    //       X(laser-semimirror)        + through
    //     + X(semimirror-bottommirror) + Front_reflect
    //     + Y(bottommirror-semimirror) + Front_reflect
    //     + X(semimirror-detector)
    d1x2 =   80 //+ through
           + 60 //+ Front_reflect
           + 60 //+ Front_reflect
           + (d1x-40);
    
    //d1a2 = through + Front_reflect + Back_reflect;
    d1a2 += through;
    d1a2 += Front_reflect;
    if (secondMirrorBackReflect) d1a2 += Front_reflect; // NOTE: back in the mirror is front from this direction
    else d1a2 += Back_reflect;
    
    // no mirror
    //       X(laser-semimirror)     + Front_reflect
    //     + Y(semimirror-topmirror) + Front_reflect
    //     + X(topmirror-detector)
    d1x0 =    80 //+ Front_reflect
           + 60 //+ Front_reflect
           + (d1x+20);
    
    d1a0 = Front_reflect + Front_reflect;
    ///////////////////////////////
    
    
    
    
    ///////////////////////////////
    // D2
    // blue
    //       X(laser-semimirror)     + Front_reflect
    //     + Y(semimirror-topmirror) + Front_reflect
    //     + X(topmirror-semimirror) + Back_reflect
    //     + Y(semimirror-detector)
    d2x1 =   80 //+ Front_reflect
           + 60 //+ Front_reflect
           + 60 //+ Back_reflect
           + (d2y);
    
    
    //d2a1 = Front_reflect + Front_reflect + Back_reflect;
    if (firstMirrorBackReflect) d2a1 += Back_reflect;
    else d2a1 += Front_reflect;
    d2a1 += Front_reflect;
    if (secondMirrorBackReflect) d2a1 += Back_reflect; // This is the normal way this expriment is set up
    else d2a1 += Front_reflect;
    
    // red
    //       X(laser-semimirror)        + through
    //     + X(semimirror-bottommirror) + Front_reflect
    //     + Y(bottommirror-semimirror) + through
    //     + Y(semimirror-detector)
    d2x2 =   80 //+ through
           + 60 //+ Front_reflect
           + 60 //+ through
           + (d2y);
    
    d2a2 = through + Front_reflect + through;
    
    // no mirror
    //       X(laser-semimirror)        + through
    //     + X(semimirror-bottommirror) + Front_reflect
    //     + Y(bottommirror-detector)
    d2x0 =   80 //+ through
           + 60 //+ Front_reflect
           + (d2y+60);
    
    d2a0 = through + Front_reflect;
    ///////////////////////////////

    
    //2. rotate clock
    /*d1x1 = (d1x1 * d1x1) + d1a1;
    d1x2 = (d1x2 * d1x2) + d1a2;
    d1x0 = (d1x0 * d1x0) + d1a0;
    
    d2x1 = (d2x1 * d2x1) + d2a1;
    d2x2 = (d2x2 * d2x2) + d2a2;
    d2x0 = (d2x0 * d2x0) + d2a0;*/
    
    

    d1x1 = d1x1 + d1a1;
    d1x2 = d1x2 + d1a2;
    d1x0 = d1x0 + d1a0;
    
    d2x1 = d2x1 + d2a1;
    d2x2 = d2x2 + d2a2;
    d2x0 = d2x0 + d2a0;
/*    
    d1x1 = (d1x1 * d1x1);
    d1x2 = (d1x2 * d1x2);
    d1x0 = (d1x0 * d1x0);
    d2x1 = (d2x1 * d2x1);
    d2x2 = (d2x2 * d2x2);
    d2x0 = (d2x0 * d2x0);
*/
    
    
    /*
    PVector v1 = new PVector(0, 10);
    PVector v2 = new PVector(7, 10);
    line(0, 0, v1.x, v1.y);
    line(0, 0, v2.x, v2.y);
    line(v1.x, v1.y, v1.x+v2.x, v1.y+v2.y);
    PVector v3 = v1;
    v3.add(v2);
    line(0, 0, v3.x, v3.y);
    */
    
    /*
    // apply to vectors
    d1v1.rotate(d1x1);
    d1v2.rotate(d1x2);
    d1v0.rotate(d1x0);
    
    d2v1.rotate(d2x1);
    d2v2.rotate(d2x2);
    d2v0.rotate(d2x0);
    */
    
    
    
    d1v1.x = d1v1.y * sin(d1x1);
    d1v1.y = d1v1.y * cos(d1x1);
    d1v2.x = d1v2.y * sin(d1x2);
    d1v2.y = d1v2.y * cos(d1x2);
    d1v0.x = d1v0.y * sin(d1x0);
    d1v0.y = d1v0.y * cos(d1x0);
    
    d2v1.x = d2v1.y * sin(d2x1);
    d2v1.y = d2v1.y * cos(d2x1);
    d2v2.x = d2v2.y * sin(d2x2);
    d2v2.y = d2v2.y * cos(d2x2);
    d2v0.x = d2v0.y * sin(d2x0);
    d2v0.y = d2v0.y * cos(d2x0);
    
    
    //text(d2v1.x, 0, -50);
    //text(d2v1.y, 0, -40);
    
    //line(0,0, d2v1.x*100, d2v1.y*100);
    
    
    //if (frameCount == 1) println("" + d1v1.x + ", " + d1v1.y);
    //if (frameCount == 1) println("" + d1v2.x + ", " + d1v2.y);
    //if (frameCount == 1) println("" + d2v1.x + ", " + d2v1.y);
    //if (frameCount == 1) println("" + d2v2.x + ", " + d2v2.y);
    // add vectors
    if (useMirror)
    {
      d1v0 = d1v1;
      d1v0.add(d1v2);
      
      d2v0 = d2v1;
      d2v0.add(d2v2);
    }
    // else use the normal v0's
    
    
    //3. the probability
    //float d1p = d1v0.magSq();
    //float d2p = d2v0.magSq();
    
    //float d1p = sqrt((d1v0.x * d1v0.x) + (d1v0.y * d1v0.y));
    //float d2p = sqrt((d2v0.x * d2v0.x) + (d2v0.y * d2v0.y));
    
    //if (frameCount == 1) println("" + d2v0.x + ", " + d2v0.y);
    
    d1p = (d1v0.x * d1v0.x) + (d1v0.y * d1v0.y);
    d2p = (d2v0.x * d2v0.x) + (d2v0.y * d2v0.y);
    
    float total = d1p+d2p;
    // normalise;
    float m = 1.0 / total;
    d1p = d1p * m;
    d2p = d2p * m;
    //total = d1p+d2p;
    //if (frameCount == 1) println("" + d2v0.x + ", " + d2v0.y);
    //if (frameCount == 1) println("" + d1p + ", " + d2p);
    float r = random();
    
    
    //float c = d2x2 - d2x1;
    //text(c, 0, -50);
    //if (frameCount == 1) 
    //text(d1p, 0, -50);
    //text(d2p, 0, -40);
    
    if (r < d2p) detector2On = true;
    else detector2On = false;
    
    
    if (graph && fire)
    {
      int xPos = (int) detectorDistance;
      //println(xPos);
      /*if (!detector2On)
      {
        d1Data[xPos] = d1Data[xPos] + (1.0 - d1Data[xPos]) / 8.0;
        d2Data[xPos] = d2Data[xPos] + (0.0 - d2Data[xPos]) / 8.0;
      }
      else
      {
        d1Data[xPos] = d1Data[xPos] + (0.0 - d1Data[xPos]) / 8.0;
        d2Data[xPos] = d2Data[xPos] + (1.0 - d2Data[xPos]) / 8.0;
      }*/
      
      d1Data[xPos] = d1p;
      d2Data[xPos] = d2p;
    }

  }
  
  
  
  // now pick the detector based on the probability.
  
  
  color r = color(255, 50, 80);
  color b = color(190, 190, 255);
  
  strokeWeight(2);
  
  stroke(255,120,120);
  line(-100,60,-20,60);
  stroke(b);
  line(-20,60,-20,0);
  stroke(r);
  line(-20,60,40,60);
  
  if (useMirror)
  {
    stroke(b);
    line(-20,0,40,0);
    stroke(255,120,255);
    line(40,0,d1x,0);
    
    stroke(r);
    line(40,60,40,0);
    stroke(255,120,255);
    line(40,0,40,d2y);
    
  }
  else
  {
    stroke(b);
    line(-20,0,d1x,0);
    
    stroke(r);
    line(40,60,40,d2y);
  }
  
  textAlign(CENTER, CENTER);
  
  drawLazer(-100,60);
  
  if (!firstMirrorBackReflect)
  {
    drawSemiMirror(-20, 60, 0);
  }
  else
  {
    drawSemiMirror(-20, 60, PI);
  }
  
  
  drawFullMirror(-20, 0, 3*PI/4);
  drawFullMirror(40, 60, -PI/4.0);
  drawDetector(d1x,0,-PI/2.0, start && !detector2On); 
  drawDetector(40,d2y,PI, start && detector2On);
  if (useMirror) 
  {
    if (secondMirrorBackReflect)
    {
      drawSemiMirror(40, 0, PI);
    }
    else
    {
      drawSemiMirror(40, 0, 0);
    }    
  }
  
  if (useMirror) fill(0); else fill(0,0,255);
  text("D1", 20+d1x, 0);
  
  if (useMirror) fill(0); else fill(255,0,0);
  text("D2", 40, d2y-20);
  
  //if (g == null) {createG();}
  //if (g != null)
  //{
  //  imageMode(CENTER);
  //  image(g, 0, 0);
  //}
  
  if (graph)
  {
    int xPos = (int) detectorDistance;
    //println(xPos);
    /*if (!detector2On)
    {
      d1Data[xPos] = (d1Data[xPos] + 1.0) / 2.0;
      d2Data[xPos] = (d2Data[xPos] + 0.0) / 2.0;
    }
    else
    {
      d1Data[xPos] = (d1Data[xPos] + 0.0) / 2.0;
      d2Data[xPos] = (d2Data[xPos] + 1.0) / 2.0;
    }*/
    
    //d1Data[xPos] = d1p;
    //d2Data[xPos] = d2p;
    
    drawGraph(76, -20, 0, d1Data);
    drawGraph(20, -40, -PI/2, d2Data);
  }
  
  
  if (start)
  {
    fill(190);
    text(d1p, -100, 30);
    text(d2p, -100, 40);
  }
}

void drawLazer(int x, int y)
{
  pushMatrix();
  
  translate(x,y);
  
  stroke(0); strokeWeight(1); fill(255,255,0);
  rectMode(CENTER);
  rect(0, 0, 30, 10);
  
  popMatrix();
}

void drawSemiMirror(int x, int y, float a)
{
  pushMatrix();
  
  translate(x,y);
  rotate(-PI/4.0);
  
  rotate(a);
  
  stroke(220,240,255); strokeWeight(1); fill(220,240,255);
  rectMode(CENTER);
  rect(0, 0, 20, 2);
  
  stroke(190,190,255); strokeWeight(1);
  line(-10,-1, 10, -1);
  
  popMatrix();
}

void drawFullMirror(int x, int y, float a)
{
  pushMatrix();
  
  translate(x,y);
  rotate(a);
  
  rectMode(CENTER);
  stroke(180,180,255); strokeWeight(1); fill(180,180,255);
  rect(0, 0, 20, 2);
  stroke(50,50,150); strokeWeight(1); fill(50,50,150);
  rect(0, 2, 20, 2);
  
  popMatrix();
}

void drawDetector(int x, int y, float a, boolean detectorOn)
{
  pushMatrix();
  
  translate(x,y);
  rotate(a);
  
  rectMode(CENTER);
  stroke(0); strokeWeight(1); fill(255);
  rect(0, 0, 20, 4);
  stroke(0); strokeWeight(1); 
  if (detectorOn) fill(255,255,0); else fill(90,90,90);
  rect(0, 4, 20, 8);
  
  popMatrix();
}

void drawGraph(int x, int y, float a, float[] d)
{
  if (frameCount == 1) return;
  
  int yAxis = -30;
  
  pushMatrix();
  
  translate(x, y);
  rotate(a);
  stroke(190);
  strokeWeight(1);
  int xAxis = s1.maxV - s1.minV + 1;
  
  
  line(0, 0, xAxis, 0);
  line(0, 0, 0, yAxis);
  
  stroke(90);
  for (int i = 0; i < 59; i++)
  {
    int d1 = (int) (d[i] * yAxis);
    //int d2 = d2Data[i] * yAxis;
    line(i+1, 0, i+1, d1);
  }
  
  popMatrix();
}
