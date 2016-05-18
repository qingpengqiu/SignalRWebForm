<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MessageBox.aspx.cs" Inherits="infocenter_MessageBox" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<script type="text/javascript" src="/Html/js/jquery.emotions.js"></script>
<script type="text/javascript" src="../Html/js/jquery.pagination.js"></script>

<article>
    <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
    <div class="main-right">
        <div class="blog">
            <div class="equip">
                <span class="equip-ous">留言</span>
            </div>
            <div class="blog-content l-message">
                <h4><%=strMsg %></h4>
                <div class="blogComment">
                    <div class="faceimg"></div>
                    <textarea name="mContent" id="mContent"></textarea>
                    <button class="discussSubmit" onclick="sub()">提交</button>
                </div>
                <ul class="friend-message-list">
                </ul>
                <div class="pages" id="Pagination">
                </div>
            </div>
        </div>
    </div>
</article>
<script type="text/javascript">
var mea = ['','微笑','憨笑','调皮','惊讶','耍酷','发火','呵呵','汗水','大哭','尴尬','鄙视','难过','夸奖','财迷','疑问','哼哼','狂吐','哟呵','害羞','亲吻','发愁','大笑','晕倒','可爱','坏笑','呲牙','暴汗','楚楚可怜','困','哭','生气','吃惊','口水','爱','心碎','玫瑰','礼物','彩虹','月亮','太阳','钱钱','灯泡','咖啡','蛋糕','音乐','爱你','胜利','赞','弱','OK','D哭','D加油','D必胜','D贱贱','D牛逼','D想静静','D颠球','D生气','D得瑟','D狂奔','D赞','E加油','D大哭','D红牌罚下','D激动','D哈哈'],
    t = ''
    jQuery(document).ready(function ($) {
        //留言
        $(".article-up-iframe").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });
    createEx()

    });
    //分页 ****************************************
    var pageIndex = 0;     //页面索引初始值
    var pageSize = 10;     //每页显示条数初始化，修改显示条数，修改这里即可
    $(function() {       
        InitTable(0);    //Load事件，初始化表格数据，页面索引为0（第一页）
                                                        
        //分页，PageCount是总条目数，这是必选参数，其它参数都是可选
        $("#Pagination").pagination(<%=pageCount %>, {
            callback: PageCallback,
            prev_text: '上一页',       //上一页按钮里text
            next_text: '下一页',       //下一页按钮里text
            items_per_page: pageSize,  //显示条数
            num_display_entries: 6,    //连续分页主体部分分页条目数
            current_page: pageIndex,   //当前页索引
            num_edge_entries: 2        //两侧首尾分页条目数
        });
        
        //翻页调用
        function PageCallback(index, jq) {           
            InitTable(index);
        }

        //请求数据
        function InitTable(pageIndex) {                                
            $.ajax({ 
                type: "POST",
                dataType: "text",
                url: '/action/GetMessageList.ashx',      //提交到一般处理程序请求数据
                data: "pageIndex=" + (pageIndex + 1) + "&pageSize=" + pageSize + "&command=MsgBoxlist",          //提交两个参数：pageIndex(页面索引)，pageSize(显示条数)                
                success: function(data) {                                 
                    $(".friend-message-list li").remove(); 
                    $(".friend-message-list").append(data);         
                    $('.friend-message-list').emotions();    
                }
            });            
        }
    
    });
    //分页end***************************************************       

function createEx(){
    for (var i = 1; i <= 66; i++) {
    var l = (i-1)*30
    if (i > 50 ) {
        t+='<a data-img="/assets/face/i_f'+i+'.gif" data-t="'+ mea[i] +'" style="background-position: left -'+l+'px"></a>'
    }else{
        t+='<a data-img="/assets/face/i_f'+i+'.png" data-t="'+ mea[i] +'" style="background-position: left -'+l+'px"></a>'
        }
    };
    $(".faceimg").append(t).find('a').hover(function() {
        var x = $(this).offset().left+35,
            y = $(this).offset().top+15,
            url = $(this).data('img'),
            bigface = '<div class="bigface" style="top:'+y+'px;left:'+x+'px"><img src="'+url+'"></div>'
        $("body").append(bigface)
    }, function() {
        $("body").find('.bigface').remove()
    }).click(function(event) {
        var p = $(this).data('t')
        document.getElementById("mContent").value += '['+ p + ']';
    });
}
function sub()
{
    var cContent = $("#mContent").val()
    if($.trim(cContent).length<=0)
    {
        $(".toast").html('留言不能为空').show().addClass('toast-error')
    }
    else  if($.trim(cContent).length>128)
    {
        $(".toast").html('留言最多可输入128个汉字').show().addClass('toast-error')
    }
    else
    {
        $.ajax({
            url:"/action/GetMessageList.ashx",
            type:'post',
            data:"pageIndex=1&pageSize=10&command=addMsg&text="+cContent,
            success:function(data){
                if (data=='1')
                {
                    $(".toast").html('留言最多可输入128个汉字').show().addClass('toast-error')
                }else if (data=='ERROR')
                {
                    $(".toast").html('系统错误，刷新重试').show().addClass('toast-error')
                }else{
                    $("#mContent").val("");
                    $(".friend-message-list li").remove(); 
                    $(".friend-message-list").append(data);         
                    $('.friend-message-list').emotions(); 
                }
            },
            error:function(){
                $(".toast").html('系统错误，刷新重试').show().addClass('toast-error')
            }
        }); 
    }
    errorboxhide()
}
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />