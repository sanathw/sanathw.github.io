// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

// https://www.youtube.com/watch?v=pZ1-YhuJkX8
// Fourth Doctor Titles Version 2 - Doctor Who - BBC
// "C:\Sanath\Video\Fourth Doctor Titles Version 2 - Doctor Who - BBC.mp4"

const MAX_DEPTH = 32;
const STARS = 500;
var starBackground = [];
var star = [];

var showBackground = false;
var showColor = false;
var showGradient = false;
var showStars = 500;
var speed = 0.1;

void setup()
{
  for (int i = 0; i < STARS; i++)
  {
    star[i] = new PVector(random(-200, 200), random(-200, 200), random(1, MAX_DEPTH));
    starBackground[i] = new PVector(random(-200, 200), random(-200, 200));
  }
  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(400, 400, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  var ccr = (int) map(speed, 0, 0.5, 0, 40);
  var ccb = (int) map(speed, 0, 0.5, 60, 10);
  if (showGradient) g.gradientBackground3(VERTICAL, color(0), color(0), 0.5, color(ccr,0,ccb));
  else g.background(0);
  
  
}

void draw()
{
  initDraw();
  
  for (int i = 0; i<showStars; i++)
  {
    star[i].z = star[i].z - speed;
    
    if (star[i].z <= 0)
    {
      star[i].x = random(-200, 200);
      star[i].y = random(-200, 200);
      star[i].z = MAX_DEPTH;
    }
    
    if (showBackground)
    {
      var cc = (int) map(speed, 0, 0.5, 60, 0);
      strokeWeight(0.001); fill(cc); rect(starBackground[i].x, starBackground[i].y, 2, 2);
    }
    
    var c = (int) ((1 - (star[i].z / MAX_DEPTH)) * 255);
    var n = 255 - (int) (min(255, (c * speed *10)));
    
    
    
    
    var c3 = c;
    if (speed <= 0.1)  c3 = (int) (c/map(speed,0, 0.1, 4, 1));
    
    var n3 = n;
    if (speed <= 0.1)  n3 = (int) (c/map(speed,0, 0.1, 1, 4));
    
    if (showColor)
    {
      drawStar(star[i].x, star[i].y, star[i].z-(speed*4), color(255,n3,n3, c3));
      drawStar(star[i].x, star[i].y, star[i].z-(speed*3), color(255,255,n3, c3));
      drawStar(star[i].x, star[i].y, star[i].z-(speed*2), color(n,255,n3, c3));
      drawStar(star[i].x, star[i].y, star[i].z, color(n3,n3,255, c3));
    }
    else
    {
      drawStar(star[i].x, star[i].y, star[i].z, color(c));
    }
  }
}

void drawStar(float star_x, float star_y, float star_z, color c1)
{
  //var t = ((1 - (star_z / MAX_DEPTH)) * 30);


  var p = 15 / star_z;
  int x = (int) (star_x * p);// to curve -300+(t*t);
  int y = (int) (star_y * p);
  var s = (int) ((1 - (star_z / MAX_DEPTH)) * 5);
  //var c = (int) ((1 - (star_z / MAX_DEPTH)) * 255);
  
  strokeWeight(0.001);
  fill(c1); rect(x, y, s, s);
}
