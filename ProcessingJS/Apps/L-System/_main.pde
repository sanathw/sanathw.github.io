// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................


float a = QUARTER_PI/2f;
float l = 20;
//ArrayList C = new ArrayList();
string C = "F";

PGraphics2D g;
void setup()
{
  setSize(100, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(255);
}

void createG()
{
  int s = max(sw, sh);
  g = createGraphics(s, s, P2D);
  g.strokeWeight(1);
  g.noFill();
  int ss = (s / 2) + (s/6);
  g.translate(s/2, ss);
}

void setSeq()
{
  //t1.isDisabled = true;
  //kbContainer.isDisabled = true;
  
  C = "F";
  g.background(0,0);
  
  //C.clear();
  //for(int i = 0; i< t1.txt.length; i++)
  //{
  //  C.add(t1.txt[i]);
  //}
}

/*void insertMapping(ArrayList c){
  for(int i = 0; i< m.length; i++){
    c.add(m[i]);
  }
}*/

void update()
{
  string C1 = "";
  
  for (int i = 0;  i < C.length; i++)
  {
    if (C[i] == "F")
    {
      C1 = C1 + t1.txt;
    }
    else
    {
      C1 = C1 + C[i];
    }
  }
  
  C = C1;
/*  
  ArrayList C1 = new ArrayList();
  
  for(int i = 0; i< C.size(); i++){
    Character c = (Character) C.get(i);
    
    if (c == 'F') insertMapping(C1);
    else C1.add(c);
  }
  
  C = C1;
  redraw();
  */
  
  g.beginDraw();
  g.background(0,0);
  g.pushMatrix();
  
  int p = 0;
  
  for(int i = 0; i< C.length; i++)
  {
    //string c = C[i];
    
    
    //if (c == "F") println("Hello");
    switch(C[i])
    {
      case "F":
        g.line(0,0, 0, -l);
        g.translate(0, -l);
      break;
      case "+":
        g.rotate(a);
      break;
      case "-":
        g.rotate(-a);
      break;
      case "[":
        g.pushMatrix();
        p++;
      break;
      case "]":
        if (p > 0)
        {
          g.popMatrix();
          p--;
        }
      break;
    }
   // 
  }
  
  while (p > 0)
  {
    g.popMatrix();
    p--;
  }
  
  g.popMatrix(); 
  g.endDraw();
}


boolean resetSeq = true;
void draw()
{
  initDraw();
  
  if (g == null) {createG();}
  
  if (g != null)
  {
    if (mousePressed && mousePressed != pmousePressed)
    {
      //if (resetSeq) {resetSeq = false; setSeq();}
      
      update();
      //println(C);
    }
    
    imageMode(CENTER);
    image(g, 0, 0);
  }
}
