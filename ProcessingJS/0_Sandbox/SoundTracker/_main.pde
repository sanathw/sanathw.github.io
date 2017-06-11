// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................


// https://www.youtube.com/watch?v=WgHZZx-wFjQ
// [AMIGA MUSIC] Live and Let Die : The Computer Game -01- Title Screen
// "C:\Sanath\Video\[AMIGA MUSIC] Live and Let Die -  The Computer Game  -01-  Title Screen.mp4"

// mousePressed, mouseX, mouseY
// debug by println();

//PGraphics2D g;
var audioCtx = new (window.AudioContext || window.webkitAudioContext)();

var audioContext = new(window.AudioContext || window.webkitAudioContext)();
var sampleBuffer = null;
var sampleURL = './_resources/DrWho.m4a' ;// './bass.wav';// 'https://dl.dropboxusercontent.com/s/47hgqffhjcsli6r/dinky-jam.mp3';
var sound;
var played = false;

void setup()
{
  //playTone();
  
  //loadDogSound("./_resources/psb02_17.wav");
  //loadDogSound("bass.wav");
  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(100, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  //g.background(255);
}

void draw()
{
  initDraw();
  
  int x = random(-50, 50);
  int y = random(-150, 150);
  rect(x, y, 5, 5);
  
  //println(frameCount);
  if (frameCount > 10 && sampleBuffer != null && played == false) {played =true; playSound();}
}


void playTone()
{
  // create Oscillator node
  var oscillator = audioCtx.createOscillator();
  oscillator.type = 'square';
  oscillator.frequency.value = 440; // value in hertz
  oscillator.connect(audioCtx.destination);
  oscillator.start();
}

// void loadDogSound(url) 
// {
  // var request = new XMLHttpRequest();
  // request.open('GET', url, true);
  // request.responseType = 'arraybuffer';

  
  // /*
  // // Decode asynchronously
  // request.onload = function() 
  // {
    // //var source = myAudioContext.createBufferSource();
    // //source.buffer = myAudioContext.createBuffer(request.response, false);
    // //dogBarkingBuffer = audioCtx.createBuffer(request.response, false);
    // println(request.response);
    
    // //audioCtx.decodeAudioData(request.response, function(buffer) {println("hello"); dogBarkingBuffer = buffer; playSound(dogBarkingBuffer); }, onError);
  // }
  // */
 // // request.addEventListener('load', bufferSound, false);
 
 // request.onload = function() 
   // {
      // /* Put the modulated audio data into the audioData variable */ 
      // var audioData = request.response;
      // //println(audioData.length);
      // //var v1 = audioData.toString('hex');
      // //alert(v1);
      
      // audioRouting(audioData);
      
      // /*if (audioData) { 
        // var byteArray = new Uint8Array(audioData);
        // println(byteArray.length);
        // playSound(byteArray);
        // //audioCtx.decodeAudioData(byteArray, function(buffer) {println("hello"); dogBarkingBuffer = buffer; playSound(dogBarkingBuffer); }, onError);
        // }*/
   // };
   
   // request.onreadystatechange = function() 
   // {
      // //println(request.readyState);
      // //println(request.status);
   // }
 
  // request.send();
// }

// unction bufferSound(event) 
// {
    // var request = event.target;
    // var v = request.response;
    // println((request.response + '').length);
    // //var source = myAudioContext.createBufferSource();
    // //source.buffer = myAudioContext.createBuffer(request.response, false);
    // //mySource = source;
// }


// // Create Buffered Sound Source
// function audioRouting(data) {
    // source = audioCtx.createBufferSource(); // Create sound source
    // audioCtx.decodeAudioData(data, function(buffer){ // Create source buffer from raw binary
    // source.buffer = buffer; // Add buffered data to object
    // source.connect(audioCtx.destination); // Connect sound source to output
    // playSound(source); // Pass the object to the play function
    // });
// }

// void playSound(buffer) 
// {
  
  // var source = audioCtx.createBufferSource(); // creates a sound source
  
  
  
  // source.buffer = buffer;                    // tell the source which sound to play
  
  // println(source.buffer.length);
  
  // source.connect(audioCtx.destination);       // connect the source to the context's destination (the speakers)
  
  // source.start(0);                           // play the source now
                                             // // note: on older systems, may have to use deprecated noteOn(time);
// }







// function to load sounds via AJAX
function loadSound(url) {
    var request = new XMLHttpRequest();
    request.open('GET', url, true);
    request.responseType = 'arraybuffer';

    request.onload = function () {
        audioContext.decodeAudioData(request.response, function (buffer) {
            var soundLength = buffer.duration;
            sampleBuffer = buffer;
            //loopStart.setAttribute('max', Math.floor(soundLength));
            //loopEnd.setAttribute('max', Math.floor(soundLength));
            //playButton.disabled = false;
            //playButton.innerHTML = 'play';
        });
    };

    request.send();
}

// set our sound buffer, loop, and connect to destination
function setupSound() {
    sound = audioContext.createBufferSource();
    sound.buffer = sampleBuffer;
    //sound.loop = loop;
    //sound.loopStart = loopStart.value;
    //sound.loopEnd = loopEnd.value;
    //sound.detune.value = -1000;
    //sound.playbackRate.value = playbackSlider.value;
    sound.connect(audioContext.destination);
}

// play sound and enable / disable buttons
function playSound() {
    setupSound();
    //UI('play');
    sound.start(0);
    sound.onended = function () {
        //UI('stop');
    }
}
// stop sound and enable / disable buttons
function stopSound() {
    //UI('stop');
    sound.stop(0);
}

loadSound(sampleURL);