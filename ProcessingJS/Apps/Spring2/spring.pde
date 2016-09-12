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
    
    PVector temp = B.d.get(); temp.sub(A.d);
    this.l = temp.mag();//B.d - A.d; 
    this.cur_l = l;
  }
  
  void calculate() 
  {
    float last_l = cur_l;
    
    PVector temp = B.d.get(); temp.sub(A.d);
    cur_l = temp.mag();//B.d - A.d; // current length of the spring
    
    
    // get the direction that the spring force should be applied
    temp.normalize();
    
    // given a length calculate the force (Hook's Law)
    PVector f = temp.get();
    f.mult(  (cur_l - l) * k ); //f = (cur_l - l) * k;  
    
    // damping
    //v = temp.get();
    //v.mult( abs(last_l - cur_l) ); ////v = last_l - cur_l;
    //v.mult(c)
    //f.sub(v); //f -= c * v;
    float vv = last_l - cur_l;
    //temp = f.get();
    //temp.normalize();
    temp.mult( (c * vv * -1 ) );
    //if (
    f.add(temp);
    //f.sub( (c * vv) );
    //f.sub( (c * vv) );
    
    A.F.add(f); //A.F += f;
    B.F.sub(f); //B.F -= f;
  }

  void display()
  {
    pushMatrix();
    
    
    //stroke(0); strokeWeight(2);
    //line(B.d.x, B.d.y, A.d.x, A.d.y);
    
    PVector temp = B.d.get(); temp.sub(A.d);
    float ll = temp.mag();//B.d - A.d;
    
    
    translate(A.d.x, A.d.y);
    float a = atan2(temp.x, temp.y);
    rotate(-a);
    
    int n = (int) max((l / (k * 40)), 1);
    float p = (1 / ( 1 + abs((ll - l) * 0.01))) * (l / (n * 2));
    int j = (int) constrain((k * 40), 5, 150);
    int u = (int) constrain((c * 50), 1, 20);
    
    
    stroke(0, 90); strokeWeight(u); noFill();
    float x = (ll - p) / n;
    
    for (int i = 0; i < n; i++)
    {
      int y1 = 0 + (i * x);
      int y2 = y1 + x + p;
      bezier(0, y1, j, y1, j, y2, 0, y2);
      if (i < (n-1))
      {
        y1 = 0 + ((i+1) * x);
        y2 = y1 + p;
        bezier(0, y1, -j, y1, -j, y2, 0, y2);
      }
    }
    
    popMatrix();
  }
}