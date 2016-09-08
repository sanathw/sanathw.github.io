class RigidRod extends RigidObject
{
  PhysicalObjectBase A; 
  PhysicalObjectBase B;
  float lA = 0;
  float lB = 0;
  
  
  float fixX = 0;
  float fixY = 0;
  
  RigidRod(PhysicalObjectBase A, PhysicalObjectBase B)
  {
    this.name = "ROD";
    this.A = A; fixX = A.d.x; fixY = A.d.y;
    this.B = B;
    
    float m = A.m + B.m;
    //A.m = 0; B.m = 0;
    float cogX = ( (A.d.x * A.m) + (B.d.x * B.m) ) / ( A.m + B.m);
    float cogY = ( (A.d.y * A.m) + (B.d.y * B.m) ) / ( A.m + B.m);
    PVector d = new PVector(cogX, cogY, 0);
    PVector v = new PVector();
    PVector a = new PVector();
    float rm = m * 10000;
    float rd = -atan2(B.d.x - A.d.x, B.d.y - A.d.y);
    float rv = 0;
    float ra = 0;
    float shapeX = 20;
    float shapeY = 20;
    lA = dist(A.d.x, A.d.y, cogX, cogY);
    lB = dist(B.d.x, B.d.y, cogX, cogY);
    super(m, d, v, a,   rm, rd, rv, ra, shapeX, shapeY);
  }
  
  void calculate() 
  {
    A.d.x = d.x + (sin(rd) * lA);
    A.d.y = d.y - (cos(rd) * lA);
    calculateTorque(A.F, new PVector( (A.d.x - d.x), (A.d.y - d.y ), 0 ) );
    
    B.d.x = d.x - (sin(rd) * lB);
    B.d.y = d.y + (cos(rd) * lB);
    calculateTorque(B.F, new PVector( (B.d.x - d.x), (B.d.y - d.y ), 0 ) );
    
    F.add(A.F);
    F.add(B.F);
  }
  
  void calculateTorque(PVector f, PVector l)
  {
    float ll = l.mag();
    l.normalize();
    PVector perpendicularForce = l.cross(f);
    // the force is stored in the last value of the matrix.
    // smae as perpendicularForce.mag(), but has the sign
    ra += perpendicularForce.z * ll / rm;
  }
  
  void update()
  {
    rv += ra;
    rd += rv;
    
    ra = 0;
    
    // if pinned
    /*F.sub(F);
    float f = (rv * rm) / lA;
    PVector rl = new PVector(sin(rd), -cos(rd), 0);
    
    stroke(0, 0, 255); strokeWeight(4);
    PVector rf = new PVector(rl.y, -rl.x, 0);
    rf.mult(f);
    //println(rf);
    pushMatrix();
    translate(d.x + (sin(rd) * lA), d.y - (cos(rd) * lA));
    line(0, 0, rf.x, rf.y);
    popMatrix();
    //rf.mult(f);
    calculateTorque(rf, rl);
    rv += ra;
    rd += rv;
    ra = 0;*/
    
    super.update();
    
    
    A.d.x = d.x + (sin(rd) * lA);
    A.d.y = d.y - (cos(rd) * lA);
    A.v.x = 0;
    A.v.y = 0;
    A.a.x = 0;
    A.a.y = 0;
    A.F.x = 0;
    A.F.y = 0;
    
    B.d.x = d.x - (sin(rd) * lB);
    B.d.y = d.y + (cos(rd) * lB);
    B.v.x = 0;
    B.v.y = 0;
    B.a.x = 0;
    B.a.y = 0;
    B.F.x = 0;
    B.F.y = 0;
    
    // To pin to a point
    //float mx = fixX - A.d.x;
    //float my = fixY - A.d.y;
    //d.x += mx;
    //d.y += my;
    //v.x += mx;
    //v.y += my;
    //A.d.x += mx;
    //A.d.y += my;
    //B.d.x += mx;
    //B.d.y += my;
  }
  
  float displayScale = 7;
  void display()
  {
    int s = (int) (m*displayScale);
    
    pushMatrix();
    translate(d.x, d.y);
    rotate(rd);
    stroke(0); strokeWeight(2); fill(0, 90);
    ellipseMode(CENTER); ellipse(0, 0, s, s);
    line (0, 0, 0, lB);
    line (0, 0, 0, -lA);
    popMatrix();
  }
}