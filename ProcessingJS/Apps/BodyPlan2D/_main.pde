// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

//int[] DNA = new int[]{ 9, 6, 0, 1, 2, 2, 0, 2, 1, 2,       5, 3, 0, 1, 3, 0, 1,1,1,0};
//int[] DNA = new int[]{3, 0, 1, 3, 0, 1,1,1,0};
//int[] DNA = new int[]{5,	4,	6,	5,	0,	8,	0,	7,	2,	4,	5,	7,	7,	1};

//int[] DNA = new int[]{6};
//int[] DNA = new int[10];

int count = 0;

float S = 10;
float S_LINE = S + (S);// / 10f);

//PGraphics2D g;
void setup()
{
  setSize(400, 600, P2D, FIT_OUTSIDE, this); // this has to be the last line in this function
  
  S = (float)sw / 60f;
  S_LINE = S + (S);
}

void drawBackground(var g)
{
  g.gradientBackground3(VERTICAL, color(255,0,255), color(255,200,255), .8, color(0,0,200));//, 0.5, color(255, 0, 0));
  //g.background(255);
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

class DNAPointer{
  int p = 0;
  DNAPointer(int p){
    this.p = p;
  }
  
  int getValue(){
    return DNA[p];
  }
  
  int getNextValue(){
    getNextP();
    return DNA[p];
  }
  
  int getNextP(){
    p++;
    if (p == DNA.length) p = 0;
    return p;
  }
}

boolean firstDraw = true;
Animal animal = null;
void draw()
{
  initDraw();
  
  //if (g == null) {createG();}
  //if (g != null)
  //{
  //  imageMode(CENTER);
  //  image(g, 0, 0);
  //}
  
  
  if ((mousePressed && mousePressed != pmousePressed) || firstDraw == true)
  {
    //println("A");
    
    //translate(width/4, height/2);
    grow();
  }
  
  //background(190);
  fill(220);
  rectMode(CENTER);
  ellipseMode(CENTER);
  translate(-sw/4,0);
  if (animal != null) animal.draw();
  
  firstDraw = false;
}

int[] DNA = new int[20];//{0, 9, 0,1,3,3,0, 2,1,  3,2,7,   0, 1};//{0,4,1,0, 2,1,5,4,4,    0,2};//{5,4,3,0,0};
//final float S = 10;
//final float S_LINE = S + (S);// / 10f);
final int MAX_CELLS = 60;

void grow(){
  for (int i = 0; i< DNA.length; i++)
  {
    DNA[i] = (int) random(0, 10);
    //print(DNA[i] + " ");
  }
  //println();
  
  animal = new Animal();
  count = 0;
  animal.read(0);
}
