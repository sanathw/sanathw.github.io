// http://localhost:5050/0_Sandbox/TestOverlay/main.html
//.......................................................................
//http://stackoverflow.com/questions/7242006/html5-copy-a-canvas-to-image-and-back

PGraphics g;

var cvs = document.getElementById("mySketch");
var ctx;

var cvs2 = document.getElementById("mySketch2");
var ctx2;

void setup()
{
  size(400, 400, P3D);
  
  ctx2 = cvs2.getContext('2d');
  ctx2.width = cvs2.width = 200; ctx2.height = cvs2.height = 200;
  
  ctx = externals.context;
  
  g = createGraphics(300, 300, P2D);
  
  //cvs.style.visibility='hidden';
}

void draw()
{
  background(240);
  pushMatrix();
  
  lights();
  translate(width/2, height/2);
  //translate(-100, -100);
  rotateX(frameCount/100);//mouseY/100);
  rotateY(mouseX/100);
  fill(255);
  box(50);
  
  popMatrix();
  //rect(-50, -50, 50, 50);
  
  /*var ctx = externals.context;
  var my_gradient=ctx2.createLinearGradient(0,0,0,100);
  my_gradient.addColorStop(0,'rgba(0,0,255,0)');
  my_gradient.addColorStop(0.5,'#ff0000');
  my_gradient.addColorStop(0.75,'green');
  my_gradient.addColorStop(1,'rgba(255,255,255,0)');
  ctx2.fillStyle=my_gradient;
  ctx2.fillRect(0,0,100,100);*/
  
  //var imgData = ctx.getImageData(0,0,50,50);
  //ctx2.drawImage(imgData,0,0);
  
  g.background(0, 0, 255);
  //hint(DISABLE_DEPTH_TEST);
  //image(g, 0, 0);
  //hint(ENABLE_DEPTH_TEST);
  
  hint(DISABLE_DEPTH_TEST);
  fill(0);
  text("Hello", 0,0);
  hint(ENABLE_DEPTH_TEST);
  
  ctx2.fillStyle = 'rgba(240, 0, 0, 1)'; ctx2.fillRect(0, 0, ctx2.width, ctx2.height);
  ctx2.drawImage(cvs, 10,10, 180, 180);
  
  //g.background(0, 0, 255);
  //ctx2.drawImage(cvs, 0,0, 80, 80);
  
  /*with (ctx2)
  {
    //save();
    fillStyle = 'rgba(240, 0, 0, 1)'; fillRect(0, 0, width, height);
    //ctx.drawImage(img,10,10);
    
    //var imgData=ctx.getImageData(0,0,100,100);
    //putImageData(imgData,0,0);
    
    var img = new Image();
    img.src = cvs.toDataURL();
    ctx2.drawImage(img,10,10);
  }*/
}

