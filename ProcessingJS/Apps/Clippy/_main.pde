// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

var O = {};
PImage img;

float mobileScale = 1;

PGraphics2D g;
void setup()
{
  img = loadImage("./_resources/Rover-map.png");
  //img = loadImage("./_resources/Links-map.png");
  //img = loadImage("./_resources/Peedy-map.png");
  //img = loadImage("./_resources/F1-map.png");
  setSize(180, 180, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(255);
}

int imgW;
int imgH;
int imgWCount;
int imgHCount;

void createG()
{
  boolean crappyiPhone = false;
  if( /iPhone/i.test(navigator.userAgent) == true ) crappyiPhone = true;

  // The iPhone for some reason halfs large files
  // I don't know what large is....guess it's 5000000
  if (isMobile && crappyiPhone && (img.width * img.height) > 5000000)
  {
    mobileScale = 0.5;
  }
  else
  {
    mobileScale = 1;
  }

  //g = createGraphics(80, 80, P2D); // works for Rover - KEEP THE SAME
  //g = createGraphics(80, 64, P2D); // works for Peedy - need to half
  //g = createGraphics(62, 46, P2D); // works for Links - need to half
  //g = createGraphics(62, 46, P2D); // works for F1 - need to half
  
  int w = imgW * mobileScale;
  int h = imgH * mobileScale;
  g = createGraphics(w, h, P2D);
}

string action = "Hide";
int step = 0;
boolean animate = false;
int t = 0;
boolean finishNow = false;
boolean doBranching = true;

var agents = ["Rover", "Links", "Peedy", "F1"];
var agentId = 0;
var agent = agents[agentId];

int t1 = 0;

void draw()
{
  initDraw();
  
  if (mousePressed)
  {
    step = 0;
    animate = true;
  }
  
  imgW = O[agent].imgW; imgH = O[agent].imgH;  imgWCount = O[agent].imgWCount; imgHCount = O[agent].imgHCount; 
  
  if (img.width > 0 && g == null) {createG();}
  if (g != null)
  {
    int maxStep = O[agent].animations[action].frames.length;
    
    
    int d = O[agent].animations[action].frames[step].duration;
    
    if (img.width > 0 && O[agent].animations[action].frames[step].images != null)
    {
      g.beginDraw();
      g.background(0, 0);
      
      int x = (O[agent].animations[action].frames[step].images[0][0])* mobileScale;///2;
      int y = (O[agent].animations[action].frames[step].images[0][1])* mobileScale;///2;
      
      g.pushMatrix();
      g.translate(-x, -y);
      g.image(img, 0, 0);
      //g.copy(img, x, y, imgW, imgH, 0, 0, 80, 80);
      g.popMatrix();
      g.endDraw();
    }
    
    imageMode(CENTER);
    
    pushMatrix();
    translate(0, -30);
    scale(100/g.height);
    image(g, 0, 0);
    popMatrix();
    
    fill(0, 100);
    textAlign(CENTER, CENTER);
    text(action, 0, 30);
    
    if (animate)
    {
      fill(0, 0, 255, 80);
      noStroke();
      ellipseMode(CENTER);
      ellipse(0, 45, 8, 8);
    }
    
    
    if (animate)
    { 
      if (t >= d)
      {
        int nextStep = step + 1;
        
        if (doBranching)
        {
          if (finishNow)
          {
            if (O[agent].animations[action].frames[step].exitBranch != null)
            {
              nextStep = O[agent].animations[action].frames[step].exitBranch;
            }
          }
          else
          {
            if (O[agent].animations[action].frames[step].branching != null)
            {
              int p = 0;
              int r = (int) random(100);
              
              for (int i = 0; i < O[agent].animations[action].frames[step].branching.branches.length; i++)
              {
                p += O[agent].animations[action].frames[step].branching.branches[i].weight;
                
                if (p >= r)
                {
                  nextStep = O[agent].animations[action].frames[step].branching.branches[i].frameIndex;
                  break;
                }
              }
            }
          }
        }
        
        if ( nextStep >= maxStep)
        {
          //action = "RestPose";
          t1 = 0;
          //step = 0; 
          animate = false;
          finishNow = false;
        }
        else step = nextStep;
        
        t = 0;
      }
      t += 50;
    }
    else
    {
      if (t1 >= 50)
      {
        step = 0;
      }
      else 
      {
        t1++;
      
        stroke(0, 0, 255, 80);
        strokeWeight(1);
        noFill();
        ellipseMode(CENTER);
        ellipse(0, 45, 8, 8);
      }
    }
  }
}
