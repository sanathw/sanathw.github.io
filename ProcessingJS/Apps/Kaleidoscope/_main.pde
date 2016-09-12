// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

boolean isLinear = true;
boolean showUser = true;
boolean showBack = true;
int step = 4;
int pstep = step;
int frontColorId = 8; 
int backColorId = 1; 
int sizeId = 4;

color cf;
color cb;
boolean colorBack = false;
color[] cc = new color[] {color(255, 255, 255, 255), color(255, 0, 0, 255), color(0, 255, 0, 255), color(0, 0, 255, 255),
color(255, 0, 255, 255), color(0, 255, 255, 255), color(255, 255, 0, 255), color(0, 0, 0, 255)}; 
int[] ss = new int[] {1, 2, 3, 4, 5, 6, 7, 8};
int ps;


PGraphics2D g;
PGraphics2D g2;
PGraphics2D gm;
void setup()
{
  cf = cc[(frontColorId-1)];
  cb = cc[(backColorId-1)];
  ps = ss[sizeId-1];
  
  doZoom = false;
  doTranslate = false;
  doRotate = false;
  
  setSize(300, 300, P2D, FIT_OUTSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(cb);
}

void createG()
{
  int s = max(sw, sh);
  gm = createGraphics(s, s, P2D);
  g = createGraphics(100, 100, P2D);
  g2 = createGraphics(s, s, P2D);
  clearDisplay();
//  g.strokeWeight(1);
//  g.noFill();
//  int ss = (s / 2) + (s/6);
//  g.translate(s/2, ss);
}


void clearDisplay()
{
  if (gm != null) gm.background(0, 0);
  if (g != null) g.background(0, 0);
  if (g2 != null) g2.background(0, 0);
}


void selectColor()
{
  restColors(); 
  
  int i;
  if (colorBack) i = backColorId;
  else i = frontColorId;
  
  if (i == 1) bColor1.isOn = true;
  if (i == 2) bColor2.isOn = true;
  if (i == 3) bColor3.isOn = true;
  if (i == 4) bColor4.isOn = true;
  if (i == 5) bColor5.isOn = true;
  if (i == 6) bColor6.isOn = true;
  if (i == 7) bColor7.isOn = true;
  if (i == 8) bColor8.isOn = true;
}

void setColor(int i)
{
  if (colorBack) {backColorId = i; cb = cc[(i-1)];}
  else {frontColorId = i; cf = cc[(i-1)];}
}


void setPenSize(int i)
{
  ps = ss[(i-1)];
}


boolean dots = true;
void draw()
{
  initDraw();
  
  if (g == null) {createG();}
  if (gm!= null && g != null && g2 != null)
  {
  
    
    if ((step != pstep) ||(mousePressed == false && mousePressed != pmousePressed))
    {
      if (isLinear)
      {
        // draw the copies Linear
        //-------------------------
        gm.imageMode(CORNER);
        float newW = g.width / step;
        float newH = g.height / step;
        
        float cntx = (int) (((float)gm.width / (float)newW) + 0.5);
        float cnty = (int) (((float)gm.height / (float)newH) + 0.5);
        
        gm.background(0,0);
        
        int oy = 0;
        for (int y = 0; y < cnty; y++)
        {
          int ox = 0;
          for (int x = 0; x < cntx; x++)
          {
            gm.image(g, ox, oy, newW, newH);
            ox += newW;
          }
          
          oy += newH;
        }
        //-------------------------
      }
      else
      {
        // draw the copies Angular
        //-------------------------
        gm.pushMatrix();
        gm.background(0,0);
        
        gm.translate(gm.width/2, gm.height/2);
        
        gm.imageMode(CENTER);
        float dr = TWO_PI / step;
        for (int r = 0; r < step; r++)
        {
          gm.pushMatrix();
          gm.rotate(dr*((float)r));
          gm.image(g2, 0, 0);
          gm.popMatrix();
        }
        
        gm.popMatrix();
        //-------------------------
      }
      
      pstep = step;
    }
    
    if (showBack)
    {
      imageMode(CENTER);
      image(gm, 0, 0);
    }
    
    if (showUser)
    {
      if (isLinear)
      {
        //Linear
        //-------------------------
        pushMatrix();
        
        translate((-h_dw + g.width/2), (-h_dh + g.height/2));
        
        g.beginDraw();
        
        if (dots && mousePressed)
        {
          g.fill(cf);
          g.noStroke();
          g.rectMode(CENTER);
          g.rect(mouseX+h_dw, mouseY+h_dh, ps, ps);
        }
        
        if (dots == false && mousePressed && mousePressed == pmousePressed)
        {
          g.stroke(cf);
          g.strokeWeight(ps);
          g.line(pmouseX+h_dw, pmouseY+h_dh, mouseX+h_dw, mouseY+h_dh);
        }
        
        g.endDraw();
        
        rectMode(CENTER);
        noStroke();
        fill(cb);
        rect(0, 0, g.width, g.height);
        
        imageMode(CENTER);
        image(g, 0, 0);
        rectMode(CENTER);
        noFill();
        stroke(0); strokeWeight(1);
        rect(0, 0, g.width, g.height);
        
        popMatrix();
        //-------------------------
      }
      else
      {
        // Angular
        //-------------------------
        pushMatrix();
        
        g2.beginDraw();
        
        if (dots && mousePressed)
        {
          g2.fill(cf);
          g2.noStroke();
          g2.rectMode(CENTER);
          g2.rect(mouseX+(g2.width/2), mouseY+(g2.height/2), ps, ps);
        }
        
        if (dots == false && mousePressed && mousePressed == pmousePressed)
        {
          g2.stroke(cf);
          g2.strokeWeight(ps);
          g2.line(pmouseX+(g2.width/2), pmouseY+(g2.height/2), mouseX+(g2.width/2), mouseY+(g2.height/2));
        }
        
        g2.endDraw();
        
        imageMode(CENTER);
        image(g2, 0, 0);
        popMatrix();
        //-------------------------
      }
    }
  }
}
