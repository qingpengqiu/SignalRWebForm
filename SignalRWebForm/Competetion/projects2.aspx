<%@ Page Language="C#" AutoEventWireup="true" CodeFile="projects2.aspx.cs" Inherits="Competetion_projects2" %>

<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Competetion/ICart.ascx" TagPrefix="ERUN360" TagName="ICart" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body {
        background: #f6f6f6;
    }
</style>
<link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
<script type="text/javascript" src="/Common/jCity.js"></script>
<script type="text/javascript" src="/Common/jCheck.js"></script>
<script type="text/javascript" src="/Html/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/assets/js/html5ImgCompress.min.js"></script>
<div class="banner">
    <div class="mine">
        <h1><%=title %></h1>
        <asp:literal id="ltlbanner" runat="server"></asp:literal>
    </div>
</div>
<div class="tbody">
    <div class="mine">
        <ERUN360:bmnav runat="server" ID="bmnav" />
        <div class="tbodyBox">
            <div class="event this clearfix">
                <form id="form2" runat="server">
                </form>
                <form id="form1">

                    <div class="bmtitle">
                        请完善个人信息 / 请确认个人信息：
                    </div>
                    <div class="bmtable clearfix">
                        <%=Result %>
                        <div>
                        </div>
                    </div>
                    <a id="projectpos" href="javascript:void(0)">提  交</a>
                    <%-- <input type="submit" name="projectpos" value="提  交" id="projectpos">--%>
                    <%-- <asp:Button ID="projectpos" runat="server" Text="提  交" />--%>
                    <!-- <div class="total">
                        <p><asp:Literal ID="ltlDetail" runat="server"></asp:Literal><br>
                            <asp:Literal ID="ltlTotal" runat="server"></asp:Literal>￥<asp:Literal ID="ltlfPrice" runat="server"></asp:Literal>元
                        </p>
                        <em><asp:Literal ID="ltlSelect" runat="server"></asp:Literal></em>
                    </div> -->
                    <div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<ERUN360:ICart runat="server" ID="ICart" />
<script>
$(".fileupload").change(function (e) {
    var formData = new FormData(),
        sthis = $(this)
    new html5ImgCompress(e.target.files[0], {
        before: function(file) {
          console.log('单张: 压缩前...');
        },
        done: function (file, base64) {
          console.log('单张: 压缩成功...');
          formData.append('upload_file', base64);
                $.ajax({
                    url: '/action/fileUp.ashx?id=<%=sid%>',
                     type: 'POST',
                     data: formData,
                     cache: false,
                     contentType: false,
                     processData: false,
                     success: function (data) {
                         var data = data[0]
                         if (data.status == 1) {
                             sthis.next("input").val(data.url)
                            tipbox(data.message,'success')
                         } else {
                            tipbox(data.message,'error')
                         }
                     }
                 });
        },
        fail: function(file) {
          console.log('单张: 压缩失败...');
        },
        complate: function(file) {
          console.log('单张: 压缩完成...');
        },
        notSupport: function(file) {
            tipbox('浏览器不支持！','error')
        }
    });

});
$("#projectpos").click(function (event) {
    $.ajax({
     url: '/action/EventService.ashx?op=tjdd&sid=<%=sid%>&p=<%=idItem%>&jf=<%=iFlag%>&jfz='+GetQueryString("jfz"),
        type: 'get',
        dataType: 'json',
        data: encodeURI($("#form1").serialize()),
        //data: { op: "OrderAdd", data:encodeURI($("#form1").serialize()), rnd: Math.random() },
        success: function (sdata) {
            if (sdata.status == "1") {
                //alert(sdata.msg)
                window.location.href = '/Competetion/OrderDetails.aspx?sid=<%=sid%>&nav=2&orderid=' + sdata.orderid;

                return false
            } else {
                $(".toast").html(sdata.msg).show().addClass('toast-error')
                errorboxhide()
            }
        }
    });
});
        jQuery(document).ready(function ($) {
            var fileimg = $("#fileurl").val()
            if (fileimg) {
                $("#idFJSC em").append('<a target="_blank" href="<%=HostInfo.imgName %>/Utility/uploads/' + fileimg + '">&nbsp;已上传&nbsp;<img src="/Html/images/img_icon.png"></a>')
            } else {
                $("#idFJSC .Validform_checktip").append("<a>请您上传体检证明或成绩证书 </a>")
            }
            var iCityid = '<% =iCity %>',
                iAreaid = '<% =iArea %>'
            if (iCityid == "") {
                iCityid = 1
            }
            if (iAreaid == "") {
                iAreaid = 1
            }
            $("#idCity").val(101)
            var iCity = parseInt(iCityid) - 1,
                iArea = parseInt(iAreaid)

            $("#cCityname").val(china[iCity][0] + china[iCity][iArea])
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
            // if (GetQueryString("idcompete") == "300000445") {
            //     loadjscssfile("/Html/css/racetnf.css", "css")
            //     $(".logo").replaceWith('<div class="tnflogo"><a href="/"><img src="/Html/images/tnflogo1.png"></a><a href="http://www.quyeba.com" target="_blank"><img src="/Html/images/tnflogo2.png"></a><a href="http://www.quyeba.com/tnf100/" target="_blank"><img src="/Html/images/tnflogo3.png"></a></div>')
            // }
        });
    function loadjscssfile(filename, filetype) {
        if (filetype == "js") { //判断文件类型 
            var fileref = document.createElement('script')//创建标签 
            fileref.setAttribute("type", "text/javascript")//定义属性type的值为text/javascript 
            fileref.setAttribute("src", filename)//文件的地址 
        }
        else if (filetype == "css") { //判断文件类型 
            var fileref = document.createElement("link")
            fileref.setAttribute("rel", "stylesheet")
            fileref.setAttribute("type", "text/css")
            fileref.setAttribute("href", filename)
        }
        if (typeof fileref != "undefined")
            document.getElementsByTagName("head")[0].appendChild(fileref)
    }
    //$("#address").focus(function (event) {
    //    $(this).css('width', '200px');
    //});
    $("#address").blur(function (event) {
        $(this).css('width', '100px');
    });
    $("#prependedDropdownButton").focus(function (event) {
        $(this).css('width', '170px');
    });
    $("#prependedDropdownButton").blur(function (event) {
        $(this).css('width', '118px');
    });
    var demo = $("#form1").Validform({
        tiptype: function (msg, o, cssctl) {
            if (!o.obj.is("form")) {
                var objtip = o.obj.nextAll(".Validform_checktip");
                cssctl(objtip, o.type);
                objtip.text(msg);
            }
        }
    });
    if (GetQueryString("la") == "cn") {
        demo.addRule([
            {
                ele: "#name",
                datatype: "s2-18",
                nullmsg: "请输入真实姓名!",
                errormsg: "至少6个字符,最多18个字符！"
            },
            {
                ele: "#mobile",
                datatype: "m",
                nullmsg: "请填写手机号码!",
                errormsg: "手机号码不正确"
            },
            {
                ele: "#email",
                datatype: "e",
                nullmsg: "请填写邮箱",
                errormsg: "邮箱地址格式不对!"
            },
            {
                ele: "#zipcode",
                datatype: "*",
                nullmsg: "请填邮编"
            },
            {
                ele: "#cNational",
                datatype: "*",
                nullmsg: "请填国籍"
            },
            {
                ele: "#emerger",
                datatype: "*",
                nullmsg: "请填写紧急联系人"
            },
            {
                ele: "#emermobile",
                datatype: "*",
                nullmsg: "请填写紧急联系电话"
            },
            {
                ele: "#prependedDropdownButton",
                datatype: "*",
                nullmsg: "证件号必填"
            },
            {
                ele: "#idgj",
                datatype: "*",
                nullmsg: "国籍必填"
            },
            {
                ele: "#address",
                datatype: "*",
                nullmsg: "详细地址必填"
            },
            {
                ele: "#ddlProvince",
                datatype: "*",
                nullmsg: "请选择地区"
            },
            {
                ele: "#ddlCity",
                datatype: "*",
                nullmsg: "请选择城市"
            },
            {
                ele: "#bzfield1",
                datatype: "*",
                nullmsg: "必填"
            }
            ,
            {
                ele: "#bzfield2",
                datatype: "*",
                nullmsg: "必填"
            }
             ,
            {
                ele: "#bzfield3",
                datatype: "*",
                nullmsg: "必填"
            },
            {
                ele: "#fileurl1",
                datatype: "*",
                nullmsg: "请您上传文件"
            }
            ,
            {
                ele: "#fileurl2",
                datatype: "*",
                nullmsg: "请您上传文件"
            }
             ,
            {
                ele: "#fileurl3",
                datatype: "*",
                nullmsg: "请您上传文件"
            },
            {
                ele: "#IdNo",
                datatype: "*",
                nullmsg: "请填写护照"
            },
            {
                ele: "#Placeofissue",
                datatype: "*",
                nullmsg: "请填写护照签发地点"
            },
            {
                ele: "#cMail",
                datatype: "*",
                nullmsg: "请填写邮箱"
            },
            {
                ele: "#cZipcode",
                datatype: "*",
                nullmsg: "请填写邮编"
            },
            {
                ele: "#cShoe",
                datatype: "*",
                nullmsg: "请填写鞋子尺码"
            }
        ]);
    } else {
        demo.addRule([
            {
                ele: "#name",
                datatype: "s2-18",
                nullmsg: "em!",
                errormsg: "至少6个字符,最多18个字符！",
                sucmsg: "Right"
            },
            {
                ele: "#mobile",
                datatype: "m",
                nullmsg: "请填写手机号码!",
                errormsg: "手机号码不正确",
                sucmsg: "Right"
            },
            {
                ele: "#email",
                datatype: "e",
                nullmsg: "请填写邮箱",
                errormsg: "邮箱地址格式不对!",
                sucmsg: "Right"
            },
            {
                ele: "#cNational",
                datatype: "*",
                nullmsg: "请填国籍"
            },
            {
                ele: "#zipcode",
                datatype: "*",
                nullmsg: "请填邮编",
                sucmsg: "Right"
            },
            {
                ele: "#emerger",
                datatype: "*",
                nullmsg: "请填写紧急联系人",
                sucmsg: "Right"
            },
            {
                ele: "#emermobile",
                datatype: "*",
                nullmsg: "请填写紧急联系电话",
                sucmsg: "Right"
            },
            {
                ele: "#prependedDropdownButton",
                datatype: "*",
                nullmsg: "证件号必填",
                sucmsg: "Right"
            },
            {
                ele: "#idgj",
                datatype: "*",
                nullmsg: "国籍必填",
                sucmsg: "Right"
            },
            {
                ele: "#address",
                datatype: "*",
                nullmsg: "详细地址必填",
                sucmsg: "Address Right"
            },
            {
                ele: "#ddlProvince",
                datatype: "*",
                nullmsg: "请选择地区",
                sucmsg: "Province Right"
            },
            {
                ele: "#ddlCity",
                datatype: "*",
                nullmsg: "请选择城市",
                sucmsg: "City Right"
            },
            {
                ele: "#bzfield1",
                datatype: "*",
                nullmsg: "必填"
            }
            ,
            {
                ele: "#bzfield2",
                datatype: "*",
                nullmsg: "必填"
            }
             ,
            {
                ele: "#bzfield3",
                datatype: "*",
                nullmsg: "必填"
            },
            {
                ele: "#fileurl1",
                datatype: "*",
                nullmsg: "请您上传文件"
            }
            ,
            {
                ele: "#fileurl2",
                datatype: "*",
                nullmsg: "请您上传文件"
            }
             ,
            {
                ele: "#fileurl3",
                datatype: "*",
                nullmsg: "请您上传文件"
            },
            {
                ele: "#IdNo",
                datatype: "*",
                nullmsg: "请填写护照"
            },
            {
                ele: "#Placeofissue",
                datatype: "*",
                nullmsg: "请填写护照签发地点"
            },
            {
                ele: "#cMail",
                datatype: "*",
                nullmsg: "请填写邮箱"
            },
            {
                ele: "#cZipcode",
                datatype: "*",
                nullmsg: "请填写邮编"
            },
            {
                ele: "#cShoe",
                datatype: "*",
                nullmsg: "请填写鞋子尺码"
            }
        ]);

        $('label[for="idBlood_4"]').html("Other")
        $('label[for="idgender_0"]').html("Male")
        $('label[for="idgender_1"]').html("Female")

        $('#ddlEducation option[value="0"]').html("Other")
        $('#ddlEducation option[value="1"]').html("junior college")
        $('#ddlEducation option[value="2"]').html("bachelor")
        $('#ddlEducation option[value="3"]').html("postgraduate")
        $('#ddlEducation option[value="4"]').html("Ph.D")
        $('#ddlEducation option[value="5"]').html("master")

        $('#ddlCard option[value="1"]').html("ID card")
        $('#ddlCard option[value="2"]').html("Military identification")
        $('#ddlCard option[value="3"]').html("Residence booklet")
        $('#ddlCard option[value="4"]').html("Passport")
        $('#ddlCard option[value="5"]').html("Other")
        $('#ddlProvince option[value=""]').html("Province")
        // $('#ddlCity option[value=""]').html("City")
    }

</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />
