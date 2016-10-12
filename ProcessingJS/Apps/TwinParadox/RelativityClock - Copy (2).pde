public class RelativityClock
{
  PGraphics2D g;
  PVector v1; PVector v2;
  PVector v1_orig; PVector v2_orig;
  PVector lightStart1;
  int lightRadius1;
  PVector lightStart2;
  int lightRadius2;
  boolean endV1 = false;
  float speedX;
  float speedY;
  float speed;
  
  boolean c1 = false;
  boolean c2 = false;

  color On1 = color(0, 255, 255, 190);
  color On2 = color(255, 255, 0, 190);
  int Count = 0;
  boolean grid = false;
  int tick;
  
  public RelativityClock(int width, int height, float speedX, float speedY, boolean grid, int tick)
  {
    int cx = (int) (width/2); int cy = (int) (height/2);
    g = createGraphics(width, height, P2D);
    g.translate(cx, cy);
    g.ellipseMode(RADIUS);
    g.rectMode(CENTER);
    g.textAlign(CENTER, CENTER);
    
    v1_orig = new PVector(0, (height / 4.0));
    v2_orig = new PVector(0, - v1_orig.y);
    
    //v1 = new PVector(0, (height / 4.0));
    //v2 = new PVector(0, - v1.y);
    
    this.grid = grid;
    this.tick = tick;
    Reset(false, speedX, speedY);
  }
  
   void SetEtherSpeed(float speedX, float speedY)
   {
     this.speedX = speedX;
     this.speedY = speedY;
     speed = mag(speedX, speedY);
     
     v1 = new PVector(v1_orig.x, v1_orig.y);
     v2 = new PVector(v2_orig.x, v2_orig.y);
     //v2.y = v2.y * sqrt(1 - (speed * speed) / (tick * tick));
     //println((1 - (speed * speed) / (tick * tick)));
     
     float a = atan2(speedX, speedY);
     
     //float r = sqrt(1 - (speed * speed * 2.5) / (tick * tick));
     float r = sqrt(1 - (speed * speed) / (tick * tick));
     
     PMatrix2D m = new PMatrix2D();
     
     //m.translate(0, v2_orig.y);
     m.rotate(-a);
     //m.translate(0, -v2_orig.y);
     m.scale(1,r);
     //m.translate(0, v2_orig.y);
     m.rotate(a);
     //m.translate(0, -v2_orig.y);
     
     //m.translate(x, y);
     m.mult(v2_orig, v2);
     m.mult(v1_orig, v1);
   }
  
  void ResetLight(boolean endV1)
  {
    //if (endV1) lightStart1 = new PVector(v2.x, v2.y);
    //else lightStart1 = new PVector(v1.x, v1.y);
    //lightRadius1 = 0;
    this.endV1 = endV1;
    
    lightStart2 = new PVector(v2.x, v2.y);
    lightStart1 = new PVector(v1.x, v1.y);
    lightRadius1 = 0;
    lightRadius2 = 0;
    c1 = false;
    c2 = false;
  }
  
  void Reset(boolean endV1, float speedX, float speedY)
  {
    Count = 0;
    SetEtherSpeed(speedX, speedY);
    ResetLight(endV1);
  }
  
  void Toggle(boolean endV1)
  {
    //if (endV1) Count++;
    Count++;
    ResetLight(endV1);
  }
  
  public void Update()
  {
    if (c1 == false)
    {
      lightRadius1 += tick;
      lightStart1.x += speedX;
      lightStart1.y += speedY;
      
      float r1 = lightStart1.dist(v2);
      
      if ( r1 <= lightRadius1) 
      {
        lightRadius1 = r1;
        c1 = true;
      }
    }
    
    if (c2 == false)
    {
      lightRadius2 += tick;
      lightStart2.x += speedX;
      lightStart2.y += speedY;
      
      float r2 = lightStart2.dist(v1);
      
      if ( r2 <= lightRadius2) 
      {
        lightRadius2 = r2;
        c2 = true;
      }
    }
    
    if (c1 == true && c2 == true) Toggle(!endV1);
    
    //if (endV1)
    //{
    //  lightStart.y -= speed * tick;
    //  float r = lightStart.dist(v1);
    //  if ( r < lightRadius) Toggle(!endV1);
    //}
    //else
    //{
    //  lightStart.y += speed * tick;
    //  float r = lightStart.dist(v2);
    //  if ( r < lightRadius) Toggle(!endV1);
    //}
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
      int qx = ((int) lightStart1.x) % spacing;
      for (int i = qx; i < g.width; i+=spacing)
      {
        g.line(-halfWidth + i, halfHeight, -halfWidth + i, -halfHeight);
      }
      int qy = ((int) lightStart1.y) % spacing;
      for (int i = qy; i < g.height; i+=spacing)
      {
        g.line(-halfWidth, -halfHeight + i, halfWidth, -halfHeight + i);
      }
      g.fill(0, 0, 255, 90);
      if (c1 == false) g.ellipse(lightStart1.x, lightStart1.y, (int) spacing/2, (int) spacing /2);
      if (c2 == false) g.ellipse(lightStart2.x, lightStart2.y, (int) spacing/2, (int) spacing /2);
    }
    
    g.strokeWeight(1); g.stroke(0); 
    g.noFill();
    if (c1 == false) g.ellipse(lightStart1.x, lightStart1.y, lightRadius1, lightRadius1);
    if (c2 == false) g.ellipse(lightStart2.x, lightStart2.y, lightRadius2, lightRadius2);
    
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