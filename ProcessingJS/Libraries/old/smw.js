var isMobile; 

if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) == true ) 
{
  isMobile = true;
} 
else 
{
  isMobile = false;
} 

function doOnOrientationChange() 
{ 
  callProcessing_SizeChanged(); 
} 

function callProcessing_SizeChanged() 
{ 
  var pjs = Processing.getInstanceById("mySketch"); 
  pjs.sizeChanged(); 
} 

function doOnKeyDown()
{
  //alert(event.keyCode);
  if (event.keyCode === 8) // backspace
  {
    var pjs = Processing.getInstanceById("mySketch"); 
    pjs.doBackspace();
    event.preventDefault();
  }
}
window.addEventListener('keydown', doOnKeyDown); 

window.addEventListener('orientationchange', doOnOrientationChange); 
window.onresize=function() { callProcessing_SizeChanged(); };
