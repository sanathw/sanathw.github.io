// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

//PGraphics2D g;
var inputStroke = new ArrayList();
var boxTopLeft = new PVector();
var bottomRight = new PVector();
var start = new PVector();
var end = new PVector();
var cog = new PVector();

var intersetingPoint1 = new PVector();

void setup()
{
  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(100, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  g.background(255);
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

void draw()
{
  initDraw();
  
  if (mousePressed == true)
  {
    if (pmousePressed == false) inputStroke.clear();
    inputStroke.add(new PVector(mouseX, mouseY));
  }
  
  if (inputStroke.size() > 0)
  {
    // draw stroke
    for (int i = 1; i < inputStroke.size(); i++)
    {
      PVector v1 = (PVector) inputStroke.get(i-1);
      PVector v2 = (PVector) inputStroke.get(i);
     
      stroke(0); strokeWeight(2);
      line(v1.x, v1.y, v2.x, v2.y);
    }
    
     if (mousePressed == false && pmousePressed == true)
     {
       boxTopLeft = new PVector(9000000000000000, 9000000000000000);
       boxBottomRight = new PVector(-9000000000000000, -9000000000000000);
       cog = new PVector();
      
       for (int i = 0; i < inputStroke.size(); i++)
       {
         PVector v = (PVector) inputStroke.get(i);
         boxTopLeft.x = min(boxTopLeft.x, v.x);
         boxTopLeft.y = min(boxTopLeft.y, v.y);
         boxBottomRight.x = max(boxBottomRight.x, v.x);
         boxBottomRight.y = max(boxBottomRight.y, v.y);
        
         if (i == 0) start = v;
         end = v;
         cog.add(v);
       }
       
       if (inputStroke.size() > 20)
       {
         maxDiff =0;
         var lastA = 0;
         intersetingPoint1 = new PVector();
         for (int i = 10; i < inputStroke.size()-10; i++)
         {
          PVector v1 = (PVector) inputStroke.get(i-10);
          PVector v2 = (PVector) inputStroke.get(i);
          PVector v3 = (PVector) inputStroke.get(i+10);
          PVector t = v2.get();
          t.sub(v1);
          var a1 = atan2(t.y, t.x);
          
          t = v3.get();
          t.sub(v2);
          var a2 = atan2(t.y, t.x);
          
          var diff = abs(a2 - a1); 
          if (diff > maxDiff)
          {
            maxDiff = diff;
            intersetingPoint1 = v2;
          }
         }
       }
      
      // var boxWidth = (boxRight - boxLeft);
      // var boxHeight = (boxBottom - boxTop);
      
       cog.div(inputStroke.size());
     }
    
     if (mousePressed == false)
     {
       rectMode(CORNERS);
       ellipseMode(CENTER);
    
       stroke(255, 0, 0); strokeWeight(1); noFill();
       rect(boxTopLeft.x, boxTopLeft.y, boxBottomRight.x, boxBottomRight.y);
      
       stroke(255, 0, 0); strokeWeight(1); fill(255, 0, 0);
       ellipse(start.x, start.y, 10, 10);
       ellipse(end.x, end.y, 10, 10);
      
      stroke(0, 0, 255); strokeWeight(1); fill(0, 0, 255);
      ellipse(cog.x, cog.y, 10, 10);
      
      stroke(0, 0, 0); strokeWeight(1); fill(0, 255, 0);
      ellipse(intersetingPoint1.x, intersetingPoint1.y, 10, 10);
     }
  }
}
