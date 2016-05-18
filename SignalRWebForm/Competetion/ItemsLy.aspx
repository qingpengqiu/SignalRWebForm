<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ItemsLy.aspx.cs" Inherits="Competetion_ItemsLy" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
body{background: #f6f6f6}
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
    	<div class="banner">
	     <div class="mine"><h1><%=title %></h1>
            <asp:Literal ID="ltlbanner" runat="server"></asp:Literal>
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
                			<a class="eqmaa eqmazb" href="ItemsLylb.aspx?sid=<%=idcompete %>">旅游管理<i></i></a>
                		</div>
                		<div class="eqmar am-form ">
                			<div class="fbtitle">添加旅游<a class="fbadd">发布旅游信息</a></div>
                			<div class="fbli">
                				<div class="fblil"><label>旅游名称：</label></div><div class="fblir"><input id="Cname" runat="server" type="text" class="am-form-field am-radius fbftitle" placeholder="" style="width: 385px"></div>
                			</div>
                            <div class="fbli">
                                <div class="fblil"><label>排序：</label></div>
                                <div class="fblir">
                                    <input id="px" runat="server" type="text" class="am-form-field am-radius fb82"><label>按值大小排序</label>
                                </div>
                            </div>
                            <div class="fbli">
                                <div class="fblil"><label>上架时间：</label></div>
                                <div class="fblir">
                                    <input id="dRaceBegin" runat="server" name="dRaceBegin" type="text" style="width: 185px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'dRaceEnd\')}'})" class="am-form-field am-radius" />
                                -<input id="dRaceEnd" runat="server" name="dRaceEnd" type="text" style="width: 185px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'dRaceBegin\')}'})" class="am-form-field am-radius" />
                                </div>
                            </div>
                			<div class="fbli">
                				<div class="fblil"><label>每个ID最大购买数：</label></div>
                                <div class="fblir">
                                 <input type="text" runat="server" tabindex="4" id="iBuyMax" maxlength="9" class="am-form-field am-radius fb82" /></div>
                			</div>
                            <div class="fbli">
                                <div class="fblil"><label>链接：</label></div>
                                <div class="fblir">
                                    <input type="text" style="width: 385px" tabindex="1" id="cLink"  runat="server" maxlength="9" class="am-form-field am-radius fbftitle"/>
                                </div>
                            </div>
                            <div class="fbli">
                                <div class="fblil"><label>物品图片：</label></div>
                                <div class="fblir">
                                    <input type="file" class="input-large fileupload"><input type="hidden" id="hdtt" name="hdtt" runat="server"/>
                                     <label>图片大小1M以下，建议分辨500px*295px</label>
                                </div>
                            </div>
                            <div class="fbli">                                
                                        
                                    <%=port %>
                                                                
                                </div>
                            <div id="xm">

                            </div>
                            <div class="fbli">
                                <div class="fblil"><a href="javascript:void(0)" class="add-records">+添加景点</a><%--<asp:Button ID="Button1" runat="server"  class="fkbuttom" Text="添加款式" OnClick="Button1_Click" ></asp:Button>--%></div>
                            </div>
                			<div class="fbli">
                				<div class="fblil"><label>旅游介绍：</label></div>
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
                				<div class="fblil"><label>旅游特点：</label></div>
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
        $(".fileupload").change(function(){
         var data = new FormData(),
            sthis = $(this)
         $.each(sthis[0].files, function(i, file) {
             data.append('upload_file', file);
         });
         $.ajax({
             url:'/action/fileUp.ashx?name=Filedata',
             type:'POST',
             data:data,
             cache: false,
             contentType: false,
             processData: false,
             success:function(data){
                var data = data[0]
                if(data.status == 1){
                    sthis.next("input").val(data.url)
                    $(".toast").html(data.message).show().addClass('toast-success')
                        errorboxhide()

                }else{
                    $(".toast").html(data.message).show().addClass('toast-error')
                        errorboxhide()
                }
             }
         });
     });
        var num = 0;

        $(".add-records").click(function () {
           
            $("#xm").append("<div class=\"fbli\"><div class=\"fblil\"><label>类型：</label></div><div class=\"fblir\"><input type=\"text\" id=\"cColor" + num + "\" name=\"cColor" + num + "\" class=\"am-form-field am-radius fb82\"/><label>项目：</label><input type=\"text\" id=\"cSize" + num + "\" name=\"cSize" + num + "\" class=\"am-form-field am-radius fb82\"/><label>数量：</label><input id=\"iLimit" + num + "\" name=\"iLimit" + num + "\" type=\"text\" class=\"am-form-field am-radius fb82\"/></div></div><div class=\"fbli\"><div class=\"fblil\"><label>上架时间：</label></div><div class=\"fblir\"><input id=\"dRaceBegin" + num + "\"  name=\"dRaceBegin" + num + "\" type=\"text\" style=\"width: 185px\" onfocus=\"WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate:'%y-%M-#{%d}'})\" />-<input id=\"dRaceEnd" + num + "\"  name=\"dRaceEnd" + num + "\" type=\"text\" style=\"width: 185px\" onfocus=\"WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate:'%y-%M-#{%d}'})\" /></div></div>               <div class=\"fbli\"><div class=\"fblil\"><label>市场价：</label></div><div class=\"fblir\"><input type=\"text\" id=\"fMarketPrice" + num + "\" class=\"am-form-field am-radius fb82\" name=\"fMarketPrice" + num + "\"> 元（人民币）<label>现价：</label><input type=\"text\" id=\"fSellPrice" + num + "\" name=\"fSellPrice" + num + "\" class=\"am-form-field am-radius fb82\"> 元（人民币）</div></div>                   <div class=\"fbli\"><div class=\"fblil\"><label>使用积分：</label></div><div class=\"fblir\"><input name=\"iScore" + num + "\" type=\"text\" id=\"iScore" + num + "\" class=\"am-form-field am-radius fb82\" ><label>兑换:</label><input type=\"text\" id=\"iMoney" + num + "\" name=\"iMoney" + num + "\" class=\"am-form-field am-radius fb82\">元</div></div>                             <div class=\"fbli\"><div class=\"fblil\"><label>缩略图：</label></div><div class=\"fblir\"><img src=\"<%=portrait %>\" id=\"upimg" + num + "\" name=\"upimg" + num + "\"/><input type=\"file\" class=\"input-large fileupload\"><input type=\"hidden\" id=\"avatarurl" + num + "\" name=\"avatarurl" + num + "\" /></div></div>").find(".fileupload").change(function () {
         var data = new FormData(),
            sthis = $(this)
         $.each(sthis[0].files, function(i, file) {
             data.append('upload_file', file);
         });
         $.ajax({
             url:'/action/fileUp.ashx?name=Filedata',
             type:'POST',
             data:data,
             cache: false,
             contentType: false,
             processData: false,
             success:function(data){
                var data = data[0]
                if(data.status == 1){
                    sthis.next("input").val(data.url)
                    $(".toast").html(data.message).show().addClass('toast-success')
                        errorboxhide()

                }else{
                    $(".toast").html(data.message).show().addClass('toast-error')
                        errorboxhide()
                }
             }
         });
     });

                num++;
        });


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
<ERUN360:footerv3 runat="server" ID="footerv3" />