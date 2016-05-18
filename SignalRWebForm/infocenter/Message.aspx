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
                <span class="equip-ous">����</span>
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

        //��ҳ ****************************************
        var pageIndex = 0;     //ҳ��������ʼֵ
        var pageSize = 10;     //ÿҳ��ʾ������ʼ�����޸���ʾ�������޸����Ｔ��
   
   
        $(function() {       
            InitTable(0);    //Load�¼�����ʼ��������ݣ�ҳ������Ϊ0����һҳ��
                                                            
            //��ҳ��PageCount������Ŀ�������Ǳ�ѡ�����������������ǿ�ѡ
            $("#Pagination").pagination(<%=pageCount %>, {
                callback: PageCallback,
                prev_text: '��һҳ',       //��һҳ��ť��text
                next_text: '��һҳ',       //��һҳ��ť��text
                items_per_page: pageSize,  //��ʾ����
                num_display_entries: 6,    //������ҳ���岿�ַ�ҳ��Ŀ��
                current_page: pageIndex,   //��ǰҳ����
                num_edge_entries: 2        //������β��ҳ��Ŀ��
            });
            
            //��ҳ����
            function PageCallback(index, jq) {           
                InitTable(index);
            }

            //��������
            function InitTable(pageIndex) {                                
                $.ajax({ 
                    type: "POST",
                    dataType: "text",
                    url: '/action/GetMessageList.ashx',      //�ύ��һ�㴦�������������
                    data: "pageIndex=" + (pageIndex + 1) + "&pageSize=" + pageSize+ "&command=MessageList",          //�ύ����������pageIndex(ҳ������)��pageSize(��ʾ����)                
                    success: function(data) {                                 
                        $(".message-list li").remove();        
                        $(".message-list").append(data);      
                        $('.message-list').emotions();           
                    }
                });            
            }
        
        });
        //��ҳend***************************************************
    </script>
<ERUN360:footerv3 runat="server" ID="footerv3" />