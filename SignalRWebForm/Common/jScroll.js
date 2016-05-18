var scroll_timer;

function TopIt() 
{
	var fgObj = document.getElementById("blog_top");
	if(document.documentElement && document.documentElement.scrollTop)
		fgObj.style.top = document.documentElement.scrollTop +"px";
	else if(document.body)
		fgObj.style.top = document.body.scrollTop +"px";
}

window.onscroll = TopIt;
