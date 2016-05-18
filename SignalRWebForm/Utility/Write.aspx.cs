using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_BlogsWrite : System.Web.UI.Page
{
    public Groups groups = new Groups();
    public string PageUser = "";
    public string PageResult = "";
    public string PageList = "";
    public string PageFrom = "";
    public string PageAdmin = "";
    public string PageSwitch = "";
    public UserInfo u;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region 身份确认
        Member m = new Member();
        if (m.Default == null)
        {
            Response.Redirect("/Member/");
            return;
        }
        #endregion

        string cmd = "";
        if (Request.QueryString["cmd"] != null)
        {
            cmd = Request.QueryString["cmd"].ToString().ToLower();
        }

        StringBuilder sm = new StringBuilder();
        sm.AppendLine("<input type=\"radio\" id=\"blogStyle\" name=\"blogStyle\" value=\"Blog\" " + (cmd == "" ? "checked" : "") + " onclick=\"SwitchTo(this)\">博客 ");
        sm.AppendLine("<input type=\"radio\" id=\"blogStyle\" name=\"blogStyle\" value=\"Activity\" " + (cmd == "race" ? "checked" : "") + " onclick=\"SwitchTo(this)\">约跑 ");
        if (Admin.IsSuper() || Admin.IsAdmin())
        {
            sm.AppendLine("<input type=\"radio\" id=\"blogStyle\" name=\"blogStyle\" value=\"Club\" " + (cmd == "club" ? "checked" : "") + " onclick=\"SwitchTo(this)\">俱乐部 ");
            sm.AppendLine("<input type=\"radio\" id=\"blogStyle\" name=\"blogStyle\" value=\"Competetion\" " + (cmd == "competetion" ? "checked" : "") + " onclick=\"SwitchTo(this)\">竞赛 ");
        }
        sm.AppendLine("<input type=\"radio\" id=\"blogStyle\" name=\"blogStyle\" value=\"Products\" " + (cmd == "equipment" ? "checked" : "") + " onclick=\"SwitchTo(this)\">装备");
        PageAdmin = sm.ToString();

        PageSwitch = "";
        if (cmd == "race") PageSwitch = "SwitchTo2(\"Activity\");";
        if (cmd == "club") PageSwitch = "SwitchTo2(\"Club\");";
        if (cmd == "competetion") PageSwitch = "SwitchTo2(\"Competetion\");";
        if (cmd == "equipment") PageSwitch = "SwitchTo2(\"Products\");";

        u = Users.Find(m.Default.id);
        if (u == null)
        {
            Response.Redirect("/Member/");
        }

        if (u.cBio.Length < 1)
        {
            PageUser = "<a href=\"/member/personal.aspx\" style=\"border:solid 0px #FFFFFF;padding-left:0px;\">填写简介...</a>";
        }
        else
        {
            PageUser = u.cBio;
        }

        BlogGroup bg = new BlogGroup();
        PageList = bg.UserSelect(m.Default.id, 0);

        if (Request.QueryString["from"] != null)
        {
            PageFrom = "<input type=\"hidden\" id=\"from\" name=\"from\" value=\"" + Request.QueryString["from"].ToString() + "\">";
        }
    }
}
