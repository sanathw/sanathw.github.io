// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

class Icon
{
	float cx, cy, w;
	float ncx, ncy, nw;
	color clr;
	PImage img;
	
	Icon(float cx, float cy, float w, int i)
	{
		this.cx = cx; this.ncx = cx;
		this.cy = cy; this.ncy = cy;
		this.w = w; this.nw = w;
		clr = color((int) random(255), (int) random(255), (int) random(255));
		
		if (i < images.size())
		{
			String s = (String) images.get(i);
			this.img = loadImage("./_resources/" + s);
		}
	}
}
ArrayList icons = new ArrayList();

ArrayList images = new ArrayList();

float w;


//PImage imgLake;
void setup()
{
  //imgLake = loadImage("./_resources/lake.png");
  
	images.add("Explorer.png");
	images.add("Google.png");
	images.add("IE.png");
	images.add("Evernote.png");
	images.add("SQL.png");
	images.add("VisualStudio.png");
	images.add("Notepad.png");
	images.add("MediaPlayer.png");
	images.add("General.png");
	
	
  setSize(600, 400, P2D, FIT_INSIDE, this);
  
  rectMode(CENTER);
	ellipseMode(CENTER);
	imageMode(CENTER);
	
	int c = 10;
	//float w = (float) width / (float) c;
	w = ((float)sw - ((float)sw / 4f)) / (float) c;
	float offset = (0 - (w * (float)c)) / 2f;
	
	for (int i = 0; i < c; i++)
	{
		float cx = offset + (w/2f) + (w * i);
		float cy = -w;//w;//(height/2f) + w;
		
		icons.add(new Icon(cx, cy, w, i));
	}
  
}

float getY(float x)
{
	float decay = 0.0005f;
	return (1f / (1f + decay * x * x));
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(255);
}

void draw()
{
  initDraw();
  
  //background(250);
  
  //pushMatrix();
  //scale(2, 4);
  //image(imgLake, 0, 0);
  //popMatrix();
  
  /*
  // display
  stroke(0, 255, 0); strokeWeight(1); line(-h_dw, -h_dh, +h_dw, +h_dh); line(+h_dw, -h_dh, -h_dw, +h_dh);
  ellipseMode(CENTER); noFill(); ellipse(0, 0, dw, dh);
  
  // sketch
  noStroke(); fill(255, 200, 200, 100); rectMode(CENTER); rect(0, 0, sw, sh);
  stroke(0, 0, 255); line(0, 0, 0, -h_sh/2);
  stroke(0, 0, 255); strokeWeight(3); line(0, 0, -h_dw, 0);
  
  if (mousePressed == true) line(0, 0, mouseX, mouseY);
  
  
  if (mode == P2D)
  {
    rotate(mouseX/100);
    rotate(mouseY/100);
    if (mousePressed == true && mouseButton == RIGHT) fill(255, 0, 0);
    else fill(255);
    stroke(0); strokeWeight(1);
    rectMode(CENTER); rect(0, 0, 20, 20);
  }*/
  
  
	stroke(200);
	noFill();
	
	// draw cruve
	float lastX = -sw/2;
	float lastY = -w*2;//height/2;
	for (int i=-sw/2; i < sw/2; i++)
	{
		float newX = i;
		float newY = -w*2;//height/2;
		float ampl = 100f;
		
		newY -= ampl * getY(mouseX - i);
		
		line(lastX, lastY, newX, newY);
		
		lastX = newX;
		lastY = newY;
	}
	
	// draw unmodified
	for (int i = 0; i  < icons.size(); i++)
	{
		Icon icon = (Icon) icons.get(i);
		color c = color(red(icon.clr), green(icon.clr), blue(icon.clr), 10);
		fill(c);
		icon.ncx = icon.cx;
		icon.ncy = icon.cy + 90;
		icon.nw = icon.w
		rect(icon.cx, icon.cy, icon.w, icon.w);
	}
	
	
	/////////
	// calculate new sizes
	float minDx = 10000f;
	float selectedX = 0f;
	float offset = 0;
	
	if (mouseY > 0)//height / 2)
	{
		for (int i = 0; i  < icons.size(); i++)
		{
			Icon icon = (Icon) icons.get(i);
			
			float dx = abs(mouseX - icon.cx);
			
			icon.nw = icon.w * (map(getY(dx), 0, 1, 1, 2.5));
			icon.ncx = offset + icon.nw / 2f;
			icon.ncy = icon.cy - (icon.nw / 2f) + (icon.w / 2f);
			icon.ncy += 90;
			
			if (dx < minDx)
			{
				minDx = dx;
				float r = ((float) mouseX - (icon.cx - (icon.w/2f))) / icon.w;
				selectedX = icon.ncx - (icon.nw / 2f) + (icon.nw * r);
			}
			
			offset += icon.nw;
		}
		
		// bring back the same spot pointed by the mouse on the sized back to the same spot on the original. 
		offset = selectedX - mouseX;
	}
	
	
	
	// draw mirrored
	for (int i = 0; i  < icons.size(); i++)
	{
		Icon icon = (Icon) icons.get(i);

		//if (icon.img == null)
		//{
		//	noStroke();
		//	color c = color(red(icon.clr), green(icon.clr), blue(icon.clr), 10);
		//	fill(c);
		//	rect(icon.ncx - offset, icon.ncy + icon.nw, icon.nw, icon.nw);
		//}
		//else
		if (icon.img != null && icon.img.width > 0 && icon.img.height > 0)
    {
			pushMatrix();
			translate(icon.ncx - offset, icon.ncy + icon.nw);
			//tint(255, 255, 255, 255);
			//rotate(PI);
			scale(1,-1);
      //tint(255, 100); // works but slow on iPhone
			image(icon.img, 0, 0, icon.nw, icon.nw);
			popMatrix();
			
			noStroke();
			fill(250, 150);
			rect(icon.ncx - offset, icon.ncy + icon.nw, icon.nw, icon.nw);
		}
    else
    {
      noStroke();
			color c = color(red(icon.clr), green(icon.clr), blue(icon.clr), 30);
			fill(c);
			rect(icon.ncx - offset, icon.ncy + icon.nw, icon.nw, icon.nw);
      noStroke();
			fill(250, 150);
			rect(icon.ncx - offset, icon.ncy + icon.nw, icon.nw, icon.nw);
    }
	}
	
	// draw mirror
	float x1l, x1r;
	float x2l, x2r;
	float y1;
	float y2;
	Icon icon;
	icon = (Icon) icons.get(0);
	x1l = icon.ncx - offset - icon.nw;
	y1 = icon.cy + 90;//icon.ncy;
	y2 = y1 + 40;
	x2l = x1l - 20;
	
	icon = (Icon) icons.get(icons.size() - 1);
	x1r = icon.ncx - offset + icon.nw;
	x2r = x1r + 20;
	
	stroke(0);
	fill(0, 0, 255, 120);
	quad(x1l, y1, x1r, y1, x2r, y2, x2l, y2);
	
	
	
	// draw new sizes
	for (int i = 0; i  < icons.size(); i++)
	{
		Icon icon = (Icon) icons.get(i);

		//if (icon.img == null)
		//{
		//	noStroke();
		//	fill(255);
		//	rect(icon.ncx - offset, icon.ncy, icon.nw, icon.nw);
		//	color c = color(red(icon.clr), green(icon.clr), blue(icon.clr), 30);
		//	fill(c);
		//	rect(icon.ncx - offset, icon.ncy, icon.nw, icon.nw);
		//}
		//else
    if (icon.img != null && icon.img.width > 0 && icon.img.height > 0)
		{
			pushMatrix();
			translate(icon.ncx - offset, icon.ncy);
			//tint(255, 255, 255, 255);
      //tint(255, 255); // works but slow on iPhone
			image(icon.img, 0, 0, icon.nw, icon.nw);
			popMatrix();
		}
    else
    {
			noStroke();
			fill(255);
			rect(icon.ncx - offset, icon.ncy, icon.nw, icon.nw);
			color c = color(red(icon.clr), green(icon.clr), blue(icon.clr), 30);
			fill(c);
			rect(icon.ncx - offset, icon.ncy, icon.nw, icon.nw);
		}
	}
	
	//noStroke();
	//fill(250, 190);
	//rect(width/2,height/2,width, height);
}
