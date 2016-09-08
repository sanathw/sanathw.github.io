/* @pjs globalKeyEvents="true"; */
float desiredWidth;
float desiredHeight;
float half_desiredWidth;
float half_desiredHeight;
boolean isFitInside;
final boolean FIT_INSIDE = true;
final boolean FIT_OUTSIDE = false;

float modeldisplay_x1;
float modeldisplay_y1;
float modeldisplay_x2;
float modeldisplay_y2;

float display_s;

float modelMouseX;
float modelMouseY;

PGraphics g;
PGraphics g3D;
boolean is3D;

PMatrix3D cam = new PMatrix3D();
PMatrix3D T = new PMatrix3D();
PMatrix3D R = new PMatrix3D();

float tx = 0;
float ty = 0;
boolean isZoomTranslateRotate = false;
int fingers = 0;

ControlManager cm = new ControlManager();
void sizeChanged() 
{
  //setSize(); 
  size(document.body.clientWidth, document.body.clientHeight, P2D);
  cm.calculateSize(); setDesiredScale();
  
  if (is3D == true) g3D = createGraphics(width, height, P3D);
}

void setDesiredScale()
{
  float sx = width / desiredWidth;
  float sy = height / desiredHeight;
  if (isFitInside == true) display_s = min(sx, sy);
  else display_s = max(sx, sy);
}

void desiredSize(float i_desiredWidth, float i_desiredHeight, int i_mode, boolean i_isFitInside) 
{
  desiredWidth = i_desiredWidth;
  desiredHeight = i_desiredHeight;
  isFitInside = i_isFitInside;
  
  half_desiredWidth = desiredWidth/2;
  half_desiredHeight = i_desiredHeight/2;
  
  if (i_mode == P3D) is3D = true;
  else is3D = false;
  
  sizeChanged() ;
}
void draw()
{
  
  if (is3D == true) g = g3D;
  else g = this;
  

  preDraw();
  
  modelmouseX = mouseX - (width/2);
  modelmouseY = mouseY - (height/2);
  
  modelmouseX = modelmouseX / display_s;
  modelmouseY = modelmouseY / display_s;
  
  modeldisplay_x1 = -(width/2) / display_s;
  modeldisplay_y1 = -(height/2) / display_s;
  modeldisplay_x2 = (width/2) / display_s;
  modeldisplay_y2 = (height/2) / display_s;
  
  
  g.pushMatrix();
  
  g.translate(width/2, height/2);
  g.scale(display_s);
  
  if (doZoom == true) 
  {
    g.scale(zoom);
    
    modelmouseX = modelmouseX / zoom;
    modelmouseY = modelmouseY / zoom;
  
    modeldisplay_x1 = modeldisplay_x1 / zoom;
    modeldisplay_y1 = modeldisplay_y1 / zoom;
    modeldisplay_x2 = modeldisplay_x2 / zoom;
    modeldisplay_y2 = modeldisplay_y2 / zoom;
  }
  
  
  if (fingers == 0 && mousePressed == true && mouseButton == RIGHT) 
  {
    isZoomTranslateRotate = true;
    tx = tx + (mouseX - pmouseX)/zoom;
    ty = ty + (mouseY - pmouseY)/zoom;
  }
  
  if (doTranslate == true) 
  {
    g.translate(tx, ty);
    
    modelmouseX = modelmouseX - tx;
    modelmouseY = modelmouseY - ty;
    
    modeldisplay_x1 = modeldisplay_x1 - tx;
    modeldisplay_y1 = modeldisplay_y1 - ty;
    modeldisplay_x2 = modeldisplay_x2 - tx;
    modeldisplay_y2 = modeldisplay_y2 - ty;
  }
  
  draw2D(g);
  
  if (cm.isControlDown == false && mousePressed == true)
  {
  
    // rotation ...............................
    if (is3D == true && mouseButton == LEFT)
    {
      PMatrix3D tempR = new PMatrix3D();
      tempR.rotateY((float)(mouseX-pmouseX) * map(abs(mouseY-height/2), 0, height/2, 1, 0) /100f) ;
      tempR.rotateX((float)(mouseY-pmouseY) * map(abs(mouseX-width/2), 0, width/2, 1, 0)/-100f);
      tempR.rotateZ((float)(mouseY-pmouseY) * map(mouseX, 0, width, -1, 1)/100f);
      tempR.rotateZ((float)(mouseX-pmouseX) * map(mouseY, 0, height, -1, 1) /-100f) ;
      tempR.apply(R);
      R = tempR.get();
      isZoomTranslateRotate = true;
    }
  
    if (isZoomTranslateRotate == false) mouseDraw(g);
  }
  
  if(is3D == true)
  {
    // 3D Draw
    ////////////////////////////////
    g.pushMatrix();
    g.resetMatrix();
    cam.reset();
    cam.apply(T);
    
    if (doZoom == true) cam.scale(zoom);
    if (doTranslate == true) cam.translate(tx, ty);
    if (doRotate == true) cam.apply(R);
    //cam.apply(T);
    
    

    float[] f = new float[16]; f = cam.array();
    g.applyMatrix(
       f[0], f[1], f[2], f[3],
       f[4], f[5], f[6], f[7],
       f[8], f[9], f[10], f[11],
       f[12], f[13], f[14], f[15]);
    
    draw3D(g);
    g.popMatrix();
    ///////////////////////////////
  }
  
  g.popMatrix();
  
  if (is3D == true) image(g3D, 0, 0);
  
  //hint(DISABLE_DEPTH_TEST);
  postDraw();
  //hint(ENABLE_DEPTH_TEST);
  
  
  
  zoomStep = 0;
  if (mousePressed == false) isZoomTranslateRotate = false;
  
}
void preDraw() { cm.update(); controlManagerDoProcess(); }
void postDraw() { cm.draw(); }


// Touch & Zoom ............................
float zoom = 1;
int zoomStep = 0;
boolean doZoom = true;
boolean doRotate = true;
boolean doTranslate = true;
float pdist;
float cdist;
float tx1; float ty1;
float tx2; float ty2;
float px1; float py1;
float px2; float py2;
void touchStart(TouchEvent touchEvent) 
{
  mouseX = touchEvent.touches[0].offsetX;
  mouseY = touchEvent.touches[0].offsetY;
  mousePressed = true;
  
  tx1 = mouseX; 
  ty1 = mouseY;
  px1 = tx1;
  py1 = ty1;
  
  if (touchEvent.touches.length > 1)
  {
    tx2 = touchEvent.touches[1].offsetX; 
    ty2 = touchEvent.touches[1].offsetY;
    px2 = tx2;
    py2 = ty2;
    cdist = abs(dist(tx1, ty1, tx2, ty2));
    pdist = cdist;
    isZoomTranslateRotate = true;
  }
  
  fingers = touchEvent.touches.length
}

void touchMove(TouchEvent touchEvent) 
{
  mouseX = touchEvent.touches[0].offsetX;
  mouseY = touchEvent.touches[0].offsetY;
  mousePressed = true;
  
  tx1 = mouseX; 
  ty1 = mouseY;
  if (touchEvent.touches.length > 1)
  {
    isZoomTranslateRotate = true;
    tx2 = touchEvent.touches[1].offsetX; 
    ty2 = touchEvent.touches[1].offsetY;
    
    int dx1 = 0;
    if ((tx1 - px1) > 0 ) dx1 = 1;
    else if ((tx1 - px1) < 0 ) dx1 = -1;
    
    int dy1 = 0;
    if ((ty1 - py1) > 0 ) dy1 = 1;
    else if ((ty1 - py1) < 0 ) dy1 = -1;
    
    int dx2 = 0;
    if ((tx2 - px2) > 0 ) dx2 = 1;
    else if ((tx2 - px2) < 0 ) dx2 = -1;
    
    int dy2 = 0;
    if ((ty2 - py2) > 0 ) dy2 = 1;
    else if ((ty2 - py2) < 0 ) dy2 = -1;
    
    cdist = abs(dist(tx1, ty1, tx2, ty2));
    
    if (dx1 == dx2 && dy1 == dy2 && ((dx1 != 0 && dx2 != 0) || (dy1 != 0 && dy2 != 0)))
    {
      tx = tx + (tx2 - px2) / zoom;
      ty = ty + (ty2 - py2) / zoom;
    }
    else if (abs(cdist - pdist) > (0.02 * pdist)) //if ((dx1 != dx2) ||(dy1 != dy2))
    {
      mouseScroll = cdist - pdist;
      mouseScrolled();
    }
    
    /*
    //if (cdist != pdist)
    if (abs(cdist - pdist) > (0.02 * pdist))
    {
      mouseScroll = cdist - pdist;
      mouseScrolled();
    }
    else
    {
      tx = tx + tx2 - px2;
      ty = ty + ty2 - py2;
    }*/
    
    pdist = cdist;
    
    px2 = tx2;
    py2 = ty2;
  }
  
  px1 = tx1;
  py1 = ty1;
  
  // empty the canvas
  //noStroke();
  //fill(255);
  //rect(0, 0, 400, 300);
 
  // draw circles at where fingers touch
  //fill(180, 180, 100);
  //for (int i = 0; i < touchEvent.touches.length; i++) {
  //  int x = touchEvent.touches[i].offsetX;
  //  int y = touchEvent.touches[i].offsetY;
  //  
  //  ellipse(x, y, 50, 50);
  //}
}

void touchEnd(TouchEvent touchEvent) 
{
  mousePressed = false;
  fingers = 0;
}

void touchCancel(TouchEvent touchEvent)
{
  mousePressed = false;
   fingers = 0;
}


void mouseScrolled()
{
  if (mouseScroll > 0) { zoom = zoom * 1.2; zoomStep = 1; }
  else { zoom = zoom / 1.2; zoomStep = -1; }
  isZoomTranslateRotate = true;
}



// Keyboard.........................................
void doBackspace()
{
  if (selectedTextBox != null) selectedTextBox.backspace();
}

void keyPressed()
{
  //alert(selectedTextBox);
  if (selectedTextBox != null)
  {
    if (key == CODED) 
    {
      if (keyCode == LEFT) selectedTextBox.moveLeft();
      if (keyCode == RIGHT) selectedTextBox.moveRight();
    }
    else
    {
      if (key == 127) 
      {
        selectedTextBox.delete();
      }
      else
      {
        String s = new String(key);
        selectedTextBox.add(s);
      }
    }
  }
}
///////////////////////////////

//________________________________________________________________________
// CONTROL MANAGER
//########################################################################
boolean isBackgroundDown = false;
Control focusControl = null;
TextBox selectedTextBox = null;

final boolean SHOW_AS_HORIZONTAL = true;
final boolean SHOW_AS_VERTICAL = false;
final boolean SHOW_AT_TOP = true;
final boolean SHOW_AT_LEFT = true;
final boolean SHOW_AT_BOTTOM = false;
final boolean SHOW_AT_RIGHT = false;
final boolean START_OPENED = true;
final boolean START_CLOSED = false;

class ControlManager
{
  ArrayList controls = new ArrayList();
  float showPercent;
  float showChange = 0;
  final float showChangeStep = 0.15;// 0.075;
  boolean showAsHorizontal;
  boolean showAtTop; 
  float expandPercent;
  float expandSize;
  boolean isOpened;
  float minScreenSize;
  float ctrSize;
  boolean isControlDown = false;
  float x1; float y1;
  float x2; float y2;
  
  void setParameters(boolean i_showAsHorizontal, boolean i_showAtTop, float i_expandPercent, boolean i_startOpened) 
  { 
    showAsHorizontal = i_showAsHorizontal; showAtTop = i_showAtTop; expandPercent = i_expandPercent; if (i_startOpened == true) {showPercent = 1; isOpened = true;} else {showPercent = 0; isOpened = false}
    calculateSize();
  }
  
  void add(Control c) { c.cm = this; controls.add(c); }
  
  void calculateSize()
  {    
    if (isMobile == true)
    {
      minScreenSize = min(window.innerWidth, window.innerHeight);
      expandSize = expandPercent * minScreenSize;
      ctrSize = 0.05 * minScreenSize;
    }
    else
    {
      minScreenSize = min(screen.width, screen.height);
      expandSize = expandPercent * minScreenSize * 0.5;
      ctrSize = 0.05 * minScreenSize * 0.25;
      
      float t_minScreenSize = min(document.body.clientWidth, document.body.clientHeight);
      float t_expandSize = expandPercent * t_minScreenSize;
      float t_ctrSize = 0.05 * t_minScreenSize;
      
      if (t_expandSize < expandSize) expandSize = t_expandSize;
      if (t_ctrSize < ctrSize) ctrSize = t_ctrSize;
      
    }
    
    half_ctrSize = ctrSize / 2;
    two_ctrSize = ctrSize * 2;
  }

  void update()
  {
    
    if (isBackgroundDown == false)
    {
      if (mousePressed == true)
      {
        if (isControlDown == false)
        {
          if ((showAsHorizontal == true && showAtTop == true) || (showAsHorizontal == false && showAtTop == true))
          {
            if (mouseX <= two_ctrSize && mouseY <= two_ctrSize) { if (isOpened == true) showChange = -showChangeStep; else showChange = showChangeStep; isControlDown = true; }
          }
          else
          {
            if (mouseX >= (width - two_ctrSize) && mouseY >= (height - two_ctrSize)) { if (isOpened == true) showChange = -showChangeStep; else showChange = showChangeStep; isControlDown = true; }
          }
        }
        
        if (mouseX >= x1 && mouseX <= x2 && mouseY >= y1 && mouseY <= y2) isControlDown = true;
        
      }
      else
      {
        isControlDown = false;
      }
      
      
      
      for (int i = 0; i < controls.size(); i++) 
      { 
        Control c = (Control) controls.get(i); 
        c.update(); 
        
        //isControlItemDown = isControlItemDown || c.isDown;
        //if (focusControl == null && c.isDown == true) {focusControl = c; }// println("SET");}
        isControlDown = isControlDown || c.isDown;  //SANATH
      }
    }
    
    if (isControlDown == false && mousePressed == true) isBackgroundDown = true;
    if (mousePressed == false) {isBackgroundDown = false; focusControl = null;}// isControlItemDown = false;}
    
    //if (mousePressed == true && focusControl == null ) selectedTextBox = null;
    
    showPercent += showChange;
    if (showPercent > 1) {showPercent = 1; showChange =0; isOpened = true;}
    if (showPercent < 0) {showPercent = 0; showChange =0; isOpened = false;}
  }
  
  void draw()
  {
    float expanseStart;
    float b;
    if (showAsHorizontal == true) b = height;
    else b = width;
    
    if (showAtTop == true) expanseStart = (showPercent * expandSize) - expandSize;
    else expanseStart = b - (showPercent * expandSize);
    

    float w;
    float h;
    
    if (showAsHorizontal == true) 
    { 
      x1 = 0; w = width; 
      if (showAtTop == true) {y1 = 0 + expanseStart; h = expandSize;}
      else {y1 = expanseStart; h = expandSize;}
    }
    else 
    { 
      y1 = 0; h = height;
      if (showAtTop == true) {x1 = 0 + expanseStart; w = expandSize;}
      else {x1 = expanseStart; w = expandSize;}
    }
    x2 = x1 + w;
    y2 = y1 + h;
    stroke(0, 50); strokeWeight(1); fill(255, 140); rectMode(CORNERS);
    rect(x1, y1, x2, y2);
    
    for (int i = 0; i < controls.size(); i++) 
    { 
      Control c = (Control) controls.get(i); 
      c.draw(x1, y1, x2, y2); 
    }

    
    
    pushMatrix();
    stroke(0, 40); strokeWeight(1); fill(255, 80); ellipseMode(CENTER);
    if ((showAsHorizontal == true && showAtTop == true) || (showAsHorizontal == false && showAtTop == true)) translate(ctrSize, ctrSize);
    else translate(width - ctrSize, height - ctrSize);
    ellipse( 0, 0, two_ctrSize, two_ctrSize);
    
     if (showAsHorizontal == true && showAtTop == true) scale(1, 1);
     if (showAsHorizontal == true && showAtTop == false) scale(1, -1);
     if (showAsHorizontal == false && showAtTop == true) rotate(-HALF_PI);
     if (showAsHorizontal == false && showAtTop == false) rotate(HALF_PI);
    
    stroke(0, 100);
    if (isOpened == true)
    {
      line (0, 0, half_ctrSize, half_ctrSize);
      line (0, 0, -half_ctrSize, half_ctrSize);
    }
    else
    {
      line (0, 0, -half_ctrSize, -half_ctrSize);
      line (0, 0, half_ctrSize, -half_ctrSize);
    }
    popMatrix();
  }
}
// Example:
// //Button b1 = new Button(0, 0, .25, .25, "A"); // TextBox // add(""), backspase(), clear() //LabelBox //ImageButton //cm.add(b1); //b1.isContinous = true; //b1.isOn = true; //b1.isDisabled = true;

//________________________________________________________________________
// Enable or disable a group of controls
//________________________________________________________________________
class ControlEnableDisableGroup
{
  ArrayList controls = new ArrayList();
  void add(Control c) { controls.add(c); }

  void enable()
  {
    for (int i = 0; i < controls.size(); i++) { Control c = (Control) controls.get(i); c.isDisabled = false;}
  }

  void disable()
  {
    for (int i = 0; i < controls.size(); i++) { Control c = (Control) controls.get(i); c.isDisabled = true;}
  }
}
// Example:
// ControlEnableDisableGroup edg = new ControlEnableDisableGroup(); //add controls as required: edg.add(b1); // edg.disable(); edg.enable();

//________________________________________________________________________
class Container extends Control
{
  ArrayList controls = new ArrayList();
  Control ctr = null;
  
  Container(float i_px1, float i_py1, float i_pw, float i_ph) 
  { 
    super(i_px1, i_py1, i_pw, i_ph);
  }
  
  void add(Control c)
  {
    controls.add(c);
  }
  
  void clear()
  {
    controls.clear();
  }
 
  void update()
  {
    isDown = false;
    doProcess = false;

    for (int i = 0; i< controls.size(); i++)
    {
      Control c = (Control) controls.get(i);
      c.update();
      isDown = isDown || c.isDown;
      
      if (c.doProcess == true) { ctr = c; doProcess = true;}
    }
  }
  
 
  void draw(float i_x1, float i_y1, float i_x2, float i_y2)
  {
    super.calculateSize(i_x1, i_y1, i_x2, i_y2);
    
    for (int i = 0; i< controls.size(); i++)
    {
      Control c = (Control) controls.get(i);
      c.draw(x1, y1, x2, y2);
    }
  }
}

//________________________________________________________________________
class Control
{
  float x1; float y1; float x2; float y2;
  float w; float h;
  float px1; float py1; float pw; float ph;
  
  boolean isOver = false; boolean isDown = false; boolean doProcess = false;
  boolean isDisabled = false;
  Control(float i_px1, float i_py1, float i_pw, float i_ph) { px1 = i_px1; py1 = i_py1; pw = i_pw; ph = i_ph; }
  void update() {}
  void draw(float i_x1, float i_y1, float i_x2, float i_y2){}

  boolean isInside(int x, int y)
  {
    if (x >= x1 && x <= x2 && y >= y1 && y <= y2) return true;
    return false;
  }
  
  void calculateSize(float i_x1, float i_y1, float i_x2, float i_y2)
  {
    float tw = i_x2 - i_x1;
    float th = i_y2 - i_y1;
    
    x1 = i_x1 + tw * px1;
    y1 = i_y1 +th * py1;
    x2 = x1 + tw * pw;
    y2 = y1 + th * ph;
    
    w = x2 - x1;
    h = y2 - y1;
  }
  
  float getFittedTextSize(String txt, float border)
  {
    textSize(40);
    float sw = textWidth(txt);
    float sh = textAscent() + textDescent();
    
    float dw = sw / (w - (w * border));
    float dh = sh / (h - (h * border));
    
    float d = max(dw, dh);
    return 40 /d;
  }
}
// Example:
// in controlManagerDoProcess() if (b1.doProcess == true)

//________________________________________________________________________
class Button extends Control
{
  String txt;
  color c1 = color(0, 50); color c2 = color(255); color cText;
  color c3 = color(190, 50);  color c4 = color(190, 150); color c5 = color(0, 0, 255, 150); color c6 = color(255, 0, 0, 150); color c7 = color(0, 255, 0, 150);  color cBack;
  boolean processed = false;
  boolean isContinous = false;
  boolean isOn = false;

  Button (float i_px1, float i_py1, float i_pw, float i_ph, String t) { super(i_px1, i_py1, i_pw, i_ph);  txt = t; }

  void update()
  {
    isOver = false;
    isDown = false; //SANATH
    doProcess = false;
    
    //TextBox b = (TextBox) focusControl;
    //if (focusControl != null) println(focusControl.x1);
  
  //println(focusControl);
  
  
  
  
    if ( (focusControl == null || focusControl == this) && isDisabled == false)
    {
      if (isInside(mouseX, mouseY) == true)
      {
        if (isMobile == false) isOver = true;
        if (mousePressed == true) 
        { 
          isDown = true; 
          
          
          if(processed == false) 
          {
            doProcess = true;  
            if (isContinous == false) processed = true;
          }
        }
      }
    }
    
    if (mousePressed == false) { processed = false; isDown = false;}   //SANATH
  }

  void draw(float i_x1, float i_y1, float i_x2, float i_y2)
  {
    super.calculateSize(i_x1, i_y1, i_x2, i_y2);
    
    if (isDisabled == true)
    {
      cText = c1;
      cBack = c3;
    }
    else
    {
      cText = c2;
      cBack = c4;
      if (isOn == true) cBack = c7;
      if (isOver == true) cBack = c5;
      if (isDown == true) cBack = c6;
    }
    
    noStroke(); fill(cBack); rectMode(CORNERS);
    rect(x1, y1, x2, y2);
    
    /*if (txt.length > 0)
    {
      float s = min((x2-x1) / txt.length, (y2-y1));
      textSize(s);
      
      fill(cText); textAlign(CENTER, CENTER);
      text(txt, (x1 + x2)/2, (y1 + y2)/2);
    }*/
    
    if (txt.length > 0)
    {
      textSize(getFittedTextSize(txt, 0.1));
      
      fill(cText); textAlign(CENTER, CENTER);
      text(txt, (x1 + x2)/2, (y1 + y2)/2);
    }
  }
}
// Example:
/* Example of a new Button
class ImageButton extends Button
{
  ImageButton (float i_px1, float i_py1, float i_pw, float i_ph, String t) { super(i_px1, i_py1, i_pw, i_ph, t); }

  void draw(float i_x1, float i_y1, float i_x2, float i_y2)
  {
    super.calculateSize(i_x1, i_y1, i_x2, i_y2);
    
      // ib1 draw
      //{
        //ib1.txt
        //ib1.isDisabled  cBack = ib1.c3; cText = c1;
        // cBack = ib1.c3; cText = c2;
        //ib1.isOn == true) cBack = ib1.c7;  
        //ib1.isOver == true) cBack = ib1.c5;
        //ib1.isDown == true) cBack = ib1.c6;
        //noStroke(); fill(255, 0, 0); rectMode(CORNERS);
        //rect(ib1.x1, ib1.y1, ib1.x2, ib1.y2);
      //}
  }
  //Button b1 = new Button(0, 0, .25, .25, "A"); // TextBox // add(""), backspase(), clear() //LabelBox //ImageButton //cm.add(b1); //b1.isContinous = true; //b1.isOn = true; //b1.isDisabled = true;
}
*/

//________________________________________________________________________
class TextBox extends Control
{
  String txt;
  int crt = 0;
  boolean showcrt = true;
  float charWidth;
  float half_charWidth;
  color c1 = color(0, 50); color c2 = color(150); color cText;
  color c3 = color(190, 50);  color c4 = color(255, 150);  color cBack;
  KeyboardContainer kbContainer = null;
  KeyboardCtrl kbctrl = null;;

  TextBox(float i_px1, float i_py1, float i_pw, float i_ph, String t) { super(i_px1, i_py1, i_pw, i_ph);  txt = t; selectedTextBox = this;}
 
  void attachKeyboard(KeyboardCtrl i_kbctrl, KeyboardContainer i_kbContainer)
  {
    kbContainer = i_kbContainer;
    kbctrl = i_kbctrl;
    
    if (selectedTextBox == this) kbContainer.setKeyboard(kbctrl, this);
  }
 
  void update()
  {
    isDown = false;
    
    if (isDisabled == false && mousePressed == true && focusControl == null && isInside(mouseX, mouseY) == true )
    {
      isDown = true;
      focusControl = this;
      //println(this);
      selectedTextBox = this;
      
      if (kbContainer != null && kbctrl != null)
      {
        kbContainer.setKeyboard(kbctrl, this);
      }
      
    }
    
    if (isDisabled == false && mousePressed == true && focusControl == this )//&& isInside(mouseX, mouseY) == true )
    {
      isDown = true;
      int d = mouseX - x1;
      d = d - half_charWidth + charWidth;
      d = d / charWidth;
      crt = (int) d;
      if (crt > txt.length) crt = txt.length;
      if (crt < 0) crt = 0; 
    }
  }
  
  void moveLeft()
  {
    crt--;
    if (crt < 0) crt = 0;
  }
  
  void moveRight()
  {
    crt++;
    if (crt > txt.length) crt = txt.length;
  }
 
  void backspace()
  {
    if (crt > 0)
    {
      string temp = txt;
      txt = temp.substring(0, crt-1);
      txt = txt + temp.substring(crt);
      crt = crt -1;
      if (crt < 0) crt = 0;
    }
  }
  
  void delete()
  {
    if (crt < txt.length)
    {
      string temp = txt;
      txt = temp.substring(0, crt);
      txt = txt + temp.substring(crt+1);
    }
  }
 
  void clear()
  {
    txt = "";
    crt = 0;
  }
 
  void add(string s)
  {
    if (kbctrl != null && kbctrl.validKeys.indexOf(s) <= -1) return;
    
    string temp = txt;
    txt = temp.substring(0, crt);
    txt = txt + s;
    txt = txt + temp.substring(crt);
    crt++;
  }
 
  void draw(float i_x1, float i_y1, float i_x2, float i_y2)
  {
    super.calculateSize(i_x1, i_y1, i_x2, i_y2);
    
    if (isDisabled == true)
    {
      cText = c1;
      cBack = c3;
      showcrt = false;
    }
    else
    {
      cText = c2;
      cBack = c4;
      showcrt = true;
    }
    
    if (this != selectedTextBox) showcrt = false;
    
    stroke(150); strokeWeight(1); fill(cBack); rectMode(CORNERS);
    //if (selectedTextBox == this) strokeWeight(3);
    rect(x1, y1, x2, y2);
      
    charWidth = min((x2-x1) / (txt.length + 1), (y2-y1));
    half_charWidth = charWidth / 2;
    textSize(charWidth);
    
    fill(cText); textAlign(CENTER, CENTER);
    for (int i = 0; i < txt.length+1; i++)
    {
      if (i < txt.length) text(txt[i], x1 + half_charWidth + (charWidth * i), (y1 + y2) / 2);
      if (i==crt && showcrt == true)
      {
        stroke(0, 0, 255); strokeWeight(1);
        int x = x1 + (charWidth * i);
        line(x, y1-(charWidth/3), x, y2+(charWidth/3));
      }
    }
    
    //fill(0);
    //textSize(40);
    //alert(y1); noLoop();
    //text("Hello", x1, y1);
  }
}
// Example:
// //Button b1 = new Button(0, 0, .25, .25, "A"); // TextBox // add(""), backspase(), clear() //LabelBox //ImageButton //cm.add(b1); //b1.isContinous = true; //b1.isOn = true; //b1.isDisabled = true;


//________________________________________________________________________
class KeyboardLine extends Control
{
  String validKeys = "";
  String txt = "";
  ArrayList buttons = new ArrayList();
  TextBox txtBox;
  
  KeyboardLine(float i_px1, float i_py1, float i_pw, float i_ph, String txt, TextBox i_txtBox) 
  { 
    super(i_px1, i_py1, i_pw, i_ph);
    
    txtBox = i_txtBox;
    
    validKeys = txt;
    
    var t = txt;//txt.split(" ");
    
    float gap = 1 / ((t.length*6) + (t.length-1));
    float dw = gap * 6;
    
    for (int i = 0; i < t.length; i++)
    {
      Button b;
      if ( i == 0) b = new Button(dw*i, 0, dw, 1, t[i]);
      else b = new Button((dw+gap)*i, 0, dw, 1, t[i]);
      
      buttons.add(b);
    }
    
  }
  
  void setTextBox(TextBox i_txtBox)
  {
    txtBox = i_txtBox;
  }
 
  void update()
  {
    isDown = false;
    doProcess = false;
    
    for (int i = 0; i< buttons.size(); i++)
    {
      Button b = (Button) buttons.get(i);
      b.update();
      isDown = isDown || b.isDown;
      
      //if (isDown == true) {txt = b.txt; doProcess = true;}
      if (b.doProcess == true) { txtBox.add(b.txt); txt = b.txt; doProcess = true;}
    }
  }
  
 
  void draw(float i_x1, float i_y1, float i_x2, float i_y2)
  {
    super.calculateSize(i_x1, i_y1, i_x2, i_y2);
    
    stroke(0); strokeWeight(1); noFill();rectMode(CORNERS);
    rect(x1, y1, x2, y2);
    
    for (int i = 0; i< buttons.size(); i++)
    {
      Button b = (Button) buttons.get(i);
      b.draw(x1, y1, x2, y2);
      
      //if (b.doProcess == true) { txtBox.add(b.txt); txt = b.txt; doProcess = true;}
    }
  }
}

class KeyboardContainer extends Control
{
  KeyboardCtrl keyboard = null;
  String txt = "";
  
  KeyboardContainer(float i_px1, float i_py1, float i_pw, float i_ph)
  { 
    super(i_px1, i_py1, i_pw, i_ph);
  }
  
  void setKeyboard(KeyboardCtrl i_keyboard, TextBox i_txtBox)
  {
    keyboard = i_keyboard;
    keyboard.setTextBox(i_txtBox);
  }
  
  
  
  
  void update()
  {
    isDown = false;
    doProcess = false;
    
    if (keyboard != null)
    {
     keyboard.update();
     isDown = isDown || keyboard.isDown;
     if (keyboard.doProcess == true) {txt = keyboard.txt; doProcess = true;};
    }
  }
  
 
  void draw(float i_x1, float i_y1, float i_x2, float i_y2)
  {
    super.calculateSize(i_x1, i_y1, i_x2, i_y2);
    
    if (keyboard != null)
    {
      keyboard.draw(x1, y1, x2, y2);
    }
  }
  
}

class KeyboardCtrl extends Control
{
  String validKeys = "";
  String txt = "";
  TextBox txtBox;
  boolean addCycle = false;
  Button cycle = new Button(0, 0, .1, 1, "Cycle");
  Container c = new Container(0, 0, .86, 1);
  Button bkSpace = new Button(.9, 0, .1, 1, "Bksp");
  
  ArrayList lines = new ArrayList();
  int currLine;
  //Button del = new Button(.6, 0, .4, .45, "Del");
  //Button clr = new Button(.6, .55, .4, .45, "Clr");
  
  KeyboardCtrl(float i_px1, float i_py1, float i_pw, float i_ph, TextBox i_txtBox) 
  { 
    super(i_px1, i_py1, i_pw, i_ph);
    
    txtBox = i_txtBox;
  }
  
  void setTextBox(TextBox i_txtBox)
  {
    txtBox = i_txtBox;
    
    
    for (int i = 0; i < lines.size(); i++)
    {
      KeyboardLine kbl = (KeyboardLine) lines.get(i);
      kbl.setTextBox(i_txtBox);
    }
  }
  
  void addLine(String t)
  {
    KeyboardLine kbl = new KeyboardLine(0, 0, 1, 1, t, txtBox);
    lines.add(kbl);
    validKeys = validKeys + t;
    if (lines.size() == 1) { setLine(0); }
    if (lines.size() == 2) { addCycle = true; c.px1 = 0.14; c.pw = .72;}
  }
  
  void setLine(int i)
  {
    if (i < lines.size()) currLine = i;
    c.clear();
    c.add(lines.get(currLine));
  }
  
  void cycleLine()
  {
    currLine++;
    if (currLine >= lines.size()) currLine = 0;
    setLine(currLine);
  }
 
  void update()
  {
    isDown = false;
    doProcess = false;
    
    if (addCycle == true)
    {
      cycle.update();
      isDown = isDown || cycle.isDown;
      if (cycle.doProcess == true) { cycleLine(); }
    }
    
     bkSpace.update();
     isDown = isDown || bkSpace.isDown;
     if (bkSpace.doProcess == true) { txtBox.backspace();  }
     
     //del.update();
     //isDown = isDown || del.isDown;
     //if (del.doProcess == true) txtBox.delete();
     
     //clr.update();
     //isDown = isDown || clr.isDown;
     //if (clr.doProcess == true) txtBox.clear();
     
     
     c.update();
     isDown = isDown || c.isDown;
     //if (c.doProcess == true) {KeyboardLine kbl = (KeyboardLine) c; txt = kbl.txt; doProcess = true;};
     if (c.doProcess == true) {txt = c.ctr.txt; doProcess = true;  }
     
    /*
    for (int i = 0; i< lines.size(); i++)
    {
      KeyboardLine kbl = (KeyboardLine) lines.get(i);
      kbl.update();
      isDown = isDown || kbl.isDown;
      
      if (kbl.doProcess == true) { txt = kbl.txt; doProcess = true;}
    }*/
  }
  
 
  void draw(float i_x1, float i_y1, float i_x2, float i_y2)
  {
    super.calculateSize(i_x1, i_y1, i_x2, i_y2);
    
    stroke(0); strokeWeight(1); noFill();rectMode(CORNERS);
    //rect(x1, y1, x2, y2);
    
    if (addCycle == true) cycle.draw(x1, y1, x2, y2);
    
    bkSpace.draw(x1, y1, x2, y2);
    //del.draw(x1, y1, x2, y2);
    //clr.draw(x1, y1, x2, y2);
    
    c.draw(x1, y1, x2, y2);
    /*
    for (int i = 0; i< lines.size(); i++)
    {
      KeyboardLine kbl = (KeyboardLine) lines.get(i);
      kbl.draw(x1, y1, x2 - bkSpace.w, y2);
      
      //if (b.doProcess == true) { txtBox.add(b.txt); txt = b.txt; doProcess = true;}
    }
    */
  }
}

//________________________________________________________________________
class LabelBox extends Control
{
  String txt;
  color c1 = color(0, 50); color c2 = color(150); color cText;
  color c3 = color(190, 50);  color c4 = color(255, 150);  color cBack;

  LabelBox (float i_px1, float i_py1, float i_pw, float i_ph, String t) { super(i_px1, i_py1, i_pw, i_ph);  txt = t; }

  void draw(float i_x1, float i_y1, float i_x2, float i_y2)
  {
    super.calculateSize(i_x1, i_y1, i_x2, i_y2);
    
    if (isDisabled == true)
    {
      cText = c1;
      cBack = c3;
    }
    else
    {
      cText = c2;
      cBack = c4;
    }
    
    noStroke(); fill(cBack); rectMode(CORNERS);
    rect(x1, y1, x2, y2);
    
    if (txt.length > 0)
    {
      /*float s = min((x2-x1) / txt.length, (y2-y1));
      textSize(s);*/
      
      textSize(getFittedTextSize(txt, 0.1));
      
      fill(cText); textAlign(CENTER, CENTER);
      text(txt, (x1 + x2)/2, (y1 + y2)/2);
      
    }
  }
}
//########################################################################



