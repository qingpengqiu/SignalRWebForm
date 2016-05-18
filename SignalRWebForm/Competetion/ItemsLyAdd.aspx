<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ItemsLyAdd.aspx.cs" Inherits="Competetion_ItemsLyAdd" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Competetion/ICart.ascx" TagPrefix="ERUN360" TagName="ICart" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body{background: #f6f6f6}
</style>
    <script type="text/javascript" src="/Common/jCity.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../Html/js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="/Html/js/swfobject.js"></script>
    <script type="text/javascript" src="/Html/js/fullAvatarEditor.js"></script>
<style>
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
<form id="form1" runat="server">
	<div class="banner">
	     <div class="mine"><h1><%=title %></h1>
            <asp:Literal ID="ltlbanner" runat="server"></asp:Literal>
        </div>
	</div>
    <div class="tbody">
        <div class="mine">
            <ERUN360:bmnav runat="server" ID="bmnav" />
            <div class="tbodyBox">
                <div class="event this clearfix">
                	<div class="eqma">
                        <div class="eqmal"></div>
                		<div class="eqmar am-form " aria-haspopup="False">
                			<div class="fbtitle">编辑旅游</div>
                            <div class="fbli">
                                <div class="fblil"><label>类型：</label></div>
                                <div class="fblir">
                                    <input type="text" runat="server" tabindex="4" id="cColor" maxlength="9" class="am-form-field am-radius fb82"/><label>项目：</label><input type="text" runat="server" tabindex="4" id="cSize" maxlength="9"  class="am-form-field am-radius fb82"/><label>数量：</label><input id="iLimit" type="text" class="am-form-field am-radius fb82" placeholder="" runat="server">

                                </div>
                            </div>
                            <div class="fbli">
                                <div class="fblil"><label>上架时间：</label></div>
                                <div class="fblir">
                                <input id="dRaceBegin" runat="server" class="am-form-field am-radius fbftitle" style="width: 185px" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'dRaceEnd\')}'})"/>
                                -
                                <input id="dRaceEnd" runat="server" class="am-form-field am-radius fbftitle" style="width: 185px" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'dRaceBegin\')}'})"/></div>
                            </div>
                			<div class="fbli">
                				<div class="fblil"><label>市场价：</label></div>
                				<div class="fblir">
                					<input type="text" id="fMarketPrice" class="am-form-field am-radius fb82" placeholder="" runat="server"> 元（人民币）<label>现价：</label><input type="text" id="fSellPrice" class="am-form-field am-radius fb82" placeholder="" runat="server"> 元（人民币）
                				</div>
                			</div>
                			<div class="fbli">
                				<div class="fblil"><label>使用积分：</label></div>
                				<div class="fblir">
                					<input type="text" id="iScore" class="am-form-field am-radius fb82" placeholder="" runat="server"><label>兑换:</label><input type="text" id="iMoney" class="am-form-field am-radius fb82" placeholder="" runat="server">元
                				</div>
                			</div>
                            <div class="fbli">
                                    <div class="fblil"><label>缩略图：</label></div>
                                    <div class="fblir">
                                        <label for="hoteleditimg"><img src="<%=portrait %>" class="hoteloldimg"/></label><input type="file" class="input-large fileupload" id="hoteleditimg" style="display:none">
                                        <input type="hidden" runat="server" id="avatarurl" /><br>
                                        图片大小1M以下，建议分辨率300*300
                                    </div>
                                </div>
                			<div class="savefb"><asp:Button ID="but_save" runat="server"  class="fkbuttom" Text="保存" OnClick="but_save_Click" ></asp:Button></div>
                		</div>                        
                	</div>
                </div>
            </div>
        </div>
    </div>
            <div style="display:none">
        <div id="tips" >
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
        var idcompte = '<%=id%>';
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
<ERUN360:footerv3 runat="server" ID="footerv3" />