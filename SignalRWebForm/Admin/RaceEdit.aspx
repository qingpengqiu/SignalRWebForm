<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceEdit.aspx.cs" Inherits="Admin_RaceEdit" %>

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
		<a href="/Admin/RaceList.aspx" >��ҳ</a> >
		��������
	</div>
    
	<table>
		<tr>
			<td><label for="ssname">�������ƣ�</label></td>
			<td>
                <input type="text" id="ssmc" readonly  tabindex="1" runat="server"/>	
			</td>
		</tr>
        <%--<tr>
			<td><label>����������</label></td>
			<td>
				<input type="text" id="time" value="" onclick="GDate(this);" tabindex="2" runat="server"/>				
			</td>
		</tr>		--%>
        <tr>
			<td><label for="item">��Ŀ����</label></td>
			<td>
               <input type="text" id="item" class="item"  runat="server" tabindex="3" maxlength="16" />
			</td>
		</tr>
        <tr>
			<td><label for="item">��Ŀ����</label></td>
			<td>
               <input type="text" class="price"  id="price"  runat="server" tabindex="4" /><label for="price">Ԫ</label>
			</td>
		</tr>
        <tr>
			<td><label for="number">���</label></td>
			<td>
              <input type="text" name="number" id="number" runat="server" class="number" tabindex="5" /><label for="number">��</label>
			</td>
		</tr>
        <tr>
			<td><label for="commemt">��ע��</label></td>
			<td>
               <input type="text" class="commemt" id="bz" runat="server" tabindex='6' />
			</td>
		</tr>
		<tr>
			<td><label for="dressyes">�ṩ��װ��</label></td>
			<td>
          <asp:RadioButtonList ID="rdbfz" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" Width="80px" TabIndex="7">
                    <asp:ListItem Value="1">��</asp:ListItem>
                    <asp:ListItem Value="0" Selected="True">��</asp:ListItem>
                </asp:RadioButtonList>
			</td>
		</tr>
		<tr>
			<td><label for="shoesyes">�ṩ��Ь��</label></td>
			<td>
                <asp:RadioButtonList ID="rdbpx" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" Width="80px" TabIndex="8">
                    <asp:ListItem Value="1">��</asp:ListItem>
                    <asp:ListItem Value="0" Selected="True">��</asp:ListItem>
                </asp:RadioButtonList>				
			</td>
		</tr>
		<tr>
			<td><label for="checkyes">��Ҫ���ϸ�֤��</label></td>
			<td>
				<asp:RadioButtonList ID="rdbhgz" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" Width="80px" TabIndex="9">
                    <asp:ListItem Value="1">��</asp:ListItem>
                    <asp:ListItem Value="0" Selected="True">��</asp:ListItem>
                </asp:RadioButtonList>
			</td>
		</tr>
        <tr>
			<td><label for="checkyes">�Ƿ���Ҫ��ˣ�</label></td>
			<td>
				<asp:RadioButtonList ID="rdbsh" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" Width="150px" TabIndex="9">
                    <asp:ListItem Value="1">��</asp:ListItem>
                    <asp:ListItem Value="0" Selected="True">��</asp:ListItem>
                </asp:RadioButtonList>
			</td>
		</tr>
        <tr>
			<td><label for="shoesyes">���</label></td>
			<td>
                <asp:RadioButtonList ID="rdbType" runat="server" RepeatDirection="Vertical" RepeatLayout="UnorderedList" TabIndex="10" OnSelectedIndexChanged="rdbType_SelectedIndexChanged" AutoPostBack="True">
                    <asp:ListItem Value="1" Selected="True">����</asp:ListItem>
                    <asp:ListItem Value="2">�⼮</asp:ListItem>
                    <asp:ListItem Value="3">���</asp:ListItem>
                    <asp:ListItem Value="4">�Ŷ�</asp:ListItem>
                </asp:RadioButtonList>				
			</td>
		</tr>
        <tr id="idNum" runat="server" visible="false">
            <td>
                <label for="idNumber">���������</label>
            </td>
            <td>
                <input type="text" name="idNumber" id="idNumber" runat="server" class="number" tabindex="11" /><label for="idNumber">��</label>
            </td>
        </tr>
            <tr>
            <td>
            </td>
            <td>
               <label for="iScore">���α�������</label><input type="text" name="iScore" id="iScore" runat="server" class="number" tabindex="12" value="0" /><label for="iMoney">���ֶһ�</label><input type="text" name="iMoney" id="iMoney" runat="server" class="number" tabindex="13" value="0"/><label for="idNumber">Ԫ</label>
            </td>
        </tr>
        <%--  <tr>
            <td>
                <label for="PortraitAlter">����ͼ��</label>
            </td>
            <td>
                <img src="<%=portrait %>" id="upimg"></img>
                <input type="hidden" runat="server" id="avatarurl" />
            </td>
        </tr>--%>         
         <tr>
            <td><label for="item">��չ�ֶΣ�</label></td>   
            <td><a  class="addproject" href="RaceExt.aspx?id=0&iditem=<%=id%>&idCompete=<%=idCompete%>" >�����չ�ֶ�</a></td>
        </tr> 
        <tr>
			<td colspan="2">
                <asp:Repeater ID="rptExt" runat="server">
                        <HeaderTemplate>
                        <table class="maxm">
                            <tr>
                                <td>������չ˵��</td>
                                <td>Ӣ����չ˵��</td>
                                <td>��չ����</td>
                                <td>���λ��</td>
                                <td>���ı�ע</td>
                                <td>Ӣ�ı�ע</td>                         
                                <td>����</td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>                          
                           <td><%# DataBinder.Eval(Container.DataItem, "cnName")%></td>                            
                            <td><%# DataBinder.Eval(Container.DataItem, "enName")%></td>
                            <td>
                                <%#  Eval("data_type").ToString() == "1" ? "�����ϴ�": Eval("data_type").ToString() == "2" ? "�ı���ע":Eval("data_type").ToString() == "3" ? "ѡ����":""%>
                            </td>
                            <td>
                                 <%#  Eval("sales_field").ToString() == "cRemark2" ? "λ��1": Eval("sales_field").ToString() == "cRemark3" ? "λ��2":Eval("sales_field").ToString() == "cRemark4" ? "λ��3":""%>
                            </td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cnTip")%></td>
                             <td><%# DataBinder.Eval(Container.DataItem, "enTip")%></td>
                            <td><a href='<%# "RaceExt.aspx?id="+DataBinder.Eval(Container.DataItem, "id")+"&idCompete="+idCompete +"&iditem="+DataBinder.Eval(Container.DataItem, "iditem")%>' target="_blank">�༭</a>
                            
                            </td>
                        </tr>
                    </ItemTemplate>
                    <%--AlternatingItemTemplate������������е���һ�����--%>
                    <AlternatingItemTemplate>
                        <tr bgcolor="#e8e8e8">                          
                            <td><%# DataBinder.Eval(Container.DataItem, "cnName")%></td>                            
                            <td><%# DataBinder.Eval(Container.DataItem, "enName")%></td>
                            <td>
                                <%#  Eval("data_type").ToString() == "1" ? "�����ϴ�": Eval("data_type").ToString() == "2" ? "�ı���ע":Eval("data_type").ToString() == "3" ? "�Ƿ�":""%>
                            </td>
                            <td>
                                <%#  Eval("sales_field").ToString() == "cRemark2" ? "λ��1": Eval("sales_field").ToString() == "cRemark3" ? "λ��2":Eval("sales_field").ToString() == "cRemark4" ? "λ��3":""%>
                                </td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cnTip")%></td>
                             <td><%# DataBinder.Eval(Container.DataItem, "enTip")%></td>
                            <td><a href='<%# "RaceExt.aspx?id="+DataBinder.Eval(Container.DataItem, "id")+"&idCompete="+idCompete +"&iditem="+DataBinder.Eval(Container.DataItem, "iditem")%>' target="_blank">�༭</a>
                            
                            </td>
                        </tr>
                    </AlternatingItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
			</td>
		</tr>
        <tr>
			<td><asp:Button ID="Btnsubmit" runat="server" Text="Button" OnClick="Btnsubmit_Click"></asp:Button></td>
			<td>
			</td>
		</tr>
	</table> 
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
        
         var idcompte = '<%=idCompete%>';         
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

