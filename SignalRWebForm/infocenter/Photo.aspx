<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Photo.aspx.cs" Inherits="infocenter_Photo" %>

<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>



<!DOCTYPE html>
<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title>全部相片-益跑网个人中心</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="../Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/themes.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/colorbox.css" />
    <script type="text/javascript" src="../Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../Html/js/modernizr.js"></script>
    <script type="text/javascript" src="../Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="../Html/js/jquery.pagination.js"></script>
    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js?appkey=" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <!--[if lte IE 9]>
<link rel="stylesheet" type="text/css" href="js/IE9.js"/>
<![endif]-->
    <style type="text/css">
        .main-left ul .left2 img {
            filter: alpha(Opacity=100);
            -moz-opacity: 1;
            opacity: 1;
        }

        .main-left ul .left2 a {
            color: #693f69;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
        <div class="wrap">
            <article>
                <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <div class="main-right">
                    <div class="blog">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <%=PhotoList %>
                                <webdiyer:AspNetPager ID="pager" runat="server" FirstPageText="<<" LastPageText=">>"
                                    NextPageText="下一页" CssClass="pages"
                                    CurrentPageButtonClass="cpb" PrevPageText="上一页"
                                    OnPageChanged="pager_PageChanged" PageSize="24">
                                </webdiyer:AspNetPager>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </article>
        </div>
        <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
        <script type="text/javascript">
            jQuery(document).ready(function ($) {
                $(".article-up-iframe").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });
                $(".close").click(function () {
                    $(".message").hide();
                });
                $(".group2").colorbox({ rel: 'group2', transition: "fade" });
            });
            window.onload = ReSizeImg("myphoto", 202, 202);
            function ReSizeImg(cName, w, h) {
                var reImgs = $("img");
                for (j = 0; j < reImgs.length; j++) {
                    if (reImgs[j].className == cName && (reImgs[j].height > h || reImgs[j].width > w)) {
                        if (reImgs[j].height == reImgs[j].width) {
                            reImgs[j].height = h; reImgs[j].width = w;
                        } else if (reImgs[j].height > reImgs[j].width) {
                            reImgs[j].height = h;
                        } else if (reImgs[j].height < reImgs[j].width) {
                            reImgs[j].width = w;
                        }
                    }
                }
            }

            //瀑布流代码
            $(function () { waterfall(".group2") });
            function waterfall(cls) {
                if (!$(cls).length) return;//没有元素
                var con = {
                    obj: null,//图片div对象
                    l: 0, //总共数量
                    w: 179,//列宽
                    s: 0,//列间距
                    list: 0, //多少列
                    arr: [],//最后一排数组
                    anim: [],//动画参数数组
                    n: 0,//需要做动画的编号
                    state: "loading" //状态 loading:加载图片中，ajax:正在发生ajax请求，finish:完成任务，resize:执行了窗口变化
                };
                //查找数组最大与最小值
                function get_value(obj, i) {
                    if (!Object.prototype.toString.call(obj) === '[object Array]') return 0;
                    var arr = obj.concat().sort(function (a, b) { return a - b });
                    return i == 0 ? arr[0] : arr[arr.length - 1];
                }
                con.obj = $(cls);//图片div对象
                con.l = con.obj.size();//统计共有多少个图片div
                con.list = Math.floor($(".album").width() / (con.w + con.s));//统计共有多少列
                $(window).resize(function () {
                    var w = Math.floor($(".album").width() / (con.w + con.s));//重新统计共有多少列
                    if (w != con.list) {
                        if ("finish" == con.state) {
                            con.list = w;
                            con.n = 0;//图片编号又从0开始
                            fall_pic(0);
                        } else {
                            con.state = "resize";
                        }
                    }
                }).scroll(function () {
                    var top = Math.max.apply(Math, con.arr) - 50;//get_value(con.arr,1)-50;//让滚动条离最底差50像素时触发新增图片动作
                    var scrollTop = document.documentElement.scrollTop || document.body.scrollTop || 0;//滚动条距离
                    var windowHeight = document.documentElement.clientHeight || document.body.clientHeight || 0;//窗口高度
                    // if(windowHeight+scrollTop>=top){
                    //     if("finish"==con.state){
                    //         con.state="ajax";//当滚动条拉到看到最后一张图片时
                    //         var html='';//实现案例中此改成ajax请求json或html,每次请求只增加一排
                    //         for(var i=con.l;i<con.l+con.list;i++){
                    //             html+='<div class="cell"><img src="http://cued.xunlei.com/demos/publ/img/P_'+('00'+i%162).slice(-3)+'.jpg" /><h3>'+i+' AJAX加载</h3><p>JQUERY瀑布流原理：每次排版取前一排最低的位置接着排，窗口改变后先计算一下列数有没有发生变化，变化后才重排。当下拉滚动条达到最后一个DIV的顶部时请求ajax生成新的图片插到底部执行继排功能。</p></div>';
                    //         }
                    //         $(".album").append(html);
                    //         con.obj=$(cls);//更新对象
                    //         con.n=con.l;//记录加载前的最后一个编号
                    //         con.l=con.obj.size();//统计现在共有多少张图片
                    //         load_pic(con.n);//接着加载前最后一张图片排序;
                    //     }else{
                    //         $(window).scrollTop(scrollTop-1);//让滚动条不要到底
                    //     }
                    // }
                });
                load_pic(0);//开始加载图片
                function load_pic(n) {
                    //确保新图片已加载成功
                    if (n < con.l) {
                        var obj = con.obj.eq(n);//获取对象
                        var img = new Image();
                        img.onload = function () {
                            obj.find("img").attr("height", this.height);//设置好高可能对获取outerHeight()有改进？
                            n++; load_pic(n);
                        };
                        img.onerror = function () {
                            //加载失败就替换图片，并省去设置外围div的高
                            obj.find("img").attr({ height: 200, src: "error.jpg" });
                            n++; load_pic(n);
                        };
                        img.src = obj.find("img").attr("src");
                    } else {
                        fall_pic(con.n);//开始执行计算与动画
                       $(".photo-loading").hide();
                        
                    }

                }
                function fall_pic(n) {
                    if (0 == n) con.arr = [];//清空数组
                    if (n < con.l) {
                        var obj = con.obj.eq(n);//获取对象
                        var x = 0, y = 0;//对象坐标值
                        if (n < con.list) {
                            x = n * (con.w + con.s);//如果是第一排，y=0,x=宽度+列间距
                            con.arr[n] = obj.outerHeight(true) + con.s;//记录屁股里那张图片的y坐标
                        } else {
                            var _i = 0;//查一下最后一排哪张图片的底部离顶部最高，然后在其后面插入新图片
                            y = con.arr[0];//先假设是第一排，然后比较
                            for (var i = 0, l = con.arr.length; i < l; i++) {
                                if (y > con.arr[i]) {
                                    y = con.arr[i];
                                    _i = i;
                                    x = i * (con.w + con.s);
                                }
                            }
                            con.arr[_i] = con.arr[_i] + obj.outerHeight(true) + con.s;//替换数组
                        }
                        con.anim[n] = { left: x, top: y };//数组应该快过$.data()方法吧 obj.data("coordinate",{left:x,top:y});
                        n++; fall_pic(n);
                    } else {
                        //$(".album").stop().animate({height:get_value(con.arr,2)},"fast");//设置外框高
                        $(".album").stop().animate({ height: Math.max.apply(Math, con.arr) }, "fast");//设置外框高
                        //符合条件的元素执行动画
                        $(cls + (con.n > 0 ? ":gt(" + (con.n - 1) + ")" : "")).each(function (i) {
                            var coordinate = con.anim[i + con.n];
                            if ("ajax" == con.state) {
                                $(this).css(coordinate).hide().fadeIn(400);
                            } else {
                                $(this).animate(coordinate, 600);
                            }
                        });
                        setTimeout(function () {
                            if ("resize" == con.state && con.list != Math.floor($(".album").width() / (con.w + con.s))) {
                                con.state = "finish";
                                $(window).scroll();
                            } else
                                con.state = "finish";
                        }, 1000)
                    }
                }
            }
        </script>

    </form>

</body>
</html>
