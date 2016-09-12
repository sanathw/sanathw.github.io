//////////////////////////////////////////////////////////////

class GameOfLifeController
{
  var createElement() { return new GameOfLifeElement(); }
  
  void initialiseFabric()
  {
    for (int i = 0; i < 20; i++)
    {
      int x = (int) random(fabricW-1);
      int y = (int) random(fabricH-1);
      getFrabricElement(x, y).s = 1;
    }
  }

  void modifyFabric()
  {
  }

  void setFabricElement(int x, int y, boolean isWall)
  {
    if (!getFrabricElement(x, y).isWall)
    {
      if (isWall)
      {
        getFrabricElement(x, y).s = 0;
      }
      else
      {
        getFrabricElement(x, y).s = 1;
      }
      getFrabricElement(x, y).isWall = isWall;
    }
  }
}

// ...........................................................

class GameOfLifeElement
{
  int x; int y; boolean isWall;
  
  // data
  float s; 
  void copyDataTo(e) { e.s = s; };
  
  // compute
  void compute(var buff)
  {
    if (isWall) 
    {
      buff.s = s;
    }
    else
    {
      var e;
      float c = 0;
      
      e = getFrabricElement(x-1, y-1); if (e != null) c += e.s;
      e = getFrabricElement(x,   y-1); if (e != null) c += e.s;
      e = getFrabricElement(x+1, y-1); if (e != null) c += e.s;
      
      e = getFrabricElement(x-1, y); if (e != null) c += e.s;
      e = getFrabricElement(x+1, y); if (e != null) c += e.s;
      
      e = getFrabricElement(x-1, y+1); if (e != null) c += e.s;
      e = getFrabricElement(x,   y+1); if (e != null) c += e.s;
      e = getFrabricElement(x+1, y+1); if (e != null) c += e.s;
      
      // http://en.wikipedia.org/wiki/Conway's_Game_of_Life
      if (s == 1)
      {
        if (c < 2) buff.s = 0;
        else if (c == 2 || c == 3) buff.s = 1;
        else if (c > 3) buff.s = 0;
      }
      else
      {
        if (c == 3) buff.s = 1;
      }
      
      //if (c >= 2 && c <= 6) buff.s = 1;
      //else buff.s = 0;
    }
  }
  
  // display
  void display(PImage img)
  {
    int c = map(s,0, 1, 0, 255);
    if (isWall) img.pixels[getIndex(x, y)] = color(255, 0, 0);
    else img.pixels[getIndex(x, y)] = color(255, c);
  }
}

//////////////////////////////////////////////////////////////