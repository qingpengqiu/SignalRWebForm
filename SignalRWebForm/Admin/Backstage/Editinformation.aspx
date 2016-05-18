<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Editinformation.aspx.cs" Inherits="Admin_Backstage_Editinformation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>管理入口-益跑网</title>
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Admin.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script language="javascript" src="/Common/jCalendar.js?2012111"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script language="javascript" src="/Common/jPopup.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <style type="text/css">
        table {
            width: 100%;
        }

            table tr td:first-child {
                text-align: right;
                padding-right: 4px;
            }

            table ul {
                margin: 0;
            }

                table ul li {
                    float: left;
                }

                    table ul li input {
                        float: left;
                    }

                    table ul li label {
                        float: left;
                    }

        .cont {
            width: 930px;
            padding: 10px;
            text-align: left;
            font-family: 微软雅黑;
        }

        .conttop {
            padding: 10px;
            height: 32px;
            font-size: 14px;
            font-weight: bold;
            color: #333;
        }

        .newclub {
            width: 100%;
            font-family: \5FAE\8F6F\96C5\9ED1;
        }

            .newclub tr td {
                font-size: 12px;
                color: #000;
            }
        .focus-b {
    background: none repeat scroll 0 0 #378ed6;
    border-radius: 5px;
    color: #fff;
    float: left;
    font-size: 12px;
    font-weight: 100;
    line-height: 12px;
    margin-left: 12px;
    padding: 6px;
    text-shadow: 0.08em 0.08em 0.04em #296694;
}
        /*
            .newclub label {
                margin-bottom: 7px;
                padding-right: 10px;
                display: inline-block;
            }

            .newclub select {
                width: 120px;
            }

            .newclub textarea {
                padding: 14px;
                width: 420px;
                height: 120px;
            }
        #idCity, #cCityname {
            display: none;
        }

        #ImageButton1 {
            width:80px;
            display: block;
        }*/

    </style>
</head>

<body>
    <form id="form1" runat="server">
        <center>
<div style="width:100%;height:85px;padding-top:30px;background-color:#F8FFF8;">
	<div style="width:950px;height:85px;text-align:left;">
		<img src="/images/logo-u.gif" onclick="window.location='/';" style="margin-right:80px;">
		<img src="/images/top-user.jpg">
	</div>
</div>

<div class="cont">
		<div class="conttop">
		<a href="/" >首页</a>  >
<a href="/Admin/RaceList.aspx">赛事首页</a>><a href="/Admin/Backstage/ExportOrders.aspx">报名记录</a>>
		编辑
	</div>
    <%--<a name='a<%=id %>>'></a>--%>
      <table>
        <tr>
            <td>
                <label for="">姓名</label></td>
            <td>
                <input type="text" runat="server" value="" maxlength="16" tabindex="1" id="name" name="name" datatype="*1-30" errormsg="请填写真实姓名"  nullmsg="必填！"/></td>
            <td>
                <label for="">性别</label></td>
            <td>
                    <asp:RadioButtonList ID="idgender" runat="server" RepeatLayout="UnorderedList" tabindex="2">
                <asp:ListItem Value="0" Selected="True">男</asp:ListItem>
                <asp:ListItem Value="1">女</asp:ListItem>
            </asp:RadioButtonList></td>
        </tr>
        <tr>
            <td>
                <label for="">血型</label></td>
            <td>
                    <asp:RadioButtonList ID="idBlood" runat="server" RepeatLayout="UnorderedList"  tabindex="3">
                    <asp:ListItem Value="0" Selected="True">A</asp:ListItem>
                    <asp:ListItem Value="1">B</asp:ListItem>
                    <asp:ListItem Value="3">AB</asp:ListItem>
                    <asp:ListItem Value="2">O</asp:ListItem>
                    <asp:ListItem Value="4">其他</asp:ListItem>
                </asp:RadioButtonList></td>
            <td><label for="">生日</label></td>
            <td>
                <input id="birday" runat="server" class="Wdate input-large" type="text" style="width: 185px" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt: 'yyyy-MM-dd',maxDate:'%y-%M-#{%d}'})" value="2008-08-08" tabindex="4"/></td>
        </tr>
        <tr>
            <td>
                <label for="">学历</label></td>
            <td>
                <asp:DropDownList ID="ddlEducation" runat="server" TabIndex="5">
            <asp:ListItem Value="0" Selected="True">其他</asp:ListItem>
            <asp:ListItem Value="1">大专</asp:ListItem>
            <asp:ListItem Value="2">本科</asp:ListItem>
            <asp:ListItem Value="3">研究生</asp:ListItem>
            <asp:ListItem Value="4">博士</asp:ListItem> 
            <asp:ListItem Value="5">硕士</asp:ListItem>     
        </asp:DropDownList></td>
                <td>
                <label for="">职业</label></td>
            <td>
                <asp:DropDownList ID="idOccupation" runat="server" TabIndex="6"></asp:DropDownList></td>
        </tr>
        <tr>
                <td>
                <label for="">国籍</label></td>
            <td>
                <input type="text" name="idgj" id="idgj" value="中国" tabindex="7" runat="server" />
            </td>
                <td>
                <label for="">证件类型</label></td>
            <td>
                <asp:DropDownList ID="ddlCard"  class="card" runat="server" TabIndex="8">
            <asp:ListItem Value="1">身份证</asp:ListItem>
            <asp:ListItem Value="2">军官证</asp:ListItem>
            <asp:ListItem Value="3">户口本</asp:ListItem>
            <asp:ListItem Value="4">护照</asp:ListItem> 
            <asp:ListItem Value="5">其它</asp:ListItem>  
        </asp:DropDownList>
        <input type="text" tabindex="9" id="idCard" class="cardin" runat="server" maxlength="24"/>
        </td>
        </tr>
        <tr>
            <td>
                <label for="">手机</label></td>
            <td>
                <input type="text" name="mobile" id="mobile" value="" tabindex="10" runat="server" maxlength="11"/>
            </td>
                <td>
                <label for="">电子邮箱</label></td>
            <td>
                <input type="text" name="email" id="email" value="" tabindex="12"  runat="server" maxlength="64" /></td>
        </tr>
        <tr>
            <td>
                <label for="">邮编</label></td>
            <td>
                <input type="text" name="zipcode" id="zipcode" value="" tabindex="11" runat="server" maxlength="6"  /> </td>
            <td>
                <label for="">地址</label></td>
            <td>
            <input type="text" tabindex="12" id="cCityname" runat="server" readonly/>
            <input type="text" name="address" id="address" value="" tabindex="13" runat="server" maxlength="128"/>
            </td>
                        
        </tr>
        <tr>
            <td>
                <label for="">紧急联系人</label></td>
            <td>
            <input type="text" name="emerger" id="emerger" value="" tabindex="14" runat="server" maxlength="30" />
            </td>
            <td>
                <label for="">紧急电话</label></td>
            <td>
            <input type="text" name="emermobile" id="emermobile" value="" tabindex="15" runat="server" maxlength="30"   />
            <div class="Validform_checktip"></div></td>
        </tr>
        <tr>
            <td>
                <label for="">服装尺码</label></td>
            <td>
             <asp:RadioButtonList ID="size" runat="server" RepeatDirection="Vertical" RepeatLayout="UnorderedList">
                                    <asp:ListItem Selected="True">S</asp:ListItem>
                                    <asp:ListItem>M</asp:ListItem>
                                    <asp:ListItem>L</asp:ListItem>
                                    <asp:ListItem>XL</asp:ListItem>
                                    <asp:ListItem>XXL</asp:ListItem>
                                    <asp:ListItem>XXXL</asp:ListItem>
                                </asp:RadioButtonList>
            </td>
           <%-- <td>
                <label for="">报名状态</label></td>
            <td>
                <asp:DropDownList ID="state"  class="card" runat="server" Enabled="false" >
            <asp:ListItem Value="0">未审核</asp:ListItem>
            <asp:ListItem Value="1">待付款</asp:ListItem>
            <asp:ListItem Value="2">已付款</asp:ListItem>
            <asp:ListItem Value="3">已组队</asp:ListItem> 
            <asp:ListItem Value="-1">已过期</asp:ListItem>  
        </asp:DropDownList>
           </td>--%>
        </tr>
       <%-- <tr>
            <td>
                <label for="">审核批注</label></td>
            <td>
            <input type="text"  id="cRemark1" value="" tabindex="14" runat="server" maxlength="128" readonly=""/>
            </td>
            <%--<td>
                <label for="">附件</label>
             </td>
            <td>
<asp:Literal ID="ltlImg" runat="server"></asp:Literal>
            </td>
        </tr>--%>
        <tr>
            <td>
                </td>
            <td>
            <%--<a class="focus-b article-up-iframe cboxElement" href="/infocenter/PostMessage.aspx?uId=<%=iduser %>">给TA留言</a>--%>
            </td>
            <td>
                <%--<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="返回" />--%>
            </td>
            <td><asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/submit.png" OnClick="ImageButton1_Click" />
            </td>
        </tr>
          <tr>
            <td><label for="">订单号</label></td>
            <td><asp:Literal ID="ltlorder" runat="server"></asp:Literal></td>
            <td></td>
            <td></td>
        </tr>
        <%--<tr>
            <td><label for="">位置1</label></td>
            <td><asp:Literal ID="ltlbz1" runat="server"></asp:Literal></td>
            <td><label for="">位置2</label></td>
            <td><asp:Literal ID="ltlbz2" runat="server"></asp:Literal></td>
        </tr>
          <tr>
            <td><label for="">位置3</label></td>
            <td><asp:Literal ID="ltlbz3" runat="server"></asp:Literal></td>
            <%--<td><label for="">使用积分</label></td>
            <td><asp:Literal ID="ltljifen" runat="server"></asp:Literal></td>
        </tr>--%>
    </table>
    
</div>
</center>
          <script type="text/javascript">

              $(".new-classify").colorbox({ iframe: true, width: "647px", height: "423px" });
              jQuery(document).ready(function ($) {
                  var lheight = $(".main-right").height() - "16";
                  if (lheight > "530") {
                      $(".main-left").css("height", lheight);
                  }
              });
              $(".article-up-iframe").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });

        </script>
    </form>
</body>
</html>