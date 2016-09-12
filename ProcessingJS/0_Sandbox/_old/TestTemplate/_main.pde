// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................
   
void setup()
{
  setSize(100, 300, P2D, FIT_INSIDE, this);
}

void drawBackground(var g)
{
  g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  //g.background(255);
}

void draw()
{
  initDraw();
  
  
  // display
  stroke(0, 255, 0); strokeWeight(1); line(-h_dw, -h_dh, +h_dw, +h_dh); line(+h_dw, -h_dh, -h_dw, +h_dh);
  ellipseMode(CENTER); noFill(); ellipse(0, 0, dw, dh);
  
  // sketch
  noStroke(); fill(255, 200, 200, 100); rectMode(CENTER); rect(0, 0, sw, sh);
  stroke(0, 0, 255); line(0, 0, 0, -h_sh/2);
  stroke(0, 0, 255); strokeWeight(3); line(0, 0, -h_dw, 0);
  
  if (mousePressed == true) line(0, 0, mouseX, mouseY);
  
  if (mode == P3D)
  {
    lights();
    if (mousePressed == true && mouseButton == RIGHT) fill(255, 0, 0);
    else fill(255);
    stroke(0); strokeWeight(1);
    box(15);
    translate(200, 0);
    fill(0, 255, 0);
    box(10);
  }
  
  if (mode == P2D)
  {
    rotate(mouseX/100);
    rotate(mouseY/100);
    if (mousePressed == true && mouseButton == RIGHT) fill(255, 0, 0);
    else fill(255);
    stroke(0); strokeWeight(1);
    rectMode(CENTER); rect(0, 0, 20, 20);
  }
}
