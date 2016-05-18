<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Items.aspx.cs" Inherits="Competetion_Items" %>

<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<%@ Register Src="~/Competetion/headerv2.ascx" TagPrefix="ERUN360" TagName="headerv2" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<!DOCTYPE html>
<html lang="cn">
<head >
    <meta charset="gb2312">
    <title></title>
    <link rel="stylesheet" href="/mz/css/amazeui.min.css">
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="/Html/css/marathon.css">
    <script src="/Html/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script src="/Html/js/marathon.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>       
    <script type="text/javascript" src="/Common/jCity.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../Html/js/My97DatePicker/WdatePicker.js"></script>
</head>
    
<body>

    <style>
        /*#Btnsubmit {
            width: 83px;
            height: 32px;
            background: url(/Images/submit.gif);
            border: 0;
            text-indent: -999em;
        }*/
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

    </style>
    <ERUN360:headerv2 runat="server" ID="headerv2" />
	<div class="banner">
	    <div class="mine"><h1>扬州马拉松比赛</h1>
	        <img src="/Html/images/banner.jpg" alt="">
	    </div>
	</div>
    <form id="form1" runat="server">
    <div class="tbody">
        <div class="mine">
            <ERUN360:bmnav runat="server" ID="bmnav" />
            <div class="tbodyBox">
                <div class="event this clearfix">
                	<div class="eqma">
                		<div class="eqmal">
                			<a class="eqmaa eqmajd" href="">酒店管理<i></i></a>
                			<a class="eqmaa eqmajt" href="">交通管理<i></i></a>
                			<a class="eqmaa eqmaly" href="">旅游管理<i></i></a>
                			<a class="eqmaa eqmazb" href="">装备管理<i></i></a>
                		</div>
                		<div class="eqmar am-form ">
                			<div class="fbtitle">装备发布/管理 <a class="fbadd">发布装备信息</a></div>
                            <div class="fbli">
                				<div class="fblil"><label>赛事名称：</label></div>
                                <div >
                                   <asp:DropDownList ID="idGood" runat="server"  style="width: 200px;"></asp:DropDownList></div>
                			</div>
                			<div class="fbli">
                				<div class="fblil"><label>装备名称：</label></div><div class="fblir"><input  id="Cname" type="text" class="am-form-field am-radius fbftitle" placeholder="" runat="server" style="width: 200px;"></div>
                			</div>
                			
                			<div class="fbli">
                				<div class="fblil"><label>开始时间：</label></div>
                				<div class="fblir">
                					<input id="dRaceBegin" runat="server" name="dRaceBegin" type="text" style="width: 200px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd',minDate:'%y-%M-#{%d}'})" class="am-form-field am-radius fb82"/>
                				</div>
                			</div>
                			<div class="fbli">
                				<div class="fblil"><label>结束时间：</label></div>
                				<div class="fblir">
                					<input id="dRaceEnd" runat="server" name="dRaceEnd" type="text" style="width: 200px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd',minDate:'%y-%M-#{%d}'})" class="am-form-field am-radius fb82" />
                				</div>
                			</div>


                            <div class="fbli">
                				<div class="fblil"><label>装备链接：</label></div><div class="fblir"> <input type="text" tabindex="1" id="cLink"  runat="server" maxlength="9" class="am-form-field am-radius fb82" style="width: 200px;" /></div>
                			</div>
                            <div class="fbli">
                				<div class="fblil"><label>装备数量：</label></div><div class="fblir"><input id="iTotal" type="text" class="am-form-field am-radius fb82" placeholder="" runat="server"><label>每个ID最大购买数：</label><input type="text" runat="server" tabindex="4" id="iBuyMax" maxlength="9" class="am-form-field am-radius fb82" /></div>
                			</div>
                            <div class="fbli">
                				<div class="fblil"><label>缩略图：</label></div><div class="fblir">
                                    <img src="<%=portrait %>" id="upimg"/>
                                    <input type="hidden" runat="server" id="avatarurl" />
                				</div>
                			</div>

                			<div class="fbli">
                				<div class="fblil"><label>装备介绍：</label></div>
                				<div class="fblir fbtext">
                					<textarea name="Text1" id="Text1" runat="server"></textarea>
                				</div>
                                <script src="../UEditor/ueditor.config.js"></script>
                            <script src="../UEditor/ueditor.all.js"></script>

                            <script type="text/javascript">
                                var editor = new UE.ui.Editor();
                                editor.render("Text1");
                            </script>
                			</div>
                            <div class="fbli">
                				<div class="fblil"><label>推荐原因：</label></div>
                				<div class="fblir fbtext">
                					<textarea name="Text2" id="Text2" runat="server"></textarea>
                				</div>
                                <script type="text/javascript">
                                    var editor = new UE.ui.Editor();
                                    editor.render("Text2");
                            </script>
                			</div>
                            <div class="fbli">
                				<div class="fblil"><label>装备特点：</label></div>
                				<div class="fblir fbtext">
                					<textarea name="Text3" id="Text3" runat="server"></textarea>
                				</div>
                                <script type="text/javascript">
                                    var editor = new UE.ui.Editor();
                                    editor.render("Text3");
                            </script>
                			</div>
                			<div class="fbli">
                				<div class="fblil"><label>状态：</label></div>
                				<div class="fblir">
                					<select id="iState" runat="server" tabindex="12"  style="width: 200px;"> 
                                <option value="1">发布</option>
                                <option value="0">待发布</option>
                                <option value="-1">禁用</option>
                            </select>
                				</div>
                			</div>
                			<div class="savefb"><asp:Button ID="but_save" runat="server"  class="fkbuttom" Text="保存" OnClick="but_save_Click" ></asp:Button></div>
                		</div>
                	</div>
                </div>
            </div>
        </div>
    </div>
        </form>
    <div style="display: none">
        <div id="thumb">
            <p id="swfContainer">
                本组件需要安装Flash Player后才可使用，请从<a href="http://www.adobe.com/go/getflashplayer">这里</a>下载安装。
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
    <div class="toast toast-error" ></div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
