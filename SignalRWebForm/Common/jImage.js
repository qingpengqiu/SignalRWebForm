
function EnhancedImage(src,onLoaded){
    var self = this;
    this.src = src;
    this.width = 0;
    this.height = 0;
    this.onLoaded = onLoaded;
    this.loaded = false;
    this.image = null;
    
    this.load = function(){
        if(this.loaded) return;
        this.image = new Image();
        this.image.src = this.src;
        function loadImage(){
            if(self.width != 0 && self.height != 0)
			{
                clearInterval(interval);
                self.loaded = true;
                self.onLoaded(self);
            }
            self.width = self.image.width;
            self.height = self.image.height;
        }
        var interval = setInterval(loadImage,100);
    }
}


function ImageLoader(src,obj)
{
	var img = new EnhancedImage(src,onImageLoad);
	function onImageLoad(image){
		var hm = obj.innerHTML;
		hm = hm.replace("/images/ajax-loader.gif\">", src + "\" width=\"280\" style=\"border:solid 3px #DEDEDE;\" onclick=\"ImageShow(this)\">");
		obj.innerHTML = hm;
	}
    img.load();
}

function getElementsById(name) 
{ 
	var returns = document.getElementsByName(name); 
	if(returns.length > 0) return returns; 
	returns = new Array(); 
	var e = document.getElementsByTagName("div"); 
	for(i = 0; i < e.length; i++) {
		if(e[i].getAttribute("id") == name) { 
			returns[returns.length] = e[i]; 
		} 
	} 
	return returns; 
}

function LoadImages()
{
	var dvs = getElementsById("imgList");
	for(var i=0; i<dvs.length; i++)
	{
		var url = dvs[i].getAttribute("title");
		ImageLoader(url,dvs[i]);
	}
}

var last_scroll;

function ImageShow(obj)
{
	var fname = obj.src;

	var iWidth = document.body.clientWidth;
	var iHeight = document.body.scrollHeight + 24;
	var vHeight = document.documentElement.clientHeight;
	
	var sHeight = document.body.clientHeight+24;
	if(sHeight < iHeight) sHeight = iHeight;
	if(sHeight < 900) sHeight = 900;

	var bgObj = document.createElement("div");
	bgObj.style.cssText = "position:absolute;left:0px;top:0px;width:" + iWidth + "px;height:" + sHeight + "px;text-align:center;filter:alpha(opacity=60);opacity:0.6;background-color:#000000;z-index:101;";
	document.body.appendChild(bgObj);

	var fgObj = document.createElement("img");
	fgObj.style.cssText = "position:absolute;left:10px;top:10px;border:solid 10px #888888;z-index:102;";
	document.body.appendChild(fgObj);
	fgObj.src = fname;

	var csObj = document.createElement("img");
	csObj.style.cssText = "position:absolute;left:10px;top:10px;z-index:103;";
	document.body.appendChild(csObj);
	csObj.src = "/images/close.png";

	function fsize()
	{
		if(fgObj.width !=0 && fgObj.height!=0)
		{
			clearInterval(interval);

			var xyscale = fgObj.width / fgObj.height;
			if(fgObj.width > 1116) { fgObj.width = 1116; fgObj.height = fgObj.width / xyscale; }
			if(fgObj.height > (vHeight - 60)) { fgObj.height = vHeight - 60; fgObj.width = fgObj.height * xyscale; }

			fgObj.style.top = ((vHeight - fgObj.height - 20)/2) + "px";
			fgObj.style.left = ((iWidth - fgObj.width - 20)/2) + "px";

			csObj.style.top = ((vHeight - fgObj.height)/2 - 10) + "px";
			csObj.style.left = (parseInt(fgObj.style.left.replace("px",""), 10) + fgObj.width - 4) + "px";

			Fix();
		}
	}

	var interval = setInterval(fsize,100);
	
	fgObj.onclick = function()
	{
		window.open(fgObj.src);
	}

	csObj.onclick = function() { 
		document.body.removeChild(bgObj);
		document.body.removeChild(fgObj);
		document.body.removeChild(csObj);
		window.onscroll = last_scroll;
	}

	function getPosition() 
	{
		if(document.documentElement && document.documentElement.scrollTop) {
			var top = document.documentElement.scrollTop;
			var left = document.documentElement.scrollLeft;
			var height = document.documentElement.clientHeight;
			var width = document.documentElement.clientWidth;
		}
		else if (document.body) 
		{
			var top = document.body.scrollTop;
			var left = document.body.scrollLeft;
			var height = document.documentElement.clientHeight;
			var width = document.documentElement.clientWidth;
		}
		return {top:top,left:left,height:height,width:width };
	}

	function Fix()
	{
		var Position = getPosition();
		var leftadd = (Position.width - fgObj.width)/2;
		var topadd = (Position.height - fgObj.height)/2;

		fgObj.style.top = (Position.top + topadd) +"px";
		csObj.style.top = (Position.top + topadd) +"px";

		if(last_scroll!=null) last_scroll();
	}

	last_scroll = window.onscroll;
    window.onscroll = Fix;
}
