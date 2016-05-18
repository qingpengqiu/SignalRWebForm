<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceCom.aspx.cs" Inherits="Admin_RaceCom" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>�������-������</title>
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Admin.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script language="javascript" src="/Common/jCheck.js?2012111"></script>
    <script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script language="javascript" src="/Html/js/jCalendar.js?2012111"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script language="javascript" src="/Common/jPopup.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/swfobject.js"></script>
    <script type="text/javascript" src="/Html/js/fullAvatarEditor.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../Html/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
    <script language="javascript" src="/Common/jCheck.js"></script>
    <script language="javascript" src="/Html/js/jCalendar.js"></script>

    <form id="form1" runat="server">
        <center>
<div style="width:100%;height:85px;padding-top:30px;background-color:#F8FFF8;">
    <div style="width:950px;height:85px;text-align:left;">
        <img src="/images/logo-u.gif" onclick="window.location='/';" style="margin-right:80px;">
        <img src="/images/top-user.jpg">
    </div>
</div>
<style>
    .cont {
        width: 930px;
        height: 600px;
        padding: 10px;
        text-align: left;
        font-family: ΢���ź�;
    }

    .conttop {
        padding: 10px;
        height: 32px;
        font-size: 14px;
        font-weight: bold;
        color: #333;
    }

    .cont table {
        color: #666;
        width: 930px;
    }

        .cont table tr td:first-child {
            width: 120px;
            text-align: right;
        }

        .cont table tr td:last-child {
            width: 410px;
        }

        .cont table tr {
            height: 40px;
            line-height: 50px;
        }

    #CalendarDiv select {
        width: 60px;
        height: 20px;
    }

    #CalendarDiv table tr {
        height: 20px;
        line-height: 20px;
    }

        #CalendarDiv table tr td {
            height: 20px;
            line-height: 20px;
        }

    #signingup {
        width: 202px;
    }

    .cont table tr td:last-child input {
        float: left;
        margin-left: 4px;
    }

    .cont table tr td:last-child label {
        float: left;
        margin-left: 3px;
        margin-right: 4px;
    }

    .cont select {
        width: 320px;
    }

    .item {
        width: 124px;
    }

    .price {
        width: 58px;
    }

    .number {
        width: 58px;
    }

    .cont table tr .project label {
        margin-top: 4px;
    }

    .addproject {
        width: 60px;
        height: 22px;
        line-height: 22px;
        color: #458b08;
        font-size: 12px;
        border: 1px solid #e5e5e5;
        text-align: center;
        border-radius: 4px;
        float: left;
    }

    #Btnsubmit {
        width: 83px;
        height: 32px;
        background: url(/Images/submit.gif);
        border: 0;
        text-indent: -999em;
    }

    #tips {
        background: #fff;
        height: 100%;
        line-height: 110px;
        text-align: center;
        font-size: 14px;
    }

        #tips img {
            margin-right: 4px;
        }

    #thumb {
        width: 630px;
        height: 430px;
        background: #fff;
        padding-top: 40px;
    }
    .maxm td{text-align: center!important;}
    .cont table.maxm tr td:last-child{width: auto;}
</style>
<div class="cont">
	<div class="conttop">
		<a href="/" >��ҳ</a>  >
<a href="/Admin/RaceList.aspx">������ҳ</a>>
		��������
	</div>
    
	<table>
		<tr>
			<td><label for="ssname">ѡ�����£�</label></td>
			<td>
                    <asp:DropDownList ID="DDLRace" runat="server" OnSelectedIndexChanged="DDLRace_SelectedIndexChanged"  AutoPostBack="true">
                        
                    </asp:DropDownList></td>
		</tr>		
        <tr>
            <td><label for="item">��Ŀ�����ã�</label></td>   
            <td><a  class="addproject" href="RaceEdit.aspx?id=0&idCompete=<%=idcompete%>" >�����Ŀ</a></td>
        </tr> 
        <tr><td colspan="2" style="text-align: left; color: #0000FF;">(ע�����������Ŀ���������ύ��)</td></tr>    
</table>
<asp:Repeater ID="rptrunrecord" runat="server">
                        <HeaderTemplate>
                        <table class="maxm">
                            <tr>
                              <%--  <td>���</td>--%>
                                <td>���</td>
                                <td>����</td>
                                <td>����</td>
                                <td>����</td>
                                <td>��ע</td>
                                <td>��װ</td> 
                                <td>��Ь</td> 
                                <td>�ϸ�֤</td>
                                <td>���</td>
                                <td>���ֶһ�</td>                                                       
                                <td>����</td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <%--<td>
                            <asp:Label ID="lblID" Text='<%# DataBinder.Eval(Container.DataItem, "id")%>' runat="server"></asp:Label></td>--%>
                             <td>
                                <%#  Eval("iType").ToString() == "1" ? "����": Eval("iType").ToString() == "2" ? "�⼮": Eval("iType").ToString() == "3" ? "���("+Eval("iNum").ToString()+"��)": Eval("iType").ToString() == "4" ? "�Ŷ�": "����"%>
                            </td>
                           <td><%# DataBinder.Eval(Container.DataItem, "cType")%></td>                            
                            <td><%# DataBinder.Eval(Container.DataItem, "iCost")%>Ԫ</td>
                            <td><%# DataBinder.Eval(Container.DataItem, "iLimit")%>��</td>
                              <td><%# DataBinder.Eval(Container.DataItem, "cComment")%></td>
                             <td>
                                <%#  Eval("iCloth").ToString() == "1" ? "��": "��"%>                                
                            </td>
                            <td>
                                <%#  Eval("iShoe").ToString() == "1" ? "��": "��"%>                                
                            </td>
                            <td>
                                <%#  Eval("ihealth").ToString() == "1" ? "��": "��"%>                                
                            </td>
                             <td>
                                <%#  Eval("iAudit").ToString() == "1" ? "��": "��"%>                                
                            </td> 
                             <td>
                                 <%#  Eval("iScore").ToString() == "0" ? "��": Eval("iScore").ToString()+"���ֶһ�"+ Eval("iMoney").ToString()+"Ԫ"%> 
                            </td>     
                             <td><a href='<%# "RaceEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id")+"&idCompete="+DataBinder.Eval(Container.DataItem, "idCompete") %>' target="_blank">�༭</a>
                            <%--<a href='<%# "RaceEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id") %>'>ɾ��</a>--%>
                             </td>
                        </tr>
                    </ItemTemplate>
                    <%--AlternatingItemTemplate������������е���һ�����--%>
                    <AlternatingItemTemplate>
                        <tr bgcolor="#e8e8e8">
                           <%-- <td>
                            <asp:Label ID="lblID" Text='<%# DataBinder.Eval(Container.DataItem, "id")%>' runat="server"></asp:Label></td>--%>
                            <td>
                                <%#  Eval("iType").ToString() == "1" ? "����": Eval("iType").ToString() == "2" ? "�⼮": Eval("iType").ToString() == "3" ? "���("+Eval("iNum").ToString()+"��)": Eval("iType").ToString() == "4" ? "�Ŷ�": "����"%>
                            </td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cType")%></td>                            
                            <td><%# DataBinder.Eval(Container.DataItem, "iCost")%>Ԫ</td>
                            <td><%# DataBinder.Eval(Container.DataItem, "iLimit")%>��</td>
                              <td><%# DataBinder.Eval(Container.DataItem, "cComment")%></td>
                             <td>
                                <%#  Eval("iCloth").ToString() == "1" ? "��": "��"%>                                
                            </td>
                            <td>
                                <%#  Eval("iShoe").ToString() == "1" ? "��": "��"%>                                
                            </td>
                            <td>
                                <%#  Eval("ihealth").ToString() == "1" ? "��": "��"%>                                
                            </td>    
                             <td>
                                <%#  Eval("iAudit").ToString() == "1" ? "��": "��"%>                                
                            </td>
                            <td>
                                 <%#  Eval("iScore").ToString() == "0" ? "��": Eval("iScore").ToString()+"���ֶһ�"+ Eval("iMoney").ToString()+"Ԫ"%> 
                            </td>   
                            <td><a href='<%# "RaceEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id")+"&idCompete="+DataBinder.Eval(Container.DataItem, "idCompete") %>' target="_blank">�༭</a>
                            <%--<a href='<%# "RaceEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id") %>'>ɾ��</a>--%>
                            </td>
                        </tr>
                    </AlternatingItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>

<table>
   <tr>
			<td><label>����������</label></td>
			<td>			
                 <input id="signingup" runat="server" class="Wdate input-large" type="text" style="width: 185px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate:'%y-%M-#{%d}'})" />				
			</td>
		</tr>
        <tr>
            <td>
                <label for="PortraitAlter">����ͼ��</label>
            </td>
            <td>
                <img src="<%=portrait %>" id="upimg"></img>
                <input type="hidden" runat="server" id="avatarurl" />
            </td>
        </tr>
     <tr>
			<td><label>������Ʒ��</label></td>
			<td>			
                <asp:CheckBoxList ID="cbxFscp" runat="server" RepeatLayout="OrderedList"></asp:CheckBoxList>	
			</td>
		</tr>
    <tr>
        <td colspan="2">
            <asp:Button ID="Btnsubmit" runat="server" Text="Button" OnClick="Btnsubmit_Click"></asp:Button>
        </td>
    </tr>
</table>

    <div style="display:none">
    <div id="tips" >
        
    </div>  
</div>
</div>
</center>
    </form>
    <div style="display: none">
        <div id="thumb">
            <p id="swfContainer">
                �������Ҫ��װFlash Player��ſ�ʹ�ã����<a href="http://www.adobe.com/go/getflashplayer">����</a>���ذ�װ��
            </p>
        </div>
    </div>
    <script type="text/javascript">
       
        var idcompte = '<%=idcompete%>';       
        function tips(msg, url, imgname) {
            var img = "<img src=\"\/Html\/images\/" + imgname + "\.png\">"
            $("#tips").append(img).append(msg);


            $.colorbox({ inline: true, width: "50%", href: "#tips", width: "254px", height: "141px", opacity: "0.4" });
            var url = url;
            if (url == "") {
                setTimeout("$.colorbox.close();", 5000)

            } else {
                setTimeout("location.href = \"" + url + "\"", 3000)
            }

        }

        $("#upimg").colorbox({ inline: true, href: "#thumb", width: "641px", height: "504px", opacity: "0.4" });

        swfobject.addDomLoadEvent(function () {
            var swf = new fullAvatarEditor("swfContainer", {
                id: 'swf',
                avatar_sizes: '150*150|50*50|32*32',
                upload_url: '/action/Upload.ashx?u=r+|' + idcompte,
                src_upload: 2
            }, function (msg) {
                switch (msg.code) {
                    //case 1: alert("ҳ��ɹ������������"); break;
                    //case 2: alert("�ѳɹ�����Ĭ��ָ����ͼƬ���༭��塣"); break;
                    case 3:
                        if (msg.type == 0) {
                            alert("����ͷ��׼���������û�������ʹ�á�");
                        }
                        else if (msg.type == 1) {
                            alert("����ͷ��׼���������û�δ����ʹ�ã�");
                        }
                        else {
                            alert("����ͷ��ռ�ã�");
                        }
                        break;
                    case 5:
                        if (msg.type == 0) {
                            document.getElementById("avatarurl").value = "<%=HostInfo.imgName%>/Utility/Uploads" + msg.content.avatarUrls[0];
                            $("#upimg").attr('src', '<%=HostInfo.imgName%>/Utility/Uploads' + msg.content.avatarUrls[0]);
                            $.colorbox.close();
                        }
                        break;
                }
            }
            );

        });

    </script>
</body>
</html>
