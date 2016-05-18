<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CompetitionCalendar.aspx.cs" Inherits="Channels_Competetion_CompetitionCalendar" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<article>
<% =DateBuffer %>
</article>
<script language="javascript">
function JoinCreate(user, idx)
{
	$.get("/Utility/Ajax/RaceJoinCreate.aspx", { onwer : user , id : idx }, function(result) {
		if(result == "OK") {
			document.getElementById("comp_join"+idx).outerHTML = "<span class=\"comp_ygz\"></span>";
		}
		else { alert(result); document.getElementById("comp_join").innerHTML = result; }
	});
}
function ComptOfDay(y,m,d)
{
	$.get("/Utility/Ajax/Competetion.aspx", { year : y , month : m, day : d }, function(result) {
		document.getElementById("competInfos").innerHTML = result;
	});
}
$(".moremoth").click(function() {
    $(".moremotha").toggle();
});
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />