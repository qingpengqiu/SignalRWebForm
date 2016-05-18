<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GoodEdit.aspx.cs" Inherits="Admin_GoodEdit" %>

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
    <script language="javascript" src="/Common/jCheck.js?2012111"></script>
    <script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script language="javascript" src="/Common/jCalendar.js?2012111"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script language="javascript" src="/Common/jPopup.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../Common/jCity.js"></script>
    <script type="text/javascript" src="../Html/js/My97DatePicker/WdatePicker.js"></script>
    <style type="text/css">
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
            overflow: hidden;
            margin-top: 10px;
            font-family: \5FAE\8F6F\96C5\9ED1;
        }

            .newclub tr td {
                font-size: 14px;
                color: #000;
            }

                .newclub tr td:first-child {
                    width: 260px;
                    text-align: right;
                }

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

        #b2 {
            border: 0px;
            background: none;
            box-shadow: none;
            font-size: 12px;
            margin: -10px 0 0 320px;
        }

            #b2:focus {
                box-shadow: none;
            }

        .newclub li {
            float: left;
     
            text-align: center;
          
        }

        .newclub ul {
            width: 464px;
            display: inline-block;
            padding-top: 20px;
        }

            .newclub ul label {
                margin: 0;
            }

        #ImageButton1 {
            margin: 40px auto;
            display: block;
        }
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
		<a href="/Admin/PayList.aspx">物品管理首页</a> >
<a href="/Admin/GoodList.aspx">商品列表</a>>
		编辑商品
	</div>
   <div class="indecen">
            <div class="newclub">
                <table>
                     <tr>
                        <td>
                            <label for="">商品类别</label></td>
                        <td>
                            <select id="itpye" runat="server" tabindex="1" disabled> 
                                <option value="1">积分兑换</option>
                                <option value="2">团购商品</option>
                                <%--<option value="3">普通商品</option>--%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">商品名称</label></td>
                        <td>
                            <input type="text" tabindex="2" id="cname" name="name" runat="server" maxlength="64" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">物品属性</label></td>
                        <td>
                            <asp:RadioButtonList ID="rdoEntry" runat="server" RepeatLayout="UnorderedList" tabindex="3">
                            <asp:ListItem Value="0" Selected="True">虚拟物品</asp:ListItem>
                            <asp:ListItem Value="1">实物</asp:ListItem>
                        </asp:RadioButtonList>
                        </td>
                    </tr>                    
                    <tr>
                        <td>
                            <label for="">上架时间</label></td>
                        <td>
                           <input id="dbegintime" runat="server" tabindex="4" class="Wdate" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'dendtime\')}'})"/>-<input id="dendtime" tabindex="5" runat="server" class="Wdate" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'dbegintime\')}'})"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">市场价格</label></td>
                        <td>
                            <input type="text" runat="server" tabindex="5" id="fMarketPrice" maxlength="9" value="0" /><label for="">元</label>
                        </td>
                    </tr>                    
                     <tr >
                        <td>
                            <label for="">益跑价</label></td>
                        <td>
                           <input type="text" name="iScore" id="iScore" runat="server" class="number" tabindex="6" value="0" style="width: 80px" />积分+<input type="text"  style="width: 80px"  tabindex="7" id="fSellPrice" runat="server" maxlength="9" value="0" /><label for="idNumber">元</label>
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <label for="">物品图片</label></td>
                        <td>
                           <asp:FileUpload ID="hdtt" runat="server" class="input-large"/> <asp:Label ID="lbtt" runat="server" Text="" ></asp:Label>
                                    图片大小1M以下，建议分辨率300*300
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <label for="">外部链接</label></td>
                        <td>
                            <input type="text" tabindex="10" id="cLink" name="name" runat="server" maxlength="512" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">排序</label></td>
                        <td>
                            <input type="text" tabindex="11" id="iTotal" name="name" runat="server" maxlength="10" value="0"/>（数值越大越靠前）
                        </td>
                    </tr>
                    <tr style="display: none">
                        <td>
                            <label for="">产品介绍</label></td>
                        <td><%--<textarea id="cBio" runat="server" rows="2" cols="20"></textarea>--%>
                            <textarea name="cBio" id="cBio" runat="server"  rows="2" cols="20"></textarea>

                        <script src="../UEditor/ueditor-small.config.js"></script>
                        <script src="../UEditor/ueditor.all.js"></script>

                        <script type="text/javascript">
                            var editor = new UE.ui.Editor();
                            editor.render("cBio");
                        </script>
                        </td>
                    </tr>
                    <tr style="display: none">
                        <td>
                            <label for="">规格参数</label></td>
                        <td><textarea id="cNorm" name="cNorm" runat="server" rows="2" cols="20"></textarea>
                              <script type="text/javascript">
                                  var editor = new UE.ui.Editor();
                                  editor.render("cNorm");
                        </script>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">状态</label></td>
                        <td>
                            <select id="state" runat="server" tabindex="13"> 
                                <option value="0">待发布</option> 
                                <option value="1">发布</option>
                                <option value="-1">禁用</option>
                            </select>
                        </td>
                    </tr>                   
                </table>
                 <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/botton.png" OnClick="ImageButton1_Click" />
            </div>
        </div>
</div>
</center>
    </form>

</body>
</html>
