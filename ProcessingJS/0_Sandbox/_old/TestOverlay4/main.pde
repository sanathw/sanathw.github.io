// http://localhost:5050/0_Sandbox/TestOverlay4/main.html
//.......................................................................

float s = 1;

void setup()
{
  size(600, 300, P3D);
}

void setScale(float i_s)
{
  s = i_s;
}

void draw()
{
  background(250, 250, 255);
  lights();
  //ellipseMode(CORNERS); noFill(); ellipse(0, 0, width, height);
  translate(width/2, height/2);
  
  scale(s, s);
  
  rotateY(mouseX/100);
  rotateX(mouseY/100);
  
  if (mousePressed == true && mouseButton == RIGHT) fill(255, 0, 0);
  else fill(255);
  
  box(30);
}

