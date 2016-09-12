// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

//PGraphics2D g;
void setup()
{
  setSize(100, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  g.gradientBackground3(VERTICAL, color(200,200,255), color(255), 0.5, color(255));
  //g.background(255);
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
  
  noStroke();
  fill(100,230,230);
  rectMode(CORNERS);
  rect(-h_dw,0,h_dw, h_dh);
  
  rectMode(CENTER);
  fill(255);
  
  float r1;
  float r2;
  
  for(int y= 0; y< h_dh; y++)
  {
    r2=map(y,0,h_dh,0.0,1.0);
    for(int x =-h_dw; x < h_dw; x++)
    {
      r1= map(abs(x), 0, h_dw, 1.0, r2);
       if ( random(1) < r1)
       {
         rect(x,y,2,1);
       }
    }
  }
}


