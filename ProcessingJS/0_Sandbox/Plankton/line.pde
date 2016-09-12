void set(int x, int y, color c2)
{

  if (x < 0 || x >= img.width) return;
  if (y < 0 || y >= img.height) return;

  int r2 = red(c2);
  int g2 = green(c2);
  int b2 = blue(c2);
  int a2 = alpha(c2);

  color c1 = img.pixels[(img.width*y)+x];
  int r1 = red(c1);
  int g1 = green(c1);
  int b1 = blue(c1);
  
  double dr = r2 - r1;
  double dg = g2 - g1;
  double db = b2 - b1;
  double a = (double) (a2) / 255f;
  
  double r = r1 + dr * a;
  double g = g1 + dg * a;
  double b = b1 + db * a;
  
  color c = color((int) r, (int) g, (int) b);

  img.pixels[(img.width*y)+x] = c;
}


void drawLine( int x1, int y1, color c1, int x2, int y2, color c2)
{

  int r1 = red(c1);
  int g1 = green(c1);
  int b1 = blue(c1);
  int a1 = alpha(c1);
  
  int r2 = red(c2);
  int g2 = green(c2);
  int b2 = blue(c2);
  int a2 = alpha(c2);

  // Bresenham line
  // http://www.gamedev.net/reference/articles/article1275.asp
  //when abs(deltax) >= abs(deltay) and deltax >= 0 and deltay >= 0
  //for the other combinations the x, y's and the ++ change
  //  //int deltax = x2 - x1;           // The difference in the x's
  //  //int deltay = y2 - y1;           // The difference in the y's
  //  //int y = y1;                     // Start y off at the first pixel value
  //  //int ynum = deltax / 2;          // The starting value for the numerator
  //  //for (int x = x1; x <= x2; x++)
  //  //{
  //    SetPixel(0, 0, 255,255,255,255);           // Draw the current pixel
  //    //ynum += deltay;           // Increase the numerator by the top of the fraction
  //    //if (ynum >= deltax)       // Check if numerator >= denominator
  //    //{
  //     // ynum -= deltax;         // Calculate the new numerator value
  //    //  y++;                    // Increase the value in front of the numerator (y)
  //    //}
  //  //}

  int xinc1;
  int xinc2;
  int yinc1;
  int yinc2;
  int den;
  float num;
  int numadd;
  int numpixels;

  int deltax = abs(x2 - x1);        // The difference between the x's
  int deltay = abs(y2 - y1);        // The difference between the y's
  int x = x1;                       // Start x off at the first pixel
  int y = y1;                       // Start y off at the first pixel

  if (x2 >= x1)                 // The x-values are increasing
  {
      xinc1 = 1;
      xinc2 = 1;
  }
  else                          // The x-values are decreasing
  {
      xinc1 = -1;
      xinc2 = -1;
  }

  if (y2 >= y1)                 // The y-values are increasing
  {
      yinc1 = 1;
      yinc2 = 1;
  }
  else                          // The y-values are decreasing
  {
      yinc1 = -1;
      yinc2 = -1;
  }

  if (deltax >= deltay)         // There is at least one x-value for every y-value
  {
      xinc1 = 0;                  // Don't change the x when numerator >= denominator
      yinc2 = 0;                  // Don't change the y for every iteration
      den = deltax;
      num = deltax / 2f;
      numadd = deltay;
      numpixels = deltax;         // There are more x-values than y-values
  }
  else                          // There is at least one y-value for every x-value
  {
      xinc2 = 0;                  // Don't change the x for every iteration
      yinc1 = 0;                  // Don't change the y when numerator >= denominator
      den = deltay;
      num = deltay / 2f;
      numadd = deltax;
      numpixels = deltay;         // There are more y-values than x-values
  }

  float da = (float) (a2 - a1) / (float)numpixels;
  float dr = (float) (r2 - r1) / (float)numpixels;
  float dg = (float) (g2 - g1) / (float)numpixels;
  float db = (float) (b2 - b1) / (float)numpixels;

  float a = a1;
  float r = r1;
  float g = g1;
  float b = b1;


  for (int curpixel = 0; curpixel <= numpixels; curpixel++)
  {
      set(x, y, color((int)r, (int)g, (int)b, (int)a));  // Draw the current pixel
      num += numadd;                  // Increase the numerator by the top of the fraction
      if (num >= den)                 // Check if numerator >= denominator
      {
          num -= den;                   // Calculate the new numerator value
          x += xinc1;                   // Change the x as appropriate
          y += yinc1;                   // Change the y as appropriate
      }
      x += xinc2;                     // Change the x as appropriate
      y += yinc2;                     // Change the y as appropriate

      a += da;
      r += dr;
      g += dg;
      b += db;
  }
}
