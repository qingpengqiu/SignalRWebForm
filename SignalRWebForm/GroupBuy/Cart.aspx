<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Cart.aspx.cs" Inherits="GroupBuy_Cart" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><!DOCTYPE html>
<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title>团购-益跑网个人中心</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="/Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/user-more.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/themes.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/Group.css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/groupmedia.css" />
    <script type="text/javascript" src="../Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Html/js/modernizr.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="/Html/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/Html/js/bootstrap-validation.min.js"></script>
    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js?appkey=" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/Html/js/swfobject.js"></script>
    <script type="text/javascript" src="/Html/js/fullAvatarEditor.js"></script>
    <script type="text/javascript" src="../Common/jCity.js"></script>
    <script src="../Common/jCheck.js"></script>
    <script src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <style>
        .main-left ul .user-dq {
            filter: alpha(Opacity=100);
            -moz-opacity: 1;
            opacity: 1;
        }
    </style>
    <!--[if lte IE 9]>
<link rel="stylesheet" type="text/css" href="js/IE9.js"/>
<![endif]-->
</head>
<body>
    <form id="form1" runat="server">
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="wrap">
        <article>
            <div class="buylc">
                购买<span>仅三步</span>
                <div class="lc"></div>
            </div>
            <div class="sbox">
                <div class="sboxtable">
                    <div class="sboxtr">
                        <div class="sboxth">团购商品</div>
                        <div class="sboxth">颜色/大小</div>
                        <div class="sboxth">数量</div>
                        <div class="sboxth">单价</div>
                        <div class="sboxth">总价</div>
                    </div>
                    <div class="sboxtr">
                        <div class="sboxtd" id="imgtile"><img src="" alt=""></div>
                        <div class="sboxtd"><select name="colorsize" id="colorsize"></select></div>
                        <div class="sboxtd"><a href="javascript:void(0);" class="datajian">-</a><input type="text" id="datanum" value="1" class="data"><a href="javascript:void(0);" class="datajia">+</a></div>
                        <div class="sboxtd" id="price">单价</div>
                        <div class="sboxtd" id="allprice">总价</div>
                    </div>
                </div>
                <div class="allm">
                  <input type="checkbox" id="UseIntegral"> <label for="UseIntegral">您有<span id="TotalScore">0</span>积分,可使用<span id="Score">0</span>积分 抵扣<span id="Money">0</span>元</label>
                  <div class="intError">当前积分不足以抵扣，<a target="_blank" href="/blog/200016255.aspx">点击查看积分来源</a></div>
                </div>
                <%=Ishow%>
                <div class="sboxt" id="idsboxt" runat="server">
                    <a  href="#address" class="otheradd">使用其它地址</a>收货地址
                </div>
                <div class="address" id="idaddress" runat="server" data-idaddress="on">
                    
                </div>
                <div class="sboxt">
                    备注
                </div>
                <textarea maxlength="256"  cols="70" rows="3" class="contbox" id="contbox"></textarea>
            </div>
            <div class="tobuy"><span></span></div>
            <div style="display:none">
                <div id="address">
                    <table>
                        <tr><td><span>*</span>所在地区:</td><td><select name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)" runat="server"></select>
                        <select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)" runat="server">
                        </select>
                        <script type="text/javascript">
                            BindProvince("北京");
                        </script>
                        <input type="text" id="idCity" name="idCity" size="5" readonly value="0" runat="server">
                        <input type="text" id="cCityname" name="cCityname" size="15" readonly value="" runat="server">
                        <input type="hidden" runat="server" id="UpdatedFields" name="UpdatedFields" value=""></td>
                        </tr>
                        <tr><td><span>*</span>街道地址:</td><td><input type="text" class="addm" id="newaddress"></td></tr>
                        <tr><td><span>*</span>邮政编码:</td><td><input type="text" id="newzipcode"></td>
                        </tr>
                        <tr><td><span>*</span>收货人姓名:</td><td><input type="text" id="newname"></td></tr>
                        <tr><td><span>*</span>电话号码:</td><td><input type="text" id="newtel"></td>
                        </tr>
                    </table>
                    <a class="Sadd">保存</a>
                </div>
            </div>  
        </article> 
    </div>
    <script>

    var Result = <%=Result%>
    if(Result == 'nologin'){
        PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();
    }
    var colorsize = '',
        colorarray = new Array(),
        Quantity= Result[0].Quantity,
        overage = Result[0].Reserve[0].overage,
        buynum = 1,
        Score = Result[0].Score,
        TotalScore = Result[0].TotalScore,
        Mnoeyon = Result[0].Money,
        Money = 0,
        idCity = Result[0].idCity,
        newaddress = Result[0].Address,
        newzipcode = Result[0].Zipcode,
        newname = Result[0].Name,
        newtel = Result[0].Mobile,
        isAddress = 0,
        Cityname = ''
        jQuery(document).ready(function($) {
            if(Result[0].Reserve[0].cImage){
                $("#imgtile").html('<img src="'+Result[0].Reserve[0].cImage+'" alt=""><em>'+Result[0].Title+'</em>')
            }else{
                $("#imgtile").html('<img src="'+Result[0].Image+'" alt="">'+Result[0].Title)
            }
            $.each(Result[0].Reserve, function(i, v) {
                    colorsize += '<option value="'+v.id+'">'+v.cColor+'/'+v.cSize+'</option>'
                    colorarray.push(v.id.toString())
                });
            $("#colorsize").html(colorsize)
            ChangePrice(buynum,Result[0].Price,Money)
            $("#TotalScore").html(TotalScore)
            $("#Score").html(Score)
            $("#Money").html(Mnoeyon)
            if(Result[0].type == 1){
                $(".allm").hide()
            }
            if(Result[0].fScore == 1){
                if(TotalScore<Score){
                    $("#UseIntegral").attr('disabled', 'true').removeAttr('checked');
                    $(".intError").show()
                }
            }else{
                $("#UseIntegral").attr('disabled', 'true').removeAttr('checked');
            }
            $(".address").html(Result[0].Cityname+newaddress+' '+newzipcode+' ( '+newname+'收 ) '+newtel)
            $("#contbox").html(Result[0].Mark)
        });
        $(".otheradd").colorbox({inline:true, width:"50%", opacity: "0.4"});
        $(document).on('keyup', '#datanum', function(event) {
            var tmptxt=$(this).val();
            $(this).val(tmptxt.replace(/\D|^0/g,'')).on('paste', function(event) {
                $(this).val(tmptxt.replace(/\D|^0/g,'')).css("ime-mode", "disabled");
            });
            if($(this).val() > overage) {
                $(this).val(overage)
                tmptxt = overage
            }else if(!$(this).val()){
                tmptxt = 1
            };
            buynum = tmptxt
             ChangePrice(buynum,Result[0].Price,Money)
        });
        $(document).on("click",".thumblist img",function(){
                var src= $(this).attr('src');
                $(this).addClass('this').siblings().removeClass('this')
                $("#thumbtg").attr('src',src);
        });
        $(".datajian").on('click', function(event) {
            if (buynum > 1) {
                buynum --
            };
            $('#datanum').val(buynum)
            ChangePrice(buynum,Result[0].Price,Money)
        });
        $(".datajia").on('click', function(event) {
            if (buynum < Quantity && buynum < overage) {
                buynum ++
            };
            $('#datanum').val(buynum)
            ChangePrice(buynum,Result[0].Price,Money)
        });
        $("#UseIntegral").change(function(event) {
            if ($("#UseIntegral:checked").val()?1:0 == 1){
                Money = Mnoeyon
                ChangePrice(buynum,Result[0].Price,Money)
            }else{
                Money = 0
                ChangePrice(buynum,Result[0].Price,Money)
            }
        });
        $("#colorsize").change(function(event) {
            var ii =$(this).val()
            var i = colorarray.indexOf(ii)
            overage = Result[0].Reserve[i].overage
            if(overage == 0){
                alert('该颜色商品已售光')
                return false
            }

            if(buynum>overage){
                buynum = overage
            }
            ChangePrice(buynum,Result[0].Price,Money)
            if(Result[0].Reserve[i].cImage){
                $('#imgtile img').attr('src',Result[0].Reserve[i].cImage );
            }
        });
        $(".Sadd").click(function(event) {
            idCity = $('#idCity').val(),
            newaddress = $('#newaddress').val(),
            newzipcode = $('#newzipcode').val(),
            newname = $('#newname').val(),
            newtel = $('#newtel').val()
            Cityname = $("#ddlProvince").val()+$("#ddlCity").val()
            var telReg = /^1\d{10}$/; 
            var zipReg =/^[a-zA-Z0-9 ]{3,12}$/

            if(Cityname == 'null'){
                showTips('请选择省份城市~');
            }else if(newaddress ==''){
                showTips('街道地址必填~');
            }else if(!zipReg.test(newzipcode)){
                showTips('邮政编码错咯~');
            }else if(newname == ''){
                showTips('姓名必填~');
            }else if(!telReg.test(newtel)){
                    showTips('手机号错咯~');
            }else{
                showTips('修改成功~ 继续填写',2500,1);
                $(".address").html($("#ddlProvince").val()+$("#ddlCity").val()+newaddress+' '+newzipcode+' ( '+newname+'收 ) '+newtel)
                isAddress = 1
                setTimeout(function(){ $.colorbox.close(); },1510);
            }
        });
//显示提示框，目前三个参数(txt：要显示的文本；time：自动关闭的时间（不设置的话默认1500毫秒）；status：默认0为错误提示，1为正确提示；)
        function showTips(txt,time,status)
        {
            var htmlCon = '';
            if(txt != ''){
                if(status != 0 && status != undefined){
                    htmlCon = '<div class="tipsBoxtop tipsBoxok"><img src="/Html/images/ok.png"/>'+txt+'</div>';
                }else{
                    htmlCon = '<div class="tipsBoxtop tipsBoxterr"><img src="/Html/images/err.png"/>'+txt+'</div>';
                }
                $('#address').prepend(htmlCon);
                if(time == '' || time == undefined){
                    time = 1500; 
                }
                setTimeout(function(){ $('.tipsBoxtop').remove(); },time);
            }
        }

        function ChangePrice(num,price,Money){
            var payprice = (num*price-Money).toFixed(2)
            $('#allprice').html('&yen;'+payprice)
            $(".paym span").html(payprice)
            $("#price").html(price)
            $("#datanum").val(num)
        }
        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
            }
        $(".tobuy").click(function(event) {
            $(".tobuy span").html('')
            if($("#idaddress").data('idaddress')){
                if(!$("#idaddress").html()){
                    $(".tobuy span").html('请填写收货地址')
                    return false
                }
            }else{
            }

            var fScore = $("#UseIntegral").attr("checked")?1:0
            $.post("/action/AjaxTour.ashx",{m:'SubmitTour',idGood:GetQueryString('id'),idReserve:$("#colorsize").val(),iNum:$("#datanum").val(),fScore:$("#UseIntegral:checked").val()?1:0,isAddress:isAddress,idCity:idCity,Cityname:Cityname,newaddress:newaddress,newzipcode:newzipcode,newname:newname,newtel:newtel,contbox:$("#contbox").val()},function(data){
                        var dielog
                        if(data.length > 3){
                            location.href="GetOrderInfo.aspx?idorder="+data
                        }else{
                            switch(data){
                                case '0':
                                dielog = '失败'
                                break;
                                case '-1':
                                dielog = '未登录'
                                PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();
                                break;
                                case '-2':
                                dielog = '商品不存在'
                                break;
                                case '-3':
                                dielog = '库存不存在'
                                break;
                                case '-4':
                                dielog = '超出用户最大限额'
                                break;
                                case '-5':
                                dielog = '团购价格不存在'
                                break;
                                case '-6':
                                dielog = '不是拼团'
                                break;
                                case '-7':
                                dielog = '积分使用不相符'
                                break;
                                case '-8':
                                    dielog = '请填写收货地址'
                                break;
                                case '-9':
                                dielog = '您选购的商品卖光了'
                                break;
                                case '-10':
                                dielog = '该商品不数量不足'
                                break;
                                case '-11':
                                dielog = '商品类型不匹配'
                                break;
                                case '-12':
                                dielog = '积分不足'
                                break;
                                case '-13':
                                dielog = '兑换劵已售完'
                                break;

                            }
                            $(".tobuy span").html(dielog)
                        }
                      },'text');
        });
    </script>
         </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>