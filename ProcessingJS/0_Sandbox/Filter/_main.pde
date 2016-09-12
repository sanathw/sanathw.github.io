// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

//http://docs.gimp.org/en/plug-in-convmatrix.html
//Convolution uses a Kernal Matrix


/* @pjs preload="./_resources/Notepad.png"; */

PImage inImg;
//PImage outImg;

/*
// Blur
var filter = [
[1, 1, 1,   1,   1, 1, 1],
[1, 1, 1,   1,   1, 1, 1],
[1, 1, 1,   1,   1, 1, 1],

[1, 1, 1,   1,   1, 1, 1],

[1, 1, 1,   1,   1, 1, 1],
[1, 1, 1,   1,   1, 1, 1],
[1, 1, 1,   1,   1, 1, 1]
];
float threshold = 1;
*/

/*
// Edge
var filter = [
[1, 1, 1,   1,   1, 1, 1],
[1, 1, 1,   1,   1, 1, 1],
[1, 1, -0.125,   -0.125,   -0.125, 1, 1],

[1, 1, -0.125,   1,   -0.125, 1, 1],

[1, 1, -0.125,   -0.125,   -0.125, 1, 1],
[1, 1, 1,   1,   1, 1, 1],
[1, 1, 1,   1,   1, 1, 1]
];
int threshold = 50;
*/

/*
// Edge
var filter = [
[1, 1, 1,   1,   1, 1, 1],
[1, 1, 1,   1,   1, 1, 1],
[1, 1, 0,   -0.25,   0, 1, 1],

[1, 1, -0.25,   1,   -0.25, 1, 1],

[1, 1, 0,   -0.25,   0, 1, 1],
[1, 1, 1,   1,   1, 1, 1],
[1, 1, 1,   1,   1, 1, 1]
];
int threshold = 100;
*/

// Edge
var filter = [
[1, 1, 1,   1,   1, 1, 1],
[1, 1, 1,   1,   1, 1, 1],
[1, 1, 0,   1,   0, 1, 1],

[1, 1, 1,   -4,   1, 1, 1],

[1, 1, 0,   1,   0, 1, 1],
[1, 1, 1,   1,   1, 1, 1],
[1, 1, 1,   1,   1, 1, 1]
];
int threshold = 100;


int s = 1;
//PGraphics2D g;
void setup()
{
  inImg = loadImage("./_resources/Notepad.png");
  outImg = new PImage(inImg.width, inImg.height);
  
  applyFilter();
  
  setSize(100, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(255);
}

void applyFilter()
{
  //int min = 999999999;
  //int max = 0;

  for (int j = 0; j < inImg.height; j++)
  {
    for (int i = 0; i < inImg.width; i++)
    {
      
      
      int p = (outImg.width*j)+i;
      int cr = 0;
      int cg = 0;
      int cb = 0;
      //int a = 0;
      
      for (int j1 = -s; j1 <= s; j1++)
      {
        for (int i1 = -s; i1 <= s; i1++)
        {
          int y = j + j1;
          int x = i + i1;
          
          if (x >= 0 && x < inImg.width && y >= 0 && y < inImg.height)
          {
            int wy = 3 + j1;
            int wx = 3 + i1;
            int w = filter[wy][wx];
            
            w = w * threshold;
            
            int p1 = (inImg.width*y)+x;
            
            /*int c1 = 0;
            int a1 = 0;
            c1 += red(inImg.pixels[p1]);
            c1 += green(inImg.pixels[p1]);
            c1 += blue(inImg.pixels[p1]);
            c1 = c1 / 3;
            //a1 = alpha(inImg.pixels[p1);
            
            c += (c1 * w);
            //a += a1;
            */
            
            int cr1 = red(inImg.pixels[p1]);
            int cg1 = green(inImg.pixels[p1]);
            int cb1 = blue(inImg.pixels[p1]);
            cr += (cr1 * w);
            cg += (cg1 * w);
            cb += (cb1 * w);
          }
        }
      }
      
      int t = ((s*2)+1) * ((s*2)+1);
      cr = (int) (cr / t);
      cg = cg / t;
      cb = (int) (cb / t);
      
      
      //cr = cr * 100;
      //cg = cg * 100;
      //cb = cb * 100;
      if (cr < 0) cr = 0;
      if (cg < 0) cg = 0;
      if (cb < 0) cb = 0;
      if (cr > 255) cr = 255;
      if (cg > 255) cg = 255;
      if (cb > 255) cb = 255;
      
      int c1 = (cr + cg + cb) / 3;
      
      //println(cr);
      if (cr < min) min = cr;
      if (cr > max) max = cr;
      
      //outImg.pixels[p] = color(cr);
      outImg.pixels[p] = color(cr, cg, cb);
      //outImg.pixels[p] = color(c1);//cr, cg, cb);//, a);
    }
  }
  
  //println("" + min + ", " + max);
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
  imageMode(CENTER);
  image(outImg, 0, 0);
}
