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
                <span class="equip-ous">����</span>
            </div>
            <div class="blog-content l-message">
                <h4><%=strMsg %></h4>
                <div class="blogComment">
                    <div class="faceimg"></div>
                    <textarea name="mContent" id="mContent"></textarea>
                    <button class="discussSubmit" onclick="sub()">�ύ</button>
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
var mea = ['','΢Ц','��Ц','��Ƥ','����','ˣ��','����','�Ǻ�','��ˮ','���','����','����','�ѹ�','�佱','����','����','�ߺ�','����','Ӵ��','����','����','����','��Ц','�ε�','�ɰ�','��Ц','����','����','��������','��','��','����','�Ծ�','��ˮ','��','����','õ��','����','�ʺ�','����','̫��','ǮǮ','����','����','����','����','����','ʤ��','��','��','OK','D��','D����','D��ʤ','D����','Dţ��','D�뾲��','D����','D����','D��ɪ','D��','D��','E����','D���','D���Ʒ���','D����','D����'],
    t = ''
    jQuery(document).ready(function ($) {
        //����
        $(".article-up-iframe").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });
    createEx()

    });
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
                data: "pageIndex=" + (pageIndex + 1) + "&pageSize=" + pageSize + "&command=MsgBoxlist",          //�ύ����������pageIndex(ҳ������)��pageSize(��ʾ����)                
                success: function(data) {                                 
                    $(".friend-message-list li").remove(); 
                    $(".friend-message-list").append(data);         
                    $('.friend-message-list').emotions();    
                }
            });            
        }
    
    });
    //��ҳend***************************************************       

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
        $(".toast").html('���Բ���Ϊ��').show().addClass('toast-error')
    }
    else  if($.trim(cContent).length>128)
    {
        $(".toast").html('������������128������').show().addClass('toast-error')
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
                    $(".toast").html('������������128������').show().addClass('toast-error')
                }else if (data=='ERROR')
                {
                    $(".toast").html('ϵͳ����ˢ������').show().addClass('toast-error')
                }else{
                    $("#mContent").val("");
                    $(".friend-message-list li").remove(); 
                    $(".friend-message-list").append(data);         
                    $('.friend-message-list').emotions(); 
                }
            },
            error:function(){
                $(".toast").html('ϵͳ����ˢ������').show().addClass('toast-error')
            }
        }); 
    }
    errorboxhide()
}
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />