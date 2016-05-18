<%@ WebHandler Language="C#" Class="loginstatus" %>

using System;
using System.Web;
using System.Web.SessionState;
using Erun360.Model;
using ERUN360.Entity;
using DBM4 = Erun360.Model.DB4;
using DB4 = Erun360.BLL.DB4;
using Model_DB2 = Erun360.Model.DB2;
using BLL_DB2 = Erun360.BLL.DB2;

public class loginstatus : IHttpHandler,IRequiresSessionState
{
    public void ProcessRequest (HttpContext context) {
        int cId = 0;
        string cName = string.Empty;
        string loginstatus = string.Empty;
        string club = string.Empty;
        string admin = string.Empty;
        context.Response.ContentType = "text/plain";

        if (context.Session["CurrentUser"] == null)
        {
            if (context.Request["equip"] == "mobile")
            {
                loginstatus = "<a class=\"ml2\" onclick=\"PopupShowdl();StatusCheck();\" href=\"javascript:void(0)\">登录</a><a class=\"ml2 registback\" href=\"javascript:void(0)\" data-u=\"/Member/register.aspx\">注册</a>";
            }
            else if(context.Request["equip"] == "pc")
            {
                loginstatus = "<div class=\"icenter\"><a href=\"javascript:void(0)\" data-u=\"/Member/register.aspx\" class=\"dla registback\">注册</a><a class=\"zca\" href=\"javascript:\" onclick=\"PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();\">登录</a></div>";
            }
        }
        else
        {
            UserInfoModel CurrentUser = (UserInfoModel)context.Session["CurrentUser"];
            cId = CurrentUser.uId;
            cName = CurrentUser.cNickName;
            if (context.Request["equip"] == "pc")
            {
                if (Admin.IsAdmin())
                {
                    admin = "<dt><a href=\"/Admin/\">管理入口</a></dt>";
                }
                if (CurrentUser.uId == 100001183 || CurrentUser.idMemberStyle == 99)
                {
                    admin += "<dt><a href=\"/Admin/RaceList.aspx\">赛事管理</a></dt>";
                }
                if (new DB4.tblRACE_CLUB().GetRecordCount(" iAudit>2 and idUser =" + CurrentUser.uId) > 0)
                {
                    club += "<dt><a href=\"" + UrlHelper.ClubUrl(Convert.ToInt32(new DB4.tblRACE_CLUB().GetIdClub(CurrentUser.uId))) + "\">管理俱乐部</a></dt>";
                }
                else
                {
                    club += "<dt><a href=\"/infocenter/appClub.aspx\">创建俱乐部</a></dt>";
                }
                loginstatus = "<div class=\"icenter\">俱乐部<i></i><dl><dt><a href=\"/infocenter/ClubJoin.aspx\">我加入的</a></dt><dt><a href=\"/infocenter/SearchClub.aspx\">搜索俱乐部</a></dt>" + club + "</dl></div><div class=\"icenter\">我的好友<em class=\"msgshowb\"></em><i></i><dl><dt><a href=\"/infocenter/Focus.aspx?uId=" + cId + "\">关注</a></dt><dt><a href=\"/infocenter/Fans.aspx?uId=" + cId + "\">粉丝<em class=\"msgshowf\"></em></a></dt><dt><a href=\"/infocenter/recom.aspx?uId=" + cId + "\">编辑推荐</a></dt><dt><a href=\"/infocenter/findpeople.aspx?uId=" + cId + "\">查找好友</a></dt></dl></div><div class=\"icenter\"><em class=\"msgshowa\"></em>Hello，<a href=\"/user/" + cId + ".aspx\">" + cName + "</a><i></i><dl><dt><a href=\"/user/" + cId + ".aspx\">个人中心</a></dt><dt><a href=\"/infocenter/Account.aspx?uId=" + cId + "\">帐户管理</a></dt><dt><a href=\"/infocenter/Message.aspx?uId=" + cId + "\">留言<em class=\"msgshowl\"></em></a></dt><dt><a href=\"/infocenter/Comments.aspx?uId=" + cId + "\">评论<em class=\"msgshowpl\"></em></a></dt><dt><a href=\"/infocenter/Integral.aspx?uId=" + cId + "\">积分</a></dt><dt><a href=\"javascript:void(0)\" onclick=\"loginout()\">退出登录</a></dt>" + admin + "</dl></div>";

                /*loginstatus = "<div class=\"icenter\">我的好友<em class=\"msgshowb\"></em><i></i><dl><dt><a href=\"/infocenter/Focus.aspx?uId=" + cId + "\">关注</a></dt><dt><a href=\"/infocenter/Fans.aspx?uId=" + cId + "\">粉丝<em class=\"msgshowf\"></em></a></dt><dt><a href=\"/infocenter/recom.aspx?uId=" + cId + "\">编辑推荐</a></dt><dt><a href=\"/infocenter/findpeople.aspx?uId=" + cId + "\">查找好友</a></dt></dl></div><div class=\"icenter\"><em class=\"msgshowa\"></em>Hello，<a href=\"/user/" + cId + ".aspx\">" + cName + "</a><i></i><dl><dt><a href=\"/user/" + cId + ".aspx\">个人中心</a></dt><dt><a href=\"/infocenter/Account.aspx?uId=" + cId + "\">帐户管理</a></dt><dt><a href=\"/infocenter/Message.aspx?uId=" + cId + "\">留言<em class=\"msgshowl\"></em></a></dt><dt><a href=\"/infocenter/Comments.aspx?uId=" + cId + "\">评论<em class=\"msgshowpl\"></em></a></dt><dt><a href=\"/infocenter/Integral.aspx?uId=" + cId + "\">积分</a></dt><dt><a href=\"javascript:void(0)\" onclick=\"loginout()\">退出登录</a></dt>" + admin + "</dl></div>";*/

            }
            else if(context.Request["equip"] == "mobile")
            {
                loginstatus = "<a class=\"ml3 uname\" href=\""+UrlHelper.MemberUrl(cId) + "\">"+cName +"</a>"
                            +"<label class=\"ml3\">"
                                +"<em class=\"msgshowb\"></em><i></i>我的好友"
                                    +"<input name=\"switch-field-2\" class=\"ace ace-switch ace-switch-4 btn-flat\" type=\"checkbox\" value=\"2\" />"
                                +"<ul>"
                                    +"<li><a href=\"/infocenter/Focus.aspx?uId="+cId +"\">关注</a></li>"
                                    +"<li><a href=\"/infocenter/Fans.aspx?uId="+cId +"\">粉丝<em class=\"msgshowf\"></em></a></li>"
                                    +"<li><a href=\"/infocenter/recom.aspx?uId="+cId +"\">编辑推荐</a></li>"
                                    +"<li><a href=\"/infocenter/findpeople.aspx?uId="+cId +"\">查找好友</a></li>"
                                    +""+club +""
                                +"</ul>"
                            +"</label>"
                            +"<label class=\"ml3\">"
                                +"<em class=\"msgshowa\"></em><i></i>我的益跑"
                                    +"<input name=\"switch-field-3\" class=\"ace ace-switch ace-switch-4 btn-flat\" type=\"checkbox\" value=\"3\" />"
                                +"<ul>"
                                    +"<li><a href=\"/infocenter/Account.aspx?uId="+cId +"\">帐户管理</a></li>"
                                    +"<li><a href=\"/infocenter/Message.aspx?uId="+cId +"\">留言<em class=\"msgshowl\"></em></a></li>"
                                    +"<li><a href=\"/infocenter/Comments.aspx?uId="+cId +"\">评论<em class=\"msgshowpl\"></em></a></li>"
                                    +"<li><a href=\"/infocenter/Integral.aspx?uId="+cId +"\">积分</a></li>"
                                    +"<li><a href=\"javascript:void(0)\" onclick=\"loginout()\">退出登录</a><i></i></li>"
                                    +""+admin+""
                                +"</ul>"
                                +"</label>";
            }
        }
        context.Response.Write(loginstatus);

    }

    public bool IsReusable {
    get {
        return false;
    }
}

}