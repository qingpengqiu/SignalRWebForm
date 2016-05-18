
function changeBack(bk_index)
{
	$.get("/Utility/Ajax/Face.aspx", { id : bk_index }, function(result) {
		if(result.length > 0) {
			changeBackAction(bk_index);
		}
	});
}

function changeBackAction(bk_index)
{
	obj = document.getElementById("blog_b");
	if(obj==null) return;
	switch(bk_index)
	{
		case 1:
			obj.style.backgroundImage = "url(/images/blog/blog1.jpg)";
			obj.style.backgroundColor = "#DDECCD";
			document.body.style.backgroundColor = "#DDECCD";
			document.getElementById("blog_title").className = "blog_title1";
			break;

		case 2:
			obj.style.backgroundImage = "url(/images/blog/blog2.jpg)";
			obj.style.backgroundColor = "#586F81";
			document.body.style.backgroundColor = "#586F81";
			document.getElementById("blog_title").className = "blog_title1";
			break;

		case 3:
			obj.style.backgroundImage = "url(/images/blog/blog3.jpg)";
			obj.style.backgroundColor = "#6145AB";
			document.body.style.backgroundColor = "#6145AB";
			document.getElementById("blog_title").className = "blog_title2";
			break;

		case 4:
			obj.style.backgroundImage = "url(/images/blog/blog4.jpg)";
			obj.style.backgroundColor = "#2D62AE";
			document.body.style.backgroundColor = "#2D62AE";
			document.getElementById("blog_title").className = "blog_title2";
			break;
	}
}

function backFix()
{
	var obj = document.getElementById("blog_b");
	if(obj==null) return;
	obj.style.backgroundPosition = parseInt((obj.clientWidth - 1440)/2) + "px -0px";
}

window.onresize = backFix;
