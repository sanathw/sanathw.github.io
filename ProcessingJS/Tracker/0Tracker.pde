var ctx;
ControlLocation displaycl;

Control input = new Control();
PGraphics inputG;
PImage iii;
ControlLocation inputSmall;
ControlLocation inputLarge;
boolean showLarge = false;

Control currentMem = new Control();
ArrayList memList = new ArrayList();


PImage img;

void setup()
{
	size(400, 400, P2D);
	ctx = externals.context;
	displaycl = new ControlLocation(0, 0, width, height, true);

	currentMem.setLocation(new ControlLocation(0, 0, width/2, height/2, true));
	
	inputSmall = new ControlLocation(currentMem.cl.width, 0, width/2, height/2, true);
	inputLarge = new ControlLocation(0, 0, width, height, true);
	
	input.setLocation(inputSmall);
	inputG = createGraphics(width, height, P2D);
	input.setImage(inputG);
	
	Control mem;
	int columns = 8;
	int rows = 2;
	
	int s = (int)(width/columns);
	int yoffset = height -20 - (rows * s);
	for (int y = 0; y < rows; y++)
	{
		int xoffset = 0;
		for (int x = 0; x < columns; x++)
		{
			mem = new Control();
			mem.setLocation(new ControlLocation(xoffset, yoffset, s, s, true));
			memList.add(mem);
			xoffset += s;
		}
		yoffset += s;
	}
	
	frameRate(10);
	
	//img = loadImage("../../OLD/0IMAGES/icons/Notepad.png");
}

boolean settingMemory = false;
int currentMemoryIndx = 0;
int selectedmemIndex = -1;
void mousePressed() 
{
	if (input.isInside(mouseX, mouseY))
	{
		PVector v = input.getScreenPointOnImage(mouseX, mouseY);
		input.selection = new ControlLocation(v.x, v.y, v.x, v.y, false);
		settingMemory = true;
	}
	else
	{
		for (int i = 0; i < memList.size(); i++)
		{
			Control mem = (Control) memList.get(i);
			if (mem.isInside(mouseX, mouseY))
			{
				currentMem.setImage(mem.snapshot);
				currentMem.selection = mem.selection;
				selectedmemIndex = i;
			}
		}
	}
}

void mouseDragged()
{
	if (settingMemory && input.isInside(mouseX, mouseY))
	{
		PVector v = input.getScreenPointOnImage(mouseX, mouseY);
		input.selection.setSize(v.x, v.y, false);
	}
}

boolean startScan = false;
void mouseReleased()
{
	if (settingMemory)
	{
		resetMemory();
		
		selectedmemIndex = 0;
		Control mem = (Control) memList.get(selectedmemIndex);
		mem.snapshot = input.img.get();
		mem.selection = input.selection.get();
		mem.setImage(input.img.get(input.selection.x, input.selection.y, input.selection.width, input.selection.height));
		mem.match = 1;
		
		currentMem.setImage(mem.snapshot);
		currentMem.selection = mem.selection;
		
		cx = (int) ((mem.selection.x2 + mem.selection.x1) / 2);
		cy = (int) ((mem.selection.y2 + mem.selection.y1) / 2);
		cw = mem.selection.width;
		ch = mem.selection.height;
		
		input.selection = null;
		startScan = true;
		settingMemory = false;
	}
}

void resetMemory()
{
	startScan = false;
	memIndex = -1;
	selectedmemIndex = -1;
	
	for (int i = 0; i < memList.size(); i++)
	{
		Control mem = (Control) memList.get(i);
		mem.setImage(null);
		mem.snapshot = null;
		mem.selection = null;
		mem.match = 0;
	}
	
	cx=0; cy =0; cw=0; ch =0;
	currentMem.setImage(null);
	currentMem.selection = null;
}

int icx; int icy;
float ics = 1;
float icr;

int cx; int cy; //<--- the focus
int cw; int ch;
float Maxmatch;
int maxCx = 0;
int maxCy = 0;
int memIndex = -1;
void keyPressed()
{
	if (keyCode == 37) icx-=2;
	if (keyCode == 39) icx+=2;
	if (keyCode == 38) icy-=2;
	if (keyCode == 40) icy+=2;
	if (key == 'q') ics -= 0.05;
	if (key == 'w') ics += 0.05;
	if (key == 'a') icr -= 0.05;
	if (key == 's') icr += 0.05;
	if (key == 'r') {icx = 0; icy = 0; ics = 1; icr = 0;}
	if (key == 'c') resetMemory();
	if (key == ' ')
	{
		showLarge = !showLarge;
		if (showLarge) input.setLocation(inputLarge);
		else input.setLocation(inputSmall);
	}
	
	if (key == 'd' && selectedmemIndex >= 0)
	{
		Control mem = (Control) memList.get(selectedmemIndex);
		mem.setImage(null);
		mem.snapshot = null;
		mem.selection = null;
		mem.match = 0;
		currentMem.setImage(null);
		currentMem.selection = null;
	}

	
	if (key == 'z')
	{
	
	//if (Maxmatch < 0.5f && Maxmatch > 0.3f)
		{
			//println(Maxmatch);
			//println("A");
			// find the lowest matching
			Control lowestMem;// = (Control) memList.get(1);
			float lowestmatch = 1;
			
			for (int i = 0; i < memList.size(); i++)
			{
				Control mem = (Control) memList.get(i);
				if (mem.match < lowestmatch) 
				{
					lowestmatch = mem.match;
					lowestMem = mem;
					memIndex = i;
				}
			}
			
			if (lowestMem != null)
			{
			//	println("B");
				lowestMem.snapshot = input.img.get();
				lowestMem.selection = new ControlLocation((int)(cx-(cw/2)), (int)(cy-(ch/2)), cw, ch, true);
				lowestMem.setImage(input.img.get(lowestMem.selection.x, lowestMem.selection.y, lowestMem.selection.width, lowestMem.selection.height));
				lowestMem.match = 1;
				
				currentMem.setImage(lowestMem.snapshot);
				currentMem.selection = lowestMem.selection;
				//currentMem.setImage(input.img.get());
				//currentMem.selection = new ControlLocation(cx-(cw/2), cy-(ch/2), cw, ch, true);
				
				DoScan(memIndex);
			}
		}
	/*
		Control mem = (Control) memList.get(1);
		mem.selection = new ControlLocation((int)(cx-(cw/2)), (int)(cy-(ch/2)), cw, ch, true);//input.selection.get();
		mem.snapshot = iii.get(); 

		mem.setImage(iii.get(mem.selection.x, mem.selection.y, mem.selection.width, mem.selection.height));
		mem.match = 1;
		
		println (" " + mem.selection.x + ", " + mem.selection.y + ", " + mem.selection.width + ", " + mem.selection.height);
		
		currentMem.setImage(mem.snapshot);
		currentMem.selection = mem.selection;
		*/
		
	
	
		//resetMemory();
	/////////////////////////
	/*
	Control mem = (Control) memList.get(1);
	mem.snapshot = input.img.get();
	mem.selection = new ControlLocation((int)(cx-(cw/2)), (int)(cy-(ch/2)), cw, ch, true);//input.selection.get();
	mem.setImage(input.img.get(mem.selection.x, mem.selection.y, mem.selection.width, mem.selection.height));
	mem.match = 1;
	
	currentMem.setImage(mem.snapshot.get());
	currentMem.selection = mem.selection;
	*/
	///////////////////////////
	//cx = (int) ((mem.selection.x2 + mem.selection.x1) / 2);
    //cy = (int) ((mem.selection.y2 + mem.selection.y1) / 2);
	//cw = mem.selection.width;
	//ch = mem.selection.height;
	
	//input.selection = null;
	//startScan = true;
	
	
	/*
	
		//resetMemory();
		
		Control mem = (Control) memList.get(1);
		mem.selection = new ControlLocation((int)(cx-(cw/2)), (int)(cy-(ch/2)), cw, ch, true);//input.selection.get();
		mem.snapshot = iii.get(); 
		
		
		
		mem.setImage(iii.get(mem.selection.x, mem.selection.y, mem.selection.width, mem.selection.height));
		mem.match = 1;
		
		println (" " + mem.selection.x + ", " + mem.selection.y + ", " + mem.selection.width + ", " + mem.selection.height);
		
		currentMem.setImage(mem.snapshot);
		currentMem.selection = mem.selection;
		
		//cx = (int) ((mem.selection.x2 + mem.selection.x1) / 2);
		//cy = (int) ((mem.selection.y2 + mem.selection.y1) / 2);
		//cw = mem.selection.width;
		//ch = mem.selection.height;
		
		//input.selection = null;
		//startScan = true;
		*/

	}
}

void draw()
{
	background(255);
	
	
	// get the video
	ControlLocation cl = new ControlLocation(displaycl, video.width, video.height, true);
	pushMatrix();
	translate(width,0);
	scale(-1,1);//mirror the video
	ctx.drawImage(video, cl.x, cl.y, cl.width, cl.height); //video is defined outside processing code
	popMatrix();
	//image(img, 0, 0, width, height);
	
	iii = get();
	
	//input.setImage(get());
	inputG.beginDraw();
	inputG.background(200);
	inputG.pushMatrix();
	inputG.translate(inputG.width/2, inputG.height/2);
	inputG.translate(icx, icy);
	inputG.scale(ics);
	inputG.rotate(icr);
	inputG.translate(-inputG.width/2, -inputG.height/2);
	inputG.image(get(), 0, 0);
	inputG.popMatrix();
	inputG.endDraw();
	//input.setImage(inputG);
	
	//background(0);
	
	Maxmatch = 0;
	if (startScan)
	{
		for (int i1 = 0; i1 < memList.size(); i1++)
		{
			DoScan(i1);
		}
		
		//fill(0);
		//	text(maxCx, 0, height-5);
		
		//if (Maxmatch > 0.25)
		//{
			cx = maxCx;
			cy = maxCy;
			
			
		//}
		
		
		/*if (Maxmatch < 0.5f && Maxmatch > 0.3f)
		{
			println(Maxmatch);
			//println("A");
			// find the lowest matching
			Control lowestMem;// = (Control) memList.get(1);
			float lowestmatch = 1;
			
			for (int i = 0; i < memList.size(); i++)
			{
				Control mem = (Control) memList.get(i);
				if (mem.match < lowestmatch) 
				{
					lowestmatch = mem.match;
					lowestMem = mem;
					memIndex = i;
				}
			}
			
			if (lowestMem != null)
			{
			//	println("B");
				lowestMem.snapshot = input.img.get();
				lowestMem.selection = new ControlLocation((int)(cx-(cw/2)), (int)(cy-(ch/2)), cw, ch, true);
				lowestMem.setImage(input.img.get(lowestMem.selection.x, lowestMem.selection.y, lowestMem.selection.width, lowestMem.selection.height));
				lowestMem.match = 1;
				
				currentMem.setImage(lowestMem.snapshot);
				currentMem.selection = lowestMem.selection;
				//currentMem.setImage(input.img.get());
				//currentMem.selection = new ControlLocation(cx-(cw/2), cy-(ch/2), cw, ch, true);
				
				DoScan(memIndex);
			}
		}*/
	}
	
	
	if (!showLarge)
	{
		currentMem.draw(0, color(255,0,0));
		currentMem.drawSelection();
		
		for (int i = 0; i < memList.size(); i++)
		{
			Control mem = (Control) memList.get(i);
			mem.draw(0, color(0,0,255));
		}
	}
	
	input.draw(0, color(255,0,0));
	input.drawSelection();
	
	
	
	strokeWeight(1);
	stroke(0, 255, 0);
	noFill();
	PVertex v1 = input.getImagePointOnScreen(cx-(cw/2), cy-(ch/2));
	PVertex v2 = input.getImagePointOnScreen(cx+(cw/2), cy+(ch/2));
	rectMode(CORNERS);
	rect(v1.x, v1.y, v2.x, v2.y);
	
	strokeWeight(0.01);
	fill(255, 100);
	rectMode(CORNER);
	rect(0, height-20, width, 20);
	fill(0);
	text("" + Maxmatch +"   (" + memIndex + ")", (width/2), height-5);
}

void DoScan(int idx)
{
	Control mem = (Control) memList.get(idx);
	if (mem.img == null) return;

	input.img.loadPixels();
	mem.img.loadPixels();
	
	int memHalfW = (int) (mem.img.width / 2);
	int memHalfH = (int) (mem.img.height / 2);
	
	//match = 0;
	//maxCx = 0;
	//maxCy = 0;
	
	
	int dmx = (int)(mem.img.width / 10);
	int dmy = (int)(mem.img.height / 10);
	
	int sheight = ch;
	int swidth = cw;
	
	int dsx = (int)(swidth / 10);
	int dsy = (int)(sheight / 10);
	
	int fy = 1;
	int fx = 1;

	for (int dy = 0; dy < sheight; dy += dsy)
	{
		int sy = cy + (dy * fy);
		fy = fy * -1;

		for (int dx = 0; dx < swidth; dx += dsx)
		{
			int sx = cx + (dx * fx);
			fx = fx * -1;
		
			float m = 0;
			float cnt = 0;
			
			for (int my = 0; my < mem.img.height; my+=dmy)
			{
				for (int mx = 0; mx < mem.img.width; mx+=dmx)
				{
					int ix = sx - memHalfW + mx;
					int iy = sy - memHalfH + my;
					cnt++;
					
					if (ix >= 0 && ix < input.img.width && iy >=0 && iy < input.img.height)
					{
						color mc = mem.img.pixels[(mem.img.width * my) + mx];
						color ic = input.img.pixels[(input.img.width * iy) + ix];
						
						float r = abs(red(mc) - red(ic));
						float g = abs(green(mc) - green(ic));
						float b = abs(blue(mc) - blue(ic));
						
						float a = 0;
						a = max(a, r);
						a = max(a, g);
						a = max(a, b);
						
						a = (255f - a)/ 255f;
						if (a > 0.95) m++;
					}
				}
			}
			
			m = m / cnt;
			
			if (m >= Maxmatch)
			{
				Maxmatch = m;
				maxCx = sx;
				maxCy = sy;
				memIndex = idx;
			}
		}	
	}
	
	//cx = maxCx;
	//cy = maxCy;
	
	mem.img.updatePixels();
	input.img.updatePixels();
}
