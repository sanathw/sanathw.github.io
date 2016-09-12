// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................



//ArrayList a = new ArrayList();
HashMap a = new HashMap();


void setup()
{
	setSize(100, 300, P2D, FIT_INSIDE, this);
	//alert("A");
  
  //a.add(new MyAudio("Kalimba.mp3", 0));
  //a.add(new MyAudio("Blow.mp3", 30));
  a.put('q', new MyAudio("./_resources/Kalimba.mp3", 0));
  //a.put('w', new MyAudio("./_resources/Kalimba2.mp3", 0));
  //a.put('e', new MyAudio("Kalimba.mp3", 0));
  //a.put(' ', new MyAudio("Blow.mp3", 30));
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(255);
}

/*
void keyPressed()
{
  //if (key == 'q') {((MyAudio)a.get(0)).play();}
  //if (key == 'w') {((MyAudio)a.get(1)).play();}
  string k = 'q';
  println(k);
  ((MyAudio)a.get(k)).play();
}

void keyReleased()
{
  //if (key == 'q') {((MyAudio)a.get(0)).decay();}
  //if (key == 'w') {((MyAudio)a.get(1)).decay();}
  ((MyAudio)a.get('q')).decay();
}*/


/*
HashMap a = new HashMap();

void setup()
{
  setSize(100, 300, P2D, FIT_INSIDE, this);
  
  //a.put("q", new MyAudio("./_resources/Balloon.wav", 0));
  a.put('q', new MyAudio("./_resources/Kalimba.mp3", 0));
  //a.put('w', new MyAudio("./_resources/Kalimba.mp3", 0));
  //a.put('e', new MyAudio("./_resources/Kalimba.mp3", 0));
  //a.put(' ', new MyAudio("Blow.mp3", 30));
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(255);
}

void keyPressed()
{
  //((MyAudio)a.get('q')).play();
  //alert(key);
  //((MyAudio)a.get(key)).play();
  string k = "q";
  //alert(((MyAudio)a.get('q')));
  ((MyAudio)a.get('q')).play();
  //alert("B");
}

void keyReleased()
{
  string k = "q";
  ((MyAudio)a.get(k)).decay();
}

//boolean f = true;
*/

color c = color(0,255,0);
void draw()
{
  initDraw();
  
  //println("A");
  
  /*if (mousePressed == true && f == true)
  {
    ((MyAudio)a.get('q')).play();
    f = false;
  }
  
  if (mousePressed == false && f == false)
  {
    ((MyAudio)a.get('q')).decay();
    f = true;
  }*/
  
  //println(mousePressed + " " + pmousePressed);
  
  if (mousePressed == true && mousePressed != pmousePressed)
  {
    c = color(255,0,0);
    string k = 'q';
    //println(k);
    ((MyAudio)a.get(k)).play();
    //smwABC();
  }
  
  if (mousePressed == false && mousePressed != pmousePressed)
  {
    c = color(255);
    string k = 'q';
    //println(k);
    ((MyAudio)a.get(k)).decay();
  }
  
  background(c);
  
  Iterator i = a.entrySet().iterator();  // Get an iterator
  while (i.hasNext()) 
  {
    Map.Entry me = (Map.Entry)i.next();
    //print(me.getKey() + " is ");
    //println(me.getValue());
    ((MyAudio)me.getValue()).update();
  }
  
  /*
  
  // display
  stroke(0, 255, 0); strokeWeight(1); line(-h_dw, -h_dh, +h_dw, +h_dh); line(+h_dw, -h_dh, -h_dw, +h_dh);
  ellipseMode(CENTER); noFill(); ellipse(0, 0, dw, dh);
  
  // sketch
  noStroke(); fill(255, 200, 200, 100); rectMode(CENTER); rect(0, 0, sw, sh);
  stroke(0, 0, 255); line(0, 0, 0, -h_sh/2);
  stroke(0, 0, 255); strokeWeight(3); line(0, 0, -h_dw, 0);
  
  if (mousePressed == true) line(0, 0, mouseX, mouseY);
  
  if (mode == P3D)
  {
    lights();
    if (mousePressed == true && mouseButton == RIGHT) fill(255, 0, 0);
    else fill(255);
    stroke(0); strokeWeight(1);
    box(15);
    translate(200, 0);
    fill(0, 255, 0);
    box(10);
  }
  
  if (mode == P2D)
  {
    rotate(mouseX/100);
    rotate(mouseY/100);
    if (mousePressed == true && mouseButton == RIGHT) fill(255, 0, 0);
    else fill(255);
    stroke(0); strokeWeight(1);
    rectMode(CENTER); rect(0, 0, 20, 20);
  }*/
}
