<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceQuery.aspx.cs" Inherits="Raceresult_RaceQuery" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style>
@media screen and (min-width:100px) and (max-width:800px) {
.resultquery .table{display: block;}
.resultquery .tr .td:first-child{width: auto;text-align: left;padding: 0 0 0 5px}
.resultquery .tr{display: block;padding:0 10px;}
.resultquery .tr .td{display: block;padding: 0}
}
</style>
<form  id="rpfrom" runat="server">
<article>
	<div class="resultquery">
        <h1>成绩查询</h1>
        <div class="table">
            <div class="tr">
                <div class="td">
                    <label>赛事选择:</label>
                </div>
                <div class="td">
                    <asp:DropDownList ID="match" runat="server" ></asp:DropDownList>
                </div>
            </div>
            <div class="tr">
                <div class="td">
                    <label>姓名:</label>
                </div>
                <div class="td">
                    <input type="text" id="name" runat="server">
                </div>
            </div>
            <div class="tr">
                <div class="td">
                    <label id="lbNo" runat="server">姓名:</label>
                </div>
                <div class="td">
                    <input type="text" id="idcard" runat="server"><input type="text" id="idBib" runat="server">
                </div>
            </div>
            <div class="tr racetip">
                <%=cmark %>
            </div>
            <div class="tr">
                <div class="td"></div>
                <div class="td">
                    <a class="querygo" href="javascript:void(0)">点击查询</a>
                </div>
            </div>
        </div>
	</div>
</article>
</form>
<script type="text/javascript">
    $("#match").change(function(event) {
        window.location.href="/Raceresult/RaceQuery.aspx?id="+$(this).val()
    });

    $(".querygo").click(function(event) {
        var href = '',
            go = '0'
        $(".resultquery input").each(function(index, el) {
            if (!$(this).val()) {
                $(this).css('border', '1px solid red').attr('placeholder', '必填');
                go = '0'
                return false
            }else{
                $(".resultquery input").removeAttr('style')
                if ($(this).attr('id') == "name") {
                    href += '&'+$(this).attr('id')+'='+decToHex($(this).val())
                }else{
                    href += '&'+$(this).attr('id')+'='+$(this).val()
                }
                
                go = '1'
            }
        });
        if (go == '1') {
             window.location.href='/Raceresult/RaceResult.aspx?id='+$("#match").val()+href
        };
    });
var decToHex = function(str) {
    var res=[];
    for(var i=0;i < str.length;i++)
    res[i]=("00"+str.charCodeAt(i).toString(16)).slice(-4);
    return "\\u"+res.join("\\u");
}
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />