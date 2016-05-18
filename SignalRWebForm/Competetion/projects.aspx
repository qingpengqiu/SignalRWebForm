<%@ Page Language="C#" AutoEventWireup="true" CodeFile="projects.aspx.cs" Inherits="Competetion_projects" %>

<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Competetion/ICart.ascx" TagPrefix="ERUN360" TagName="ICart" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body{background: #f6f6f6}
</style>
<script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
<div class="banner">
    <div class="mine">
        <h1><%=title %></h1>
        <asp:Literal ID="ltlbanner" runat="server"></asp:Literal>
    </div>
</div>
<div class="tbody">
    <div class="mine">
        <ERUN360:bmnav runat="server" ID="bmnav" />
        <div class="tbodyBox">
            <div class="event this">
                <a href="/Competetion/projects.aspx?sid=<%=sid %>&la=en&nav=2" class="lanen">English</a>
                <div class="eventTip">
                    <asp:Literal ID="ltlHeader" runat="server"></asp:Literal>
                </div>
                <form id="rpfrom" runat="server">
                    <div class="ccenter ">
                        <div class="racebody">
                            <div class="mproject">
                                <h5>
                                    <asp:Literal ID="ltlProject" runat="server"></asp:Literal></h5>
                                <ul class="mprojectlist">
                                    <%=item %>
                                </ul>
                                <div class="integralw">
                                    <div class="integral">
                                        <input type="checkbox" id="UseIntegral">
                                        <label for="UseIntegral">您有 <span><%=iScore%></span> 积分,可使用 <span id="integral">0</span> 积分 抵扣 <span id="price">0</span> 元 </label>
                                        <div class="intError">当前积分不足以抵扣，<a href="/blog/200016255.aspx" target="_blank">点击查看积分来源</a></div>
                                    </div>
                                    <div class="puintegral">
                                      <input type="checkbox" id="UseIntegral2">
                                      <label for="UseIntegral2">最多可以使用 <span id="canusein"></span> 积分, </label>使用<input type="text" id="integral2" value="1" data-max="0" disabled>积分抵扣 <span id="inyuan">0.01</span> 元
                                    </div>
                                </div>
                                <div id="racetip">
                                    <h2>报名须知</h2>
                                    <asp:Literal ID="ltlbmxz" runat="server"></asp:Literal>
                                </div>
                                <div class="gamein">
                                    <label><input type="checkbox" id="agree" /><asp:Literal ID="ltlbsxz" runat="server"></asp:Literal></label></div>
                                <a class="racepostcn" href="javascript:void(0)">下一步</a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<ERUN360:ICart runat="server" ID="ICart" />
<script>
custom = function(){
  window.location.reload()
}
$("#UseIntegral2").change(function(event) {
  if ($(this).is(':checked')) {
    $("#integral2").removeAttr('disabled')
  }else{
    $("#integral2").attr('disabled', 'disabled')
  }
});
$(".projecttips").click(function (event) {
    $(this).hide()
    event.preventDefault();
});
$("#integral2").change(function(event) {
  $(this).val($(this).val().replace(/\D/g,''));
  var int = parseInt($(this).val()),
      max = $(this).data('max')
      if (int > 0 && int<=max) {
        $("#inyuan").html(int/100)
      }else{
        tipbox('输入错误','error',3000)
        $("#integral2").val(1)
        $("#inyuan").html(0.01)
      }
});
function integral(t) {
    $("#UseIntegral").removeAttr('checked');
    $("#UseIntegral2").removeAttr('checked');
    $("#integral2").attr('disabled', 'disabled')

    var integral  = t.data('integral'),
        price     = t.data('price'),
        dprice    = t.data('dprice'),
        status    = t.data('status'),
        iScore    = <%=iScore%>
        $(".integral").hide()
        $(".puintegral").hide()
  if (status == 1) {

    $("#integral").html(integral)
    $("#price").html(price)
    $("#lprice").html(dprice - price)
    if (iScore < integral) {
        $("#UseIntegral").attr('disabled', 'true').removeAttr('checked');
        $(".intError").show()
        $(".integral").show()
    } else {
        if (integral == 0) {
            $(".integral").hide()
            $("#UseIntegral").removeAttr('checked');
        } else {
            $("#UseIntegral").removeAttr('disabled')
            $(".intError").hide()
            $(".integral").show()
        }
    }
  }else{
    $(".puintegral").show();
    $("#canusein").html(integral)
    $("#inyuan").html(integral/100)
    $("#integral2").data('max', integral).val(integral)
  }
}
$(".mprojectlist input").on('click', function (event) {
    $(".projecttips").hide()
    $(this).next("label").find(".projecttips").show();
    integral($(this))
});
jQuery(document).ready(function ($) {
    $('.mprojectlist input').each(function (index, val) {
        if (val.checked) {
            integral($(this))
        };
    });
    if (GetQueryString("la") == "en") {
        $(".lanen").attr('href', '/Competetion/projects.aspx?sid=<%=sid %>&la=cn&nav=2').html("中文");
    }
    $(".racepostcn").click(function (event) {
      var lang = GetQueryString("la") ? GetQueryString("la") : "cn",
      integral = $("#UseIntegral").is(':checked') || $("#UseIntegral2").is(':checked')? 1 : 0
      if ($('input[name="project"]:checked').val()) {
          if ($('input[id="agree"]:checked').val()) {
                window.location.href = "projects2.aspx?sid=<%=sid %>&nav=2&la=" + lang + "&p=" + $('input[name="project"]:checked').val() + "&jf=" + integral+"&jfz="+$("#integral2").val()
          } else {
              tipbox('请同意报名须知','error',3000)
          }
      } else {
        tipbox('请选择项目','error',3000)
      }
    });
});
$("#agree").click(function(event) {
  if ($('input[id="agree"]:checked').val()) {
    $('.racepostcn').addClass('racego')
  }else{
    $('.racepostcn').removeClass('racego')
  }
});
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />