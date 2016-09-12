public class RelativityClock
{
  PGraphics2D g;
  PVector v1; PVector V2;
  PVector lightStart;
  int lightRadius;
  boolean endV1 = false;
  float speedX;
  float speedY;

  color On1 = color(0, 255, 255, 190);
  color On2 = color(255, 255, 0, 190);
  int Count = 0;
  boolean grid = false;
  
  public RelativityClock(int width, int height, float speedX, float speedY, boolean grid)
  {
    int cx = (int) (width/2); int cy = (int) (height/2);
    g = createGraphics(width, height, P2D);
    g.translate(cx, cy);
    g.ellipseMode(RADIUS);
    g.rectMode(CENTER);
    g.textAlign(CENTER, CENTER);
    
    v1 = new PVector(0, (height / 4.0));
    v2 = new PVector(0, - v1.y);
    
    this.grid = grid;
    Reset(false, speedX, speedY);
  }
  
   void SetEtherSpeed(float speedX, float speedY)
   {
     this.speedX = speedX;
     this.speedY = speedY;
   }
  
  void ResetLight(boolean endV1)
  {
    if (endV1) lightStart = new PVector(v2.x, v2.y);
    else lightStart = new PVector(v1.x, v1.y);
    lightRadius = 0;
    this.endV1 = endV1;
  }
  
  void Reset(boolean endV1, float speedX, float speedY)
  {
    Count = 0;
    SetEtherSpeed(speedX, speedY);
    ResetLight(endV1);
  }
  
  void Toggle(boolean endV1)
  {
    if (endV1) Count++;
    ResetLight(endV1);
  }
  
  public void Update()
  {
    lightRadius += 1;
    lightStart.x += speedX;
    lightStart.y += speedY;
    
    if (endV1)
    {
      float r = lightStart.dist(v1);
      if ( r < lightRadius) Toggle(!endV1);
    }
    else
    {
      float r = lightStart.dist(v2);
      if ( r < lightRadius) Toggle(!endV1);
    }
  }
  
  public PGraphics2D Draw()
  {
    //g.background(220);
    
    g.strokeWeight(4); g.stroke(190); 
    g.fill(220);
    g.rect(0, 0, g.width, g.height);
    
    int spacing = (int) g.width / 20;
    
    if (grid)
    {
      int halfWidth = (int) g.width / 2;
      int halfHeight = (int) g.height / 2;
      g.strokeWeight(1); g.stroke(0,0,255, 90); 
      int qx = ((int) lightStart.x) % spacing;
      for (int i = qx; i < g.width; i+=spacing)
      {
        g.line(-halfWidth + i, halfHeight, -halfWidth + i, -halfHeight);
      }
      int qy = ((int) lightStart.y) % spacing;
      for (int i = qy; i < g.height; i+=spacing)
      {
        g.line(-halfWidth, -halfHeight + i, halfWidth, -halfHeight + i);
      }
      g.fill(0, 0, 255, 90);
      g.ellipse(lightStart.x, lightStart.y, (int) spacing/2, (int) spacing /2);
    }
    
    g.strokeWeight(1); g.stroke(0); 
    g.noFill();
    g.ellipse(lightStart.x, lightStart.y, lightRadius, lightRadius);
    
    if (endV1) g.fill(On1); 
    else g.noFill();
    g.ellipse(v1.x, v1.y, spacing, spacing);
    
    if (!endV1) g.fill(On2); 
    else g.noFill();
    g.ellipse(v2.x, v2.y, spacing, spacing);
    
    g.fill(0);
    g.text(Count,0,0);
    
    return g;
  }
}