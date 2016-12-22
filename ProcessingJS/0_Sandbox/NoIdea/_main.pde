void setup()
{

  setSize(300, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(255);
}



int boxX= 0;
int boxY= 0;

int bulletX = 0;
int bulletY = 0;
boolean killed = false;


void DrawCrossHair(int x, int y)
{

  strokeWeight(1);
  stroke(125, 125, 125);
  fill(125, 125, 125);
  ellipse(bulletX, bulletY, 10, 10);

  line(x, y-20, x, y+20);
  line(x-20, y, x+20, y);
 
  if (mousePressed)
  {
    fill(255, 255, 0);
    bulletX = x;
    bulletY = y;
   
    if ( (x > boxX - 20) && (x < boxX + 20) && (y > boxY - 20) && (y < boxY + 20))
    {
      killed = true;
      score = score + 10;
    }
    else
    {
      score = score - 1;
      bkColor = bkColor - 2;
      if (bkColor < 0) bkColor = 0;
    }
  }
  else
  {
    noFill();
  }
  ellipse(x, y, 10, 10);
 
}

int bkColor = 255;

boolean allowReset = false;
int difficulty = 0;
int score = 0;

void draw()
{
  ellipseMode(CENTER);
  rectMode(CENTER);
 
  initDraw();
 
  if (killed)
  {
    background(255,0,0);
    
    if (allowReset && mousePressed)
    {
      killed = false;
      allowReset = false;
      boxX = mouseX + 50;
      boxY = mouseY + 50;
      difficulty = difficulty + 1;
      bkColor = 255;
    }
    
    if (!allowReset && !mousePressed)
    {
      allowReset = true;
    }
  }
  else
  {
    background(255, bkColor, bkColor);
    int q = random(0+(difficulty*5), 10+(difficulty*5));
 
    int r = random(0, 10);
    if (r < 5) boxX = boxX -q;
    else boxX = boxX + q;
 
    r = random(0, 10);
    if (r < 5) boxY = boxY -q;
    else boxY = boxY + q;
 
    if (boxX > 150) boxX = 150;
    if (boxX < -150) boxX = -150;
 
    if (boxY > 150) boxY = 150;
    if (boxY < -150) boxY = -150;
    
    stroke(240, 0, 0);
 
    fill(255, 0, 0);
    rect(boxX, boxY, 20, 20);
 
    DrawCrossHair(mouseX, mouseY);
    
  }
  
    fill(0);
    text("Difficulty: " + difficulty, -120, -120);
    text("Score: " + score, 120, -120);

}