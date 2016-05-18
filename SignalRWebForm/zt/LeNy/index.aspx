<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="zt_LeNy_index" %>

<%@ Register Src="~/Competetion/headerv2.ascx" TagPrefix="ERUN360" TagName="headerv2" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>益跑乐视纽约马拉松竞猜赢手机</title>
    <meta name="keywords" content="益跑乐视纽约马拉松竞猜赢手机" />
    <meta name="description" content="益跑乐视纽约马拉松竞猜赢手机" />
    <link rel="stylesheet" href="/Html/css/marathon.css">
    <link rel="stylesheet" type="text/css" href="css/db.css" />
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
</head>
<body>
    <ERUN360:headerv2 runat="server" ID="headerv2" />
    <div class="lebox">
        <div class="indecen">
            <div class="letop">
                <a class="lelogo">
                    <img src="img/lelogo.png"></a>
                <div class="zbtime">转播时间：北京时间11月1日晚22点10分</div>
                <div class="cde">所有参加竞猜并猜对选项的跑友均可获得乐视免费会员1个月并有机会参与乐视超级手机抽奖。</div>
            </div>
            <div class="videobox">
                <iframe width=900  height=500  frameborder=0 src=http://minisite.letv.com/tuiguang/index.shtml?islive=1&pid=1020151029111141></iframe>
            </div>
            <div class="cpright">内容来自乐视体育转播</div>
            <div class="nys">
                <span>纽约<i>马拉松</i></span>
                作者：本次乐视特邀主持——北京奥运会、北京田径世锦赛鸟巢现场解说——陈晨 <br>
                作为每年世界六大马拉松满贯赛事的最后一站，也作为两年一度的马拉松满贯积分的重要一站，同时也是世界参赛人数最多的马拉松赛事，每年都吸引世界各大顶尖高手前来，被看作为赛季之末再决胜负的关键一役。
                <br>
                进入2000年以来，绝大部分年份的纽马的夺冠主题，都是肯尼亚与埃塞俄比亚的两强对决，今年也不例外。
                <br>
                男子方面，群雄混战。埃塞俄比亚由2013莫斯科世锦赛银牌得主、当年迪拜马拉松冠军德西萨（Lelisa Desisa），搭配北京世锦赛新科马拉松亚军特萨盖（Lelisa Desisa）两位大赛型选手出马。肯尼亚一方，则不仅实力更胜一筹、并且数量占优。由前世界纪录保持者、去年纽约马拉松冠军、两届伦敦马拉松冠军威尔逊·吉普桑（Wilson Kipsang）领衔，辅以2015新科世界越野锦标赛冠军、北京世锦赛男子万米银牌得主卡姆沃罗（Geoffrey Kamworor），以及2012巴黎马拉松冠军、赛会纪录保持者比沃特（Stanley Biwott），组成铁三角。构成三雄与两强的对撞。
冠的图法（Tigist Tufa）挑起重担。两个月前北京世锦赛女子马拉松赛场上，同胞马勒·迪巴巴一人秒杀肯尼亚三大高手的壮举还会上演么？
一起期待11月1日晚，2015世界马拉松六大满贯终章之战！

            </div>
            <div class="timebox <%=str %> <%=over %>" data-o="<%=js %>">
                <!-- timeout -->
                <div class="cai <%=jf11 %>">
                    <div class="q">
                        <i>竞猜积分</i>
                        100<br>
                        <i>获得积分</i>
                        <em>1000</em>
                    </div>
                    <a href="javascript:void(0)" class="c" data-cid="1" data-t="2:02:NEI">点击竞猜
                    </a>
                    <div class="tc">
                        您参与的竞猜积分为:
                        <br>
                        <em><%=jf1 %></em>
                        <i>参与成功！</i>
                    </div>
                </div>
                <div class="cai <%=jf22 %>">
                    <div class="q">
                        <i>竞猜积分</i>
                        100<br>
                        <i>获得积分</i>
                        <em>500</em>
                    </div>
                    <a href="javascript:void(0)" class="c" data-cid="2" data-t="2:02:57-2:08:00">点击竞猜
                    </a>
                    <div class="tc">
                        您参与的竞猜积分为:
                        <br>
                        <em><%=jf2 %></em>
                        <i>参与成功！</i>
                    </div>
                </div>
                <div class="cai <%=jf33 %>">
                    <div class="q">
                        <i>竞猜积分</i>
                        100<br>
                        <i>获得积分</i>
                        <em>200</em>
                    </div>
                    <a href="javascript:void(0)" class="c" data-cid="3" data-t="2:08:00-2:13:00">点击竞猜
                    </a>
                    <div class="tc">
                        您参与的竞猜积分为:
                        <br>
                        <em><%=jf3 %></em>
                        <i>参与成功！</i>
                    </div>
                </div>
                <div class="cai <%=jf44 %>">
                    <div class="q">
                        <i>竞猜积分</i>
                        100
                        <br>
                        <i>获得积分</i>
                        <em>300</em>
                    </div>
                    <a href="javascript:void(0)" class="c" data-cid="4" data-t="2:13:00WAI">点击竞猜
                    </a>
                    <div class="tc">
                        您参与的竞猜积分为:
                        <br>
                        <em><%=jf4 %></em>
                        <i>参与成功！</i>
                    </div>
                </div>

            </div>
            <div class="result">
                <h3>2015纽约马拉松男子冠军成绩：2:10:55</h3>
                <asp:Literal ID="ltltesult" runat="server"></asp:Literal>            
            </div>

        </div>
        <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    </div>
    <div class="jbg"></div>
    <div class="jbox">
        <div class="x">x</div>
        您最多可使用<%=isout %>积分
        <br>
        请您输入参与竞猜的积分
			<div class="ci">
                <i data-d="0">-</i>
                <input type="text" value="100" name="cb" id="ub">
                <i data-d="1">+</i>
            </div>
        <span>本竞猜100积分起，整百递进，2000积分封顶</span>
        <a href="javascript:void(0)" class="cb">确认</a>
    </div>
    <script type="text/javascript">
        var big = parseInt(<%=isout %>/100)*100,
            d = <%=uId%>,
				dt = '',
				t = ''

		    $(".c").click(function(event) {
		        if ($(".timebox").data("o") == 0) {
		            return false
		        };
		        dt = $(this).data('cid')
		        t = $(this).data('t')
		        if (d == 0) {
		            PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();
		            return false
		        }
		        $(".jbg").show()
		        $(".jbox").show()
		    });
		    $(".x,.jbg").click(function(event) {
		        $(".jbg").hide()
		        $(".jbox").hide()
		    });
		    $(".ci i").click(function(event) {
		        var d = $(this).data('d'),
					v = $("#ub").val()
		        if (d == 0) {
		            if (v <= 100) {
		                alert("最小竞猜为100")
		                $("#ub").val(100)
		                return false
		            };
		            $("#ub").val(eval(v-100))
		        }else{
		            if (v >= big) {
		                alert("您最多使用"+big+"积分竞猜")
		                $("#ub").val(big)
		                return false
		            };
		            $("#ub").val(eval(v-0+100))
		        }
				
		    });
		    $(".cb").click(function(event) {
		        var ub = $("#ub").val(),
					v = $("#ub").val()
		        if(ub < 100){
		            alert("最少使用100积分参与竞猜")
		            $("#ub").val(100)
		            return false
		        }else if(ub>big){
		            alert("您最多使用"+big+"积分竞猜")
		            $("#ub").val(big)
		            return false
		        }else if(ub%100 != 0) {
		            alert("竞猜金币必须为100的倍数")
		            $("#ub").val(parseInt(v/100)*100)
		            return false
		        }else{
		            $.ajax({
		                url: '/action/Quiz.ashx?op=letv',
		                type: 'get',
		                dataType: 'json',
		                data: {uid: d,idMin: dt,iAmount:$("#ub").val(),cMinName: t},
		                success:function(d){
		                    if (d.status == 1) {
		                        alert("提交成功，请等待竞猜结果	")
		                    }else if(d.status == -1){
		                        PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();
		                    }else {
		                        alert(d.msg)
		                    }
		                    location.reload()
		                    // setTimeout(function(){
		                    // 	location.reload()
		                    // }, 3000)
		                }
		            })
					
		        }
		    });
    </script>
</body>
</html>

