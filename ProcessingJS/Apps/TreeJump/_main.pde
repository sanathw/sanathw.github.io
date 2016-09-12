// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

//PGraphics2D g;
void setup()
{
  setSize(100, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void makeTree(int x, int y)
{
pushMatrix();
translate(x,y);
fill(0,255,0);
line(0,0,0,60);
ellipse(0,0,40,50);
ellipse(-20,0,25,25);
ellipse(20,0,25,25);
popMatrix();

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

int h =-70;
void draw()
{
  initDraw();
  
  //if (g == null) {createG();}
  //if (g != null)
  //{
  //  imageMode(CENTER);
  //  image(g, 0, 0);
  //}
  
  makeTree(-10,-60);
  makeTree(20, -60);

  scale(0.5);
  makeTree(-50,-50);

  scale(1);
  fill(255);
 
  translate(0,h);

  ellipse(0,-50,20,20);
  line(0,0,0,-40);
  line(-25,-30,25,-30);
  line(-25,30,0,0);
  line(25,30,0,0);

  h =h+5;
 
  if(h>0) h =0;
}
