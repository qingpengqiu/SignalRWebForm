<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Blog.aspx.cs" Inherits="_Utility_Blog" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><% =blog.cTitle %>-<% =blog.cLoginName %>-������-ERUN360.COM</title>
<meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
<meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
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
			
			<!--��ʼժҪ-->
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
								count:'', /**�Ƿ���ʾ��������1��ʾ(��ѡ)*/
								appkey:'1199421400', /**�������Ӧ��appkey,��ʾ������Դ(��ѡ)*/
								title:'', /**�������������(��ѡ��Ĭ��Ϊ����ҳ���title)*/
								pic:'', /**����ͼƬ��·��(��ѡ)*/
								ralateUid:'2961848493', /**�����û���UID������΢����@���û�(��ѡ)*/
								language:'zh_cn', /**�������ԣ�zh_cn|zh_tw(��ѡ)*/
								rnd:new Date().valueOf()
							  }
							  var temp = [];
							  for( var p in param ){
								temp.push(p + '=' + encodeURIComponent( param[p] || '' ) )
							  }
							  document.write('<iframe allowTransparency="true" frameborder="0" scrolling="no" src="http://hits.sinajs.cn/A1/weiboshare.html?' + temp.join('&') + '" width="'+ _w+'" height="'+_h+'"></iframe>')
							})()
							</script><!-- ����weibo����ť dingjian -->
					</div>
					<div id="blog_info_right" style="width:200px;">
						 �Ķ�(<% =summary.iShowTimes %>) ��ע(<% =summary.iFocus %>) ��(<% =summary.iDing %>) <a href="#AA">����</a>(<% =summary.iDiscuss %>)
					</div>
					
					<div style="clear:both;width:600px;height:15px;padding-top:5px;">
						<hr noshade size="1" color="#C3C7C9">
					</div>
					
					<!--������Ϣ-->
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

			<!--��һƪ-->
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
				
				<!--�����б�-->
				<div id="diz_infos" style="width:600px;text-align:left;padding-top:10px;">
					<img src="/images/ajax-loader.gif">
				</div>

				<div style="clear:both;width:715px;height:20px;"></div>
				</center>
			</div>

			<div id="blog_m_bot"></div>
			<div id="blog_m_spc"></div>

		</div>
		
		<!--�Ҳ��û���Ϣ-->
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
   PopupShow(600, 400, "�������", "/Utility/Include/BlogGroupList.aspx");
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
			document.getElementById(objname).innerHTML = "<div class=\"v2a\"  onclick=\"FocusErase(" + idx + ",'" + chk + "')\">- ȡ����ע</a>";
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
			document.getElementById(objname).innerHTML = "<div class=\"v1a\"  onclick=\"FocusCreate(" + idx + ",'" + chk + "')\">+ ��ע</a>";
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
			document.getElementById("join_info").innerHTML = "��ע�ɹ�";
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
   if (confirm("ȷ��Ҫɾ�����������") == true)
   {
      $.get("/Utility/Ajax/BlogDelete.aspx" , { id : idx, checksum : chk }, function(result) { 
         if(result == "OK")
         {
             alert("�������Ѿ���ɾ��!");
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
