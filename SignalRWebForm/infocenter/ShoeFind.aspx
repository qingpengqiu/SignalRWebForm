<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShoeFind.aspx.cs" Inherits="infocenter_ShoeFind" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Phiz.ascx" TagPrefix="ERUN360" TagName="Phiz" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="��http://open.weibo.com/wb��">
<head>
    <title>��Ь����-�ܲ�װ��-������-ERUN360.COM</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico" />
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Html/css/shoe.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.emotions.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>
<style>
.nav li.h_zb em {background: url(/Images/index/adqbj.png) no-repeat center 49px;}
</style>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
     <form id="form1" runat="server">

    <div class="indecen">
		<div class="shoel">
			<div class="shoelt">
				<img src="/Html/images/shoe.png" alt="" />
				<span>�ܲ�Ь</span>
				<a href="/infocenter/ShoeFind.aspx" class="shoed">������Ь</a>
				<a href="/SmartChooseShoe/ShoesMine.aspx">ͬ������</a>
				<a href="/SmartChooseShoe/ShoeCounselor.aspx">����ѡЬ</a>
				<!-- <a href="" >ͬ������</a>
				<a href="">�߼�����</a> -->
			</div>
			<div class="shoefind">
				<div class="sftit">
                    ��������ʵ�������д��            
                </div>
<table>
    <tr>
        <td class="idgender">
<span>
    <label for="idgender_0">�Ա�</label>
</span>
<em><ul id="idgender">
<li><input id="idgender_0" name="idgender" value="0" checked="checked" tabindex="2" type="radio"><label for="idgender_0">��</label></li>
<li><input id="idgender_1" name="idgender" value="1" tabindex="2" type="radio"><label for="idgender_1">Ů</label></li>
</ul></em>
            </td>
            <td>
<span>
    <label for="HeelCushioning">ǰ���ƻ���</label>
</span>
<em>
<select name="HeelCushioning " id="HeelCushioning" tabindex="5">
<option value="0">����</option>
<option value="1">�ǳ�Ӳ</option>
<option value="2">Ӳ</option>
<option value="3">�е�</option>
<option value="4">��</option>
<option value="5">�ǳ���</option>
</select>
</em>
        </td>
    </tr>
    <tr>
        <td>
<span>
<label for="Manufacturer">������</label>
</span>
<em>
<select name="Manufacturer" id="Manufacturer" tabindex="5">
    <option value="0">����</option>
    <option value="Adidas">Adidas</option>
	<option value="Aetrex">Aetrex</option>
	<option value="Altra">Altra</option>
	<option value="Anatom">Anatom</option>
	<option value="Asics">Asics</option>
	<option value="Brooks">Brooks</option>
	<option value="Columbia">Columbia</option>
	<option value="Ecco">Ecco</option>
	<option value="Etonic">Etonic</option>
	<option value="Hoka One One">Hoka One One</option>
	<option value="Icebug">Icebug</option>
	<option value="Inov-8">Inov-8</option>
	<option value="Kalenji">Kalenji</option>
	<option value="Karhu">Karhu</option>
	<option value="K-Swiss">K-Swiss</option>
	<option value="La Sportiva">La Sportiva</option>
	<option value="Merrell">Merrell</option>
	<option value="Mizuno">Mizuno</option>
	<option value="Montrail">Montrail</option>
	<option value="New Balance">New Balance</option>
	<option value="Newton">Newton</option>
	<option value="Nike">Nike</option>
	<option value="On">On</option>
	<option value="Patagonia">Patagonia</option>
	<option value="Pearl Izumi">Pearl Izumi</option>
	<option value="Puma">Puma</option>
	<option value="Reebok">Reebok</option>
	<option value="Salomon">Salomon</option>
	<option value="Saucony">Saucony</option>
	<option value="Scarpa">Scarpa</option>
	<option value="Scott">Scott</option>
	<option value="Skechers">Skechers</option>
	<option value="Skora">Skora</option>
	<option value="Speedo">Speedo</option>
	<option value="Spira">Spira</option>
	<option value="Tecnica">Tecnica</option>
	<option value="Terra Plana">Terra Plana</option>
	<option value="Teva">Teva</option>
	<option value="The North Face">The North Face</option>
	<option value="Topo Athletic">Topo Athletic</option>
	<option value="Treksta">Treksta</option>
	<option value="Under Armour">Under Armour</option>
	<option value="Vibram">Vibram</option>
	<option value="Vivobarefoot">Vivobarefoot</option>
	<option value="Zoot">Zoot</option>
</select></em></td>
        <td>
<span>
<label for="Flexibility">�����</label>
</span>
<em>
<select name="Flexibility" id="Flexibility" tabindex="5">
<option value="0">����</option>
<option value="1">�ǳ�Ӳ</option>
<option value="2">Ӳ</option>
<option value="3">�ж�</option>
<option value="4">���</option>
<option value="5">�ǳ����</option>
</select>
</em>
        </td>
    </tr>

    <tr>
        <td>
<span>
<label for="shoename">Ь������</label>
</span>
<em>
<input type="text" tabindex="1" maxlength="16" id="shoename" name="shoename">
</em>
        </td>
        <td>
<span>
<label for="HeelToe">ǰ�����</label>
</span>
<em>
<select name="HeelToe" id="HeelToe" tabindex="5">
<option value="0">����</option>
<option value="1">0mm</option>
<option value="2">1mm - 4mm</option>
<option value="3">5mm - 8mm</option>
<option value="4">9mm - 12mm</option>
<option value="5">13mm+</option>
</select>
</em>
        </td>
    </tr>
    <tr>
        <td>
<span>
<label for="ShoeType">Ь��</label>
</span>
<em>
<select name="ShoeType" id="ShoeType" tabindex="5">
<option value="0">����</option>
<option value="1">��·</option>
<option value="2">ԽҰ</option>
</select>
</em>            
        </td>
        <td>
<span>
<label for="StabilityFeatures">�ȶ���</label>
</span>
<em>
<select name="StabilityFeatures" id="StabilityFeatures" tabindex="5">
<option value="0">����</option>
<option value="1">�ǳ���</option>
<option value="2">��</option>
<option value="3">�е�</option>
<option value="4">��</option>
<option value="5">�ǳ���</option>
</select>
</em>
        </td>
    </tr>

    <tr>
        <td>
<span>
<label for="Price">�۸�</label>
</span>
<em>
<select name="Price" id="Price" tabindex="5">
<option value="0">����</option>
<option value="1">400����</option>
<option value="2">400-600</option>
<option value="3">600-1000</option>
<option value="4">1000����</option>
</select>
</em>
        </td>
        <td>
<span>
<label for="Weight">����</label>
</span>
<em>
<select name="Weight" id="Weight" tabindex="5">
<option value="0">����</option>
<option value="1">�ǳ���</option>
<option value="2">��</option>
<option value="3">�е�</option>
<option value="4">��</option>
<option value="5">�ǳ���</option>
</select>
</em>
        </td>
    </tr>
    <tr>
        <td>
<span>
<label for="footCushioning">�������</label>
</span>
<em>
<select name="footCushioning" id="footCushioning" tabindex="5">
<option value="0">����</option>
<option value="1">�ǳ�Ӳ</option>
<option value="2">Ӳ</option>
<option value="3">�е�</option>
<option value="4">��</option>
<option value="5">�ǳ���</option>
</select>
</em>
        </td>
        <td>
<span>
<label for="Profile">�߶�</label>
</span>
<em>
<select name="Profile" id="Profile" tabindex="5">
<option value="0">����</option>
<option value="1">�ǳ���</option>
<option value="2">��</option>
<option value="3">�е�</option>
<option value="4">��</option>
<option value="5">�ǳ���</option>
</select>
</em>
        </td>
    </tr>
</table>
<div class="findshoe">��ʼ����</div>
			</div>
		</div>
        <div class="shoer">
          <a target="_blank" href="/zt/runbook/index.aspx"><img width="300" height="300" border="0" alt="��������ȫ��" title="��������ȫ��" src="http://www.erun360.com/adm/ad300.jpg"></a>
                <a target="_blank" href="/GroupBuy/Group.aspx?id=63"><img width="300" height="300" border="0" alt="ħ����moudio��M100 ���������˶�����" title="��������ȫ��" src="/images/md2.jpg"></a>
        </div>
    </div>
<script>
$(".findshoe").click(function(event) {
var xb = $("input[name='idgender']:checked").val(),
    qjzhc = $("#HeelCushioning").val(),
    zzs   = $("#Manufacturer").val(),
    lhx   = $("#Flexibility").val(),
    mz    = $("#shoename").val()?$("#shoename").val():"",
    qhgc  = $("#HeelToe").val(),
    xx    = $("#ShoeType").val(),
    wdx   = $("#StabilityFeatures").val(),
    jg    = $("#Price").val(),
    zl    = $("#Weight").val(),
    zghc  = $("#footCushioning").val(),
    gd    = $("#Profile").val()

location.href = "/infocenter/ShoeResult.aspx?xb="+xb+"&qjzhc="+qjzhc+"&zzs="+zzs+"&lhx="+lhx+"&mz="+mz+"&qhgc="+qhgc+"&xx="+xx+"&wdx="+wdx+"&jg="+jg+"&zl="+zl+"&zghc="+zghc+"&gd="+gd+"&m=Seach&p=1"

});

</script>

    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
         </form>
</body>
</html>