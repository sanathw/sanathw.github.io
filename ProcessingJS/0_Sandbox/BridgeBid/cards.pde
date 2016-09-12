
class Hand
{
	ArrayList cards = new ArrayList();
  void sort()
  {
    Card c1;
    Card c2;
    
    for (int i = 0; i < cards.size() - 1; i++)
    {
      c1 = (Card) cards.get(i);

      for (int j = i + 1; j < cards.size(); j++)
      {
        c2 = (Card) cards.get(j);
        
        if (c2.order > c1.order)
        {
          //println("   " + c1.suite + " " + c2.suite);
          cards.set(i, c2);
          cards.set(j, c1);
          
          c1 = (Card) cards.get(i);
          c2 = (Card) cards.get(j);
          //println("-> " + c1.suite + " " + c2.suite);
        }
      }
    }
  }
}

var hands = [];




class Card
{
  String value;
  String suite;
  int order;
  int x;
  int y;
  Card(String v, String s, int o, int xloc, int yloc)
  {
    value = v;
    suite = s;
    order = o;
    x = 1 + (xloc * 73);
    y = 1 + (yloc * 98);
  }
}

ArrayList deck = new ArrayList();
ArrayList cards = new ArrayList();

void setupCards(boolean shuffle)
{
  hands[0] = new Hand();
  hands[1] = new Hand();
  hands[2] = new Hand();
  hands[3] = new Hand();

  deck.clear();
  cards.clear();
  maxI = 52;
  
  
  
  deck.add(new Card("2", "D", 0, 1, 3));
  deck.add(new Card("3", "D", 1, 2, 3));
  deck.add(new Card("4", "D", 2, 3, 3));
  deck.add(new Card("5", "D", 3, 4, 3));
  deck.add(new Card("6", "D", 4, 5, 3));
  deck.add(new Card("7", "D", 5, 6, 3));
  deck.add(new Card("8", "D", 6, 7, 3));
  deck.add(new Card("9", "D", 7, 8, 3));
  deck.add(new Card("10", "D", 8, 9, 3));
  deck.add(new Card("J", "D", 9, 10, 3));
  deck.add(new Card("Q", "D", 10, 11, 3));
  deck.add(new Card("K", "D", 11, 12, 3));
  deck.add(new Card("A", "D", 12, 0, 3));
  
  deck.add(new Card("2", "C", 13, 1, 0));
  deck.add(new Card("3", "C", 14, 2, 0));
  deck.add(new Card("4", "C", 15, 3, 0));
  deck.add(new Card("5", "C", 16, 4, 0));
  deck.add(new Card("6", "C", 17, 5, 0));
  deck.add(new Card("7", "C", 18, 6, 0));
  deck.add(new Card("8", "C", 19, 7, 0));
  deck.add(new Card("9", "C", 20, 8, 0));
  deck.add(new Card("10", "C", 21, 9, 0));
  deck.add(new Card("J", "C", 22, 10, 0));
  deck.add(new Card("Q", "C", 23, 11, 0));
  deck.add(new Card("K", "C", 24, 12, 0));
  deck.add(new Card("A", "C", 25, 0, 0));
  
  deck.add(new Card("2", "H", 26, 1, 2));
  deck.add(new Card("3", "H", 27, 2, 2));
  deck.add(new Card("4", "H", 28, 3, 2));
  deck.add(new Card("5", "H", 29, 4, 2));
  deck.add(new Card("6", "H", 30, 5, 2));
  deck.add(new Card("7", "H", 31, 6, 2));
  deck.add(new Card("8", "H", 32, 7, 2));
  deck.add(new Card("9", "H", 33, 8, 2));
  deck.add(new Card("10", "H", 34, 9, 2));
  deck.add(new Card("J", "H", 35, 10, 2));
  deck.add(new Card("Q", "H", 36, 11, 2));
  deck.add(new Card("K", "H", 37, 12, 2));
  deck.add(new Card("A", "H", 38, 0, 2));
  
  deck.add(new Card("2", "S", 39, 1, 1));
  deck.add(new Card("3", "S", 40, 2, 1));
  deck.add(new Card("4", "S", 41, 3, 1));
  deck.add(new Card("5", "S", 42, 4, 1));
  deck.add(new Card("6", "S", 43, 5, 1));
  deck.add(new Card("7", "S", 44, 6, 1));
  deck.add(new Card("8", "S", 45, 7, 1));
  deck.add(new Card("9", "S", 46, 8, 1));
  deck.add(new Card("10", "S", 47, 9, 1));
  deck.add(new Card("J", "S", 48, 10, 1));
  deck.add(new Card("Q", "S", 49, 11, 1));
  deck.add(new Card("K", "S", 50, 12, 1));
  deck.add(new Card("A", "S", 51, 0, 1));
  
int h = -1;

    for (i = 0; i < maxI; i++)
    {
		if (i % 13 == 0) h = h + 1;
	
      int j = (int) random(0, deck.size());
      hands[h].cards.add(deck.get(j));
      //hands[h].add(cards.add(deck.get(j)));
      deck.remove(j);
    }
    
    hands[0].sort();
}

void createG()
{
  g = createGraphics(71, 96, P2D);
}

void drawCard(Card c)
{
  if (img.width > 0 && g == null) {createG();}
  
  if (g != null)
  {
    g.beginDraw();
    g.pushMatrix();
    g.translate(-c.x, -c.y);
    g.image(img, 0, 0);
    //g.copy(img, x, y, imgW, imgH, 0, 0, 80, 80);
    g.popMatrix();
    g.endDraw();
    
    imageMode(CENTER);
    
    pushMatrix();
    //translate(0, -30);
    //scale(100/g.height);
    scale(4);
    image(g, 0, 0);
    popMatrix();
  }
  /*fill(255);
  stroke(100); strokeWeight(4);
  rectMode(CENTER);
  rect(0, 0, 150, 200);
  
  float ss = sw/2f;
  
  pushMatrix();
  if (c.value == "A" || c.value == "") scale(0.4);
  else scale(0.2);
  
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
  
  drawValue(c); */
 
}

void drawValue(Card c)
{
  pushMatrix();
  translate(-54, -78);
  
  float ss = 20;
  
  if (c.suite == "S")
  {
    stroke(0); fill(0);
    drawSpade(0, 35, ss);
  }
  else if (c.suite == "H")
  {
    stroke(255,0,0); fill(255,0,0);
    drawHeart(0, 35, ss);
  }
  else if (c.suite == "C")
  {
    stroke(0); fill(0);
    drawClub(0, 35, ss);
  }
  else if (c.suite == "D")
  {
    stroke(255,0,0); fill(255,0,0);
    drawDiamond(0, 35, ss);
  }
  
  scale(3);
  textAlign(CENTER, CENTER);
  text(c.value, 0, 0);
  //stroke(255,0,0); fill(255,0,0);
  //drawSpade(0, 10, 4);
  //text(c.value, 18, 26);
  //rotate(PI);
  //text(v, 12, -18);
  popMatrix();
}

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