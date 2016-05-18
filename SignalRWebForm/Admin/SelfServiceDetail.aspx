<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelfServiceDetail.aspx.cs" Inherits="Admin_SelfServiceDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>����������ϸ-����ά��-ERUN360.COM</title>
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
        
        <!-- ��Ϣ��ʼ -->
        <div id="pageContent">
            
            <table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#CCCCCC" style="border-collapse: collapse;">
                <tr bgcolor="#e8e8e8">
                    <td align="center" colspan="6">����������ϸ</td>
                </tr>
                <tr>
                    <td align="right" style="width: 120px;">����:</td>
                    <td>
                        <%=model.cName %>(���<%=model.id %>)
                    </td>
                    <td>
                        ״̬��</td>
                    <td>
                       <%=model.iStatus.ToString()== "1" ? "�����": model.iStatus.ToString() == "2" ? "��ͨ��":"δ����"%></td>
                    <td>
                      �ֻ���</td>
                    <td>
                        <%=model.cMobile %></td>
                </tr>
                <tr>
                    <td align="right">֤�����ͣ�</td>
                    <td>
                         <%=model.iStatus.ToString() == "1" ? "���֤" : model.iStatus.ToString() == "2"?"����֤":model.iStatus.ToString() == "3" ? "���ڱ�":model.iStatus.ToString() == "4" ? "����":"δѡ��"%></td>
                    <td>
                       ֤�����룺</td>
                    <td>
                       <%=model.cNationID %></td>
                    <td>
                       �������䣺</td>
                    <td>
                       <%=model.cMail %></td>
                </tr>
                <tr>
                    <td align="right">�ʼĵ�ַ��</td>
                    <td><%=model.cAddress %></td>
                    <td align="right">��ע˵����</td>
                    <td> <%=model.cMemo %></td>
                    <td> </td>
                    <td> </td>
                </tr>
                <tr>
                    <td align="right">����֤����</td>
                    <td><img src=" <%=HostInfo.imgName+"/Utility/uploads/"+model.cFaceUrl %>" width="60" height="60"></td>
                    <td>����֤����</td>
                    <td><img src=" <%=HostInfo.imgName+"/Utility/uploads/"+model.cBackUrl %>" width="60" height="60"></td>
                    <td></td>
                    <td></td>
                </tr>
              <tr bgcolor="#e8e8e8">
                    <td align="center" colspan="6">������ϸ</td>
                </tr>
                 <tr>
                    <td align="right">�������ƣ�</td>
                    <td><%=model.cRaceTitle %></td>
                    <td align="right">ʱ�䣺</td>
                    <td> <%=model.dRacetime %></td>
                    <td>�ص㣺</td>
                    <td> <%=model.cRaceAddress %></td>
                </tr>
                <tr>
                    <td align="right">����ͣ�</td>
                    <td><%=model.cStyle %></td>
                    <td align="right">��ģ��</td>
                    <td> <%=model.iScale %></td>
                    <td>��ע��</td>
                    <td> <%=model.cMark %></td>
                </tr>
                <tr>
                    <td align="right">���������ݣ�</td>
                    <td colspan="5"><%=model.cRacepack%></td>
                </tr>
                <tr>
                    <td align="right">�����̣�</td>
                    <td  colspan="5"><%=model.tRegulation%></td>
                </tr>
                <tr>
                    <td align="right">��������ͼƬ��</td>
                    <td  colspan="5"><img src=" <%=HostInfo.imgName+"/Utility/uploads/"+model.cSRacePicUrl %>" width="60" height="60"></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
