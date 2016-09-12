// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................
//"C:\Sanath\Processing\Projects\WebServer\Camera2\Camera2.html"

PImage imgCur;
PImage imgPrev;
PImage imgOut;

//var imageObj = new Image();

int camW = 360;//640; normally, but on Samsung front camera it's 360
int camH = 360;//480;
int outScale = 1;

//PGraphics2D g;
void setup()
{
  imgOut = new PImage(camW/outScale, camH/outScale);
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


int diff1 = 100;
int diff2 = 50;
int diff3 = 30;

int state = 1;
boolean showCur = true;
boolean showOut = false;

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
      
      // Output original image
      if (showCur) image(imgCur, 0, 0);
      
      if (showOut)
      {
        if (imgPrev != null)
        {
          if (outScale == 1)
          {
            // FAST using pixels
            for (int i = 0; i < imgOut.pixels.length; i++)
            {
              color current = imgCur.pixels[i];    
              color previous = imgPrev.pixels[i];
              float r1 = red(current); float g1 = green(current); float b1 = blue(current);
              float r2 = red(previous); float g2 = green(previous); float b2 = blue(previous);
              float diff = dist(r1,g1,b1,r2,g2,b2);

              if (diff > diff1) imgOut.pixels[i] = color(155+diff, 0, 0);
              else if (diff > diff2) imgOut.pixels[i] = color(0, 155+diff, 0);
              else if (diff > diff3) imgOut.pixels[i] = color(0, 0, 205+diff);
              else 
              {
                if (showCur) imgOut.pixels[i] = 0;
                else imgOut.pixels[i] = color(diff);
              }
            }
          }
          else
          {
            // SLOW using width and height
            for (int j = 0; j < imgOut.height; j++)
            {
              for (int i =0; i < imgOut.width; i++)
              {
                color current = imgCur.pixels[((imgCur.width)*j*outScale) + (i*outScale)];    
                color previous = imgPrev.pixels[((imgPrev.width)*j*outScale) + (i*outScale)];
                float r1 = red(current); float g1 = green(current); float b1 = blue(current);
                float r2 = red(previous); float g2 = green(previous); float b2 = blue(previous);
                float diff = dist(r1,g1,b1,r2,g2,b2);
                
                int ij = (imgOut.width*j)+i;
                if (diff > diff1) imgOut.pixels[ij] = color(155+diff, 0, 0);
                else if (diff > diff2) imgOut.pixels[ij] = color(0, 155+diff, 0);
                else if (diff > diff3) imgOut.pixels[ij] = color(0, 0, 205+diff);
                else 
                {
                  if (showCur) imgOut.pixels[ij] = 0;
                  else imgOut.pixels[ij] = color(diff);
                }
              }
            }
          }
        }
        //tint(255, 50);
        pushMatrix();
        scale(outScale);
        image(imgOut, 0, 0);
        popMatrix();
      }
      imgPrev = imgCur.get();
      
      
      popMatrix();
    }
    
    
    //ellipse(0,0,dw,dh);
    
  }
 }