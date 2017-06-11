// http://localhost:5050/0_Sandbox/TestTemplate/main.html
//.......................................................................

//----------------------------------------------------------------
//  http://localhost:5050/0_Sandbox/SoundTracker/testSound-simple-HttpRequest.html

  var audioContext = new(window.AudioContext || window.webkitAudioContext)();
  var sampleURL = './bass.wav';// 'https://dl.dropboxusercontent.com/s/47hgqffhjcsli6r/dinky-jam.mp3';
  var sound;
  var sampleBuffer = null;
  
  function setupSound() 
  {
    alert(sampleBuffer);
    //alert(buffer.duration);
      sound = audioContext.createBufferSource();
      sound.buffer = sampleBuffer;
      
      alert("numberOfChannels: " + sampleBuffer.numberOfChannels + ", sampleRate: " + sampleBuffer.sampleRate + ", duration: " + sampleBuffer.duration + ", frameCount: " + sampleBuffer.frameCount);
      
      var nowBuffering = sampleBuffer.getChannelData(0);
      alert("byteLength: " + nowBuffering.byteLength + ", calculated: " + sampleBuffer.sampleRate * sampleBuffer.duration);
      for (var i = 0; i < (nowBuffering.byteLength / 40); i++) 
      {
         // Math.random() is in [0; 1.0]
         // audio needs to be in [-1.0; 1.0]
         //nowBuffering[i] = Math.random() * 2 - 1;
         nowBuffering[i] = Math.sin(i/10); // PLAY A TONE FOR A SHORT WHILE THEN THE MUSIC
      }
      
      sound.connect(audioContext.destination)
  }
  
  
  function playSound() 
  {
      setupSound();
      sound.onended = function () {}
      sound.start(0);
  }

  function stopSound() 
  {
      sound.stop(0);
  }
  
  
void loadFile(files)
{ 
    var file = files[0];
    if (!file) return;
    
    //alert(files[0]);
    
    var fileReader = new FileReader;
    fileReader.onload = function()
    {
      var arrayBuffer = this.result;
      //snippet.log(arrayBuffer);
      //snippet.log(arrayBuffer.byteLength);
      //alert(arrayBuffer.byteLength);
      
      alert("Loaded");
      
      audioContext.decodeAudioData(arrayBuffer, function (buffer) { sampleBuffer = buffer; setupSound();});
    }
    fileReader.readAsArrayBuffer(file);
}

//----------------------------------------------------------------






//PGraphics2D g;
void setup()
{
  //doZoom = false; doTranslate = false; doRotate = false;
  setSize(100, 300, P2D, FIT_INSIDE, this); // this has to be the last line in this function
}

void drawBackground(var g)
{
  //g.gradientBackground2(VERTICAL, color(0,133,123), color(198,224,0));//, 0.5, color(255, 0, 0));
  g.background(255);
}

//void createG()
//{
//  int s = max(sw, sh);
//  g = createGraphics(s, s, P2D);
//  g.strokeWeight(1);
//  g.noFill();
//  int ss = (s / 2) + (s/6);
//  g.translate(s/2, ss);
//}

void draw()
{
  initDraw();
  
  
  //if (g == null) {createG();}
  //if (g != null)
  //{
  //  imageMode(CENTER);
  //  image(g, 0, 0);
  //}
}
