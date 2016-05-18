<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="zt_LeNy_index" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<link rel="stylesheet" type="text/css" href="css/db.css" />
<ERUN360:headerv3 runat="server" ID="headerv3" />
<div class="lebox">
    <div class="dtop">
        <img src="img/dtop.png">
    </div>
    <div class="videomin">  
    <div class="videobox">
        <iframe frameborder=0 src=http://www.lesports.com/topic/i/paobuhezuo/index.html></iframe>
    </div>
    <div class="cpright">内容来自乐视体育转播</div>
    </div>  
    <img src="img/dmlogo.png" class="dmlogo">
    <div class="dmsare">
东京马拉松每年春天在日本的首都东京举行，是国际田联认证的金标赛事，也是世界六大马拉松赛事之一。第一届东京马拉松是在2007年的2月18日进行的，追溯到2007年以前，东京马拉松实际上是由两个马拉松组成的--东京国际马拉松以及东京-纽约国际友谊马拉松。2007年的马拉松也是在大阪举行的田径世锦赛的选拔赛，总参赛人数为3万人，其中全程25000，10公里为5000人。东京马拉松赛是在市中心举行，在路线上，起点是东京都厅，终点为东京国际展示场。据说路线的寓意是从过去走向未来。跑者沿途会经过很多名胜，比如皇宫、东京铁塔、浅草、银座等。皇居是日本天皇居住的地方，也是东京市中心最大的一块绿地，而皇居前则是条护城河，种满了苍松翠柏，在蔚蓝天空的衬托下，显得壮观。

    </div>
    <img src="img/girlg.png" class="caiimg">
    <div class="timebox <%=status_2 %> <%=over %>" data-o="<%=quiz_2 %>">
        <!-- timeout -->
        <div class="cai <%=jf4_11 %>">
            <div class="ctime">2:20:00内</div>
            <div class="q">
                <i>竞猜积分</i>
                100<br>
                <i>获得积分</i>
                <em>1000</em>
            </div>
            <a href="javascript:void(0)" class="c" data-cid="1" data-t="2:20:00NEI" data-tokyo="woman">点击竞猜
            </a>
            <div class="tc">
                您参与的竞猜积分为:
                <br>
                <em><%=jf4_1 %></em>
                <i>参与成功！</i>
            </div>
        </div>
        <div class="cai <%=jf4_22 %>">
            <div class="ctime">2:20:00-2:25:00</div>
            <div class="q">
                <i>竞猜积分</i>
                100<br>
                <i>获得积分</i>
                <em>500</em>
            </div>
            <a href="javascript:void(0)" class="c" data-cid="2" data-t="2:20:00-2:25:00" data-tokyo="woman">点击竞猜
            </a>
            <div class="tc">
                您参与的竞猜积分为:
                <br>
                <em><%=jf4_2 %></em>
                <i>参与成功！</i>
            </div>
        </div>
        <div class="cai <%=jf4_33 %>">
            <div class="ctime">2:25:00-2:30:00</div>
            <div class="q">
                <i>竞猜积分</i>
                100<br>
                <i>获得积分</i>
                <em>200</em>
            </div>
            <a href="javascript:void(0)" class="c" data-cid="3" data-t="2:25:00-2:30:00" data-tokyo="woman">点击竞猜
            </a>
            <div class="tc">
                您参与的竞猜积分为:
                <br>
                <em><%=jf4_3 %></em>
                <i>参与成功！</i>
            </div>
        </div>
        <div class="cai <%=jf4_44 %>">
            <div class="ctime">2:30:00 外</div>
            <div class="q">
                <i>竞猜积分</i>
                100
                <br>
                <i>获得积分</i>
                <em>300</em>
            </div>
            <a href="javascript:void(0)" class="c" data-cid="4" data-t="2:30:00WAI" data-tokyo="woman">点击竞猜
            </a>
            <div class="tc">
                您参与的竞猜积分为:
                <br>
                <em><%=jf4_4 %></em>
                <i>参与成功！</i>
            </div>
        </div>

    </div>
    <img src="img/guog.png" class="caiimg">
    <div class="timebox <%=status_1 %> <%=over %>" data-o="<%=quiz_1 %>">
        <!-- timeout -->
        <div class="cai <%=jf3_11 %>">
            <div class="ctime">2:30:00内</div>
            <div class="q">
                <i>竞猜积分</i>
                100<br>
                <i>获得积分</i>
                <em>1000</em>
            </div>
            <a href="javascript:void(0)" class="c" data-cid="1" data-t="2:30:00NEI" data-tokyo="man">点击竞猜
            </a>
            <div class="tc">
                您参与的竞猜积分为:
                <br>
                <em><%=jf3_1 %></em>
                <i>参与成功！</i>
            </div>
        </div>
        <div class="cai <%=jf3_22 %>">
            <div class="ctime">2:30:00-2:50:00</div>
            <div class="q">
                <i>竞猜积分</i>
                100<br>
                <i>获得积分</i>
                <em>500</em>
            </div>
            <a href="javascript:void(0)" class="c" data-cid="2" data-t="2:30:00-2:50:00" data-tokyo="man">点击竞猜
            </a>
            <div class="tc">
                您参与的竞猜积分为:
                <br>
                <em><%=jf3_2 %></em>
                <i>参与成功！</i>
            </div>
        </div>
        <div class="cai <%=jf3_33 %>">
            <div class="ctime">2:50:00-3:10:00</div>
            <div class="q">
                <i>竞猜积分</i>
                100<br>
                <i>获得积分</i>
                <em>200</em>
            </div>
            <a href="javascript:void(0)" class="c" data-cid="3" data-t="2:50:00-3:10:00" data-tokyo="man">点击竞猜
            </a>
            <div class="tc">
                您参与的竞猜积分为:
                <br>
                <em><%=jf3_3 %></em>
                <i>参与成功！</i>
            </div>
        </div>
        <div class="cai <%=jf3_44 %>">
            <div class="ctime">3:10:00 外</div>
            <div class="q">
                <i>竞猜积分</i>
                100
                <br>
                <i>获得积分</i>
                <em>300</em>
            </div>
            <a href="javascript:void(0)" class="c" data-cid="4" data-t="3:10:00WAI" data-tokyo="man">点击竞猜
            </a>
            <div class="tc">
                您参与的竞猜积分为:
                <br>
                <em><%=jf3_4 %></em>
                <i>参与成功！</i>
            </div>
        </div>

    </div>
    <div class="result">
        <h3>2015纽约马拉松男子冠军成绩：2:10:55</h3>
        <asp:Literal ID="ltltesult" runat="server"></asp:Literal>            
    </div>
    <div class="dmgz">
        <span>竞猜规则</span>
        1、凡是益跑网注册用户，均可参与竞猜游戏。 <br>
        2、竞猜项目：东京马拉松完赛成绩竞猜。<br>
        3、当竞猜项目出现取消、中断、腰斩、提前或推迟等不可抗力因素时，竞猜也将取消，用户所竞猜的积分将全部返还。<br>
        4、竞猜结束后，将在7个工作日内结算竞猜积分。<br>
        5、停止受注时间为赛事开始前1小时截止。<br>
        6、一旦完成了投注操作，不能再进行修改与取消，所以操作请慎重。<br>
        7、网友务必保护好自己的帐号及密码，如出现帐号或密码被盗用，责任全部由网友自己承担。<br>
        8、 益跑网有权利随时更改游戏规则。本规则由益跑网制定，解释权、修改权归益跑网所有，益跑网有权修改游戏规则而无须事先通知。<br>
        9、竞猜结束后，我们将额外在两组获奖者中抽取一名幸运参赛者，奖品为乐视手机一部<br>
        益跑网积分规则（试）： <a href="http://www.erun360.com/blog/200016255.aspx">http://www.erun360.com/blog/200016255.aspx</a>
    </div>
<img src="img/bottom.png" class="dmimg">
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
var custom = function(){
    location.reload()
}
    var big = parseInt(<%=isout %>/100)*100,
        d = <%=uId%>,
			dt = '',
			t = '',
            tokyo = ''

	    $(".c").click(function(event) {
            var o = $(this).parents('.timebox').data("o")
	        if (o == 0) {
	            return false
	        };
	        dt = $(this).data('cid')
	        t = $(this).data('t')
            tokyo = $(this).data('tokyo')
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
	                url: '/action/Quiz.ashx',
	                type: 'get',
	                dataType: 'json',
	                data: {uid: d,idMin: dt,iAmount:$("#ub").val(),cMinName: t,op:"tokyo_"+tokyo},
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
<ERUN360:footerv3 runat="server" ID="footerv3" />