// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................


Card c;
int i = 0;
int maxI = 0;

PImage img;
PGraphics2D g;
//PGraphics2D g;
void setup()
{
  img = loadImage("./_resources/cards.png");
  
  doZoom = false;
  doTranslate = false;
  doRotate = false;
  setupCards(true);
  setSize(300, 400, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  g.background(220);
}


int currentHand = 0;
int points = 0;
int delay = 0;

void draw()
{
  initDraw();
  
  pushMatrix();
  translate(0, -180);
  fill(0);
  pushMatrix();
  scale(2);
  text("Opener", 0, 0);
  popMatrix();
  translate(0, 20);
  
  if (currentHand == 0) text("North", 0, 0);
  else if (currentHand == 1) text("East", 0, 0);
  else if (currentHand == 2) text("South", 0, 0);
  else text("West", 0, 0);
  
  pushMatrix();
  translate(-190,60);
  scale(0.24);
  points = 0;
  for (i = 0; i < hands[currentHand].cards.size(); i++)
  {
    translate(114, 0);
    c = (Card) hands[currentHand].cards.get(i);
    drawCard(c);
    
    if (c.value == "A") points += 4;
    if (c.value == "K") points += 3;
    if (c.value == "Q") points += 4;
    if (c.value == "J") points += 1;
    
  }
  popMatrix();
  
  if (delay > 150)
  {
  
  translate(0, 120);
  fill(0);
  text(points, 0, 0);
  }
  else delay++;
  
  popMatrix();
  
}



