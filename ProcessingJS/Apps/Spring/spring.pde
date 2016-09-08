class Spring extends PhysicalObjectBase
{  
  float l = 120;  // natural length of the spring 
  float k = 0.25; // spring constant
  float c = 0.05; // spring damping
  
  PhysicalObjectBase A; 
  PhysicalObjectBase B; // the objects on the two ends of the spring
  float cur_l = l;
  
  Spring(PhysicalObjectBase A, PhysicalObjectBase B, float k, float c) 
  { 
    this.m = 0; // no mass
    this.A = A; this.B = B; this.k = k; this.c = c;
    this.l = B.d - A.d; this.cur_l = l;
  }
  
  void calculate() 
  {
    float last_l = cur_l;
    cur_l = B.d - A.d; // current length of the spring
    
    // given a length calculate the force (Hook's Law)
    float f = (cur_l - l) * k;  
    
    // damping
    v = last_l - cur_l;
    f -= c * v;
    
    A.F += f;
    B.F -= f;
  }

  void display()
  {
    pushMatrix();
    
    float ll = B.d - A.d;
    
    int n = (int) max((l / (k * 80)), 1);
    float p = (1 / ( 1 + abs((ll - l) * 0.01))) * (l / (n * 2));
    int j = (int) constrain((k * 80), 5, 150);
    int u = (int) constrain((c * 50), 1, 20);
    
    
    stroke(0); strokeWeight(u); noFill();
    float x = (ll - p) / n;
    
    for (int i = 0; i < n; i++)
    {
      int y1 = A.d + (i * x);
      int y2 = y1 + x + p;
      bezier(0, y1, j, y1, j, y2, 0, y2);
      if (i < (n-1))
      {
        y1 = A.d + ((i+1) * x);
        y2 = y1 + p;
        bezier(0, y1, -j, y1, -j, y2, 0, y2);
      }
    }
    
    popMatrix();
  }
}