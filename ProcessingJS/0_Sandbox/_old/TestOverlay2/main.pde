// http://localhost:5050/0_Sandbox/TestOverlay2/main.html
//.......................................................................

//var cvs = document.getElementById("mySketch");
//var ctx;

//var cvs2 = document.getElementById("mySketch2");
//var ctx2;

//var pjs2;

void setup()
{
  size(200, 200, P2D);
  
  //ctx2 = cvs2.getContext('2d');
  //ctx2.width = cvs2.width = 200; ctx2.height = cvs2.height = 200;
  
  //ctx = externals.context;
  
  //cvs.style.visibility='hidden';
  
  //alert(mousePressed1);
  
}

var windowMousePressed = false;
void updateMouseButton(boolean isPressed)
{
  //alert("A"); //noLoop();
  windowMousePressed = isPressed;
}

void draw()
{
  mousePressed = windowMousePressed;//windowMousePressed;
  background(250);
  line(width/2, height/2, mouseX, mouseY);
  ellipseMode(CORNERS); noFill(); ellipse(0, 0, width, height); 
  
  if (mousePressed == true && mouseButton == LEFT)
  {
    //alert("A");
   // noLoop();
    ellipseMode(CENTER); fill(255, 0, 0); ellipse(mouseX, mouseY, 20, 20);
  }
  //if (pjs2 != null0
  //{
  //pjs2.mouseX = mouseX;
  //pjs2.mouseY = mouseY;
  //}
}

