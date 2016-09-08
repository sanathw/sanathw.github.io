var video;
var videoStarted = false;
var videoReady = false;

var getUserMedia = function(t, onsuccess, onerror) {
    if (navigator.getUserMedia) {
        return navigator.getUserMedia(t, onsuccess, onerror);
    } else if (navigator.webkitGetUserMedia) {
        return navigator.webkitGetUserMedia(t, onsuccess, onerror);
    } else if (navigator.mozGetUserMedia) {
        return navigator.mozGetUserMedia(t, onsuccess, onerror);
    } else if (navigator.msGetUserMedia) {
        return navigator.msGetUserMedia(t, onsuccess, onerror);
    } else {
        onerror(new Error("No getUserMedia implementation found."));
    }
};

var URL = window.URL || window.webkitURL;
var createObjectURL = URL.createObjectURL || webkitURL.createObjectURL;
if (!createObjectURL) {
    throw new Error("URL.createObjectURL not found.");
}



function initCam(camW, camH)
{
  videoStarted = true;
  video = document.createElement("video");

  video.setAttribute("style", "display:none;");
  video.setAttribute("id", "videoOutput");
  video.setAttribute("width", "" + camW + "px");
  video.setAttribute("height", "" + camH + "px");
  video.setAttribute("autoplay", "true");
  if(document.body!=null) document.body.appendChild(video);
  
  getUserMedia({audio:false, video:true},
    function(stream) {
        var url = createObjectURL(stream);
        video.src = url;
    },
    function(error) {
        alert("Couldn’t access webcam.");
    }
  );
  
  videoReady = true;
}