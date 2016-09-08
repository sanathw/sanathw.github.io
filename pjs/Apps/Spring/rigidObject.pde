//See Evernote:
//Torque: https://www.evernote.com/shard/s3/nl/226168/63d9583d-e0b2-45ae-bc4f-cecdedb649dc
//Rotation: https://www.evernote.com/shard/s3/nl/226168/ac48ba4d-42e2-4b3b-b77c-94e205550295

// F = M x a
// 1) T = I (rotational Inertial) x a (rotational acceleration)
// also
// 2) T = F (perpendicular) x length
// so calculate 2) first, then get a from 1)

class RigidObject extends PhysicalObjectBase
{
  float rd = 0; // angle 
  float rv = 0; // angular velocity
  float ra = 0; // angular acceleration
  float rm = 0; // rotational inertia
  
  int shapeX;
  int shapeY;

  RigidObject(float m, PVector d, PVector v, PVector a,   float rm, float rd, float rv, float ra, int shapeX, int shapeY)
  {
    this.m = m; this.d = d; this.v = v; this.a = a;
    this.rm = rm; this.rd = rd; this.rv = rv; this.ra = ra;
    this.shapeX = shapeX; this.shapeY = shapeY;
  }
  
  void calculateTorque(PVector f, PVector l)
  {
    //PVector perpendicularForce = f.cross(l);
    ////PVector T = perpendicularForce.get();
    ////T.mult(l.mag());
    ////T.div(rm);
    ////ra = -T.mag();// perpendicularForce.mag() * l.mag();
    //ra += perpendicularForce.mag() * l.mag() / rm;
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
    super.update();
  }
  
  void display()
  {
    if (doShow == false) return;
    pushMatrix();
    translate(d.x, d.y);
    rotate(rd);
    stroke(0); strokeWeight(2); fill(0, 90);
    rectMode(CENTER); rect(0, 0, shapeX, shapeY);
    popMatrix();
  }
}