<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ICart.aspx.cs" Inherits="GroupBuy_ICart" %>
<%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<!DOCTYPE html>
<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title>���ֶһ�-��������������</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="../Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/user-more.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/themes.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/Group.css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../Common/jCalendar.js"></script>
    <script type="text/javascript" src="../Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../Html/js/modernizr.js"></script>
    <script type="text/javascript" src="../Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="../Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="../Html/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../Html/js/bootstrap-validation.min.js"></script>
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
        .sbox .sboxtr .sboxth:last-child{width: 302px;}
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
                ����<span>������</span>
                <div class="lc lc3"></div>  
            </div>
            <div class="sbox">
                <div class="sboxtable">
                    <div class="sboxtr"><div class="sboxth">�һ���Ʒ</div><div class="sboxth">��ɫ/��С</div><div class="sboxth">����</div></div>
                    <div class="sboxtr"><div class="sboxtd" id="imgtile"><img src="http://119.2.5.59:8081/utility/uploads/2014/06/24/100000002_111755120.jpg" alt="">adidas  boston3</div><div class="sboxtd"><select name="colorsize" id="colorsize" ></select></div><div class="sboxtd"><input type="text" id="datanum" value="1" class="data" disabled></div></div>
                </div>
                <div class="paym">
                      ����Ҫ֧����<em></em>����
                  </div>
                <div class="sboxt addtit" id="idsboxt" runat="server">
                    <a  href="#address" class="otheradd">ʹ��������ַ</a>�ջ���ַ
                </div>
                <div class="address" id="idaddress" runat="server">
                    
                </div>
                <div class="sboxt">
                    ��ע
                </div>
                <textarea maxlength="256"  cols="70" rows="3" class="contbox" id="contbox"></textarea>
            </div>
            <div class="tobuy"><span></span></div>
            <div style="display:none">
                <div id="address">
                    <table>
                        <tr><td><span>*</span>���ڵ���:</td><td><select name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)" runat="server"></select>
                        <select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)" runat="server">
                        </select>
                        <script type="text/javascript">
                            BindProvince("����");
                        </script>
                        <input type="text" id="idCity" name="idCity" size="5" readonly value="0" runat="server">
                        <input type="text" id="cCityname" name="cCityname" size="15" readonly value="" runat="server">
                        <input type="hidden" runat="server" id="UpdatedFields" name="UpdatedFields" value=""></td>
                        </tr>
                        <tr><td><span>*</span>�ֵ���ַ:</td><td><input type="text" class="addm" id="newaddress"></td></tr>
                        <tr><td><span>*</span>��������:</td><td><input type="text" id="newzipcode"></td>
                        </tr>
                        <tr><td><span>*</span>�ջ�������:</td><td><input type="text" id="newname"></td></tr>
                        <tr><td><span>*</span>�绰����:</td><td><input type="text" id="newtel"></td>
                        </tr>
                    </table>
                    <a class="Sadd">����</a>
                </div>
            </div>  
        </article> 
    </div>
    <script>

        var Result = <%=Result%>
        if(Result == 'nologin'){
            PopupShowdl(520,305,'��¼','/utility/include/login.aspx');StatusCheck();
        }
        var colorsize = '',
            Quantity= 1,
            overage = Result[0].Reserve[0].overage,
            buynum = 1,
            Score = Result[0].Score,
            TotalScore = Result[0].TotalScore,
            price = Result[0].SellPrice,
            idCity = Result[0].idCity,
            newaddress = Result[0].Address,
            newzipcode = Result[0].Zipcode,
            newname = Result[0].Name,
            newtel = Result[0].Mobile,
            isAddress = 0,
            Cityname = ''
        jQuery(document).ready(function($) {
            if(Result[0].Entity==0){
                $(".addtit").hide();
                $(".address").hide()
            }
            $("#imgtile").html('<img src="'+Result[0].Reserve[0].cImage+'" alt="">'+Result[0].Title)
            $.each(Result[0].Reserve, function(i, v) {
                colorsize += '<option value="'+v.id+'">'+v.cColor+'/'+v.cSize+'</option>'
            });
            $("#colorsize").html(colorsize)
            ChangePrice(buynum,Result[0].SellPrice)
            $(".paym em").html(Result[0].Score)
            $("#TotalScore").html(TotalScore)
            $("#Score").html(Score)
            $(".address").html(Result[0].Cityname+newaddress+' '+newzipcode+' ( '+newname+'�� ) '+newtel)
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
            ChangePrice(buynum,Result[0].Price)
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
            ChangePrice(buynum,Result[0].Price)
        });
        $(".datajia").on('click', function(event) {
            if (buynum < Quantity && buynum < overage) {
                buynum ++
            };
            $('#datanum').val(buynum)
            ChangePrice(buynum,Result[0].Price)
        });
        $("#colorsize").change(function(event) {
            var i = $(this).val()-1
            console.log(i)
            overage = Result[0].Reserve[i].overage
            if(buynum>overage){
                buynum = overage
            }
            ChangePrice(buynum,Result[0].Price)
            $('#imgtile img').attr('src',Result[0].Reserve[i].cImage );
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
                showTips('��ѡ��ʡ�ݳ���~');
            }else if(newaddress ==''){
                showTips('�ֵ���ַ����~');
            }else if(!zipReg.test(newzipcode)){
                showTips('���������~');
            }else if(newname == ''){
                showTips('��������~');
            }else if(!telReg.test(newtel)){
                showTips('�ֻ��Ŵ�~');
            }else{
                showTips('�޸ĳɹ�~ ������д',2500,1);
                $(".address").html($("#ddlProvince").val()+$("#ddlCity").val()+newaddress+' '+newzipcode+' ( '+newname+'�� ) '+newtel)
                isAddress = 1
                setTimeout(function(){ $.colorbox.close(); },1510);
            }
        });
        //��ʾ��ʾ��Ŀǰ��������(txt��Ҫ��ʾ���ı���time���Զ��رյ�ʱ�䣨�����õĻ�Ĭ��1500���룩��status��Ĭ��0Ϊ������ʾ��1Ϊ��ȷ��ʾ��)
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

        function ChangePrice(num,price){
            if(price > 0)
            $(".paym").append('��<span>'+price+'</span>Ԫ')
            $("#datanum").val(num)
        }
        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
        $(".tobuy").click(function(event) {
            $(".tobuy span").html('')
            $.post("/action/AjaxTour.ashx",{m:'Submit',idGood:GetQueryString('id'),idReserve:$("#colorsize").val(),iNum:$("#datanum").val(),isAddress:isAddress,idCity:idCity,Cityname:Cityname,newaddress:newaddress,newzipcode:newzipcode,newname:newname,newtel:newtel,contbox:$("#contbox").val()},function(data){
                var dielog
                if(data.length > 3){
                    location.href="IOrder.aspx?idorder="+data
                }else{
                    switch(data){
                        case '0':
                            dielog = 'ʧ��'
                            break;
                        case '-1':
                            dielog = 'δ��¼'
                            PopupShowdl(520,305,'��¼','/utility/include/login.aspx');StatusCheck();
                            break;
                        case '-2':
                            dielog = '��Ʒ������'
                            break;
                        case '-3':
                            dielog = '��治����'
                            break;
                        case '-4':
                            dielog = '�����û�����޶�'
                            break;
                        case '-5':
                            dielog = '���ֶһ��۸񲻴���'
                            break;
                        case '-6':
                            dielog = '���ǻ��ֶһ�'
                            break;
                        case '-7':
                            dielog = '����ʹ�ò����'
                            break;
                        case '-8':
                            dielog = '<a href=\"/infocenter/Account.aspx?uId=<%=cidUser%>&page=1\">���������ĸ�����Ϣ</a>'
                            break;
                        case '-9':
                                dielog = '������'
                                break;
                        case '-10':
                                dielog = '����Ʒ����������'
                                break;
                        case '-11':
                                dielog = '��Ʒ���Ͳ�ƥ��'
                                break;
                        case '-12':
                                dielog = '���ֲ���'
                                break;
                        case '-13':
                            dielog = '�һ���������'
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