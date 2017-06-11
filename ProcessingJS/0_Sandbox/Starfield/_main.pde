// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

// https://www.youtube.com/watch?v=pZ1-YhuJkX8
// Fourth Doctor Titles Version 2 - Doctor Who - BBC
// "C:\Sanath\Video\Fourth Doctor Titles Version 2 - Doctor Who - BBC.mp4"


//---------------------------------------
var audioContext = new(window.AudioContext || window.webkitAudioContext)();
var sampleBuffer = null;
var sampleURL = './_resources/DrWho.mp3';// './bass.wav';// 'https://dl.dropboxusercontent.com/s/47hgqffhjcsli6r/dinky-jam.mp3';
var sound; // this is a AudioBufferSourceNode
var playState = false;

// function to load sounds via AJAX
function loadSound(url) {
  bMusic.txt = "Loading...";
    var request = new XMLHttpRequest();
    request.open('GET', url, true);
    request.responseType = 'arraybuffer';

    request.onload = function () {
        bMusic.txt = "Done";
        audioContext.decodeAudioData(request.response, function (buffer) {
            var soundLength = buffer.duration;
            sampleBuffer = buffer;
            //loopStart.setAttribute('max', Math.floor(soundLength));
            //loopEnd.setAttribute('max', Math.floor(soundLength));
            playSound();
        });
    };

    request.send();
}

// set our sound buffer, loop, and connect to destination
function setupSound() {
    sound = audioContext.createBufferSource();
    sound.buffer = sampleBuffer;
    sound.loop = true;
    //sound.loopStart = loopStart.value;
    //sound.loopEnd = loopEnd.value;
    //sound.detune.value = -1000;
    //sound.playbackRate.value = playbackSlider.value;
    sound.connect(audioContext.destination);
}

// play sound and enable / disable buttons
function playSound() {
    setupSound();
    
    playState = true;
    bMusic.txt = "Stop";
    
    sound.start(0);
    sound.onended = function () 
    {
      playState = false;
      bMusic.txt = "Play";
    }
}
// stop sound and enable / disable buttons
function stopSound() {
    //UI('stop');
    sound.stop(0);
    playState = false;
    bMusic.txt = "Play";
}
//----------------------------------------

const MAX_DEPTH = 32;
const STARS = 500;
var starBackground = [];
var star = [];
var flashlightAngle = [];
var flashlightScale = [];

var showBackground = false;
var showColor = false;
var showGradient = false;
var showStars = 500;
var speed = 0.1;

void setup()
{
  for (int i = 0; i < STARS; i++)
  {
    star[i] = new PVector(random(-200, 200), random(-200, 200), random(1, MAX_DEPTH));
    starBackground[i] = new PVector(random(-200, 200), random(-200, 200));
    flashlightAngle[i] = random(0, PI*2);
    flashlightScale[i] = random(0.5, 1);
  }
  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(400, 400, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  var ccr = (int) map(speed, 0, 0.5, 0, 40);
  var ccb = (int) map(speed, 0, 0.5, 60, 10);
  if (showGradient) g.gradientBackground3(VERTICAL, color(0), color(0), 0.5, color(ccr,0,ccb));
  else g.background(0);
  
  
}

void draw()
{
  initDraw();
  
  for (int i = 0; i<showStars; i++)
  {
    star[i].z = star[i].z - speed;
    
    if (star[i].z <= 0)
    {
      star[i].x = random(-200, 200);
      star[i].y = random(-200, 200);
      star[i].z = MAX_DEPTH;
      
      flashlightAngle[i] = random(0, PI*2);
      flashlightScale[i] = 0.5;//random(0.5, 1);
    }
    
    if (showBackground)
    {
      var cc = (int) map(speed, 0, 0.5, 60, 0);
      strokeWeight(0.001); fill(cc); rect(starBackground[i].x, starBackground[i].y, 2, 2);
    }
    
    var c = (int) ((1 - (star[i].z / MAX_DEPTH)) * 255);
    var n = 255 - (int) (min(255, (c * speed *10)));
    
    
    
    
    var c3 = c;
    if (speed <= 0.1)  c3 = (int) (c/map(speed,0, 0.1, 4, 1));
    
    var n3 = n;
    if (speed <= 0.1)  n3 = (int) (c/map(speed,0, 0.1, 1, 4));
    
    if (showColor)
    {
      drawStar(star[i].x, star[i].y, star[i].z-(speed*4), color(255,n3,n3, c3), -1);
      drawStar(star[i].x, star[i].y, star[i].z-(speed*3), color(255,255,n3, c3), -1);
      drawStar(star[i].x, star[i].y, star[i].z-(speed*2), color(n,255,n3, c3), -1);
      drawStar(star[i].x, star[i].y, star[i].z, color(n3,n3,255, c3), i);
    }
    else
    {
      drawStar(star[i].x, star[i].y, star[i].z, color(c), i);
    }
  }
  
}

void drawStar(float star_x, float star_y, float star_z, color c1, int i)
{
  //var t = ((1 - (star_z / MAX_DEPTH)) * 30);


  var p = 15 / star_z;
  int x = (int) (star_x * p);// to curve -300+(t*t);
  int y = (int) (star_y * p);
  var s = (int) ((1 - (star_z / MAX_DEPTH)) * 5);
  //var c = (int) ((1 - (star_z / MAX_DEPTH)) * 255);
  
  if (playState == true && (i == 0 || i == (int) (STARS /2) || i == (int) (STARS /4) || i == (int) (STARS-2)))
  {
    flashlightScale[i] += 0.005;
    drawFlashLightBulb(x, y, flashlightScale[i], flashlightAngle[i]);
  }
  else
  {
    strokeWeight(0.001);
    fill(c1); rect(x, y, s, s);
  }
}

void drawFlashLightBulb(int x, int y, float s, float a)
{
  pushMatrix();
  translate(x, y);
  scale(s);
  rotate(a);
  
  fill(255,255,240);
  ellipseMode(CENTER);
  ellipse(0,0,10,10);
  
  fill(255,255,240);
  triangle(-5, -3, -5, -6, -30, -30);
  triangle(5, 3, 5, 6, 30, 30);
  triangle(5, -3, 5, -6, 30, -30);
  triangle(-5, 3, -5, 6, -30, 30);
  
  //pushMatrix();
  fill(0,0,255, 240);   rect(-25, -3, 8, 6);
  fill(0,255,0, 240);   rect(-30, -3, 5, 6);
  fill(255,255,0, 240); rect(-35, -3, 7, 6);
  fill(255,0,0, 240);   rect(-40, -3, 5, 6);
  
  fill(0,0,255, 200);   rect(-55, -2, 6, 4);
  fill(0,255,0, 160);   rect(-60, -2, 7, 4);
  fill(255,255,0, 160); rect(-65, -2, 6, 4);
  fill(255,0,0, 120);   triangle(-100, 0, -65, -2, -65, 2);
  
  fill(0,0,255, 240);   rect(25, -3, -8, 6);
  fill(0,255,0, 240);   rect(30, -3, -5, 6);
  fill(255,255,0, 240); rect(35, -3, -7, 6);
  fill(255,0,0, 240);   rect(40, -3, -5, 6);
  
  fill(0,0,255, 200);   rect(55, -2, -6, 4);
  fill(0,255,0, 160);   rect(60, -2, -7, 4);
  fill(255,255,0, 160); rect(65, -2, -6, 4);
  fill(255,0,0, 120);   triangle(100, 0, 65, -2, 65, 2);
  //popMatrix();
  
  popMatrix();
  
}
