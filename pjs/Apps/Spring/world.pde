class World
{
  PVector gravity = new PVector(0, 0.25, 0);
  //WallHook floor = null;
  
  ArrayList worldObjects = new ArrayList();
  PhysicalObjectBase add(PhysicalObjectBase o) { worldObjects.add(o); return o; }
  void calculate() 
  { 
    for (int i = 0; i < worldObjects.size(); i++) worldObjects.get(i).calculate(); 
    for (int i = 0; i < worldObjects.size(); i++) 
    {
      PhysicalObjectBase o = worldObjects.get(i);
      if (o.m > 0 && o.isPlaceHolder == false)
      {   
        PVector temp = gravity.get();
        temp.mult(o.m);
        //o.F.add( temp );
        
        //if (o.name == "ROD") println(o.F);
      }
    }
  }
  void update() 
  { 
    for (int i = 0; i < worldObjects.size(); i++) worldObjects.get(i).update(); 
    //if (floor != null)
    //{
    //  for (int i = 0; i < worldObjects.size(); i++) 
    //  {
    //    PhysicalObjectBase o = worldObjects.get(i);
    //    if (o != floor)
    //    {
    //      o.checkCollision(floor);
    //    }
    //  }
    //}
    
    for (int i = 0; i < worldObjects.size(); i++) worldObjects.get(i).doProcess(); 
  }
  
  void display() { for (int i = 0; i < worldObjects.size(); i++) worldObjects.get(i).display(); }
}

class PhysicalObjectBase
{
  string name = "";
  PVector d = new PVector(); // distance 
  PVector v = new PVector(); // velocity
  PVector a = new PVector(); // acceleration
  float m = 0; // mass
  
  boolean isPlaceHolder = false;
  
  PVector F = new PVector(); // NEXT Force applied
  
  void calculate() {}
  void update()
  {
  //if (m == 3) println(F);
  
    // if pinned the the mass is infinite resulting in 0 a -> 0 v -> 0 d
    if (m > 0)
    {//if (name == "ROD") println(F);
      // has to be this order
      a = F.get(); a.div(m); //F / m;
      v.add(a); //v + a;
      d.add(v); //d + v;
    }
    
    F.x = 0; F.y = 0; F.z = 0; //F = 0; // reset the force
  
  
  
  }
  void display() {}
  boolean isInside(int y) {}
  //void checkCollision(PhysicalObjectBase floor){}
  void doProcess() {};
}