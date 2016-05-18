
function SearchInit()
{
	var dnow1 = new Date();
	dnow1.setTime(dnow1.getTime() - 24*60*60*1000);
	document.getElementById("searchDate1").value = dnow1.getFullYear() + "-" + dnow1.getMonth() + "-" + dnow1.getDate();
	var dnow2 = new Date();
	document.getElementById("searchDate2").value = dnow2.getFullYear() + "-" + dnow2.getMonth() + "-" + dnow2.getDate();
}

function SearchFit(obj)
{
   var idx = obj.selectedIndex;
   var val = obj.options[idx].value;

   document.getElementById("dataRegion1").style.display = "";
   document.getElementById("dataRegion2").style.display = "none";
   document.getElementById("dataRegion3").style.display = "";
   document.getElementById("dataRegion4").style.display = "";
   document.getElementById("dataRegion5").style.display = "";
   document.getElementById("dataRegion6").style.display = "none";
   document.getElementById("dataRegion4").innerHTML = " &lt; ";

   if(val.substr(0,4)=="text" || val.substr(0,7)=="varchar")
   {
	   document.getElementById("dataRegion1").style.display = "none";
	   document.getElementById("dataRegion2").style.display = "none";
	   document.getElementById("dataRegion3").style.display = "none";
	   document.getElementById("dataRegion4").innerHTML = " °üº¬ ";
   }

   if(val.indexOf("datetime:") >=0 ) {
	   document.getElementById("dataRegion1").style.display = "none";
	   document.getElementById("dataRegion2").style.display = "";
	   document.getElementById("dataRegion3").style.display = "";
	   document.getElementById("dataRegion4").style.display = "";
	   document.getElementById("dataRegion5").style.display = "none";
	   document.getElementById("dataRegion6").style.display = "";
   }
}
