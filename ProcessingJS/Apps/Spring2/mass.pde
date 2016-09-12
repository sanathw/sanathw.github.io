class Mass extends PhysicalObjectBase
{
  float displayScale = 15;
  
  //boolean isBox;
  Mass(float m, PVector d, PVector v, PVector a)
  {
    this.m = m; this.d = d; this.v = v; this.a = a;
    //this.isBox = isBox;
  }
  
  color c1 = color(255, 200, 90);
  color c2 = color(255, 0, 0);
  color c = c1;
  void display()
  {
    //int s = (int) constrain((m*60),1,200);
    int s = (int) (m*displayScale);
    pushMatrix();
    translate(d.x, d.y);
    stroke(125, 100, 40); strokeWeight(3); 
    
    //if(isBox)
    //{
    //  fill(220);
    //  rectMode(CENTER); rect(0, 0, s, s);
    //}
    //else
    //{
      fill(c);
      ellipseMode(CENTER); ellipse(0, 0, s, s);
    //}
    
    popMatrix();
  }
  
  boolean isInside(int x, int y) { int s = (int) (m*displayScale / 2); return (x >= d.x-s && x <= d.x+s && y >= d.y-s && y <= d.y+s); }
  
  void update()
  {
    if (isPlaceHolder == false);
    {
      super.update();
    }
  }
  
  void doProcess()
  {
    c = c1;
     if (isInside(mouseX, mouseY)) 
     {
      c = c2;
      if (mousePressed && mousePressed != pmousePressed)
      {
        sel = this;
        //d.x = mouseX;
        //d.y = mouseY;
      }
     }
     
     if (this == sel) c = c2;
  }
  
  //void checkCollision(PhysicalObjectBase floor)
  //{
  //  int s = (int) (m*60) / 2;
  //  if ((d+s) > floor.d) {d = floor.d - s; v = 0; a = 0;}
  //}
}