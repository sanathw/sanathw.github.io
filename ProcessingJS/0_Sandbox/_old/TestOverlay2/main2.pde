// http://localhost:5050/0_Sandbox/TestOverlay2/main.html
//.......................................................................

//var cvs = document.getElementById("mySketch");
//var ctx;

//var cvs2 = document.getElementById("mySketch2");
//var ctx2;

//var pjs;

void setup()
{
  size(200, 50, P2D);
  
  //ctx2 = cvs2.getContext('2d');
  //ctx2.width = cvs2.width = 200; ctx2.height = cvs2.height = 200;
  
  //ctx = externals.context;
  
  //cvs.style.visibility='hidden';
  
  //pjs = Processing.getInstanceById("mySketch"); 
  //pjs2 = this;//Processing.getInstanceById("mySketch2"); 
}

void draw()
{
  background(250, 250, 255);
  textSize(25); fill(0);
  textAlign(CENTER, CENTER);
  text("Hello", width/2, height/2);
  line(0, 0, mouseX, mouseY);
  //if (mousePressed == true)
  //{
  //  pjs.mouseX = mouseX;
  //  pjs.mouseY = mouseY;
  //}
}

