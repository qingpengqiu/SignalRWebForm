<%@ Page Language="C#" AutoEventWireup="true" CodeFile="zt.aspx.cs" Inherits="_Home_Default" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="http://open.weibo.com/wb">
<head>
<title>������-�й����ȵ��ܲ��Ż���վ-ERUN360.COM</title>
<meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
<meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
	<script language="javascript" src="/Common/jQuery1.8.js"></script>
<script type="text/javascript" src="/Common/jWeibo.js"></script>
	
<script language="javascript" src="/Common/jCheck.js?2012111"></script>
<script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
<script language="javascript" src="/Common/jCalendar.js?2012111"></script>	
</head>
<body>

    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
	
<div class="indecen">	
	<div class="indexctop" style="margin-top: 20px;">
		<div class="left ztlist">
			<ul>
				<li>
					<p><a href="/zt/group/index.aspx">����ƴ��</a> <em>2014.11.19</em> </p>
					<a href="/zt/group/index.aspx"> <img src="/zt/images/pingtuan.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/polar/index.aspx">polar</a> <em>2014.10.8</em> </p>
					<a href="/zt/polar/index.aspx"> <img src="/zt/images/polar.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/womanRunningBook/index.aspx">��Ů���ܲ�ȫ�顷</a> <em>2014.9.26</em> </p>
					<a href="/zt/womanRunningBook/index.aspx"> <img src="/zt/images/nbook.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/inex/index.aspx">���������ֶһ����ľ�ϲ����</a> <em>2014.7.25</em> </p>
					<a href="/zt/inex/index.aspx"> <img src="/zt/images/jf.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/infocenter/feedback.aspx">�������������ߡ����ִ��������</a> <em>2014.6.20</em> </p>
					<a href="/infocenter/feedback.aspx"> <img src="/zt/images/dalibao.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/fitbit/index.aspx">Fitbit</a> <em>2014.6.5</em> </p>
					<a href="/zt/fitbit/index.aspx"> <img src="/zt/images/fitbit1.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/tnf100/index.aspx">TNF100</a> <em>2014.5.15</em> </p>
					<a href="/zt/tnf100/index.aspx"> <img src="/zt/images/tnf100.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/runbook/index.aspx">����������ȫ�顷</a> <em>2013.12.30</em> </p>
					<a href="/zt/runbook/index.aspx"> <img src="/zt/images/runbook.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/nike/index.aspx">���˾Ͷ�</a> <em>2013.11.10</em> </p>
					<a href="/zt/nike/index.aspx"> <img src="/zt/images/nike.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/lzmarathon/">2013���ݹ���������</a> <em>2013.6.10</em> </p>
					<a href="/zt/lzmarathon/"> <img src="/zt/images/lanzhou.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/ddmarathon/">2013�굤��������������</a> <em>2013.5.26</em> </p>
					<a href="/zt/ddmarathon/"> <img src="/zt/images/dandong.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/game/">����ȫ����</a> <em>2013.5.16</em> </p>
					<a href="/zt/game/"> <img src="/zt/images/game.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/paobuji/">�ܲ���</a> <em>2013.4.22</em> </p>
					<a href="/zt/paobuji/"> <img src="/zt/images/paobuji.jpg" alt="" /> </a>
				</li>				
				<li>
					<p><a href="/zt/huxi/">�ܲ�����</a> <em>2013.4.15</em> </p>
					<a href="/zt/huxi/"> <img src="/zt/images/huxi.jpg" alt="" /> </a>
				</li>	
				<li>
					<p><a href="/zt/weixunlian/">΢ѵ��</a> <em>2013.4.8</em> </p>
					<a href="/zt/weixunlian/"> <img src="/zt/images/weixunlian.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/nvxing/">Ů�����ڽ����˶�</a> <em>2013.3.6</em> </p>
					<a href="/zt/nvxing/"> <img src="/zt/images/nvxing.jpg" alt="" /> </a>
				</li>				
				<li>
					<p><a href="/zt/jianfei/">�ܲ������</a> <em>2013.2.6</em> </p>
					<a href="/zt/jianfei/"> <img src="/zt/images/jianfei.jpg" alt="" /> </a>
				</li>	
				<li>
					<p><a href="/zt/xigai/">�ܲ���ϥ��</a> <em>2013.2.6</em> </p>
					<a href="/zt/xigai/"> <img src="/zt/images/xigai.jpg" alt="" /> </a>
				</li>								
				<li>
					<p><a href="/zt/hk100/">2013���VibramHK100</a> <em>2013.1.19</em> </p>
					<a href="/zt/hk100/"> <img src="/zt/images/xg100.jpg" alt="" /> </a>
				</li>	
				<li>
					<p><a href="/zt/xmmarathon/">2013���Ź���������</a> <em>2012.12.21</em> </p>
					<a href="/zt/xmmarathon/"> <img src="/zt/images/xm.jpg" alt="" /> </a>
				</li>				
				<li>
					<p><a href="/zt/zhengping/">�ܰ��޽� ��ǿ֣ƽ</a> <em>2012.11.22</em> </p>
					<a href="/zt/zhengping/"> <img src="/zt/images/zp.jpg" alt="" /> </a>
				</li>
				<li >
					<p><a href="/zt/bjmarathon/">2012����������</a> <em>2012.11.20</em> </p>
					<a href="/zt/bjmarathon/"> <img src="/zt/images/bm.jpg" alt="" /> </a>
				</li>
			</ul>
<!-- 			<div class="page">
				<a href="" class="up"> < </a>
				<a href="" class="dq">1</a>
				<a href="">2</a>
				<a href="">3</a>
				<a href="">4</a>
				<a href="">5</a>
				<span>......</span>
				<a href="">20</a>
				<a href="">21</a>
				<a href="">22</a>
				<a href="" class="down"> > </a>
			</div> -->
		</div>
		<div class="right">
			
			


		<div class="rkuang wb">
                <div class="rkuangtitle">
                    <span><a href="/Channels/Competetion/RaceList.aspx">���±���</a></span>
                </div>
                <div class="wbnr">
                    <ul id="slider" class="event">
                    </ul>
                    <script type="text/javascript">
                        $.get("/Utility/Ajax/Weibo.aspx", { rnd : MinuteRand() }, function(result) {
                            document.getElementById("slider").innerHTML = result;
                            new slider({id:'slider'});
                        });
                    </script>
                </div>
            </div>

					
	</div>		
	</div>

	
</div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />







	

</body>
</html>
