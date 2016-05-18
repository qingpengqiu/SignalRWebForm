<%@ Control Language="C#" AutoEventWireup="true" %>

<script language="javascript" src="/common/jFooter.js"></script>

<script language="javascript">
$.get("/Utility/Ajax/MemberInfo.aspx", { rnd : Math.random() }, function(result) {
    if(result.length>0) {
        document.getElementById("user_info").innerHTML = result;
    }
});
</script>
<script language="javascript">BindCapture();backFix();</script>
<script language="javascript" src="/common/jScroll.js"></script>
