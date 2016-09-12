// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

//int[] DNA = new int[]{ 9, 6, 0, 1, 2, 2, 0, 2, 1, 2,       5, 3, 0, 1, 3, 0, 1,1,1,0};
//int[] DNA = new int[]{3, 0, 1, 3, 0, 1,1,1,0};
//int[] DNA = new int[]{5,	4,	6,	5,	0,	8,	0,	7,	2,	4,	5,	7,	7,	1};

//int[] DNA = new int[]{6};
//int[] DNA = new int[10];

boolean doSpin = false;

int count = 0;

float S = 10;
float S_LINE = S + (S);// / 10f);

//PGraphics2D g;
void setup()
{
  setSize(400, 600, P3D, FIT_OUTSIDE, this); // this has to be the last line in this function
  
  S = (float)sw / 60f;
  S_LINE = S + (S);
}

void drawBackground(var g)
{
  g.gradientBackground3(VERTICAL, color(255,255,0), color(180,120,0), .5, color(255,120,50));//, 0.5, color(255, 0, 0));
  //g.background(255);
  //g.background(190, 190, 255);
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

//float aY = 0;

boolean firstDraw = true;
Animal animal = null;
boolean allowChange = true;
void draw()
{
  if (doSpin)
  {
    // to always sping in the Y axis as seen on screen
    // no matter the current user rotation
    PMatrix3D tempR = new PMatrix3D();
    tempR.rotateY(PI/100f);
    tempR.apply(R);
    R = tempR.get();
  }

  initDraw();
  
  //if (g == null) {createG();}
  //if (g != null)
  //{
  //  imageMode(CENTER);
  //  image(g, 0, 0);
  //}
  
  /*if (doSpin)
  {
    // to spin in the Y axis as seen by the model
    aY = aY + (PI/100f);
    if (aY > TWO_PI) aY = aY - TWO_PI;
    rotateY(aY);
  }
  */
  
  directionalLight(255, 255, 255, 0, 0, -1);
  directionalLight(255, 255, 255, -1, -1, 0);
  
  if (allowChange && (mouseX != pmouseX || mouseY != pmouseY))
  {
    allowChange = false;
  }
  
  if (mousePressed && mousePressed != pmousePressed)
  {
    allowChange = true;
  }
  
  if (
  (mousePressed == false && mousePressed != pmousePressed 
  && allowChange) 
  || 
  firstDraw == true)
  {
    //println("A");
    
    //translate(width/4, height/2);
    grow();
  }
  
  
  
  //background(190);
  //fill(220);
  //rectMode(CENTER);
  //ellipseMode(CENTER);
  //translate(-sw/4,0);
  if (animal != null) 
  {
    pushMatrix();
    //count = 0;
    //animal.read(0);
    animal.draw();
    popMatrix();
  }
  
  firstDraw = false;
}

int[] DNA = new int[20];//{0, 9, 0,1,3,3,0, 2,1,  3,2,7,   0, 1};//{0,4,1,0, 2,1,5,4,4,    0,2};//{5,4,3,0,0};
//int[] DNA = new int[20]{4,3,8,1,5,7,8,7,3,1,6,8,8,5,2,0,1,1,0,1};
//int[] DNA = new int[20]{9,1,6,4,6,4,4,7,3,7,5,0,2,2,1,4,6,0,0,4};


//final float S = 10;
//final float S_LINE = S + (S);// / 10f);
final int MAX_CELLS = 60;

void grow(){
  for (int i = 0; i< DNA.length; i++)
  {
    DNA[i] = (int) random(0, 10);
    //print(DNA[i] + " ");
  }
  //println(DNA);
  
  animal = new Animal();
  count = 0;
  animal.read(0);
}
