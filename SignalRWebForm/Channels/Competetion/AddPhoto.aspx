<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddPhoto.aspx.cs" Inherits="Channels_Competetion_AddPhoto" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <title>������-�й����ȵ��ܲ��Ż���վ-ERUN360.COM</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico" />
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/race.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
</head>
<body>
	<style>
		.raceaddimg{color: #000}
		.raceaddimg tr td:first-child{text-align: right;height: 60px;}
		.raceaddimg tr{}
	</style>
   <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <form  id="bcfrom" runat="server">
    <div class="indecen ">
        <div class="racebody">            
            <h1><asp:Literal ID="ltlTitle" runat="server"></asp:Literal></h1>
            <div class="racetip">
                ��������֤��ͼƬ
            </div>
            <div class="mproject">
            	<table class="raceaddimg">
            		<tr>
            			<td>���֤����<br>Medical Certificate��</td><td><asp:FileUpload ID="fptjzm" runat="server" /></td>
            		</tr>
            		<tr>
            			<td>�ĵ�ͼ��<br>ECG��</td><td><asp:FileUpload ID="fpcjzs1" runat="server" /></td>
            		</tr>
            		<tr>
            			<td>�ɼ�֤�飺<br>Race Results��</td><td><asp:FileUpload ID="fpcjzs2" runat="server" /></td>
            		</tr>
            	</table>
                
                <asp:Button ID="projectpos" runat="server" OnClick="btSubmit_Click"  />
                 
            </div>
        </div>
    </div>
        </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    <script>
jQuery(document).ready(function($) {
	if(GetQueryString("idcompete") == "300000445"){
                loadjscssfile("/Html/css/racetnf.css", "css")
                $(".logo").replaceWith('<div class="tnflogo"><a href="/"><img src="/Html/images/tnflogo1.png"></a><a href="http://www.quyeba.com" target="_blank"><img src="/Html/images/tnflogo2.png"></a><a href="http://www.quyeba.com/tnf100/" target="_blank"><img src="/Html/images/tnflogo3.png"></a></div>')
            }
});
function GetQueryString(name) {
                    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) return unescape(r[2]); return null;
                    }
function loadjscssfile(filename, filetype){ 
if (filetype=="js"){ //�ж��ļ����� 
  var fileref=document.createElement('script')//������ǩ 
  fileref.setAttribute("type","text/javascript")//��������type��ֵΪtext/javascript 
  fileref.setAttribute("src", filename)//�ļ��ĵ�ַ 
} 
else if (filetype=="css"){ //�ж��ļ����� 
  var fileref=document.createElement("link") 
  fileref.setAttribute("rel", "stylesheet") 
  fileref.setAttribute("type", "text/css")  
  fileref.setAttribute("href", filename) 
} 
if (typeof fileref!="undefined") 
  document.getElementsByTagName("head")[0].appendChild(fileref) 
}  
    </script>
</body>
</html>
