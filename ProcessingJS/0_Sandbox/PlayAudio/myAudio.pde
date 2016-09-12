class MyAudio
{
  var mediaElement;
  float v, d;
  float offset;
  boolean playing;
  
  MyAudio(String src, float offset)
  {
    mediaElement = new Audio();
    mediaElement.src = src;
    mediaElement.load();
    this.offset = offset;
    playing = false;
  }
  
  void play()
  {
    if (playing == false)
    {
      d = 0;
      v = 1;
      
      mediaElement.play();
      mediaElement.currentTime = offset;
      
      playing = true;
    }
  }
  
  void decay()
  {
    d = -0.01;
    playing = false;
  }
  
  void update()
  {
    v += d;
    if (v > 1) v=1;
    if (v < 0) v=0;
    
    if (v == 0) {mediaElement.pause; playing = false;}
    else {mediaElement.volume = v; }
  }
}