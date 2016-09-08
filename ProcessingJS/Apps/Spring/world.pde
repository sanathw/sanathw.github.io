class World
{
  float gravity = 0;
  WallHook floor = null;
  
  ArrayList worldObjects = new ArrayList();
  PhysicalObjectBase add(PhysicalObjectBase o) { worldObjects.add(o); return o; }
  void calculate() 
  { 
    for (int i = 0; i < worldObjects.size(); i++) worldObjects.get(i).calculate(); 
    for (int i = 0; i < worldObjects.size(); i++) 
    {
      PhysicalObjectBase o = worldObjects.get(i);
      if (o.m > 0) o.F += (gravity * o.m);
    }
  }
  void update() 
  { 
    for (int i = 0; i < worldObjects.size(); i++) worldObjects.get(i).update(); 
    if (floor != null)
    {
      for (int i = 0; i < worldObjects.size(); i++) 
      {
        PhysicalObjectBase o = worldObjects.get(i);
        if (o != floor)
        {
          o.checkCollision(floor);
        }
      }
    }
  }
  
  void display() { for (int i = 0; i < worldObjects.size(); i++) worldObjects.get(i).display(); }
}

class PhysicalObjectBase
{
  float d = 0; // distance 
  float v = 0; // velocity
  float a = 0; // acceleration
  float m = 0; // mass
  
  float F = 0; // NEXT Force applied
  
  void calculate() {}
  void update()
  {
    // if pinned the the mass is infinite resulting in 0 a -> 0 v -> 0 d
    if (m > 0)
    {
      // has to be this order
      a = F / m;
      v = v + a;
      d = d + v;
    }
    
    F = 0; // reset the force
  }
  void display() {}
  boolean isInside(int y) {}
  void checkCollision(PhysicalObjectBase floor){}
}