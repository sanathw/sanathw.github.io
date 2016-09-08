class Mass extends PhysicalObjectBase
{
  boolean isBox;
  Mass(float m, float d, float v, float a, boolean isBox)
  {
    this.m = m; this.d = d; this.v = v; this.a = a;
    this.isBox = isBox;
  }
  
  void display()
  {
    //int s = (int) constrain((m*60),1,200);
    int s = (int) (m*60);
    pushMatrix();
    translate(0, d);
    stroke(125, 100, 40); strokeWeight(3); 
    
    if(isBox)
    {
      fill(220);
      rectMode(CENTER); rect(0, 0, s, s);
    }
    else
    {
      fill(255, 200, 90);
      ellipseMode(CENTER); ellipse(0, 0, s, s);
    }
    
    popMatrix();
  }
  
  boolean isInside(int y) { int s = (int) map(m,1,10,40,100); return (y >= d-s && y <= d+s); }
  
  void checkCollision(PhysicalObjectBase floor)
  {
    int s = (int) (m*60) / 2;
    if ((d+s) > floor.d) {d = floor.d - s; v = 0; a = 0;}
  }
}