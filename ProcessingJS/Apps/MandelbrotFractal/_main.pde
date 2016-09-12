// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

PGraphics2D g;


PVector topLeft = new PVector();
PVector bottomRight = new PVector();
PVector p = new PVector(0, 0);
double z = 1;

double ww; double hh;
   
void setup()
{
  doZoom = false;
  doTranslate = false;
  doRotate = false;
  z = 1; ww = 2.5; hh = 2.5;
  
  setSize(400, 400, P2D, FIT_OUTSIDE, this); // this has to be the last line in this function

  //imageMode(CENTER);
  
  
  //if (width < height) h = h * (height / width);
  //if (height < width) w = w * (width / height);
  
  //calculateBox();
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(255);
}

void createG()
{
  int s = max(sw, sh);
  g = createGraphics(s, s, P2D);
}


void calculateBox()
{
  topLeft.x = p.x-(ww*z), 
  topLeft.y = p.y-(hh*z);
  bottomRight.x = p.x+(ww*z), 
  bottomRight.y = p.y+(hh*z);
  
  //println("{" + p.x + " " + p.y + "} " + ww + ", " + hh + ", " + z + " " + topLeft.x + " " + topLeft.y + " " + bottomRight.x + " " + bottomRight.y);
  
  drawFractal();
}

void calculateBoxCorners()
{
  z = 1;
  
  float x1 = map(p1.x, -h_sw, h_sw, topLeft.x, bottomRight.x);
  float x2 = map(p2.x, -h_sw, h_sw, topLeft.x, bottomRight.x);
  float y1 = map(p1.y, -h_sh, h_sh, topLeft.y, bottomRight.y);
  float y2 = map(p2.y, -h_sh, h_sh, topLeft.y, bottomRight.y);
  
  p.x = (x1 + x2) / 2;
  p.y = (y1 + y2) / 2;
  
  ww = p.x - x1;
  hh = p.y - y1;
  
  calculateBox();
}

void drawFractal()
{
  //println("drawFractal");
  if (g != null)
  {
    //println("g!=null");
    g.beginDraw();

    g.background(255);
    g.loadPixels();
    //println("loadPixels");
    //println("> " + g.width + " " + g.height);

    float dx = (bottomRight.x - topLeft.x) / g.width;
    float dy = (bottomRight.y - topLeft.y) / g.height;
    
    float y = topLeft.y;
    
    //println("[ " + dx + " " + dy + " " + y + " " + topLeft.x);
    
    for(int j = 0; j < g.height; j++)
    {
      float x = topLeft.x;
      for (int i = 0; i < g.width; i++)
      {
        int n = iterationToInfinity(x, y);
        
        /*
        int i_r = 255 *(1 / (1 + ((n - 0) * 1)^2));
        int i_g = 255 *(1 / (1 + ((n - 0) * 0.2)^2));
        int i_b = 255 *(1 / (1 + ((n - 10) * 1)^2));
        
        //pixels[i+j*width] = color(n*16 % 255, 40);
        int c =  ((n * 16) % 255);
        g.pixels[i+j*g.width] = color((c)/14, (c)/14, (c)/14);// blendColor(color(r, g, b, 40), color(n*16 % 255, 40), ADD);
        */
        
        int i_r = ((n * 80) % 200);// 0;
        int i_g = ((n * 40) % 255);//0;
        int i_b = ((n * 10) % 255);//0;
        //int c =  ((n * 16) % 255);
        
        //i_r = (i_r + c)/2;
        //i_g = (i_g + c)/2;
        //i_b = (i_b + c)/2;
        //if (n >= 0) i_r = map(n, 0, 400, 0, 255);
        //if (n >= 0) i_g = map(n, 0, 400, 0, 255);
        //if (n >= 0) i_g = map(n, 0, 400, 0, 255);
        
        //int c =  ((n * 16) % 255);
        g.pixels[i+j*g.width] = color(i_r, i_g, i_b);
        
  //g.pixels[i+j*g.width] = color(255, 0, 0);
        
        x += dx;
      }
      
      y += dy;
    }
    
    g.updatePixels();
    //println("updatePixels");

    g.endDraw();
  }
  
}

int iterationToInfinity(float x, float y)
{
  int maxIterations = 200;//400;//200;
  
  //========================================================================
  // Now we test, as we iterate Z = Z^2 + C does Z tend towards infinity?
  // Z and C are complex numbers (a + bi) with C being (x + yi)
  // (a1 + b1i) = (a0 + b0i) * (a0 + b0i) + (x + yi)
  // now
  // (a0 + b0i) * (a0 + b0i) = a0*a0 + 2a0b0i - b0*b0
  //                    => (a0a0 - b0b0) + 2a0b0i
  // add the C you get
  // (a1 + b1i)         = (a0a0 - b0b0 + x) + (2a0b0+y)i
  // ie
  // (a + bi)           = (aa - bb + x) + (2ab+y)i
  //========================================================================
  
  // Since the starting Z is 0 and C is (x + yi),
  // the (a + bi) of the Z is just the C: (x + yi)
  float a = x;
  float b = y;
  int n = 0;
  while (n < maxIterations) 
  {
    float aa = a * a;
    float bb = b * b;
    float twoab = 2.0 * a * b;
    
    // Next Z
    a = aa - bb + x;
    b = twoab + y;
    
    // Find out at which point it goes to infinity
    // Infinty in our finite world is simple, let's just consider it if the magnitute goes above 16
    if(aa + bb > 16.0) break;  // Bail
    
    n++;
  }
  
  // Did not go to infinity, so inside the Mandelbrot, color will be 0
  if (n == maxIterations)  n = 0;

  return n;
}


void zoomPhoneFractal(int dir)
{
  if (dir > 0) z = z / 1.2;
  else z = z * 1.2;
  calculateBox(); drawFractal();
}

void zoomFractal(int dir)
{ 
  //float x1 = ((bottomRight.x - topLeft.x) * mouseX / g.width) + topLeft.x;
  //float y1 = ((bottomRight.y - topLeft.y) * mouseY / g.height) + topLeft.y;
  float x1 = map(mouseX, -h_sw, h_sw, topLeft.x, bottomRight.x);
  float y1 = map(mouseY, -h_sh, h_sh, topLeft.y, bottomRight.y);
  
  double oz = z;

  if (dir > 0) z = z / 1.2;
  else z = z * 1.2;
  calculateBox();
  
  //float x2 = ((bottomRight.x - topLeft.x) * mouseX / g.width) + topLeft.x;
  //float y2 = ((bottomRight.y - topLeft.y) * mouseY / g.height) + topLeft.y;
  float x2 = map(mouseX, -h_sw, h_sw, topLeft.x, bottomRight.x);
  float y2 = map(mouseY, -h_sh, h_sh, topLeft.y, bottomRight.y);
  
  p.x -= (x2 - x1) * (oz/z);
  p.y -= (y2 - y1) * (oz/z);
  calculateBox();
  
  drawFractal();
}

void translateFractal(int i_tx, int i_ty)
{
  float x = map(i_tx, 0, sw, 0, abs(bottomRight.x - topLeft.x));
  float y = map(i_ty, 0, sh, 0, abs(bottomRight.y - topLeft.y));
  
  p.x -= x;
  p.y -= y;
  calculateBox();
  drawFractal();
}

void resetFractal()
{
  z = 1; ww = 2.5; hh = 2.5;
  p.x = 0;
  p.y = 0;
  calculateBox();
  drawFractal();
}

PVector p1 = new PVector();
PVector p2 = new PVector();

boolean autoZoom = false;

void draw()
{
  initDraw();
  
  if (g == null) { createG(); calculateBox(); }
  
  if (g != null)
  {
    if (autoZoom)
    {
      if (isMobile)
      {
        //zoomPhoneFractal(1);
      }
      else
      zoomFractal(1);
    }
    
    if (d_tx != p_d_tx || d_ty != p_d_ty)
    {
      if (isMobile)
      {
        //translateFractal(d_tx, d_ty);
      }
      else
      translateFractal(d_tx, d_ty);
    }
    
    if (d_zoom != p_d_zoom)
    {
    //println(d_zoom);
      if (d_zoom != 0) 
      {
        if (isMobile)
        {
          //zoomPhoneFractal(d_zoom);
        }
        else zoomFractal(d_zoom);
      }
    }
    
    imageMode(CENTER);
    image(g, 0, 0);
    //ellipseMode(CENTER);
    //ellipse(0, 0, 400, 400);
    
    if (mousePressed)
    {
      if (mousePressed != pmousePressed)
      {
        p1.x = mouseX;
        p1.y = mouseY;
      }
      p2.x = mouseX;
      p2.y = mouseY;
      
      noFill();
      stroke(0, 0, 255); strokeWeight(2);
      rectMode(CORNERS);
      rect(p1.x, p1.y, p2.x, p2.y);
    }
    
    if (mousePressed == false && mousePressed != pmousePressed)
    {
      calculateBoxCorners(); drawFractal();
    }
  }
  
}
