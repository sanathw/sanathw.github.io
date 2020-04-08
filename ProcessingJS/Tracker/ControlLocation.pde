///////////////////////////////////////////////////////////////////////
class Control
{
	ControlLocation cl;
	
	PImage img;
	ControlLocation il;
	
	PImage snapshot;
	ControlLocation selection;
	
	float match = 0;
	
	Control(){}
	
	Control(ControlLocation icl)
	{
		setLocation(icl);
	}
	
	Control(PImage iimg)
	{
		setImage(iimg);
	}
	
	Control(ControlLocation icl, PImage iimg)
	{
		setLocation(icl);
		setImage(iimg);
	}
	void setLocation(ControlLocation icl)
	{
		cl = icl;
		if (cl != null && img != null) il = new ControlLocation(cl, img.width, img.height, false);
	}
	
	void setImage(PImage iimg)
	{
		img = iimg;
		if (cl != null && img != null) il = new ControlLocation(cl, img.width, img.height, false);
	}
	
	void drawSelection()
	{
		if (selection != null)
		{
			PVector v1 = getImagePointOnScreen(selection.x1, selection.y1);
			PVector v2 = getImagePointOnScreen(selection.x2, selection.y2);
			
			stroke(255,200,0);
			strokeWeight(1);
			noFill();
			rectMode(CORNERS);
			rect(v1.x, v1.y, v2.x, v2.y);
		}
	}
	
	void draw(color background, color border)
	{
		if (cl != null && background !=0)
		{
			strokeWeight(0.01);
			fill(background);
			rectMode(CORNERS);
			rect(cl.x1, cl.y1, cl.x2, cl.y2);
		}
		
		if (img != null)
		{
			image(img, il.x, il.y, il.width, il.height);
		}
		
		if (cl != null && border != 0)
		{
			strokeWeight(1);
			stroke(border);
			noFill();
			rectMode(CORNERS);
			rect(cl.x1, cl.y1, cl.x2, cl.y2);
		}
	}
	
	boolean isInside(int x, int y)
	{
		if ((x >= cl.x1 && x < cl.x2) && (y >= cl.y1 && y < cl.y2)) return true;
		else return false;
	}
	
	PVertex getScreenPointOnImage(int x, int y)
	{
		int ix = (int) ((x - il.x) * (img.width / il.width));
		int iy = (int) ((y - il.y) * (img.height / il.height));
		return new PVector(ix, iy);
	}
	
	PVertex getImagePointOnScreen(int x, int y)
	{
		int ix = (int) (il.x + (x * (il.width / img.width)));
		int iy = (int) (il.y + (y * (il.height / img.height)));
		
		return new PVector(ix, iy);
	}
}

///////////////////////////////////////////////////////////////////////
class ControlLocation
{
	int x; int y;
	int x1; int y1;
	int x2; int y2;
	int width; int height;
	
	ControlLocation get()
	{
		return new ControlLocation(x, y, width, height, true);
	}
	
	//getCenteredControl
	ControlLocation(ControlLocation display, int width, int height, boolean expand)
	{
		float dw = display.width / width;
		float dh = display.height / height;
		float d = dw;
		
		if (expand) {if (dh > dw) d = dh;} // crop the picture by expanding
		else {if (dh < dw) d = dh;} // scale the whole picture to show everything
		
		int w = (int) (d * width);
		int h = (int) (d * height);
		int ix = (int) ((display.width/2)-(w/2));
		int iy = (int) ((display.height/2)-(h/2));
		setLocation(display.x + ix, display.y + iy, w, h, true);
	}
	
	ControlLocation()
	{
		setLocation(0, 0, 0, 0, false);
	}
	
	ControlLocation(int ix1, int iy1, int va, int vb, boolean isWidth)
	{
		setLocation(ix1, iy1, va, vb, isWidth);
	}
	
	void setSize(int va, int vb, boolean isWidth)
	{
		setLocation(x1, y1, va, vb, isWidth);
	}
	
	void setLocation(int ix1, int iy1, int va, int vb, boolean isWidth)
	{
		x1 = ix1; y1 = iy1;
		
		if (isWidth)
		{
			width = va; height = vb;
			x2 = x1+width-1; y2 = y1+height-1;
		}
		else
		{
			x2 = va; y2 = vb;
		}
		
		x = x1;
		y = y1;
		if (x2 < x1) x = x2;
		if (y2 < y1) y = y2;
		
		width = abs(x2-x1)+1; height = abs(y2-y1)+1;
	}
}