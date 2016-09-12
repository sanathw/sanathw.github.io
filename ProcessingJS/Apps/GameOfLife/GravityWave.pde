//////////////////////////////////////////////////////////////

class GravityWaveController
{
  var createElement() { return new GravityWaveElement(); }
  
  float r = 0;
  void initialiseFabric()
  {
    getFrabricElement(fabricW/2, fabricH/2).d = cos(r);
    /*getFrabricElement(fabricW/2, fabricH/2).d = 1;
    getFrabricElement(fabricW/2, fabricH/2).v = 0;
    getFrabricElement(fabricW/2, fabricH/2).a = 0;*/
  }

  void modifyFabric()
  {
    //r = r + 0.1;
    //getFrabricElement(fabricW/2, fabricH/2).d = cos(r);
    /*getFrabricElement(fabricW/2, fabricH/2).d = 1;
    getFrabricElement(fabricW/2, fabricH/2).v = 0;
    getFrabricElement(fabricW/2, fabricH/2).a = 0;*/
  }

  void setFabricElement(int x, int y, boolean isWall)
  {
    if (!getFrabricElement(x, y).isWall)
    {
      if (isWall)
      {
        getFrabricElement(x, y).d = 0;
        getFrabricElement(x, y).v = 0;
        getFrabricElement(x, y).a = 0;
      }
      else
      {
        getFrabricElement(x, y).d = 1;
        getFrabricElement(x, y).v = 0;
        getFrabricElement(x, y).a = 0;
      }
      getFrabricElement(x, y).isWall = isWall;
    }
  }
}

// ...........................................................

class GravityWaveElement
{
  int x; int y; boolean isWall;
  
  // data
  float d; 
  float v; 
  float a; 
  void copyDataTo(e) { e.d = d; e.v = v; e.a = a; };
  
  // compute
  void compute(var buff)
  {
    if (isWall) 
    {
      buff.d = d;
      buff.v = v;
      buff.a = a;
    }
    else
    {
      var e;
      float f = 0;
      float k = 0.25;
      float m = 1;
      float c = 0.05;
      
      //float l = 0.5;
      float l = 0.2929; // because the distances are not the same in each square
      
      e = getFrabricElement(x-1, y-1); if (e != null) f += (e.d - d) * k * l;
      e = getFrabricElement(x,   y-1); if (e != null) f += (e.d - d) * k;
      e = getFrabricElement(x+1, y-1); if (e != null) f += (e.d - d) * k * l;
      
      e = getFrabricElement(x-1, y); if (e != null) f += (e.d - d) * k;
      e = getFrabricElement(x+1, y); if (e != null) f += (e.d - d) * k;
      
      e = getFrabricElement(x-1, y+1); if (e != null) f += (e.d - d) * k * l;
      e = getFrabricElement(x,   y+1); if (e != null) f += (e.d - d) * k;
      e = getFrabricElement(x+1, y+1); if (e != null) f += (e.d - d) * k * l;
      
      //f = f /8;
      
      f += (0 - d) * k;
      
      f -= c * v; // damping
      
      // has to be this order
      buff.a = f / m;
      buff.v = buff.v + buff.a;
      buff.d = buff.d + (buff.v);
    }
  }
  
  // display
  void display(PImage img)
  {
    int c = map(d,-1, 1, 0, 255);
    c = constrain(c, 0, 255);
    if (isWall) img.pixels[getIndex(x, y)] = color(255, 0, 0);
    else img.pixels[getIndex(x, y)] = color(255, c);
  }
}

//////////////////////////////////////////////////////////////