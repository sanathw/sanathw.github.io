// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

/* @pjs preload="./_resources/Notepad.png"; */

boolean doScan = true;

final int gw = 48;
final int gh = 48;
final int gap = 40;
final float gs = 3;

PImage img;
PGraphics g1;
PGraphics g2;
PGraphics m2;

int cx = 0; 
int cy = 0;
float ss = 1;
float rr = 0;

/*int w; int h;
int x1; int y1;
int x2; int y2;

int icx; int icy;
float ics = 1; 
float icr;

int cx; int cy;
float cs = 1; 
float cr;
int cw; int ch;

boolean showImg2 = true;*/

//PGraphics2D g;
void setup()
{
  img = loadImage("./_resources/Notepad.png");
  /*float dw = (float) (gw) / (float) (img.width);
  float dh = (float) (gh) / (float) (img.height);
  float d = dw;
  if (dh < dw) d = dh;
  w = (int) (d * (float) img.width);
  h = (int) (d * (float) img.height);*/
  setSize(400, 400, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(255);
}

void createG()
{
//  int s = max(sw, sh);
//  g = createGraphics(s, s, P2D);
//  g.strokeWeight(1);
//  g.noFill();
//  int ss = (s / 2) + (s/6);
//  g.translate(s/2, ss);
  g1 = createGraphics(gw, gh, P2D);
  g2 = createGraphics(gw, gh, P2D);
  m2 = createGraphics(gw, gh, P2D);
}

//boolean store = false;

int ix1 = -1;
int iy1 = -1;
int ix2 = -1;
int iy2 = -1;
boolean selecting = false;



int last_match_x = -1;
int last_match_y = -1;


void draw()
{
  initDraw();
  
  if (g1 == null && g2 == null && m2 == null) {createG();}
  if (g1 != null && g2 != null && m2 != null)
  {
  //  imageMode(CENTER);
  //  image(g, 0, 0);
    
    /*int ix1 = x1 - ox;
    int iy1 = y1 - gap;
    int ix2 = x2 - ox;
    int iy2 = y2 - gap;
    
    if (store)
    {
      cx = (int) ((ix2+ix1) / 2);
      cy = (int) ((iy2+iy1) / 2);
      cs = 1;
      cr = 0;
      cw = ix2 - ix1;
      ch = iy2 - iy1;
    }
    store = false;*/

    int ox = ((-g1.width/2)*gs) - gap/2;
    if (mousePressed && mousePressed != pmousePressed)
    {
      cx = 0; cy =0; ss = 1; rr =0;
      
      ix1 = ((mouseX- ox)/gs)  + g1.width/2;
      iy1 = (mouseY/gs) + g1.height/2;
      
      if (ix1 < 0) ix1 = 0; if (ix1 > g1.width-1) ix1 = g1.width-1;
      if (iy1 < 1) iy1 = 1; if (iy1 > g1.height-1) iy1 = g1.height-1;
      
      selecting = true;
    }
    
    if (mousePressed && selecting)
    {
      ix2 = ((mouseX- ox)/gs)  + g1.width/2;
      iy2 = (mouseY/gs) + g1.height/2;
      
      if (ix2 < 0) ix2 = 0; if (ix2 > g1.width-1) ix2 = g1.width-1;
      if (iy2 < 1) iy2 = 1; if (iy2 > g1.height-1) iy2 = g1.height-1;
      
      if (ix1 > -1 && iy1 > -1 && ix2 > -1 && iy2 > 0 && ix1!= ix2 && iy1 != iy2)
      {
        last_match_x = (int) ((ix2 + ix1) / 2);
        last_match_y = (int) ((iy2 + iy1) / 2);
      }
    }
    
    g1.beginDraw();
    g1.background(0,0);
    g1.image(img, 0, 0);
    
    /*if (ix1 > -1 && iy1 > -1 && ix2 > -1 && iy2 > 0)
    {
      g1.stroke(255, 200, 0);
      g1.strokeWeight(1);
      g1.noFill();
      g1.rectMode(CORNERS);
      g1.rect(ix1, iy1, ix2, iy2);
    }*/
    
    g1.endDraw();
    imageMode(CENTER);
    pushMatrix();
    translate(ox, 0);
    scale(gs);
    image(g1,0, 0);
    
    
    if (ix1 > -1 && iy1 > -1 && ix2 > -1 && iy2 > 0 && ix1!= ix2 && iy1 != iy2)
    {
      m2.beginDraw(); m2.loadPixels();
      for (int y = 0; y < m2.height; y++)
      {
        for (int x = 0; x < m2.width; x++)
        {
          if (x >= ix1 && x <= ix2 && y >= iy1 && y <= iy2) m2.pixels[(m2.width * y) + x] = color(0, 0);
          else m2.pixels[(m2.width * y) + x] = color(190, 120);
        }
      }
      m2.updatePixels(); m2.endDraw();
      image(m2, 0, 0);
      
      
      stroke(255, 200, 0);
      strokeWeight(1);
      noFill();
      rectMode(CORNERS);
      translate(-g1.width/2, -g1.height/2);
      rect(ix1, iy1, ix2, iy2);
    }
    
    popMatrix();
    
    
    
    
    //********************
    
    
    if (mousePressed == false && mousePressed != pmousePressed)
    {
      selecting = false;
    }
    
    
    ox = ((g2.width/2)*gs) + gap/2;
    g2.beginDraw();
    g2.background(0,0);
    g2.pushMatrix();
    g2.translate(g2.width/2, g2.height/2);
    g2.translate(cx, cy);
    g2.scale(ss);
    g2.rotate(rr);
    g2.translate(-g2.width/2, -g2.height/2);
    g2.image(img, 0, 0);
    g2.popMatrix();
    g2.endDraw();
    imageMode(CENTER);
    pushMatrix();
    translate(ox, 0);
    scale(gs);
    image(g2,0, 0);
    
    //=======================
    float max_match = 0;
    int match_x = -1;
    int match_y = -1;
      
    if (ix1 > -1 && iy1 > -1 && ix2 > -1 && iy2 > 0 && ix1!= ix2 && iy1 != iy2)
    {
      g1.beginDraw(); g1.loadPixels();
      g2.beginDraw(); g2.loadPixels();
      m2.beginDraw(); 
      
      if (doScan == false)
      {
        m2.background(190, 120);
      }
      else
      {
        m2.background(0, 0);
      }
      
      m2.loadPixels();
      
      int sx1 = (int)ix1;
      int sx2 = (int)ix2;
      //if (sx1 > sx2) {int t = sx1; sx1 = sx2; sx2 = t;}
      
      int sy1 = (int) iy1;
      int sy2 = (int) iy2;
      //if (sy1 > sy2) {int t = sy1; sy1 = sy2; sy2 = t;}*/
      
      int ccx = (int) ((ix2 - ix1) / 2);
      int ccy = (int) ((iy2 - iy1) / 2);
      
      
      int yStart = 0;
      int yEnd = g2.height;
      int xStart = 0;
      int xEnd = g2.width;
      
      if (doScan == false)
      {
        xStart = last_match_x - ccx;
        xEnd = last_match_x + ccx;
        
        yStart = last_match_y - ccy;
        yEnd = last_match_y + ccy;
      }
      
      
      for (int y = yStart; y < yEnd; y++)
      {
        for (int x = xStart; x < xEnd; x++)
        {
        //println("" + sy1 + " " + sy2);
          float match = 0;
          float n = 0;
          for (int y1 = sy1; y1 <= sy2; y1++)
          {
            for (int x1 = sx1; x1 <= sx2; x1++)
            {
              color c1 = g1.pixels[(g1.width * y1) + x1];
              
              n = n + 1f;
              
              int qy = y + (y1-sy1) - ccy;// - ccy + y1;
              int qx = x + (x1-sx1) - ccx;// - ccx + x1;
              
              
              if (qx >= 0 && qx < g2.width && qy >=0 && qy < g2.height)
              {
                color c2 = g2.pixels[(g2.width * qy) + qx];
                
              
                float r = abs(red(c2) - red(c1)) / 255;
                float g = abs(green(c2) - green(c1)) / 255;
                float b = abs(blue(c2) - blue(c1)) / 255;
                
                //a = a + (r + g + b) / 3;
                //if (a > 0.95) m = m + 1f;
                
                /*float a = 0;
                a = max(a, r);
                a = max(a, g);
                a = max(a, b);
                a = (255f - a)/ 255f;
                if (a > 0.95) match++;*/
                
                float a = ((1-r) + (1-g) + (1-b)) / 3;
                if (a > 0.95) match = match + a;
              }
            }
          }
          
          //match = n;
          match = ((float) (match) / (float) (n));
          float c = ((float) (match)) * 255f; 
          
          if (match > max_match)
          {
            max_match = match;
            match_x = x;
            match_y = y;
          }
          //c = 255;
          
          m2.pixels[(m2.width * y) + x] = color(255, 0, 0, c);
        }
      }
      
      
      m2.updatePixels(); m2.endDraw();
      g2.updatePixels(); g2.endDraw();
      g1.updatePixels(); g1.endDraw();
      
      image(m2, 0, 0);
    }
    
    //=====================
    
    
    rectMode(CENTER);
    noFill(); stroke(0); strokeWeight(1);
    rect(0, 0, g2.width, g2.height);
    
    if (match_x > -1 && match_y > -1)
    {
      int px = match_x;
      int py = match_y;
      
      int ax = px - (g2.width / 2);
      int ay = py - (g2.height / 2);
      
      stroke(0, 90);
      line(ax, -(g2.height/1.5), ax, (g2.height/1.5));
      line(-(g2.width/1.5), ay, (g2.width/1.5), ay);
      
      if (doScan == false)
      {
        last_match_x = match_x;
        last_match_y = match_y;
      }
    }
    
    popMatrix();
    
    
    
    
    if (t1 != null) t1.txt = "";
    
    
    
    
    
    
    //ox,gap); */
    /*stroke(255, 200, 0);
    strokeWeight(1);
    noFill();
    rectMode(CORNERS);
    if (x1 != x2 && y1 != y2) rect(ox+ix1, gap+iy1, ox+ix2, gap+iy2);
    
    
    ox += g1.width + gap;
    
    g2.beginDraw();
    g2.background(0, 0);
    g2.pushMatrix();
    g2.translate(gw/2, gh/2);
    g2.translate(icx, icy);
    g2.scale(ics);
    g2.rotate(icr);
    g2.translate(-gw/2, -gh/2);
    g2.image(img,0,0, w, h);
    g2.popMatrix();
    g2.endDraw();
    if (showImg2)  image(g2, g2.width/2 + gap/2,0);
    

    /*
    if (x1 != x2 && y1 != y2) 
    {
      g1.beginDraw(); g1.loadPixels();
      g2.beginDraw(); g2.loadPixels();
      m2.beginDraw();
      
      m2.background(220, 180);
      m2.loadPixels();
      
      int sw = (ix2-ix1);
      int sh = (iy2-iy1);
      int rm = (int)(sw*sh);
      int ofx = (int) ((float) (sw) / 2f);
      int ofy = (int) ((float) (sh) / 2f);
      
      int scanX = (int) (cx - cw/2);//0;
      int scanY = (int) (cy - ch/2);//0;
      if (scanX < 0) scanX = 0;
      if (scanY < 0) scanY = 0;
      //int scanX = 0;
      //int scanY = 0;
      
      int scanW = cw;//gw;
      int scanH = ch;//gh;
      //int scanW = gw;
      //int scanH = gh;
      
      if ((scanX+scanW) >= gw) scanW = gw-scanX-1;
      if ((scanX+scanH) >= gh) scanH = gh-scanY-1;
      
      float maxmatch = 0;
      int maxCX = 0;
      int maxCY = 0;
      
      for (int y = scanY; y < (scanY+scanH); y++)
      {
        for (int x = scanX; x < (scanX+scanW); x++)
        {
          float dx = (float)(abs(x - (ix1+ofx)));
          float dy = (float)(abs(y - (iy1+ofy)));
          float d = sqrt((dx*dx) + (dy*dy));
          d = 1f / (1f + (1f * d));
                      
        
                float match = 0;
                for (int k = iy1; k <= iy2; k++)
                {
                  for (int j = ix1; j <= ix2; j++)
                  {
                    color c1 = g1.pixels[(gw * k) + j];
                    
                    int ny = k + y - iy1 - ofy;
                    int nx = j + x - ix1 - ofx;
                    if (nx >= 0 && nx < gw && ny >=0 && ny < gh)
                    {
                      color c2 = g2.pixels[(gw * ny) + nx];
                      float r = abs(red(c2) - red(c1));
                      float g = abs(green(c2) - green(c1));
                      float b = abs(blue(c2) - blue(c1));
                      
                      //float a = (r + g + b) / 3f;
                      float a = 0;
                      a = max(a, r);
                      a = max(a, g);
                      a = max(a, b);
                      
                      //match += 1f - (a/255f);
                      //a = 1f - (a/255f);
                      //a = 255f - a;
                      //if (c2 == c1) match++;
                      //if (a == 0) match++;
                      a = (255f - a)/ 255f;
                      //a = a * d;
                      //match = match + (a/255f);
                      if (a > 0.95) match++;
                      
                      
                      
                      
                      //a = a / 255f;// * 1f;//d;
                      
                      //match += a;
                      //if (a > 0.5) match++;
                    }
                  }
                }
          
          match = ((float) (match) / (float) (rm));
          
          float c = ((float) (match)) * 255f;   
          m2.pixels[(gw * y) + x] = color(255, 0, 0, (int)c);
          
          if (match > maxmatch)
          {
            maxmatch = match;
            maxCX = x;
            maxCY = y;
          }
        }
      }

      m2.updatePixels(); 
      
      if (maxmatch > 0.5)
      {
        strokeWeight(1);
        stroke(0);
        line(maxCX+ox, 0+gap, maxCX+ox, gh+gap);
        line(ox, maxCY+gap, gw+ox, maxCY+gap);
        cx = maxCX;
        cy = maxCY;
      }
      
      m2.endDraw();
      g2.updatePixels(); g2.endDraw();
      g1.updatePixels(); g1.endDraw();
      image(m2, ox, gap);
    }*/
  
  }
}
