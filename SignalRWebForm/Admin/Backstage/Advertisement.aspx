<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Advertisement.aspx.cs" Inherits="Admin_Backstage_Advertisement" %>
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
    <script type="text/javascript" src="/Common/jCity.js"></script>
    <script type="text/javascript" src="/Html/js/My97DatePicker/WdatePicker.js"></script>
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
		<a href="/Admin/">管理首页</a> >
<a href="/Admin/Backstage/Advertisementlb.aspx">广告列表</a>>
		编辑广告
	</div>
   <div class="indecen">
            <div class="newclub">
                <table>
                    <tr>
                        <td>
                            <label for="">广告名称</label></td>
                        <td>
                            <input type="text" tabindex="2" id="cName" name="cName" runat="server" maxlength="64" />
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <label for="">广告位置</label></td>
                        <td>
                            <asp:DropDownList ID="cPosition" runat="server" style="width: 220px;" OnSelectedIndexChanged="cPosition_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList><asp:Label id="cPlable" runat="server"></asp:Label>
                            <%--<select id="cPosition" runat="server" tabindex="12"  style="width: 220px;">
                            </select>  --%>
                        </td>
                         <td></td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">上架时间</label></td>
                        <td>
                           <input id="dbegintime" runat="server" tabindex="4" class="Wdate" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'dendtime\')}'})"/> --- <input id="dendtime" tabindex="5" runat="server" class="Wdate" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'dbegintime\')}'})"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">外部链接</label></td>
                        <td>
                            <input type="text" tabindex="10" id="cLick" name="cLick" runat="server" maxlength="512" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">上传类型</label></td>
                        <td>
                            <select id="cMack" runat="server" tabindex="12"  style="width: 220px;"> 
                                <option value="0">图片</option>
                                <option value="1">flash</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                                        <td>上传文件</td>
                                        <td>
<%--                                            <ul class="temx">                        
                                                <asp:HiddenField ID="radiotemp" runat="server" Value="../Images/toutu/tu1.jpg" />
                                             </ul>--%>
                                            <asp:FileUpload ID="hdtt" runat="server" class="input-large"/>
                                            <asp:Label ID="lbtt" runat="server" Text="" Enabled="false" Visible="False"></asp:Label>
                                            <asp:Label id="Label1" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                    <%-- <tr>
                        <td>
                            <label for="">物品图片</label></td>
                        <td>
                           <label for="hoteleditimg"><img src="<%=portrait %>" class="hoteloldimg"/></label>
                            <input type="file" class="input-large fileupload" id="hoteleditimg" style="display:none">
                                        <input type="hidden" runat="server" id="avatarurl" />
                        </td>
                    </tr>--%>
                    <tr>
                        <td>
                            <label for="">状态</label></td>
                        <td>
                            <select id="iState" runat="server" tabindex="12"  style="width: 220px;"> 
                                <option value="2">正常</option>
                                <option value="1">暂停</option>
                            </select>
                        </td>
                    </tr>                   
                </table>
                 <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/botton.png" OnClick="ImageButton1_Click" />
            </div>
        </div>
</div>
</center>
        <div style="display:none">
            <div id="tips" >

            </div>

        </div>
    <div class="toast" >

    </div>
    </form>
    <div class="toast toast-error" >

    </div>

    <div style="display: none">
        <div id="thumb">
            <p id="swfContainer">
                本组件需要安装Flash Player后才可使用，请从<a href="http://www.adobe.com/go/getflashplayer">这里</a>下载安装。
            </p>
        </div>
    </div>

    <script type="text/javascript">
        $(".fileupload").change(function () {
            var data = new FormData(),
               sthis = $(this)
            $.each(sthis[0].files, function (i, file) {
                data.append('upload_file', file);
            });
            $.ajax({
                url: '/action/fileUp.ashx?name=Filedata',
                type: 'POST',
                data: data,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    var data = data[0]
                    if (data.status == 1) {
                        sthis.next("input").val(data.url)
                        $(".hoteloldimg").attr('src', data.url);
                        $(".toast").html(data.message).show().addClass('toast-success')
                        errorboxhide()

                    } else {
                        $(".toast").html(data.message).show().addClass('toast-error')
                        errorboxhide()
                    }
                }
            });
        });
        var idcompte = '<%=sid%>';
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
                    //case 1: alert("页面成功加载了组件！"); break;
                    //case 2: alert("已成功加载默认指定的图片到编辑面板。"); break;
                    case 3:
                        if (msg.type == 0) {
                            alert("摄像头已准备就绪且用户已允许使用。");
                        }
                        else if (msg.type == 1) {
                            alert("摄像头已准备就绪但用户未允许使用！");
                        }
                        else {
                            alert("摄像头被占用！");
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