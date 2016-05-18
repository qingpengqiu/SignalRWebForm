<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ApplyFrom.aspx.cs" Inherits="Channels_Competetion_ApplyFrom" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><!DOCTYPE html>
<html >
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title>������������-������</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="/Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/user-more.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/themes.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/Group.css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Html/js/modernizr.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="/Html/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/Html/js/bootstrap-validation.min.js"></script>
    <script type="text/javascript" src="/Html/js/swfobject.js"></script>
    <script type="text/javascript" src="/Html/js/fullAvatarEditor.js"></script>
    <script type="text/javascript" src="/Common/jCity.js"></script>
    <script src="/Common/jCheck.js"></script>
    <script src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <style>
       
    </style>
    <!--[if lte IE 9]>
<link rel="stylesheet" type="text/css" href="js/IE9.js"/>
<![endif]-->
</head>
<body>
	<style type="text/css">
		body{background-color: #f5f5f5}
		.applybox{background: #fefefe;
box-shadow: 0px 0px 8px #ddd;
margin-top: 22px;
border-radius: 5px;
border: 1px solid #e3e3e3;
padding: 49px 70px 0 74px;
font-family: \5FAE\8F6F\96C5\9ED1!important;
display: inline-block;
width: 824px;
overflow: hidden;}
		.appTb{padding: 20px;}
		.ApplyTop{height: 76px;line-height: 76px;text-align: center;display: block;width: 520px;margin:0 auto 50px auto;border-radius: 4px;}
		.ApplyTop label{display: inline-block;width: 246px;float: left;font-size: 23px;cursor: pointer;color: #fff;height: 76px;line-height:76px;background: #cacac3;border-radius: 4px;}
		.ApplyTop label:last-child{float: right;}
		.ApplyTop input{display: none}
		.ApplyTop .this{background: #9ab671;color: #fff}
		.form-group{display: inline-block;width: 100%;}
		.srL{float: left;width:34%;text-align: right;}
		.srL label{line-height: 38px;color: #666}
		.srR{float: left;width: 58%;padding-top: 4px;padding-left: 2%;position: relative;}
		.srR label{height: 21px;position: relative;margin-top: 4px;}
		.srR label .Validform_checktip{top: 1px}
		.srR label img{position: absolute;top: 0px;left: 0;z-index: 99}
		.srR input[type="file"]{border: 0;background: none;box-shadow: none}
		.srR input{margin-bottom: 2px;
background: #f7f7f7;
box-shadow: 0px 0px 10px #ebeceb inset;
border-color: #ebeceb;}
		.srR label input{width: 10px;height: 10px;}
		.srR label input:focus{outline: none;}
		.textr .Validform_checktip{left: 440px;}
		.Validform_checktip{position: absolute;top: 12px;left: 250px;}
		.applybz{width: 70%;min-height: 30px;padding: 5px 8px;line-height: 19px;}
		.formtable{padding-bottom: 30px;}
		.ApplyS{color: #97a881;border-bottom: 3px solid #d9e0d2;padding: 0 0 8px 8px;margin-bottom: 40px;}
		.ApplyS em{font-size: 20px;font-weight: bold;}
		input.ApplyFromButton{width: 140px;height: 30px;background: #fe9c1b;color: #fff;display: block;margin: 0 auto 20px auto;border-radius: 4px;border: 0;text-align: center;}
		.applybox h1 {
color: #fbac4e;
font-size: 36px;
line-height: 41px;
border-left: 6px solid #fbc14e;
padding-left: 26px;
margin-left: 2px;font-weight: 100}

.racetip {
line-height: 18px;
border-radius: 4px;
color: #fff;
font-size: 12px;
padding: 6px 18px 6px 41px;
margin-top: 25px;
background: url(/Html/images/wt.png) no-repeat #fbb11c 11px center;
}
 select {
margin-bottom: 2px;
border-color: #d8d8d8 #d8d8d8 #b2b2b2 #d8d8d8;
background-image: -moz-linear-gradient(top, #fff, #f3f3f3);
background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #fff), color-stop(1, #f3f3f3));
box-shadow: 0px 1px 1px #e8e8e8;
line-height: 20px;
padding-top: 5px;
width: 100px;}
	</style>
    <form  id="rpfrom" runat="server">
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="articleh">
    	<div class="applybox">
    		<h1>��ӭʹ������������ƽ̨����ϵͳ</h1>
    		<div class="racetip">
                �����Ը��˻�˾�������ͨ�������������������»����Ϣʱ���밴Ҫ����д���ϴ���Ӧ��Ϣ�����ǻ���5���������ڽ�����ˣ���ʱ������ȡ����ϵ��
ʹ�ø�ƽ̨ʱ�����κ����⣬���µ�010-84374449��ѯ��
            </div>
    	<div class="appTb">
    	</div>
    	<div class="ApplyTop">
<label class="this"><input name="Fruit" type="radio" value="person" checked id="person" runat="server"/>���˷��� </label> 
<label><input name="Fruit" type="radio" value="Company" id="Company" runat="server"/>��˾���� </label> 
    	</div>
    	<div class="formtable ftbq person">
    		<div class="form-group">
				<div class="srL">
					<label class="">����: </label>
				</div>
				<div class="srR">
					<input type="text" class="form-control" id="cUserName" runat="server" placeholder="����" TabIndex="1" datatype="*" maxlength="64"><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">֤������: </label>
				</div>
				<div class="srR">
					<asp:DropDownList ID="ddlCard" runat="server" TabIndex="2">
                        <asp:ListItem Value="1">���֤</asp:ListItem>
                        <asp:ListItem Value="2">����֤</asp:ListItem>
                        <asp:ListItem Value="3">���ڱ�</asp:ListItem>
                        <asp:ListItem Value="4">����</asp:ListItem>
                        <asp:ListItem Value="5">����</asp:ListItem>
                    </asp:DropDownList>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">֤������: </label>
				</div>
				<div class="srR">
					<input type="text" class="form-control" id="prependedDropdownButton" TabIndex="3" runat="server" placeholder="֤������" datatype="*" maxlength="22"><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">�ֻ�: </label>
				</div>
				<div class="srR">
					<input type="text" class="form-control" id="mobile" placeholder="�ֻ�"  runat="server" maxlength="20" TabIndex="4" datatype="*"><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">��������: </label>
				</div>
				<div class="srR">
                    <input type="text"  class="form-control" id="email" value="" tabindex="5" runat="server" maxlength="60" placeholder="��������" datatype="*"/><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">�ʼĵ�ַ: </label>
				</div>
				<div class="srR">
                    <input type="text"  class="form-control" id="addressA" value="" tabindex="6" runat="server" maxlength="120" placeholder="�ʼĵ�ַ" datatype="*"/><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">�����֤���뱾�������֤���㣩: </label>
				</div>
				<div class="srR">
					<label for="FileFace"><img src="/Html/images/appleup.png">
					 <asp:FileUpload ID="FileFace" runat="server"  TabIndex="7" datatype="*"/><div class="Validform_checktip"></div></label>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">�����֤���뱾�˷����֤���㣩: </label>
				</div>
				<div class="srR">
					<label for="FileBack"><img src="/Html/images/appleup.png">
					<asp:FileUpload ID="FileBack" runat="server" TabIndex="8" datatype="*"/><div class="Validform_checktip"></div></label>
				</div>
			</div>
            <%--<div class="form-group">
				<div class="srL">
					<label class="">����������֤2: </label>
				</div>
				<div class="srR">
					<input type="file">
				</div>
			</div>--%>
			<div class="form-group">
				<div class="srL">
					<label class="">��ע˵��: </label>
				</div>
				<div class="srR textr">
					<textarea class="applybz" cols="20" rows="2" id="idPMark" runat="server"  maxlength="250"></textarea><div class="Validform_checktip"></div>
				</div>
			</div>
    	</div>
    	<div class="formtable ftbq Company" style="display:none">
    		<div class="form-group">
				<div class="srL">
					<label class="">��˾����: </label>
				</div>
				<div class="srR">
					<input type="text" class="form-control" id="CompanyName" runat="server" placeholder="��˾����" TabIndex="1" datatype="*" maxlength="120"><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">ס��: </label>
				</div>
				<div class="srR">
					 <input type="text" class="form-control" id="Companyaddress" value="" tabindex="2" runat="server" maxlength="120" placeholder="ס��" datatype="*" aria-invalid="false" /><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">��˾����: </label>
				</div>
				<div class="srR">
					<input type="text" class="form-control" id="CompanyType" placeholder="��˾����" runat="server" tabindex="3" datatype="*" maxlength="120"><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">��Ӫ��Χ: </label>
				</div>
				<div class="srR">
					<input type="text" class="form-control" id="CompanyScope" placeholder="��Ӫ��Χ" runat="server" tabindex="4" datatype="*" maxlength="250"><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">����: </label>
				</div>
				<div class="srR">
					<input type="text" class="form-control" id="CompanyTelephone" placeholder="����" runat="server" tabindex="5" datatype="*" maxlength="21"><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">������: </label>
				</div>
				<div class="srR">
					<input type="text" class="form-control" id="CompanyHeader" placeholder="������" runat="server" tabindex="6" datatype="*" maxlength="16"><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">��ϵ��ʽ: </label>
				</div>
				<div class="srR">
					<input type="text" class="form-control" id="CompanyMobile" placeholder="��ϵ��ʽ" runat="server" tabindex="7" datatype="*" maxlength="20"><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">Ӫҵִ������: </label>
				</div>
				<div class="srR">
					<label for="CompanyFileFace"><img src="/Html/images/appleup.png">
					<asp:FileUpload ID="CompanyFileFace" runat="server" TabIndex="8" datatype="*"/></label><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">Ӫҵִ�ո���: </label>
				</div>
				<div class="srR">
					<label for="CompanyFileBack"><img src="/Html/images/appleup.png">
					<asp:FileUpload ID="CompanyFileBack" runat="server" TabIndex="9" datatype="*"/></label><div class="Validform_checktip"></div>
				</div>
			</div>
            <%--<div class="form-group">
				<div class="srL">
					<label class="">����������֤: </label>
				</div>
				<div class="srR">
					<input type="file">
				</div>
			</div>--%>
    	</div>
    	<div class="ApplyS">
    		<em>�����</em>
    	</div>
    	<div class="formtable">
    		<div class="form-group">
				<div class="srL">
					<label class="">��������: </label>
				</div>
				<div class="srR">
					<input type="text" class="form-control" id="RaceTitle" placeholder="��������" runat="server" tabindex="10" datatype="*" maxlength="120"><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">ʱ��: </label>
				</div>
				<div class="srR">
					<input type="text" class="form-control" id="RaceTime" placeholder="ʱ��" runat="server" tabindex="11" onclick="GDate(this); " datatype="*" ><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">�ص�: </label>
				</div>
				<div class="srR">
					<input type="text" class="form-control" id="RaceAddress" placeholder="�ص�" runat="server" tabindex="12" datatype="*" maxlength="250"><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">�����: </label>
				</div>
				<div class="srR">
					<input type="text" class="form-control" id="RaceType" placeholder="�����" runat="server" tabindex="13" datatype="*" maxlength="250"><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">Ԥ�ƹ�ģ: </label>
				</div>
				<div class="srR">
					<input type="text" class="form-control" id="RaceNum" placeholder="Ԥ�ƹ�ģ" runat="server" tabindex="14" datatype="*" maxlength="8">��<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">����������: </label>
				</div>
				<div class="srR textr">
                    <asp:TextBox ID="RaceContent" runat="server" CssClass="applybz" TabIndex="15" datatype="*" MaxLength="250" TextMode="MultiLine"></asp:TextBox><div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">������: </label>
				</div>
				<div class="srR textr">
                    <asp:TextBox ID="RaceRules" runat="server" TextMode="MultiLine" CssClass="applybz" TabIndex="16" rows="12" datatype="*"></asp:TextBox><div class="Validform_checktip"></div><br><br>������������Ϣ������������Ŀ������
					<%--<input type="file" runat="server" tabindex="10">������������Ϣ������������Ŀ������--%>
				</div>
			</div>
			<div class="form-group">
				<div class="srL">
					<label class="">��������ͼƬ: </label>
				</div>
				<div class="srR">
					<label for="RaceFile"><img src="/Html/images/appleup.png">
					<asp:FileUpload ID="RaceFile" runat="server" TabIndex="17" datatype="*"/><div class="Validform_checktip"></div></label>
				</div>
			</div>
            <%--<div class="form-group">
				<div class="srL">
					<label class="">���������ϴ�: </label>
				</div>
				<div class="srR">
					<input type="file" runat="server" tabindex="10">
				</div>
			</div>--%>
			<div class="form-group">
				<div class="srL">
					<label class="">��ע˵��: </label>
				</div>
				<div class="srR textr">
					<asp:TextBox ID="RaceMark" runat="server" CssClass="applybz" TabIndex="18" MaxLength="250" TextMode="MultiLine"></asp:TextBox><div class="Validform_checktip"></div>
				</div>
			</div>
    	</div>

        <asp:Button ID="btSumit" runat="server" Text="�ύ" OnClick="btSumit_Click" class="ApplyFromButton"/>
        </div>
    </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
        </form>
        <script type="text/javascript">
            $(".ApplyTop label").click(function(event) {
            	var i = $(this).index()
            	$(this).addClass('this').siblings().removeClass('this')
            	$(".ftbq").hide().eq(i).show()
            });
        $("#rpfrom").Validform({
			ignoreHidden:true,
            tiptype: function (msg, o, cssctl) {
                if (!o.obj.is("form")) {
                    var objtip = o.obj.nextAll(".Validform_checktip");
                    cssctl(objtip, o.type);
                    objtip.text(msg);
                }
            }
        });
        $(".applybox input[type=file]").change(function(event) {
        	$(this).prev("img").attr('src', '/Html/images/applyoup.png');
        });
        </script>
</body>
</html>
