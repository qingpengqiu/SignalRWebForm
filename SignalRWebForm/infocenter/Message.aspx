<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Message.aspx.cs" Inherits="infocenter_Message" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<script src="../Html/js/jquery.emotions.js" type="text/javascript"></script>
<script type="text/javascript" src="../Html/js/jquery.pagination.js"></script>

<article>
    <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
    <div class="main-right">
        <div class="blog results">
            <div class="equip">
                <span class="equip-ous">留言</span>
            </div>
            <ul class="message-list">
            </ul>
            <div class="pages" id="Pagination">
            </div>
        </div>
    </div>
</article>
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            var lheight = $(".main-right").height() - "16";
            if (lheight > "530") {
                $(".main-left").css("height", lheight);
            }
        });
        $(".article-up-iframe").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });

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
                    data: "pageIndex=" + (pageIndex + 1) + "&pageSize=" + pageSize+ "&command=MessageList",          //提交两个参数：pageIndex(页面索引)，pageSize(显示条数)                
                    success: function(data) {                                 
                        $(".message-list li").remove();        
                        $(".message-list").append(data);      
                        $('.message-list').emotions();           
                    }
                });            
            }
        
        });
        //分页end***************************************************
    </script>
<ERUN360:footerv3 runat="server" ID="footerv3" />