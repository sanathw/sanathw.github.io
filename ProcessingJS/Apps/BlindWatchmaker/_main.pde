// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

int cellWidth = 10;
int cellHeight = 10;

class Cell
{
  int id;
  String l = "";
  float weight = 0.5;
  boolean diff = false;
  boolean match = false;
  void display(color clr, int a1, int a2, boolean displayWeight, boolean displayBack, boolean showDiff)
  {
    //fill(255); noStroke(); rectMode(CENTER); rect(0, 0, cellWidth, cellHeight);
    if (displayBack)
    {
      if (diff && showDiff) 
      {
        fill(255, 0, 0, a2); noStroke(); rectMode(CENTER); rect(0, 0, cellWidth, cellHeight);
      }
      else
      {
        fill(255, a2); noStroke(); rectMode(CENTER); rect(0, 0, cellWidth, cellHeight);
      }
    }
    
    if (match) fill(red(clr), green(clr), blue(clr), a2); else fill(red(clr), green(clr), blue(clr), (int)(a2/2));
    textAlign(CENTER, CENTER); text(l, 0, 0);
    
    if (displayWeight)
    {
      stroke(red(clr), green(clr), blue(clr), (int)(a2/4));
      strokeWeight(1);
      line(0, -cellHeight, 0, (int)(-cellHeight - (cellHeight*1*weight)));
    }
  }
}

class DNA
{
  var cells;
  int score = 0;
  color clrTitle = color(0);
  color clrCode = color(0);
  boolean displayWeight = false;
  boolean displayBack = true;
  
  void set(String ss)
  {
    cells = new Array(ss.length);
    for (int i = 0; i < ss.length; i++)
    {
      cells[i] = new Cell();
      cells[i].id = i;
      cells[i].l = ss[i];
      cells[i].weight = 0.5;
    }
  }
  
  void setRandom(int c)
  {
    cells = new Array(c);
    for (int i = 0; i < c; i++)
    {
      int l = (int) random(97, 123.5);
      if (l == 123) l = 32;
      cells[i] = new Cell();
      cells[i].id = i;
      cells[i].l = String.fromCharCode(l);
      cells[i].weight = 0.5;
    }
  }
  
  void copy(var a)
  {
    cells = new Array(a.cells.length);
    for (int i = 0; i < cells.length; i++)
    {
      cells[i] = new Cell(); 
      cells[i].id = a.cells[i].id;
      cells[i].l = a.cells[i].l;
      cells[i].weight = a.cells[i].weight;
      cells[i].diff = a.cells[i].diff;
      cells[i].match = a.cells[i].match;
    }
    score = a.score;
  }
  
 // var get()
 // {
 //   var values = new Array(cells.length);
 //   for (int i = 0; i < cells.length; i++) values[i] = cells[i].l;
 //   return values;
 // }
  
  void updateRandom(var rr, var t)
  {
    for (int i = 0; i < cells.length; i++) cells[i].diff = false;
    
    for (int i = 0; i < rr.length; i++)
    {
      int x = rr[i]; //97=a 122=z 32=space 65=A 90=Z  46=.  63=? 
      //int l = (int) random(97, 123.5);
      //if (l == 123) l = 32;
      int l = (int) random(65, 122.5);
      if (l == 91) l = 32;
      if (l == 92) l = 46;
      if (l == 93) l = 63;
      cells[x].l = String.fromCharCode(l);
      cells[x].diff = true;
    }
    
    compare(t);
  }
  
  void compare(var t)
  {
    //println(t);
    score = 0;
    for (int i = 0; i < cells.length; i++)
    {
      //if (a != null) {if (cells[i].l == a[i]) cells[i].diff = false; else cells[i].diff = true;}
      if (cells[i].l == t.cells[i].l) { cells[i].match = true; score++; }  else cells[i].match = false;
    }
  }
  
  void display(int x, int y, int a1, int a2)
  {
    pushMatrix();
    translate(x, y);
    
    boolean showDiff = true;
    
    if (score >= 0) 
    { 
      if (score >= cells.length)
      {
        fill(255, 255, 0, a1); stroke(red(clrTitle), green(clrTitle), blue(clrTitle), a1); strokeWeight(1);
        ellipseMode(CENTER); ellipse(0, 0, cellWidth*2, cellHeight*2);
        showDiff = false;
      }
      fill(red(clrTitle), green(clrTitle), blue(clrTitle), a1);
      textAlign(CENTER, CENTER); text(score, 0, 0); 
    }
    translate(cellWidth * 3, 0);
    scale(1.8);
    
    for (int i = 0; i < cells.length; i++)
    {
      translate(cellWidth, 0);
      cells[i].display(clrCode, a1, a2, displayWeight, displayBack, showDiff);
    }
    popMatrix();
  }
}


DNA target = new DNA();
DNA parent = new DNA();
DNA child = new DNA();
DNA monkey = new DNA();
DNA monkeyBest = new DNA();

//var childPrevious;
//var monkeyPrevious;

var createRandom(int n, var l)
{
  var rr = new Array(n);
  
  for (int i = 0; i < n; i++)
  {
    int x = (int) random(0, l);
    rr[i] = x;
  }
  return rr;
}

//boolean showOnce = false;
var createWeightedRandom(int n, var cells)
{
  var rr = new Array(n);
  
  // sort the cells
  var sortedCells = new Array(cells.length);
  for (int i = 0; i < cells.length; i++) sortedCells[i] = cells[i];
  sortedCells.sort(function(a, b){return a.weight-b.weight});
  
  // get totalWeight
  float totalWeight = 0;
  //string ss = "";
  for (int i = 0; i < sortedCells.length; i++) 
  {
    totalWeight += sortedCells[i].weight;
    //ss += "[" + sortedCells[i].weight + " " + sortedCells[i].l + "] ";
  }
  //if (showOnce) println(ss);
  //showOnce = false;
  
  for (int i = 0; i < n; i++)
  {
    float xx = random(0, totalWeight);
    //println(xx);
    //string ss = "";
    int x = 0;
    totalWeight = 0;
    for (int j = 0; j < sortedCells.length; j++)
    {
      //ss += sortedCells[j].l;
      x = j;
      totalWeight += sortedCells[j].weight;
      if (totalWeight > xx) break;
    }
    
    //println(ss);
    rr[i] = sortedCells[x].id;
  }
  return rr;
}

int NN = 1;
void updateRandom()
{
  var rr;
  //rr = createRandom(1, child.cells.length); child.updateRandom(rr, target); //childPrevious = child.get();
  //rr = createRandom(1, monkey.cells.length); monkey.updateRandom(rr, target); //monkeyPrevious = monkey.get();
  
  rr = createWeightedRandom(NN, parent.cells); 
  child.updateRandom(rr, target);
  
  //String ss = ""; for (int i = 0; i < child.cells.length; i++) ss += child.cells[i].l + " ";  println(ss);
  //String ss = ""; for (int i = 0; i < parent.cells.length; i++) ss += parent.cells[i].l + " ";  println(ss);
  //
  
  for (int i = 0; i < child.cells.length; i++)
  {
    if (child.cells[i].l != parent.cells[i].l) parent.cells[i].diff = true;
    else parent.cells[i].diff = false;
  }
  
  //String ss = ""; for (int i = 0; i < parent.cells.length; i++) ss += parent.cells[i].diff + " ";  println(ss);
  
  rr = createRandom(NN, target.cells.length); 
  monkey.updateRandom(rr, target);
  
  //rr = createRandom(1, target.cells.length); 
  //child.updateRandom(rr, target);
  //monkey.updateRandom(rr, target);
  gen++;
}

void updateWeights(int direction)
{
  for (int i = 0; i < parent.cells.length; i++)
  {
    if (direction > 0)
    {
      // Parent change: recude change of cell next time since it made this better - i.e. keep the child
      if (parent.cells[i].diff) {parent.cells[i].weight += (0 - parent.cells[i].weight) / 2;}
    }
    else if (direction == 0)
    {
      // Parent not changed: increase change of cell next time since it made no difference this time
      if (parent.cells[i].diff) {parent.cells[i].weight += (1 - parent.cells[i].weight) / 2;}
    }
    else
    {
      // Parent not changed: recude change of cell next time since it made this wore - i.e. keep the parent
      if (parent.cells[i].diff) {parent.cells[i].weight += (0 - parent.cells[i].weight) / 2;}
    }
  }

  /*if (isGood)
  {
    for (int i = 0; i < child.cells.length; i++)
    {
      if (child.cells[i].diff) parent.cells[i].weight = 0;// += (0 - parent.cells[i].weight) / 1.5;
    }
  }*/
  /*else
  {
    if (child.score < parent.score)
    {
      for (int i = 0; i < child.cells.length; i++)
      {
        if (child.cells[i].diff) parent.cells[i].weight += (1 - parent.cells[i].weight) / 15;
      }
    }
    else
    {
      for (int i = 0; i < child.cells.length; i++)
      {
        if (child.cells[i].diff) 
        {
          parent.cells[i].weight += (1 - parent.cells[i].weight) / 20;
        }
        else
        {
          parent.cells[i].weight += (0 - parent.cells[i].weight) / 20;
        }
      }
    }
  }*/

  
  /*for (int i = 0; i < child.cells.length; i++)
  {
    if (child.cells[i].l != parent.cells[i].l)
    {
      if (child.score > parent.score)
      {
        parent.cells[i].weight = parent.cells[i].weight + (0 - parent.cells[i].weight) / 2;
      }
      if (child.score < parent.score)
      {
        parent.cells[i].weight = parent.cells[i].weight + (1 - parent.cells[i].weight) / 2;
      }
    }
    else
    {
      if (child.score == parent.score)
      {
        parent.cells[i].weight = parent.cells[i].weight + (0 - parent.cells[i].weight) * map(child.score, 0, child.cells.length, 0, 0.5);
      }
    }
  }*/

  /*
  //if (isGood)
  if (child.score > parent.score)
  {
    for (int i = 0; i < child.cells.length; i++)
    {
      if (child.cells[i].l == parent.cells[i].l)
      {
        parent.cells[i].weight = parent.cells[i].weight + ((0 - parent.cells[i].weight) / 4);//(4*NN));
      }
      else
      {
        parent.cells[i].weight = parent.cells[i].weight + ((0 - parent.cells[i].weight) / 10);//4*NN));
      }
    }
  }*/
  /*else if (child.score < parent.score)
  {
    for (int i = 0; i < child.cells.length; i++)
    {
      if (child.cells[i].l != parent.cells[i].l)
      {
        parent.cells[i].weight = parent.cells[i].weight + ((1 - parent.cells[i].weight) / 4);//(4*NN));
      }
      else
      {
        parent.cells[i].weight = parent.cells[i].weight + ((1 - parent.cells[i].weight) / 10);//4*NN));
      }
    }
  }*/
}

int state = 0;
int pLoc = 0;
int cLoc = 0;
int cAlpha = 255;
void update()
{

  /*//if (state == 5 && cShow <= 0) {pLoc = 0; cLoc = 25; cShow = 255; state = 2; child.copy(parent); parent.compare(target);   child.compare(target); state = 2;}
  //if (state == 5) { cShow -= 2; } 
  if (state == 5) 
  {
    //cShow -= 2;
    
    // next state
    //if (cShow <= 0) 
    {
      pLoc = 0; cLoc = 25; cShow = 255; state = 2; 
      child.copy(parent); parent.compare(target);   child.compare(target); 
      state = 2;
    }
  }*/
  
  if (state == 5) 
  {
    pLoc = 0; cLoc = 25; cAlpha = 255;
    
    if (fast) { pLoc = 0; cLoc = 0; cAlpha = 255;}
    
    // <<<<<<<<<DECREASE
    //if (gen == 0)
    //{
    //  println(parent.score);
    //  if (parent.score > 0) updateWeights(true); else updateWeights(false);
    //}
    //else
    //{
    //  updateWeights(false);
    //}
    
    child.copy(parent);    
    updateRandom();
    child.compare(target); parent.compare(target);
    
    state = 2;
    
    if (fast) update(); 
    
    return;
  }
  
  if (state == 3)
  {
    cAlpha -= 10;
    if (fast) cAlpha = 0;
    
    if (cAlpha <= 0)
    {
      // <<<<<<<<<DECREASE
      if (child.score < parent.score) updateWeights(-1);
      // <<<<<<<<<SAME
      else updateWeights(0);
      //for (int i = 0; i < child.cells.length; i++)
      //{
      //  if (child.cells[i].diff == true) parent.cells[i].weight = parent.cells[i].weight + ((1 - parent.cells[i].weight) / (4*NN));
      //}
      
      state = 5;
      if (fast) update(); 
    }
    
    return;
  }
  
  if (state == 2)
  {
    pLoc += 0; cLoc -= 2;
    
    
    // next state
    if (cLoc <= 0) 
    { 
      pLoc = 0; cLoc = 0;
      if (doContinue == false) start = false;
      state = 0; 
    }
    
    return;
  }
  
  if (state == 1)
  {
    pLoc += 2; cLoc +=2;
    
    // next state
    if (pLoc >= 25) 
    {
      pLoc = 0; cLoc = 25; 
      
      //String ss = ""; for (int i = 0; i < parent.cells.length; i++) ss += parent.cells[i].diff + " ";  println(ss);
      parent.copy(child); 
      
      // >>>>>>>>>>>>>INCREASE
      //String ss = ""; for (int i = 0; i < parent.cells.length; i++) ss += parent.cells[i].diff + " ";  println(ss);
      updateWeights(1);
     //for (int i = 0; i < child.cells.length; i++)
     // {
     //   if (child.cells[i].diff == true) parent.cells[i].weight = parent.cells[i].weight + ((0 - parent.cells[i].weight) / NN);
     // }
      
      child.copy(parent); 
      parent.compare(target);   
      child.compare(target);
      updateRandom();
      state = 2; 
      
      //start = false;
    }
    
    return;
  }
  
  if (state == 0)
  {  
    //updateRandom();
    
    if (monkey.score > monkeyBest.score) 
    {
      monkeyBest.copy(monkey);
      monkeyBest.compare(target);
      //monkeyBest.score = monkey.score;
      //strMonkeyBest = "";
      //for (int i = 0; i < monkey.cells.length; i++)
      //{
      //  strMonkeyBest += "" + monkey.cells[i].l;
      //}
    }
    //String ss = ""; for (int i = 0; i < parent.cells.length; i++) ss += parent.cells[i].diff + " ";  println(ss);
    // next state
    if (child.score > parent.score) 
    {
      if (doContinue == false || doStep == true) start = false;
      state = 1;
    } 
    else 
    {
      //pLoc = 0; cLoc = 25;
      //child.copy(parent); parent.compare(target);   child.compare(target); 
      state = 3;
    }
    
    return;
  }
  
}

int gen = 0;
int monkeyBest = 0;
//String strMonkeyBest = "";
void reset(string str)
{
  target = new DNA();
  parent = new DNA();
  child = new DNA();
  monkey = new DNA();
  monkeyBest = new DNA();
  
  
  
  target.set(str); target.score = -1; target.clrCode = color(0, 255, 0); target.displayBack = false;
  monkey.setRandom(str.length); monkey.clrTitle = color(200, 0, 0);
  
  parent.setRandom(str.length); parent.clrTitle = color(0, 0, 200); parent.displayWeight = true;
  child.copy(parent); child.clrTitle = color(0, 0, 200);
  
  
  monkeyBest.copy(monkey); monkeyBest.clrTitle = color(140); monkeyBest.displayBack = false;
  
  //updateRandom();
  
  //parent.setRandom(str.length); parent.clrTitle = color(0, 0, 200); parent.displayWeight = true;
  //child.copy(parent); child.clrTitle = color(0, 0, 200);
  
  //println(parent.score);
  //if (parent.score > 0) updateWeights(true); else updateWeights(false);
  
  
  //for (int i =0; i < parent.cells.length; i++)
  //{
  //  if (child.cells[i].l = target.cells[i].l) child.cells[i].weight = 0;
  //}
  
  
  parent.compare(target);
  child.compare(target);
  monkey.compare(target);
  monkeyBest.compare(target);
  
  pLoc = 0; cLoc = 25; state = 5; cAlpha = 255;
  gen = 0;
  firstStop = true;
}

boolean firstStop = true;
boolean start = false;
boolean doContinue = false;
boolean doStep = true;
boolean fast = false;

void setup()
{
  //string ss;
  //ss = String.fromCharCode(97); //97=a 122=z 32=space      65=A 90=Z  46=.  63=?  
  //doZoom = false; doTranslate = false; doRotate = false;
  
  reset("Methinks it is like a weasel.");
  //reset("aaaaaaaaaaaaaaaaaaaaaaaaa");
  //reset("Hello");
  
  setSize(300, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.gradientBackground2(VERTICAL, color(100), color(255));//, 0.5, color(255, 0, 0));
  //g.background(255);
}

void draw()
{
  initDraw();
  
  if (mousePressed && mousePressed != pmousePressed) start = true;// {update();}
  
  if (start) update();
  
  int x; int y;
  
  
  x = -h_dw + 10; y = -h_dh + 20;
  textAlign(LEFT, CENTER);fill(0, 200, 0); text("Target: ", x, y);
  target.display(x + 105, y, 255, 255);
  
  
  x = -h_dw + 10; y = -h_dh + 105;
  textAlign(LEFT, CENTER);fill(0, 0, 200); text("Darwin Child: ", x, y);
  child.display(x + 105, y- cLoc, 255, cAlpha);
  
  x = -h_dw + 10; y = -h_dh + 80;
  textAlign(LEFT, CENTER);fill(0, 0, 200); text("Darwin Parent: ", x, y);
  parent.display(x + 105, y- pLoc, 255, (int)(map(pLoc, 0, 25, 255, 0)));
  
  
  
  x = -h_dw + 10; y = -h_dh + 160;
  textAlign(LEFT, CENTER);fill(200, 0, 0); text("Random Monkey: ", x, y);
  monkey.display(x + 105, y, 255, 255);
  
  x = -h_dw + 10; y = -h_dh + 270;
  textAlign(LEFT, CENTER);fill(140); text("Monkey's Best: ", x, y);
  monkeyBest.display(x + 105, y, 255, 100);
  
  x = 0; y = -h_dh + 240;
  translate(x, y);
  pushMatrix();
  scale(2);
  textAlign(CENTER, CENTER); fill(50); text("Generation: " + gen, 0, 0);
  //scale(0.5);
  //translate(0, 25);
  //textAlign(CENTER, CENTER); fill(140); text("Monkey's best: " + monkeyBest, 0, 0);
  //translate(0, 25);
  //textAlign(CENTER, CENTER); fill(140); text(strMonkeyBest, 0, 0);
  popMatrix();
  
  
  if (firstStop && parent.score == target.cells.length && state == 0) {start = false; firstStop = false;}// bStartStop.txt = "Start";}
}
