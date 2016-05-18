<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelfServiceDetail2.aspx.cs" Inherits="Admin_SelfServiceDetail2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>自主赛事详细-数据维护-ERUN360.COM</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <link href="/Common/Frame.css" type="text/css" rel="stylesheet" />
       <script language="javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
        <script language="javascript" src="/Common/jCheck.js"></script>
        <script language="javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    </head>
<body>
    <form id="form2" runat="server">
        
        <!-- 信息开始 -->
        <div id="pageContent">
            
            <table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#CCCCCC" style="border-collapse: collapse;">
                <tr bgcolor="#e8e8e8">
                    <td align="center" colspan="6">自主赛事明细</td>
                </tr>
                <tr>
                    <td align="right" style="width: 120px;">公司名称:</td>
                    <td>
                        <%=model.cName %>(编号<%=model.id %>)
                    </td>
                    <td>
                        状态：</td>
                    <td>
                       <%=model.iStatus.ToString()== "1" ? "待审核": model.iStatus.ToString() == "2" ? "已通过":"未发布"%></td>
                    <td>
                      公司类型：</td>
                    <td>
                        <%=model.cType %></td>
                </tr>
                <tr>
                    <td>
                       座机：</td>
                    <td>
                       <%=model.cTelephone %></td>
                    <td>
                       负责人：</td>
                    <td>
                       <%=model.cHeader %></td>
                    <td align="right">联系方式：</td>
                    <td> <%=model.cMobile %></td>
                </tr>
                <tr>
                    <td align="right">经营范围:</td>
                    <td>
                         <%=model.cScope %></td>
                    <td align="right">住所：</td>
                    <td><%=model.cAddress %></td>
                    <td> </td>
                    <td> </td>
                </tr>
                <tr>
                    <td align="right">营业执照正本：</td>
                    <td><img src=" <%=HostInfo.imgName+"/Utility/uploads/"+model.cFaceUrl %>" width="60" height="60"></td>
                    <td>营业执照副本：</td>
                    <td><img src=" <%=HostInfo.imgName+"/Utility/uploads/"+model.cBackUrl %>" width="60" height="60"></td>
                    <td></td>
                    <td></td>
                </tr>
              <tr bgcolor="#e8e8e8">
                    <td align="center" colspan="6">赛事明细</td>
                </tr>
                 <tr>
                    <td align="right">赛事名称：</td>
                    <td><%=model.cRaceTitle %></td>
                    <td align="right">时间：</td>
                    <td> <%=model.dRacetime %></td>
                    <td>地点：</td>
                    <td> <%=model.cRaceAddress %></td>
                </tr>
                <tr>
                    <td align="right">活动类型：</td>
                    <td><%=model.cStyle %></td>
                    <td align="right">规模：</td>
                    <td> <%=model.iScale %></td>
                    <td>备注：</td>
                    <td> <%=model.cMark %></td>
                </tr>
                <tr>
                    <td align="right">参赛包内容：</td>
                    <td colspan="5"><%=model.cRacepack%></td>
                </tr>
                <tr>
                    <td align="right">具体规程：</td>
                    <td  colspan="5"><%=model.tRegulation%></td>
                </tr>
                <tr>
                    <td align="right">赛事宣传图片：</td>
                    <td  colspan="5"><img src=" <%=HostInfo.imgName+"/Utility/uploads/"+model.cSRacePicUrl %>" width="60" height="60"></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
