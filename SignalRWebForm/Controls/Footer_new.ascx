<%@ Control Language="C#" AutoEventWireup="true" %>
<style>
#foot_world a { font-size:12px;color:#7E7E7E; }
#foot_world a:hover { font-size:12px;color:#FF6701; }
#footer-user { font-size:12px;clear:both;width:950px;padding-top:10px;color:#7E7E7E;line-height:25px;border-top:solid 1px #CCCCCC; }
#footer-user a { font-size:12px;color:#7E7E7E; }
#footer-user a:hover { font-size:12px;color:#FF6701; }
</style>

<script language="javascript" src="/common/jFooter_new.js"></script>
<script language="javascript" src="/common/jChannel.js"></script>

<br>

<script language="javascript">

$.get("/Utility/Ajax/MemberInfo_new.aspx", { rnd : Math.random() }, function(result) {
   if(result.length>0) {
      document.getElementById("user_info").innerHTML = result;
   }
});

</script>
