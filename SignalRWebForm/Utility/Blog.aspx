<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Blog.aspx.cs" Inherits="_Utility_Blog" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><% =blog.cTitle %>-<% =blog.cLoginName %>-益跑网-ERUN360.COM</title>
<meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
<meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<link href="/Common/Style.css" rel="stylesheet" type="text/css"/>
<link href="/Common/Blog.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<center>

<ERUN360:header_blog id="header_blog" runat="server" />
<script language="javascript" src="/Common/jquery1.8.js?2012111"></script>
<script language="javascript">

function imageResize(obj)
{
	if(obj.width > 600) 
	{
		obj.width = 600;
	}
}

</script>

<div id="blog_b">
	<div id="blog_b_1">
		<% =PageFace %>
		<div id="blog_title" class="blog_title1">
			<font style="font-size:24px;"><% =blog.cLoginName %></font><br>
			<% =PageUser %><br>
			<a href="<% =UrlHelper.MemberUrl(blog.idUser) %>">http://www.erun360.com<% =UrlHelper.MemberUrl(blog.idUser) %></a><br>
			<div id="blog_guide">
				<% =PageGuide %>
			</div>
		</div>
	</div>

	<div id="blog_c">
		<div id="blog_c_left">
			
			<!--开始摘要-->
			<div id="blog_m_top"></div>

			<div style="width:675px;background-image:url(/images/blog/bk-left2.gif);background-position:-0px -17px;font-size:12px;padding-left:20px;padding-right:20px;padding-top:5px;text-align:center;overflow:hidden;">
				<center>
				<div style="width:600px;height:20px;padding-top:5px;text-align:right;">
					<% =PageEdit %>
				</div>
				<div style="clear:both;width:600px;font-size:22px;">
					<% =blog.cTitle %>
					<% =PageSubject %>
				</div>
				<div style="height:18px;font-size:12px;color:#666666;">
					<% =blog.dCreate.ToString("yyyy-MM-dd HH:mm:ss") %> 
				</div>
				
				<div style="width:600px;font-size:14px;padding-top:10px;line-height:25px;text-align:left;">
					
					<div id="blog_info_left" style="width:400px;">
						<% =PageFocusBlog %>
						<script type="text/javascript" charset="utf-8">
							(function(){
							  var _w = 106 , _h = 24;
							  var param = {
								url:location.href,
								type:'5',
								count:'', /**是否显示分享数，1显示(可选)*/
								appkey:'1199421400', /**您申请的应用appkey,显示分享来源(可选)*/
								title:'', /**分享的文字内容(可选，默认为所在页面的title)*/
								pic:'', /**分享图片的路径(可选)*/
								ralateUid:'2961848493', /**关联用户的UID，分享微博会@该用户(可选)*/
								language:'zh_cn', /**设置语言，zh_cn|zh_tw(可选)*/
								rnd:new Date().valueOf()
							  }
							  var temp = [];
							  for( var p in param ){
								temp.push(p + '=' + encodeURIComponent( param[p] || '' ) )
							  }
							  document.write('<iframe allowTransparency="true" frameborder="0" scrolling="no" src="http://hits.sinajs.cn/A1/weiboshare.html?' + temp.join('&') + '" width="'+ _w+'" height="'+_h+'"></iframe>')
							})()
							</script><!-- 增加weibo分享按钮 dingjian -->
					</div>
					<div id="blog_info_right" style="width:200px;">
						 阅读(<% =summary.iShowTimes %>) 关注(<% =summary.iFocus %>) 顶(<% =summary.iDing %>) <a href="#AA">评论</a>(<% =summary.iDiscuss %>)
					</div>
					
					<div style="clear:both;width:600px;height:15px;padding-top:5px;">
						<hr noshade size="1" color="#C3C7C9">
					</div>
					
					<!--比赛信息-->
					<div id="extention"></div>

					<% =PageContent.Replace("border=0 onload","border=0 onmouseover='imageResize(this)' onload") %>
					
					<% =PageJoiner %>

					<div style="clear:both;width:600px;height:20px;"></div>
					<div id="dingInfo"  style="float:right;width:80px;height:32px;padding-top:48px;background-image:url(/images/ding2.gif);cursor:pointer;text-align:center;font-size:12px;color:#EEEEEE;" onclick="Ding()">
						<% =summary.iDing %>
					</div>

				</div>
				</center>
				<div style="clear:both;width:600px;height:20px;"></div>
			</div>

			<!--下一篇-->
			<div id="blog_next">
				<div id="blog_next_txt">
					<% =PageNext %>
				</div>
			</div>
			
			<a name="AA"></a>
			<div id="blog_speak">
				<center>
				<div id="blog_speak_mem">
					<% =PageDiscuss %>
				</div>
				
				<!--评论列表-->
				<div id="diz_infos" style="width:600px;text-align:left;padding-top:10px;">
					<img src="/images/ajax-loader.gif">
				</div>

				<div style="clear:both;width:715px;height:20px;"></div>
				</center>
			</div>

			<div id="blog_m_bot"></div>
			<div id="blog_m_spc"></div>

		</div>
		
		<!--右侧用户信息-->
		<div id="blog_right">
			<div id="blog_c_right">
				<img src="/images/ajax-loader.gif">
			</div>

			<div id="blog_c_group">
				<img src="/images/ajax-loader.gif">
			</div>
		</div>

		<div id="h_clear"></div>
	</div>

	<div id="h_clear"></div>
</div>

<ERUN360:footer_blog id="footer_blog" runat="server" />

<script language="javascript">
/*
function imageResize(obj)
{
	if(obj.width > 600) 
	{
		obj.width = 600;
	}
}
*/
function GroupManage()
{
   PopupShow(600, 400, "分类管理", "/Utility/Include/BlogGroupList.aspx");
}

$.get("/Utility/Ajax/UserSummery.aspx", { rnd : Math.random(), iduser: <% =blog.idUser %> }, function(result) {
	if(result.length > 0) {
		document.getElementById("blog_c_right").innerHTML = result;
	}
});

$.get("/Utility/Ajax/BlogGroupInfo.aspx", { iduser : <% =blog.idUser %> }, function(result) {
	if(result.length > 0) {
		document.getElementById("blog_c_group").innerHTML = result;
	}
});

$.get("/Utility/Ajax/Discuss.aspx", { id : <% =blog.id %> }, function(result) {
	if(result.length > 0) {
		document.getElementById("diz_infos").innerHTML = result;
	}
});


function ShowExtention(idx)
{
	$.get("/Utility/Ajax/Extention.aspx", { id : idx }, function(result) {
		if(result.length > 0) {
			document.getElementById("extention").innerHTML = "<div id=\"blog_info_compt\">" + result + "</div>";
		}
	});
}


function FocusCreate(idx, chk)
{
	var objname =  idx + "A";
	objname = (objname.substr(0,1)=="1") ? "focus" : "blog_info_left";
	$.get("/Utility/Ajax/FocusCreate.aspx", { id : idx, checksum : chk }, function(result) {
		if(result == "OK") {
			document.getElementById(objname).innerHTML = "<div class=\"v2a\"  onclick=\"FocusErase(" + idx + ",'" + chk + "')\">- 取消关注</a>";
		}
		else { document.getElementById(objname).innerHTML = result; }
	});
}

function FocusErase(idx, chk)
{
	var objname =  idx + "A";
	objname = (objname.substr(0,1)=="1") ? "focus" : "blog_info_left";
	$.get("/Utility/Ajax/FocusErase.aspx", { id : idx, checksum : chk }, function(result) {
		if(result == "OK") {
			document.getElementById(objname).innerHTML = "<div class=\"v1a\"  onclick=\"FocusCreate(" + idx + ",'" + chk + "')\">+ 关注</a>";
		}
		else { document.getElementById(objname).innerHTML = result; }
	});
}

function Ding()
{
	$.get("/Utility/Ajax/Ding.aspx", { id : <% =blog.id %> }, function(result) {
		document.getElementById("dingInfo").innerHTML = result; 
	});
}

function JoinCreate(user, idx)
{
	$.get("/Utility/Ajax/RaceJoinCreate.aspx", { onwer : user, id : idx }, function(result) {
		if(result == "OK") {
			document.getElementById("join_info").innerHTML = "关注成功";
		}
		else { document.getElementById("join_info").innerHTML = result; }
	});
}

function BlogEdit(idx)
{
	window.location = "/Utility/BlogUpdate.aspx?id=" + idx;
}

function BlogDelete(pos,idx,chk)
{
   if (confirm("确定要删除这个博客吗？") == true)
   {
      $.get("/Utility/Ajax/BlogDelete.aspx" , { id : idx, checksum : chk }, function(result) { 
         if(result == "OK")
         {
             alert("本博客已经被删除!");
         }
      });
   }
}

function EmotionAdd(v)
{
	document.getElementById("cContent").value += "[MOOD=" + v + "]";
}

</script>

<% =PageLoad %>

</center>
</body>
</html>
