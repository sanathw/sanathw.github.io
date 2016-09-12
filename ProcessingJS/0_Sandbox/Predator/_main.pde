// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................
//"C:\Sanath\Processing\Projects\WebServer\Camera2\Camera2.html"

PImage imgCur;
PImage imgCapture;
PImage imgMem;
boolean designMode = true;
boolean captureMode = true;

//var imageObj = new Image();

int camW = 360;//640; normally, but on Samsung front camera it's 360
int camH = 360;//480;
//int outScale = 1;

//PGraphics2D g;
void setup()
{
  //imgOut = new PImage(camW/outScale, camH/outScale);
  //imageObj.src = '_icon.png';
  
  setSize(400, 400, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(190);
}

//void createG()
//{
//  int s = max(sw, sh);
//  g = createGraphics(camW, camH, P2D);
//  g.strokeWeight(1);
//  g.noFill();
//  int ss = (s / 2) + (s/6);
//  g.translate(s/2, ss);
//}

int x1; int y1;
int x2; int y2;
int mcx; int tcx;
int mcy; int tcy;
int mw;
int mh;

int matchColor = 0;

void draw()
{
  background(0, 0);
  
  if (videoStarted == false) initCam(camW, camH);

  //if (video.width > 0)
  if (videoReady)
  {
    externals.context.drawImage(video, 0, 0); //video is defined outside processing code
    imgCur = get(0, 0, camW, camH);

    
    initDraw();
   
    //ellipseMode(CENTER); noFill(); stroke(0,0,255); strokeWeight(3); line(0, -h_dh, 0, h_dh); line(-h_dw,0,h_dw,0);
   
    imageMode(CENTER);
    if (imgCur != null)
    {
      pushMatrix();
      scale(-1,1);//mirror the video
      
      float sx = (float)dw/(float)camW;
      float sy = (float)dh/(float)camH;
      float ss = min(sx, sy);
      scale(ss);
      
      mouseX = -mouseX / ss;
      mouseY = mouseY / ss;
      
      if (designMode)
      {
        if (captureMode)
        {
          imgCapture = imgCur.get();
          
          if (mousePressed & mousePressed != pmousePressed)
          {
            x1 = mouseX;
            y1 = mouseY;
            captureMode = false;
            bCapture.isOn = captureMode;
          }
          
          
        }
        else
        {
          if (mousePressed & mousePressed != pmousePressed)
          {
            x1 = mouseX;
            y1 = mouseY;
          }
          
          if (mousePressed)
          {
            x2 = mouseX;
            y2 = mouseY;
          }
          
          if (mousePressed == false & mousePressed != pmousePressed)
          {
            bDesignTrack.txt = "Design";
            designMode = false;
            bCapture.isDisabled = true;
          }
          
          mcx = ((float)x1+(float)x2) /2f;
          mcy = ((float)y1+(float)y2) /2f;
          mw = abs(x2 - x1);
          mh = abs(y2 - y1);
          
          mcx = mcx + (imgCur.width/2);
          mcy = mcy + (imgCur.height/2);
          
          tcx = mcx;
          tcy = mcy;
        }
        
        if (imgCapture !=null) image(imgCapture, 0, 0);
        
        noFill();
        stroke(255, 255, 0);
        strokeWeight(1);
        rectMode(CENTER);
        rect(mcx -(imgCur.width/2), mcy-(imgCur.height/2), mw, mh);
      }
      else
      {
        // Output original image
        image(imgCur, 0, 0);
        
        if (mw > 0 && mh > 0)
        {
          // Start Tracking
          
          // given current tcx and tcy find the next tcx and tcy
          doTrack();//imgCur, tcx, tcy, mw, mh);
          
          fill(0, 255, 0, matchColor);
          stroke(0, 255, 0);
          strokeWeight(1);
          rectMode(CENTER);
          rect(tcx-(imgCur.width/2), tcy-(imgCur.height/2), mw, mh);
          stroke(0, 255, 0, matchColor);
          line(tcx-(imgCur.width/2), -h_dh, tcx-(imgCur.width/2), h_dh);
          line (-h_dw, tcy-(imgCur.height/2), h_dw, tcy-(imgCur.height/2));
        }
      }
      
      
      
      popMatrix();
    }
    
    
    //ellipse(0,0,dw,dh);
    
  }
 }
 
 void doTrack()//imgCur, tcx, tcy, mw, mh)
 {
  matchColor = 0;
  
  float max_match = 0;
  //int match_x = -1;
  //int match_y = -1;
  
  int xStart = 0;//tcx - (mw/2);
  int xEnd = 20;//tcx + (mw/2);

  int yStart = 0;//tcy - (mh/2);
  int yEnd = 20;//tcy + (mh/2);
  
  int stpX = 5;//(xEnd -  xStart) / 5;
  int stpY = 5;//(yEnd -  yStart) / 5;
  
  int xStart1 = 0 - (mw/2);
  int xEnd1 = 0 + (mw/2);

  int yStart1 = 0 - (mh/2);
  int yEnd1 = 0 + (mh/2);
  
  int stpX1 = (xEnd1 -  xStart1) / 20;
  int stpY1 = (yEnd1 -  yStart1) / 20;
  
  
  
  noFill();
  stroke(0, 255, 0, 100);
  strokeWeight(1);
  rectMode(CENTER);
  rect(tcx-(imgCur.width/2), tcy-(imgCur.height/2), (xEnd - xStart)+mw, (yEnd - yStart)+mh);
  
  //println("A");
  
  int fy = 1;
  int fx = 1;
  
  for (int yy = yStart; yy < yEnd; yy = yy + stpY)
  {
    fy = fy * -1;
    for (int xx = xStart; xx < xEnd; xx = xx + stpX)
    {
      fx = fx * -1;
      int y = tcy + (yy * fy);
      int x = tcx + (xx * fx);
      
      float match = 0;
      float n = 0;
      for (int y1 = yStart1; y1 < yEnd1; y1 = y1 + stpY1)
      {
        for (int x1 = xStart1; x1 < xEnd1; x1 = x1 + stpX1)
        {
          color c1 = imgCapture.pixels[(imgCapture.width * (mcy + y1)) + (mcx + x1)];
          
          n = n + 1f;
          
          int qy = y + y1;//(y1-sy1) - ccy;// - ccy + y1;
          int qx = x + x1;//(x1-sx1) - ccx;// - ccx + x1;
          
          /*noFill();
            stroke(0, 0, 255, 50);
            strokeWeight(1);
            rectMode(CENTER);
            rect(qx, qy, mw, mh);*/
          
          if (qx >= 0 && qx < imgCur.width && qy >=0 && qy < imgCur.height)
          {
            color c2 = imgCur.pixels[(imgCur.width * qy) + qx];
            
          
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
      
      //println(match);
      if (match > max_match)
      {
        max_match = match;
        //println("***** " + max_match);
        matchColor = (int) (max_match * 255f);
        tcx = x;
        tcy = y;
      }
      
      //c = 255;
      
      //m2.pixels[(m2.width * y) + x] = color(255, 0, 0, c);
    }
  }
  
 }