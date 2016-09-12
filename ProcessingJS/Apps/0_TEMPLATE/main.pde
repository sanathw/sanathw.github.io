// http://localhost:5050/Apps/0_TEMPLATE/main.html
//.......................................................................


Button b1 = new Button(.1, .1, .15, .41, "Hello");
TextBox t1 = new TextBox(.3, .1, .15, .411, "Hello");
TextBox t2 = new TextBox(.5, .1, .15, .411, "Hello");
LabelBox l1 = new LabelBox(.8, .1, .15, .411, "Hello");

//KeyboardLine kb1 = new KeyboardLine(.1, .6, .55, .3, "ABCD ", t1);
//KeyboardCtrl kbctrl1 = new KeyboardCtrl(.1, .6, .8, .3, t1);

KeyboardContainer kbContainer = new KeyboardContainer(.1, .6, .8, .3);
KeyboardCtrl kbctrl1 = new KeyboardCtrl(0, 0, 1, 1, null);
KeyboardCtrl kbctrl2 = new KeyboardCtrl(0, 0, 1, 1, null);

void setup()
{
  desiredSize(400, 800, P2D, FIT_INSIDE); // FIT_INSIDE for L-SystemTree, FIT_OUTSIDE for Fractal
  doZoom = true; // access to zoom, zoomStep
  T.translate(0,0,-400); //////// if 3D
  doRotate = true; // access to R
  doTranslate = true; // access tx, ty
  
  
  cm.setParameters(SHOW_AS_HORIZONTAL, SHOW_AT_BOTTOM, 0.25, START_OPENED);
  cm.add(b1);
  cm.add(t1);
  cm.add(t2);
  cm.add(l1);  
  
  kbctrl1.addLine("ABCD");
  kbctrl1.addLine("1234");
  t1.attachKeyboard(kbctrl1, kbContainer);
  
  kbctrl2.addLine("ZXY");
  kbctrl2.addLine("@$%#");
  t2.attachKeyboard(kbctrl1, kbContainer);
  
  //cm.add(kb1);
  //cm.add(kbctrl1);
  //selectedTextBox = t1; otherwise, the last added textBox
  
  kbContainer.setKeyboard(kbctrl1, t2); // to start off with a keyboard
  cm.add(kbContainer);
}
void controlManagerDoProcess() 
{
  //l1.txt = "" + cdist;
  //l1.txt = l1.txt.substring(0, 5);
  //if (kb1.doProcess == true) l1.txt = kb1.txt;
  if (kbctrl1.doProcess == true) l1.txt = kbctrl1.txt;
  
  if (b1.doProcess == true) t2.attachKeyboard(kbctrl2, kbContainer); // kbContainer.setKeyboard(kbctrl2, t2);  //kbctrl1.setLine(1);
}

float px;
float py;

void draw2D(PGraphics g)
{
  g.background(240);
  
  
  // the full model displayed on the window
  g.stroke(255, 0,0); g.strokeWeight(1); g.noFill(); g.rectMode(CENTER); g.ellipseMode(CENTER);
  g.rect(0, 0, desiredWidth, desiredHeight);
  g.ellipse(0, 0, desiredWidth, desiredHeight);
  g.line(-half_desiredWidth, -half_desiredHeight, +half_desiredWidth, +half_desiredHeight);
  g.line(-half_desiredWidth, +half_desiredHeight, +half_desiredWidth, -half_desiredHeight);
  
  
  // the mouse position on the model
  g.stroke(0, 100);
  g.line(0, 0, modelmouseX, modelmouseY);
  
  g.stroke(0);
  g.line(0, 0, px, py);
  
  
  // the amount of the moddel displayed in the window // Can be used to limit Fractal calcualation
  g.stroke(0, 255, 0);
  g.line(modeldisplay_x1, modeldisplay_y1, modeldisplay_x2, modeldisplay_y2);
  g.line(modeldisplay_x1, modeldisplay_y2, modeldisplay_x2, modeldisplay_y1);
  g.ellipseMode(CORNERS);
  g.ellipse(modeldisplay_x1, modeldisplay_y1, modeldisplay_x2, modeldisplay_y2);
  
  //g.fill(255, 240);   g.rect(0, 0, (modeldisplay_x2 - modeldisplay_x1), (modeldisplay_y2 - modeldisplay_y1));
}

void draw3D(PGraphics g)
{
  //g.directionalLight(51, 102, 126, -1, 0, 0);
  g.stroke(0); g.fill(255);
  g.box(80);
}


void mouseDraw(PGraphics g) 
{
  g.stroke(255, 0, 0);
  g.line(0, 0, modelmouseX, modelmouseY);
  px = modelmouseX;
  py = modelmouseY;
}

