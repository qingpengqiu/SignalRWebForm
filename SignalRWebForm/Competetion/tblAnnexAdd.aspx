<%@ Page Language="C#" AutoEventWireup="true" CodeFile="tblAnnexAdd.aspx.cs" Inherits="Competetion_tblAnnexAdd" %>
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
                			<a class="eqmaa eqmajd" href="tblAnnex.aspx?sid=<%=sid %>">���������<i></i></a>
                		</div>
                		<div class="eqmar am-form ">
                                <div class="fbtitle">��Ӹ�����
                			<div class="fbli">
                				<div class="fblil"><label>��Ʒ���ƣ�</label></div>
                                <div class="fblir"><input  id="Cname" type="text" class="am-form-field am-radius" placeholder="" runat="server" style="width: 200px;"></div>
                			</div>
                                     <div class="fbli">
                                <div class="fblil"><label>�ϼ�ʱ�䣺</label></div>
                                <div class="fblir">
                                <input id="dRaceBegin" runat="server" class="am-form-field am-radius fb82" style="width: 185px" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'dRaceEnd\')}'})"/>
                                -
                                <input id="dRaceEnd" runat="server" class="am-form-field am-radius fb82" style="width: 185px" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'dRaceBegin\')}'})"/></div>
                            </div>
                                <div class="fbli">
                                    <div class="fblil"><label>��Ʒ������</label></div>
                                    <div class="fblir">
                                        <input  id="fBuyPrice" type="text" class="am-form-field am-radius fbftitle" placeholder="" runat="server" style="width: 200px;">
                                    </div>
                                </div>
                                <div class="fbli">
                                    <div class="fblil"><label>��Ʒ���ۣ�</label></div>
                                    <div class="fblir">
                                        <input  id="Text1" type="text" class="am-form-field am-radius fbftitle" placeholder="" runat="server" style="width: 200px;">
                                    </div>
                                </div>
                                    <div class="fbli">
                                    <div class="fblil"><label>�޹�������</label></div>
                                    <div class="fblir">
                                        <input  id="Text2" type="text" class="am-form-field am-radius fbftitle" placeholder="" runat="server" style="width: 200px;">
                                    </div>
                                </div>
                                <div class="fbli">
                                    <div class="fblil"><label>���ӣ�</label></div>
                                    <div class="fblir">
                                        <input  id="cLink" type="text" class="am-form-field am-radius fbftitle" placeholder="" runat="server" style="width: 200px;">
                                    </div>
                                </div>
                                <div class="fbli">
                                    <div class="fblil"><label>����ͼ��</label></div>
                                    <div class="fblir">
                                        <label for="hoteleditimg"><img src="<%=portrait %>" class="hoteloldimg"/></label><input type="file" class="input-large fileupload" id="hoteleditimg" style="display:none">
                                        <input type="hidden" runat="server" id="avatarurl" /><br>
                                    </div>
                                </div>
                                <div class="fbli">
                				<div class="fblil"><label>״̬��</label></div>
                				<div class="fblir">
                					<select id="iState" runat="server" tabindex="12"  style="width: 200px;"> 
                                        <option value="2">����</option>
                                <option value="1">��ͣ</option>
                                <option value="0">����</option>
                                <option value="-1">ɾ��</option>
                            </select>
                				</div>
                			</div>
                            <div class="savefb">
                			<asp:Button ID="but_save" runat="server"   class="fkbuttom" Text="����" OnClick="but_save_Click" ></asp:Button>
                            </div>
                        </div>
                	</div>
                </div>
            </div>
        </div>
    </div>
    <div style="display:none"><div id="tips" ></div></div>
        </form>
    <div style="display: none">
        <div id="thumb">
            <p id="swfContainer">
                �������Ҫ��װFlash Player��ſ�ʹ�ã����<a href="http://www.adobe.com/go/getflashplayer">����</a>���ذ�װ��
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
                    $(".hoteloldimg").attr('src', data.url);
                    $(".toast").html(data.message).show().addClass('toast-success')
                        errorboxhide()

                }else{
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
<ERUN360:footerv3 runat="server" ID="footerv3" />