// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

// Using:
//http://cs.lmu.edu/~ray/notes/biomorphs/

// see also:
// http://www.codeproject.com/Articles/17387/AI-Dawkins-Biomorphs-And-Other-Evolving-Creatures
// Google Books: Illustrating Evolutionary Computation with Mathematica - By Christian Jacob
// https://books.google.com.au/books?id=UY4GjZssWvAC&pg=PA45&lpg=PA45&dq=desmond+morris+biomorph&source=bl&ots=LHBL4zNohF&sig=LZl5LtCUM0SpIejzLhb94BbQIac&hl=en&sa=X&ved=0CDYQ6AEwBWoVChMIiLbcgM_6xgIVhBumCh0kJweD#v=onepage&q=desmond%20morris%20biomorph&f=false


var GENES = [2,7,8,-4,-1,-1,0,6,7];

//PGraphics2D g;
void setup()
{
  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(100, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
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
   var g = GENES;
   var dx = [-g[1],-g[0],0,g[0],g[1],g[2],0,-g[2]];
   var dy = [g[5],g[4],g[3],g[4],g[5],g[6],g[7],g[6]];
   drawTree(0, 0, dx, dy, g[8], 2);
}

/*
 *The drawing function from Dawkins' book.
 */
void drawTree(x, y, dx, dy, len, dir) 
{

  var x2 = x + len * dx[dir]
  var y2 = y + len * dy[dir];

  line(x*0.5, y*0.5, x2*0.5, y2*0.5);

   if (len > 0) 
   {
     drawTree(x2, y2, dx, dy, len - 1, (dir + 7) % 8);
     drawTree(x2, y2, dx, dy, len - 1, (dir + 1) % 8);
   }
}
