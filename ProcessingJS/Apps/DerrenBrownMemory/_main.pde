// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

int speed = 30;

class Card
{
  String value;
  String suite;
  String txt;
  Card(String v, String s, String t)
  {
    value = v;
    suite = s;
    txt = t;
  }
}

class Number
{
  String value;
  String txt;
  Number(String v, String t)
  {
    value = v;
    txt = t;
  }
}

ArrayList deck = new ArrayList();
ArrayList cards = new ArrayList();
Card c;

ArrayList numList = new ArrayList();
ArrayList numbers = new ArrayList();
Number n;

boolean isCards = true;
boolean isShuffle = true;
boolean isRandom = false;

int i = 0;
int maxI = 0;

//PGraphics2D g;
void setup()
{
  resetDisplay();
  
  doZoom = false;
  doTranslate = false;
  doRotate = false;
  
  setSize(300, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  if (isCards) g.background(220);
  else g.background(255);
}

void resetDisplay()
{
  if (isCards) setupCards(isShuffle);
  else setupNumbers(isShuffle);
  delay = 0;
}

void setupCards(boolean shuffle)
{
  deck.clear();
  cards.clear();
  maxI = 52;
  
  deck.add(new Card("", "S", "Grim Reaper"));
  deck.add(new Card("2", "S", "sun"));
  deck.add(new Card("3", "S", "sum"));
  deck.add(new Card("4", "S", "sore"));
  deck.add(new Card("5", "S", "safe"));
  deck.add(new Card("6", "S", "sob"));
  deck.add(new Card("7", "S", "soot"));
  deck.add(new Card("8", "S", "sash"));
  deck.add(new Card("9", "S", "ciggy"));
  deck.add(new Card("10", "S", "sissy"));
  deck.add(new Card("J", "S", "boy digging"));
  deck.add(new Card("Q", "S", "house maid"));
  deck.add(new Card("K", "S", "gardener"));
  
  deck.add(new Card("", "H", "Big Love Heart"));
  deck.add(new Card("2", "H", "two lovers"));
  deck.add(new Card("3", "H", "home"));
  deck.add(new Card("4", "H", "hair"));
  deck.add(new Card("5", "H", "hoof"));
  deck.add(new Card("6", "H", "hoop"));
  deck.add(new Card("7", "H", "hat"));
  deck.add(new Card("8", "H", "hedge"));
  deck.add(new Card("9", "H", "hag"));
  deck.add(new Card("10", "H", "horse"));
  deck.add(new Card("J", "H", "cupid"));
  deck.add(new Card("Q", "H", "bride"));
  deck.add(new Card("K", "H", "groom"));
  
  deck.add(new Card("", "C", "Big Club"));
  deck.add(new Card("2", "C", "can"));
  deck.add(new Card("3", "C", "cum"));
  deck.add(new Card("4", "C", "car"));
  deck.add(new Card("5", "C", "cough"));
  deck.add(new Card("6", "C", "cob"));
  deck.add(new Card("7", "C", "cat"));
  deck.add(new Card("8", "C", "cash"));
  deck.add(new Card("9", "C", "cog"));
  deck.add(new Card("10", "C", "kiss"));
  deck.add(new Card("J", "C", "boy at club"));
  deck.add(new Card("Q", "C", "brothel madam"));
  deck.add(new Card("K", "C", "bouncer (cock)"));
  
  deck.add(new Card("", "D", "Big Diamond"));
  deck.add(new Card("2", "D", "dunny"));
  deck.add(new Card("3", "D", "dome"));
  deck.add(new Card("4", "D", "door"));
  deck.add(new Card("5", "D", "dove"));
  deck.add(new Card("6", "D", "Derren Brown"));
  deck.add(new Card("7", "D", "dot"));
  deck.add(new Card("8", "D", "dish"));
  deck.add(new Card("9", "D", "dog"));
  deck.add(new Card("10", "D", "dizzy"));
  deck.add(new Card("J", "D", "diamond thief"));
  deck.add(new Card("Q", "D", "the queen"));
  deck.add(new Card("K", "D", "jeweller"));
  
  if (shuffle)
  {
    for (i = 0; i < maxI; i++)
    {
      int j = (int) random(0, deck.size());
      cards.add(deck.get(j));
      deck.remove(j);
    }
  }
  else
  {
    for (i = 0; i < maxI; i++)
    {
      cards.add(deck.get(i));
    }
  }
  
  if (isRandom)
  {
    i = (int)random(0, maxI);
  }
  else
  {
    i = 0;
  }
  c = (Card) cards.get(i);
}


void setupNumbers(boolean shuffle)
{
  numList.clear();
  numbers.clear();
  maxI = 53;
  
  numList.add(new Number("0", "zoo"));
  numList.add(new Number("1", "ale"));
  numList.add(new Number("2", "hen"));
  numList.add(new Number("3", "ham"));
  numList.add(new Number("4", "whore"));
  numList.add(new Number("5", "hive"));
  numList.add(new Number("6", "bee"));
  numList.add(new Number("7", "tea"));
  numList.add(new Number("8", "shoe"));
  numList.add(new Number("9", "goo"));
  
  numList.add(new Number("10", "lice"));
  numList.add(new Number("11", "lily"));
  numList.add(new Number("12", "line"));
  numList.add(new Number("13", "lime"));
  numList.add(new Number("14", "lorry"));
  numList.add(new Number("15", "laugh"));
  numList.add(new Number("16", "lip"));
  numList.add(new Number("17", "light"));
  numList.add(new Number("18", "ledge"));
  numList.add(new Number("19", "leg"));
  
  numList.add(new Number("20", "nose"));
  numList.add(new Number("21", "nail"));
  numList.add(new Number("22", "nanny"));
  numList.add(new Number("23", "gnome"));
  numList.add(new Number("24", "Nero"));
  numList.add(new Number("25", "knife"));
  numList.add(new Number("26", "nob"));
  numList.add(new Number("27", "knight"));
  numList.add(new Number("28", "notch"));
  numList.add(new Number("29", "nag"));
  
  numList.add(new Number("30", "mouse"));
  numList.add(new Number("31", "mail"));
  numList.add(new Number("32", "money"));
  numList.add(new Number("33", "mum"));
  numList.add(new Number("34", "merry"));
  numList.add(new Number("35", "muff"));
  numList.add(new Number("36", "map"));
  numList.add(new Number("37", "mat"));
  numList.add(new Number("38", "match"));
  numList.add(new Number("39", "mag"));
  
  numList.add(new Number("40", "rose"));
  numList.add(new Number("41", "rail"));
  numList.add(new Number("42", "rain"));
  numList.add(new Number("43", "ram"));
  numList.add(new Number("44", "roar"));
  numList.add(new Number("45", "rave"));
  numList.add(new Number("46", "rub"));
  numList.add(new Number("47", "root"));
  numList.add(new Number("48", "retch"));
  numList.add(new Number("49", "rag"));
  
  numList.add(new Number("50", "fuse"));
  numList.add(new Number("51", "fall"));
  numList.add(new Number("52", "fan"));
  
  if (shuffle)
  {
    for (i = 0; i < maxI; i++)
    {
      int j = (int) random(0, numList.size());
      numbers.add(numList.get(j));
      numList.remove(j);
    }
  }
  else
  {
    for (i = 0; i < maxI; i++)
    {
      numbers.add(numList.get(i));
    }
  }
  
  if (isRandom)
  {
    i = (int)random(0, maxI);
  }
  else
  {
    i = 0;
  }
  n = (Number) numbers.get(i);
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

/*
float loc = 1;
int startX = 0;
float dx = 0;*/

boolean directionUp = true;
int currH = 0;
boolean moveCardOut = false;
boolean moveCardIn = false;
int startY = 0;

int delay = 0;
int delayT = 40;
int otxt = 0;
int ocrd = 255;

boolean showCard = true;

boolean directionSet = false;
void draw()
{
  initDraw();
  
  //if (g == null) {createG();}
  //if (g != null)
  //{
  //  imageMode(CENTER);
  //  image(g, 0, 0);
  //}
  
  /*if (mousePressed == false)
  {
    loc = loc -  loc / 10f;
    if (abs(loc) < 0.005) loc = 0;
  }
  
  if (mousePressed == true && mousePressed != pmousePressed)
  {
    startX = mouseX;
    dx = 0;
  }
  
  if (mousePressed == true)
  {
    dx = startX - mouseX;
    //dx = map(dx, -sw, sw, -1, 1); 
    if (dx < 0) loc = loc + ((1 - loc) / 50f);
    if (dx > 0) loc = loc + ((-1 - loc) / 50f);
    startX = mouseX;
  }*/
  
  
  if (mousePressed == true && mousePressed != pmousePressed)
  {
    startY = mouseY;
  }
  
  if (mousePressed == true)
  {
    moveCardOut = false;
    moveCardIn = false;
    currH -= (startY - mouseY);
    
    
    if (mouseY < startY) {directionUp = true; directionSet = true;}
    if (mouseY > startY) {directionUp = false; directionSet = true;}
    
    startY = mouseY;
  }
  else
  {
    if (moveCardOut == false && moveCardIn == false)
    {
      if (delayT == 0)// || delayT == -1)
      {
        if (!showCard) {ocrd = 255;}
        else {otxt = 255;}
      }
      else if (delayT == -1)
      {
        if (!showCard) {ocrd = 0;}
        else {otxt = 0;}
      }
      else
      {
        if (delay >= delayT)
        {
          if (otxt > 255) otxt = 255;
          else otxt += 5;
          
          if (ocrd > 255) ocrd = 255;
          else ocrd += 5;
        }
        else delay++;
      }
    }
  }
  
  if (mousePressed == false && mousePressed != pmousePressed)
  {
    if (directionSet) moveCardOut = true;
    directionSet = false;
  }
  
  pushMatrix();
  
  /*
  float ss = map (abs(loc), 0, 1, 1, 0.4);
  scale(ss);
  ss = map (loc, -1, 1, -250, 250);
  translate(ss, 0);
  ss = map(abs(loc), 0, 1, 1, 0.1);
  scale(ss, 1);*/
  
  if (moveCardOut == true)
  {
    if (directionUp)
    {
      currH = currH - speed;
      
      if (currH < - 300)
      {
        currH = 300;
        moveCardOut = false;
        
        if (isRandom)
        {
          i = (int)random(0, maxI);
        }
        else
        {
          i++;
          if (i == maxI) i = 0;
        }
        
        if (isCards) c = (Card) cards.get(i);
        else n = (Number) numbers.get(i);
        
        moveCardIn = true;
        
        if (showCard) otxt = 0;
        else ocrd = 0;
      }
    }
    else
    {
      currH = currH + speed;
      
      if (currH > 300)
      {
        currH = -300;
        moveCardOut = false;
        
        if (isRandom)
        {
          i = (int)random(0, maxI);
        }
        else
        {
          i--;
          if (i == -1) i = (maxI-1);
        }
        
        if (isCards) c = (Card) cards.get(i);
        else n = (Number) numbers.get(i);
        
        moveCardIn = true;
        
        if (showCard) otxt = 0;
        else ocrd = 0;
      }
    }
  }
  
  if (moveCardIn == true)
  {
    if (directionUp)
    {
      currH = currH - speed;
      
      if (currH < 0)
      {
        currH = 0;
        delay = 0;
        moveCardIn = false;
      }
    }
    else
    {
      currH = currH + speed;
      
      if (currH > 0)
      {
        currH = 0;
        delay = 0;
        moveCardIn = false;
      }
    }
  }
  
  translate(0, currH);
  
  if (isCards) drawCard(c);
  else drawNumber(n);
  
  popMatrix();
  
  stroke(0, 90);
  line(-100, -130, 100, -130);
  int x = map(i, 0, (maxI-1), -100, 100);
  fill(0, 90);
  ellipseMode(CENTER);
  ellipse(x, -130, 10, 10);
}

void drawNumber(Number n)
{
  pushMatrix();
  scale(8);
  fill(0, ocrd);
  textAlign(CENTER, CENTER);
  text(n.value, 0, 0);
  popMatrix();
  
  
  pushMatrix();
  scale(2);
  fill(0, otxt);
  textAlign(CENTER, CENTER);
  text(n.txt, 0, 60);
  popMatrix();
}


void drawCard(Card c)
{
  fill(255);
  stroke(0);
  rectMode(CENTER);
  rect(0, 0, 150, 200);
  
  float ss = sw/2f;
  
  pushMatrix();
  if (c.value == "") scale(0.8);
  else scale(0.4);
  
  if (c.suite == "S")
  {
    stroke(0); fill(0);
    drawSpade(0, 0, ss);
  }
  else if (c.suite == "H")
  {
    stroke(255,0,0); fill(255,0,0);
    drawHeart(0, 0, ss);
  }
  else if (c.suite == "C")
  {
    stroke(0); fill(0);
    drawClub(0, 0, ss);
  }
  else if (c.suite == "D")
  {
    stroke(255,0,0); fill(255,0,0);
    drawDiamond(0, 0, ss);
  }
  popMatrix();
  
  drawValue(c.value); 
  
  pushMatrix();
  scale(2);
  fill(0, otxt);
  textAlign(CENTER, CENTER);
  text(c.txt, 0, 60);
  popMatrix();
  
  fill(220, (255-ocrd));
  noStroke();
  rectMode(CENTER);
  rect(0, 0, 154, 204);
}

void drawValue(String v)
{
  pushMatrix();
  scale(3);
  textAlign(CENTER, CENTER);
  text(v, 18, -26);
  text(v, -18, 26);
  //rotate(PI);
  //text(v, 12, -18);
  popMatrix();
}

//void drawBack()
//{
//  fill(200);
//  rect(e, e, width - e2, height - e2);
//}

void drawSpade(float x, float y, float s)
{
  float d = s/4f;
  float w = s/2f;
  bezier(x, y+d, x+w, y+w, x+w, y, x, y-w);
  bezier(x, y+d, x-w, y+w, x-w, y, x, y-w);
  beginShape();
  vertex(x, y);
  bezierVertex(x, y, x, y+w, x+d, y+w);
  vertex(x, y+w);
  endShape();
  beginShape();
  vertex(x, y);
  bezierVertex(x, y, x, y+w, x-d, y+w);
  vertex(x, y+w);
  endShape();
}

void drawHeart(float x, float y, float s)
{
  float d = s/4f;
  float w = s/2f;
  bezier(x, y-d, x+w, y-w, x+w, y, x, y+w);
  bezier(x, y-d, x-w, y-w, x-w, y, x, y+w);
}

void drawClub(float x, float y, float s)
{
  float d = s/4f;
  float w = s/2f;
  ellipse(x, y-d, w, w);
  ellipse(x-d, y, w, w);
  ellipse(x+d, y, w, w);
  beginShape();
  vertex(x, y);
  bezierVertex(x, y, x, y+w, x+d, y+w);
  vertex(x, y+w);
  endShape();
  beginShape();
  vertex(x, y);
  bezierVertex(x, y, x, y+w, x-d, y+w);
  vertex(x, y+w);
  endShape();
}

void drawDiamond(float x, float y, float s)
{
  float d = s/4f;
  float w = s/2f;
  beginShape();
  vertex(x, y-w);
  vertex(x-w, y);
  vertex(x, y+w);
  vertex(x+w, y);
  endShape();
}
