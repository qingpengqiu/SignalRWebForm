
function GDate(DO)
{
	MyCalendar = new Calendar();
	MyCalendar.Init(DO);
}

var date_object = null;

function GDate2()
{
	alert(date_object.id);
	var mc = new Calendar();
	mc.Init(date_object);
}

function isDate(dateStr){var datePat=/^(\d{4})([\/-])(\d{1,2})([\/-])(\d{1,2})$/;dateStr=String(dateStr).replace(/^\s*|\s*$/g,"");var matchArray=dateStr.match(datePat);if(matchArray==null){return false;};var month=matchArray[3];var day=matchArray[5];var year=matchArray[1];if(month<1||month>12){return false;};if(day<1||day>31){return false;};if((month==4||month==6||month==9||month==11)&&day==31){return false;};if(month==2){var isleap=(year%4==0&&(year%100!=0||year%400==0));if(day>29||(day==29 && !isleap)){return false;}};return true;}

Calendar = function() {
	this.OID = null;
}

Calendar.prototype = 
{
	calendarHTML : function()
	{
		if(document.getElementById("CalendarDiv") !=null ){
			document.body.removeChild(document.getElementById("CalendarDiv"));
		}
		var DDiv = document.createElement("div");
		DDiv.id = "CalendarDiv";
		DDiv.left = '-5000px';
		DDiv.top = '-5000px';
		DDiv.style.display = 'none';

		var temHTML = '<div id="CalendarDivMain">'
		+ '<div class="head">'
		+ '<table width="100%" cellpadding="0" cellspacing="2" border="0" style="border-collapse:collapse;"><tr>'
		+ '<td><select id="Year" name="Year"></select></td>'
		+ '<td><select id="Month" name="Month"></select></td>'
		+ '<td width="20"><span id="Hide">×</span></td>'
		+ '</tr></table>'
		+ '</div>'
		+ '<div id="Calendar">'
		+ '<dl><dt>日</dt><dt>一</dt><dt>二</dt><dt>三</dt><dt>四</dt><dt>五</dt><dt>六</dt></dl>'
		+ '<dl id="CalendarDay">日期列表选项</dl>'
		+ '</div></div>';
		DDiv.innerHTML = temHTML;
		
		document.body.appendChild(DDiv);
	},

	alignPos: function()
	{
		var pos = {};
		var e = this.OID;
		var t = e.offsetTop;   
		var l = e.offsetLeft;   
		var height = e.offsetHeight;   
		while(e = e.offsetParent) {   
			t += e.offsetTop;   
			l += e.offsetLeft;   
		}
		pos.x = l;
		pos.y = t + this.OID.offsetHeight;
		return pos;
	},

	//得到今天的年,月,日
	getToday: new function()
	{ 
		this.now = new Date();
		this.year = this.now.getFullYear();
		this.month = this.now.getMonth()+1;
		this.day = this.now.getDate();
	},

	thisDay: function()
	{
		var D=this.OID.value;
		var Day ={};
		//得到输入框的年,月,日
		if(isDate(D)){ 
			var exp = /^(\d{4})-(\d{1,2})-(\d{1,2})$/;
			if(exp.test(D)){ 
				D = D.split("-");
			}
			else{ 
				D = D.split("/");
			}
			Day.now   = new Date(parseFloat(D[0]),parseFloat(D[1])-1,parseFloat(D[2]));
			Day.year = Day.now.getFullYear();
			Day.month = Day.now.getMonth()+1;
			Day.day   = Day.now.getDate();
		}
		else{
			Day.now   = this.getToday.now;
			Day.year = Day.now.getFullYear();
			Day.month = Day.now.getMonth()+1;
			Day.day   = Day.now.getDate();
		}
		return Day;
	},

	setYear: function()
	{
		var Year = document.getElementById("Year");
		var year = Number(this.getToday.year);
		var Day = this.thisDay();
		for(y=year-9;y<=year+3;y++) {
			Year.options[Year.options.length] = new Option(y,y)
			if(Day.year==y){
				Year.options[Year.options.length-1].selected=true;
			}
			
		}
	},

	setMonth : function()
	{
		var Month = document.getElementById("Month");
		var Day = this.thisDay();
		for(m=1;m<=12;m++) {
			Month.options[Month.options.length] = new Option(m+'月',m);
			if(Day.month==m) {
				Month.options[Month.options.length-1].selected=true;
			}
			
		}
	},

	setDay : function()
	{
		var flag = true;
		var y = this.thisDay().year;
		var m = this.thisDay().month;
		if(flag){
			y = document.getElementById("Year").value;
			m = document.getElementById("Month").value;
		}
		var day= this.getDays(y,m);
		var d = new Date(y,m-1,1).getDay();
		var _d = this.thisDay().day;

		var dayStr="";
		for(t=0;t<d;t++){ 
			dayStr+='<span></span>';
		}  
		for(t=1;t<=day;t++){
			if(t==_d){
				dayStr+='<dd class="slt" onclick="MyCalendar.getDay('+t+')">'+t+'</dd>';
			}
			else{
				dayStr+='<dd onclick="MyCalendar.getDay('+t+')">'+t+'</dd>';
			}
		}
		document.getElementById("CalendarDay").innerHTML = dayStr;
		this.reIframe();
	},

	onChange: function()
	{
		MyCalendar.setDay();
		MyCalendar.mousDay();
	},

	//实现选择
	getDay: function(d)
	{
		var y = document.getElementById("Year").value;
		var m = document.getElementById("Month").value;
		if(m<10){m='0'+m;}
		if(d<10){d='0'+d;}
		this.OID.value = y+'-'+m+'-'+d;
		this.Hide();
	},

	//获取某年某月的天数
	getDays: function (y,m)
	{
		return (m==2) ? (y%4||!(y%100)&&y%400?28:29) : (/4|6|9|11/.test(m)?30:31);
	},

	mousDay: function()
	{
		var days = document.getElementById("CalendarDay").getElementsByTagName("dd");
		for(d=0;d<days.length;d++){
			days[d].onmouseover=function(){this.className="slt";}
			days[d].onmouseout =function(){this.className="";}
		}
	},

	reIframe: function()
	{
	},

	Show: function()
	{
		var CalendarDiv = document.getElementById("CalendarDiv");
		CalendarDiv.style.left = this.alignPos().x +'px';
		CalendarDiv.style.top = this.alignPos().y +'px';
		var dis = CalendarDiv.style.display;
		if(dis=='none'){
			CalendarDiv.style.display='block';
		}
		else{
			CalendarDiv.style.display='none';
		}
		document.getElementById("Hide").onclick = this.Hide;
	},

	Hide : function()
	{
		document.getElementById("CalendarDiv").style.left= '-5000px';
		document.getElementById("CalendarDiv").style.top = '-5000px';
		document.getElementById("CalendarDiv").style.display='none';
	},

	Init : function(O)
	{
		this.OID = O;

		this.calendarHTML();

		var Year = document.getElementById("Year");
		var Month= document.getElementById("Month");
		Year.options.length = 0;
		Month.options.length = 0;
		Year.onchange = this.onChange;
		Month.onchange = this.onChange;

		this.Show();
		this.setYear();
		this.setMonth();
		this.setDay();
		this.mousDay();   
	}
}

var MyCalendar = new Calendar();
