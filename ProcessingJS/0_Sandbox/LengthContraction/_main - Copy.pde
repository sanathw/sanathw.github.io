// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

// mousePressed, mouseX, mouseY
// debug by println();

//PGraphics2D g;

class Clock
{
  public Clock(float angle, float amplitude)
  {
    this.angle = angle;
    this.amplitude = amplitude;
  }
  public float angle = 0;
  public float amplitude = 0;
}

ArrayList prob = new ArrayList(400);
ArrayList prob2 = new ArrayList(400);

void setup()
{
  for (int i = 0; i < prob.size(); i++)
  {
    Clock c = new Clock(0, 0)
    prob[i] = c;
    
    c = new Clock(0, 0)
    prob2[i] = c;
  }
  
  float normalise = 0;
  for (int i = 0; i < 20; i++)
  {
    //float a = 1 / (1 + i *2);
    a = (1/40);///sqrt(400);
    
    Clock c = (Clock) prob[200+i];
    c.amplitude = a;
    c.angle = 0;//PI*i/20;
    normalise = normalise + c.amplitude;
    
    c = (Clock) prob[200-i];
    c.amplitude = a;
    c.angle = 0;//PI*i/20;
    normalise = normalise + c.amplitude;
  }
  
  for (int i = 0; i < prob.size(); i++)
  {
    Clock c = (Clock) prob[i];
    c.amplitude = c.amplitude / normalise;
  }

  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(400, 200, P2D, FIT_INSIDE, this); // this has to be the last line in this function
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
  
  
  float t = frameCount;
  
  float normalise = 0;
  
  for (int j = 0; j < prob2.size(); j++)
  {
    float a = 0;
    float x = 0;
    float y = 0;
    
    Clock c = (Clock) prob2[j];
    
    for (int i = 0; i < 20; i++)
    { 
      // Brian Cox p49 
      // winding = (m x^2) / 2ht
      
      float outcomes = sqrt(400);
      
      float m = 0;
      float r = 0;
      float w = 0;
      
      m = 200+i;
      r = j - m;
      w = (r * r) / t;
      Clock c1 = (Clock) prob[m];
      //a = a + (c1.angle + m*m / t);
      x = x + sin(w) * c1.amplitude / outcomes;
      y = y + cos(w) * c1.amplitude / outcomes;
      
      m = 200-i;
      r = j - m;
      w = (r * r) / t;
      Clock c2 = (Clock) prob[m];
      //a = a + (c2.angle + m*m / t);
      x = x + sin(w) * c2.amplitude / outcomes;
      y = y + cos(w) * c2.amplitude / outcomes;
    }
    
    c.amplitude = (x * x) + (y * y);
    
    normalise = normalise + c.amplitude;
  }
  
  for (int j = 0; j < prob2.size(); j++)
  {
    Clock c = (Clock) prob2[j];
    c.amplitude = c.amplitude / normalise;
  }
  
  
  
  //if (g == null) {createG();}
  //if (g != null)
  //{
  //  imageMode(CENTER);
  //  image(g, 0, 0);
  //}
  
  strokeWeight(1);
  stroke(0, 50);
  line(-h_sw, 0, h_sw, 0);
  
  
  for (int i = 0; i < prob.size(); i++)
  {
    Clock c;
    int x = i - h_sw;
    int y = 0;
    
    // prob1
    c = (Clock) prob[i];
    stroke(0, 50);
    y = (int) (c.amplitude * 800);
    line (x, 0, x, -y);
    
    stroke(0, 0, 255, 50);
    y = (int) (c.angle * 10);
    line (x, 0, x, y);
    
    // prob2
    c = (Clock) prob2[i];
    stroke(0, 50);
    y = (int) (c.amplitude * 800);
    line (x, 0, x, -y);
    
    stroke(0, 0, 255, 50);
    y = (int) (c.angle * 10);
    line (x, 0, x, y);
  }
}
