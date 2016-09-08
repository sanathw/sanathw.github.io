class WallHook extends PhysicalObjectBase
{
  boolean isFloor;
  int l;
  WallHook(float d, float v, float a, boolean isFloor, int l)
  {
    this.m = -1;  // infinite mass
    this.d = d; this.v = v; this.a = a;
    this.isFloor = isFloor;
    this.l = l;
  }
  
  void display()
  {
    pushMatrix();
    translate(0, d); 
    //noStroke(); fill(255);
    //rectMode(CORNERS); rect(-40, -10, 40, 0);
    
    stroke(0); strokeWeight(3);
    line(-l, 0, l, 0);
    
    if (isFloor)
    {
      for (int i = -l; i <= l-10; i +=10)
      {
        line (i, 0, i+10, +10);
      }
      line (-l, 0, -l, +10); line (l, 0, l, +10);
    }
    else
    {
      for (int i = -l+10; i <= l; i +=10)
      {
        line (i, 0, i-10, -10);
      }
      line (-l, 0, -l, -10); line (l, 0, l, -10);
    }
    popMatrix();
  }
}