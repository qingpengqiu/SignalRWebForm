<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EventApply.aspx.cs" Inherits="Channels_Competetion_EventApply" %>

<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
    <link href="/Common/cansai-from.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Common/jCityshow.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>
<body onload="showimg()">
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="indecen">
        <form id="form1" runat="server" class="marathon-reg">
            <h1>
                <asp:Label ID="Labeltitle" runat="server" Text="����"></asp:Label><a href="/Channels/Competetion/RaceAddInfo.aspx?idcompete=<%=id%>" class="lang">�л�������</a></h1>   
                       <h4>Please fill the entry form with caution after registration, and modify it directly. Some of the blanks will be filled automatically for online registrators. All the Content below is compulsory.</h4>         
            <table>
                <tr>
                    <td>
                        <span>
                            <label for="name">Full Name</label></span>
                        <em>
                            <input type="text" name="name" id="name" value="" tabindex="1" runat="server" maxlength="30" /></em>
                    </td>
                    <td class="tdlabel">
                        <span>
                            <label for="gendera">Gender</label></span>
                         <asp:RadioButtonList ID="idgender" runat="server" RepeatLayout="UnorderedList">
                            <asp:ListItem Value="0" Selected="True">Male</asp:ListItem>
                            <asp:ListItem Value="1">Female</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td class="xuexing">
                        <span>
                            <label for="blood">Blood Type</label></span>
                        <em>
                             <asp:RadioButtonList ID="idblood" runat="server" RepeatLayout="UnorderedList" Width="250px">
                                <asp:ListItem Value="0" Selected="True">A</asp:ListItem>
                                <asp:ListItem Value="1">B</asp:ListItem>
                                <asp:ListItem Value="3">AB</asp:ListItem>
                                <asp:ListItem Value="2">O</asp:ListItem>
                                <asp:ListItem Value="4">other</asp:ListItem>                                
                            </asp:RadioButtonList>
                            </em>
                    </td>
                    <td>
                        <span>
                            <label for="birthday">Date of Birth</label></span>
                        <em>
                            <input type="text" runat="server" name="birthday" id="birday" value="" tabindex="4" onclick="GDate(this);" /></em>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>
                            <label for="education">Education Level</label></span>
                        <em>
                            <select id="education" tabindex="5" runat="server">
                                <option value="other">other</option>
                                <option value="��ר">junior college</option>
                                <option value="����">bachelor</option>
                                <option value="�о���">postgraduate</option>
                                <option value="��ʿ">Ph.D</option>
                                <option value="˶ʿ">master</option>
                            </select>
                        </em>
                    </td>
                    <td>
                        <span>
                            <label for="occupation">Occupation</label></span>
                        <em>
                            <asp:DropDownList ID="idOccupation" runat="server"></asp:DropDownList></em>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>
                            <label for="idtype">ID Type</label></span>
                        <em>
                            <div class="input-prepend">
                                <select id="idCard" class="card" tabindex="7" runat="server">
                                    <option value="��ѡ��">select</option>
                                    <option value="���֤">ID card</option>
                                    <option value="����֤">Military identification</option>
                                    <option value="���ڱ�">Residence booklet</option>
                                    <option value="����">Passport</option>
                                    <option value="����">other</option>
                                </select>
                                <input type="text" tabindex="7" id="prependedDropdownButton" class="span2" runat="server" maxlength="24">
                            </div>
                        </em>
                    </td>
                    <td>
                        <span>
                            <label for="mobile">Cellphone</label></span>
                        <em>
                            <input type="text" name="mobile" id="mobile" value="" tabindex="8" runat="server" maxlength="11" /></em>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>
                            <label for="email">E-mail</label></span>
                        <em>
                            <input type="text" name="email" id="email" value="" tabindex="9" check-type="mail" mail-message="E-mail no" runat="server" maxlength="64" /></em>
                    </td>
                    <td>
                        <span>
                            <label for="city">Resident</label></span>
                        <%--<em><input type="text" name="city" id="city" value="" tabindex="10"  runat="server"/></em>--%>
                        <select name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)" runat="server" style="width: 110px;">
                        </select>
                        <select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)" runat="server" style="width: 110px;">
                        </select>
                        <script type="text/javascript">
                            BindProvince("����");
                        </script>                        
                        <input type="hidden" id="idCity" name="idCity" size="5"  runat="server" style="width: 30px"/>
                        <input type="text" id="cCityname" name="cCityname" size="15"  value="" readonly runat="server" style="width: 100px"/>
                        <input type="hidden" runat="server" id="UpdatedFields" name="UpdatedFields" value=""/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>
                            <label for="address">Address</label></span>
                        <em>
                            <input type="text" name="address" id="address" value="" tabindex="11" runat="server" /></em>
                    </td>
                    <td>
                        <span>
                            <label for="zipcode">Zip Code</label></span>
                        <em>
                            <input type="text" name="zipcode" id="zipcode" value="" tabindex="12" runat="server" /></em>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>
                            <label for="emerger">Emergency Contact</label></span>
                        <em>
                            <input type="text" name="emerger" id="emerger" value="" tabindex="13" runat="server" /></em>
                    </td>
                    <td>
                        <span>
                            <label for="emermobile">Emergency Contact Phone</label></span>
                        <em>
                            <input type="text" name="emermobile" id="emermobile" value="" tabindex="14" runat="server" /></em>
                    </td>
                </tr>
                
                <tr class="tdlabele">
                    <td colspan="2">
                        <span><label for="competetion">Categories</label></span>
                        <em>
                            <asp:RadioButtonList ID="rdoEntries" runat="server" RepeatDirection="Vertical" AutoPostBack="True" OnSelectedIndexChanged="rdoEntries_SelectedIndexChanged" RepeatLayout="UnorderedList"></asp:RadioButtonList>
                        </em>
                    </td>
                </tr>
                <tr height="36">
                    <td colspan="2" style="height:36px">
                        <span style="padding:0"><label >Categories�� Detail</label></span><div class="bmtip"> <%=Item%><%=bm%></div>
                    </td>
                </tr>
                <tr>
                    <td class="tdlabelf">
                        <div id="sizetd" runat="server">
                            <span>
                                <label for="size">T-shirts Size</label>
                            </span>
                            <em>
                                <asp:RadioButtonList ID="size" runat="server" RepeatDirection="Vertical" RepeatLayout="UnorderedList">
                                    <asp:ListItem Selected="True">S</asp:ListItem>
                                    <asp:ListItem>M</asp:ListItem>
                                    <asp:ListItem>L</asp:ListItem>
                                    <asp:ListItem>XL</asp:ListItem>
                                    <asp:ListItem>XXL</asp:ListItem>
                                    <asp:ListItem>XXXL</asp:ListItem>
                                </asp:RadioButtonList>
                            </em>
                        </div>
                    </td>
                    <td>
                        <div id="Divshoe" runat="server">
                            <span>
                                <label for="number">Shoes Size</label></span>
                            <em>
                                <input type="text" name="shoeno" id="shoeno" value="" tabindex="17" runat="server" /></em>
                        </div>
                    </td>
                </tr>
                 <div id="gj" runat="server" visible="false">
                <tr>
                    <td colspan="2">                        
                        <span>
                            <label for="nationality">����</label></span>
                        <em>
                           <input type="text" name="shoeno" id="idgj" value="" tabindex="17" runat="server" />
                        </em>                           
                    </td>
                </tr>
                </div>
                <div id="jtfs" runat="server" visible="false">
                <tr>
                    <td class="tdlabele" colspan="2">
                       
                        <span>
                            <label for="traffica">ǰ�������ؽ�ͨ��ʽ</label></span>
                        <em>
                            <asp:RadioButtonList ID="idtjfs" runat="server" RepeatDirection="Vertical" RepeatLayout="UnorderedList">
                                    <asp:ListItem Selected="True">����6����8�����</asp:ListItem>
                                    <asp:ListItem>ʯ��ׯ6����10�����</asp:ListItem>
                                    <asp:ListItem>�Լ�</asp:ListItem>                                    
                                </asp:RadioButtonList>
                        </em>
                           
                    </td>
                </tr>
                  </div>
                <tr class="uptijian" runat="server" id="trupload">
                    <td colspan="2">
                        <span>
                            <label>medical or achievement certificate</label></span>
                        <em>
                            <asp:FileUpload ID="FileUpload1" runat="server" />��ʽΪ.jpg/.gif/.bmp/.png<input type="hidden" id="fileurl" runat="server" /></em>
                    </td>
                </tr>
            </table>
            <div class="control-group">
                <div class="controls">
                    <asp:Button ID="Ctnsubmit" runat="server" Text="Button" OnClick="Ctnsubmit_Click" />
                </div>
            </div>
        </form>
        <div style="display: none">
            <div id="tips">
            </div>
            <div id="bdmap">
                <div id="hdjmap">
                </div>
                <a href="javascript:void(0)" onclick="mapqd()" class="mapqd"></a>
            </div>
        </div>
    </div>
    <script type="text/javascript">
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
        $("#ddlCity").css("width", "110px");
        $("#ddlProvince").css("width", "110px");
        var iCity = parseInt(<% =iCity %>) - 1
        $("#ddlProvince").val(china[iCity])
        for (x in china[iCity]) {
            if (x != 0) {
                if (x == [<% =iArea  %>]) {
                    $("#ddlCity").append('<option selected=\"selected\" value=' + china[iCity][x] + '>' + china[iCity][x] + '</option>')
                } else {
                    $("#ddlCity").append('<option value=' + china[iCity][x] + '>' + china[iCity][x] + '</option>')
                }
            }
        }
        $(".hdjmap").click(function (event) {
            cityname = $("#ddlProvince").val() + $("#ddlCity").val()
            if (cityname) {
                cityname = "����"
            }
        });


        function showimg() {
            var jkimgurl = $("#fileurl").val();
            if (jkimgurl != "") {
                //console.log(jkimgurl);
                $("#trupload td").append("<a href=\"<%=HostInfo.imgName %>/Utility/uploads/" + jkimgurl + "\" target=\"_blank\">�ϴ��ɹ�&nbsp;<img src=\"/Html/images/img_icon.png\"></a>")
            } else {
                //console.log("jkimgurl");
                $("#trupload td").append("<a>�����ϴ����֤����ɼ�֤�� </a>")
            }
        }
    </script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
