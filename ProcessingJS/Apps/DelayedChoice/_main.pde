// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

// https://en.wikipedia.org/wiki/Delayed_choice_quantum_eraser

// The distance to D0 is shorter than D1,D2,D3,D4
// So the fact that you get interference at D0 depending on what is happening at the other detectors
// means that the choice at D0 is DELAYED until the other detectors are hit.
// But I explain this by saying that the distances between ANY of the detectors don't matter!!!!!
// it's entangled!!!!

// ONE photon in, TWO photons out......and there are only 4 ways this can happen!
// (D0-D1) (D0-D1) (D0-D2) (D0-D4)

// THE DIFFERENCE between the red and blue path down to the mirrors is what
// gives the INVERSE graph as seen in Wikipedia between D0-D1 and D0-D2.


// mousePressed, mouseX, mouseY
// debug by println();

int d0X = 0;
float[] d1Data = new float[101];
boolean start = false;
boolean fast = false;
boolean graph = false;
boolean showPath = false;

boolean d0On = false;
boolean d1On = false;
boolean d2On = false;
boolean d3On = false;

float red_slit_to_top_left_glass = 10.0;
float blue_slit_to_top_right_glass = 12.0;
float top_glass_to_mirror = 5.0;
float mirror_to_bottom_middle_glass = 5.0;
float middle_glass_to_detector = 8.0;
float slit_to_lens = 4.0;
float reflect = PI*2;//0.5;  // #######  CHANGES WAVE PHASE (offset)
float through = 0.085;//0.3; // #######  CHANGES WAVE FREQUENCY


float d1x1;
float d1x2;
float d1a1;
float d1a2;



boolean allStates = true;
int state = -1;

//PGraphics2D g;
void setup()
{
  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(500, 500, P2D, FIT_INSIDE, this); // this has to be the last line in this function
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
  //fill(0,0);
  //
  //ellipse(0,0,500,500);
  
  color c;
  
  PVector d1v1 = new PVector(0, 1);
  PVector d1v2 = new PVector(0, 1);
  float d1p = 0;
  
  if (fast || (frameCount % 20 == 0))
  {
    if (start)
    {
      if (allStates) state = (int) random(4)+1;
    }
    //else
    //{
    //  state = -1;
    //}
  }
  

  d0On = false;
  d1On = false;
  d2On = false;
  d3On = false;
  d4On = false;
  
  if (start)
  {
    switch(state)
    {
      case 1:
      case 2:
        var dist1 = 0 ;
        var dist2 = 0 ;
        if (state == 1) {d1On = true; dist1 = red_slit_to_top_left_glass; dist2 = blue_slit_to_top_right_glass;}
        if (state == 2) {d2On = true; dist1 = blue_slit_to_top_right_glass; dist2 = red_slit_to_top_left_glass;}
        
        
        
        d1x1 = 0;
        // red to D1
        d1x1 += dist1 //+ through
             + top_glass_to_mirror //+ reflect
             + mirror_to_bottom_middle_glass //+ reflect
             + middle_glass_to_detector;
      
        d1a1 = through + reflect + reflect;
        
        // red to D0
        //d1x1 += slit_to_lens + (abs(5+d0X+14)/500.0);
        var red_lens_to_D0x = d0X+14;
        var red_lens_to_D0y = 10;
        var red_lens_to_D0 = sqrt((red_lens_to_D0x * red_lens_to_D0x) + (red_lens_to_D0y * red_lens_to_D0y));
        d1x1 += red_lens_to_D0;//(abs(5+d0X+14)/500.0);
        
        
        d1x2 = 0;
        // blue to D1
        d1x2 += dist2 //+ through
             + top_glass_to_mirror //+ reflect
             + mirror_to_bottom_middle_glass //+ through
             + middle_glass_to_detector;
      
        d1a2 = through + reflect + through;
        
        // blue to D0
        //d1x2 += slit_to_lens +  (abs(5+d0X-14)/500.0);
        var blue_lens_to_D0x = d0X-14;
        var blue_lens_to_D0y = 10;
        var blue_lens_to_D0 = sqrt((blue_lens_to_D0x * blue_lens_to_D0x) + (blue_lens_to_D0y * blue_lens_to_D0y));
        d1x2 += blue_lens_to_D0;//(abs(5+d0X-14)/500.0);
        
        
        d1x1 += d1a1;
        d1x2 += d1a2;
        
        d1x1 = (d1x1 * d1x1) / 200; // number of line (bigger = less)
        d1x2 = (d1x2 * d1x2) / 200; // number of line (bigger = less)
        
        d1v1.x = d1v1.y * sin(d1x1);
        d1v1.y = d1v1.y * cos(d1x1);
        d1v2.x = d1v2.y * sin(d1x2);
        d1v2.y = d1v2.y * cos(d1x2); 
        
        
        //println(d1v1.x);// + " " + d1x2);
        
        //d1v1 = d1v2;
        d1v1.add(d1v2);
        d1p = (d1v1.x * d1v1.x) + (d1v1.y * d1v1.y);
        d1p = d1p / 4.0; // two outcomes squared (2^2)
        //println(d1p);
        d1Data[d0X+50] = d1p;
        //d1Data[d0X+50] = d1p * (1/(1+((d0X * d0X)/500))); // for gausian like in Wikipedia image
        
        //text(d1p, -100, -100);
        
        float r = random();
        if (r < d1p) d0On = true;
        else d0On = false;
        
        break;
      case 3:
        d3On = true;
        d0On = true; // because only one way to get this combination
        d1Data[d0X+50] = 1;
        //d1Data[d0X+50] = 1 * (1/(1+((d0X * d0X)/500))); // for gausian like in Wikipedia image
        break;
      case 4:
        d4On = true;
        d0On = true; // because only one way to get this combination
        d1Data[d0X+50] = 1;
        //d1Data[d0X+50] = 1 * (1/(1+((d0X * d0X)/500))); // for gausian like in Wikipedia image
        break;
    }
  }
  
  ///////////////////////////////////
  if (showPath)
  {
    strokeWeight(10);
    pushMatrix();
    translate(50, -115);
    rotate(-PI/4.0);
    stroke(255,200,0);
    if (state != 3 && state > 0) line(14, 0, 5+d0X, 60); // blue
    if (state != 4 && state > 0) line(-14, 0, 5+d0X, 60); // red
    popMatrix();
    if (state != 3 && state > 0) 
    {
      line(10, -170, 10, -55); // blue
      line(10, -175, 60, -125); 
      line(10, -55, 15, -30); 
    }
    
    if (state != 4 && state > 0) 
    {
      line(-10, -150, -10, -50); // red
      line(-10, -155, 40, -105);
      line(-10, -50, -15, -30);  
    }
    
    //D4
    if (state == 4)
    {
      line(15, -30, 75, 60);
      line(75, 60, 150, 5);
    }
    
    //D3
    if (state == 3)
    {
      line(-15, -30, -75, 60);
      line(-75, 60, -150, 5);
    }
    
    //D2
    if (state == 2)
    {
      line(15, -30, 160, 190);
      line(160, 190, 0, 150);
      line(0, 150, 220, 95);
      line(-15, -30, -160, 190);
      line(-160, 190, 0, 150);
    }
    
    //D1
    if (state == 1)
    {
      line(-15, -30, -160, 190);
      line(-160, 190, 0, 150);
      line(0, 150, -220, 95);
      line(15, -30, 160, 190);
      line(160, 190, 0, 150);
    }
  }
  ///////////////////////////////////
  
  
  
  rectMode(CENTER);
  ellipseMode(CENTER);
  textAlign(CENTER, CENTER);
  
  strokeWeight(1);
  stroke(100, 100, 255); fill(153,217,255, 90);
  triangle(0,-60, 30, -30, -30, -30);
  rect(0,150,5,30);
  
  stroke(0,0,255);
  line(10, -190, 10, -50);
  line(10, -175, 60, -125); 
  //line(60, -125, 90, -80);
  stroke(255,0,0);
  line(-10, -170, -10, -50);
  line(-10, -155, 40, -105); 
  //line(40, -105, 90, -80);
  
  pushMatrix();
  translate(50, -115);
  rotate(-PI/4.0);
  stroke(0,0,255);
  line(14, 0, 5+d0X, 60);
  stroke(255,0,0);
  line(-14, 0, 5+d0X, 60);
  strokeWeight(1); stroke(0); //fill(190);
  
  c = d0On ? color(255, 255, 0) : color(190); fill(c);
  rect(5+d0X, 70, 20, 20);
  fill(0);
  text("D0", 5+d0X, 70);
  
  if (graph) drawGraph(-50, 115, 0, d1Data);
  
  popMatrix();
  
  drawLightPath(color(0,0,255), 1);
  drawLightPath(color(255,0,0), -1);
  
  pushMatrix();
  translate(0, -180);
  rotate(-PI/4.0);
  strokeWeight(5); stroke(0); fill(0);
  line(-80, 0, -25, 0);
  line(-6, 0, 6, 0);
  line(25, 0, 80, 0);
  strokeWeight(1); stroke(255, 190, 190, 190); fill(255, 255, 190, 190);
  rect(0,10, 100, 10);
  strokeWeight(1); stroke(100, 100, 255); fill(153,217,255, 200);
  ellipse(-10,80,60,10);
  
  stroke(0); fill(255,255,0);
  rect(0,-100,15, 40);
  strokeWeight(6); stroke(255, 255, 0);
  line(0, -70, 0, -20);
  popMatrix();
  
  strokeWeight(1); stroke(0); //fill(190);
  
  c = d1On ? color(255, 255, 0) : color(190); fill(c);
  rect(-232, 90, 20, 20);
  
  c = d2On ? color(255, 255, 0) : color(190); fill(c);
  rect(232, 90, 20, 20);
  
  c = d3On ? color(255, 255, 0) : color(190); fill(c);
  rect(-160, 5, 20, 20);
  
  c = d4On ? color(255, 255, 0) : color(190); fill(c);
  rect(160, 5, 20, 20);
  
  fill(0);
  text("D1", -232, 90);
  text("D2", 232, 90);
  text("D3", -160, 5);
  text("D4", 160, 5);
}

void drawLightPath(color c, int xScale)
{
  pushMatrix();
  scale(xScale,1);
  
  
  pushMatrix();
  stroke(100, 100, 255); fill(153,217,255, 90);
  translate(75, 64);
  rotate(-PI/2.0);
  rect(0,0,5,30);
  popMatrix();
  
  stroke(c);
  line(10, -50, 15, -30);
  line(15,-30, 160, 190);
  line(160, 190, -232, 90);
  line(5, 150, 232, 93);
  line(75, 60, 160, 0);
  
  //stroke(0); fill(190);
  //rect(-232, 90, 20, 20);
  translate(160, 190); rotate(0.72);
  stroke(0); fill(0,0,255);
  rect(0,0,5,30);
  popMatrix();
  
}

void drawGraph(int x, int y, float a, float[] d)
{
  if (frameCount == 1) return;
  
  int yAxis = -30;
  
  pushMatrix();
  
  translate(x, y);
  rotate(a);
  if (start) stroke(190);
  else stroke(190, 90);
  strokeWeight(1);
  int xAxis = s1.maxV - s1.minV + 1;
  
  
  line(0, 0, xAxis, 0);
  line(0, 0, 0, yAxis);
  
  if (start) stroke(90);
  else stroke(90, 90);
  for (int i = 0; i < 100; i++)
  {
    int d1 = (int) (d[i] * yAxis);
    //int d2 = d2Data[i] * yAxis;
    line(i+1, 0, i+1, d1);
  }
  
  popMatrix();
}
