using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using System.Text;

public partial class Admin_RaceList : PageBase
{
    public StringBuilder item = new StringBuilder();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            AlertHelper.JQAlertGo("您没有权限", "/", false);
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.uId == 100001183 || CurrentUser.idMemberStyle == 99)
        {
            item.AppendLine(" <div id=\"item\" onclick=\"window.location='/Admin/FSCP.aspx';\">附属产品列表</div>");
            item.AppendLine(" <div id=\"item\" onclick=\"window.location='/Admin/FSCPLog.aspx';\">附属品购买记录</div>");
            //item.AppendLine("<div id=\"item\" onclick=\"window.location='/admin/RaceProductSetup.aspx';\">报名发布(老版)</div>");
             item.AppendLine(" <div id=\"item\" onclick=\"window.location='/admin/RaceCom.aspx';\">报名发布(新版)</div>     ");
             //item.AppendLine(" <div id=\"item\" onclick=\"window.location='/Admin/RaceListRecord.aspx';\">报名记录</div>");
             item.AppendLine(" <div id=\"item\" onclick=\"window.location='/Admin/RaceRecord.aspx';\">报名记录(新)</div>");
             item.AppendLine(" <div id=\"item\" onclick=\"window.location='/Admin/Team.aspx';\">组队记录</div>");
             item.AppendLine("<div id=\"item\" onclick=\"window.location='/admin/Event.aspx';\">成绩查询设置</div>");
             //item.AppendLine("<div id=\"item\" onclick=\"window.location='/admin/EventImport.aspx';\">赛事成绩导入</div>");
             item.AppendLine(" <div id=\"item\" onclick=\"window.location='/Admin/NewEvent.aspx';\">首页滚动赛事报名</div>");
             item.AppendLine("<div id=\"item\" onclick=\"window.location='/admin/international.aspx';\">直通车热门赛事</div>");
             item.AppendLine("<div id=\"item\" onclick=\"window.location='/admin/SelfService.aspx';\">自助赛事报名</div>");
             item.AppendLine(" <div id=\"item\" onclick=\"window.location='/Admin/flightgroom.aspx';\">机票赛事推荐</div>");
             item.AppendLine(" <div id=\"item\" onclick=\"window.location='/Admin/flightlist.aspx';\">机票购买记录</div>");
             item.AppendLine(" <div id=\"item\" onclick=\"window.location='/Admin/RaceJion.aspx';\">新版报名记录</div>");
             item.AppendLine(" <div id=\"item\" onclick=\"window.location='/Admin/CooperationManager.aspx';\">组织代码</div>");
             item.AppendLine(" <div id=\"item\" onclick=\"window.location='/Admin/PushEvent.aspx';\">新版赛事推送<img src=\"/images/new.gif\"></div>");
        }
        else
        {
            Response.Redirect("/");
            //AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
            //return;
        }
    }
}