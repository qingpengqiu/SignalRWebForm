using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Admin_Blog_Link : System.Web.UI.Page
{
    // 页面信息
    public string PageBuffer = "";
    public string PageResult = "";
    public string PageNavigator = "";
    public BlogInfo blog;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsAdmin())
        {
            //PageBuffer = "没有操作权限！";
            Response.Redirect("/Member/Login.aspx");
            return;
        }

        int id = 0;
        if (Request["id"] != null)
        {
            id = Int32.Parse(XString.PureNumber(Request["id"].ToString()));
        }

        int pc = 0;
        Blog blogs = new Blog();

        blog = blogs.Load(id, "", "");

        BlogLinks blink = new BlogLinks();

        if (Request.Form.Count > 0)
        {
            if (Request.Form["indexlist"] != null)
            {
                string sk = Request.Form["indexlist"].ToString();
                string[] ka = sk.Split(',');
                foreach (string ku in ka)
                {
                    string kf = ku.Trim();
                    if (kf.Length > 0)
                    {
                        int result = 0;
                        BlogLinksInfo bk = new BlogLinksInfo();
                        bk.idBlog = id;
                        bk.idInfo = Int32.Parse(kf);
                        blink.Insert(bk, out result);
                    }
                }
            }
        }

        if (Request.QueryString["opr"] != null)
        {
            if (Request.QueryString["index"] != null)
            {
                blink.Delete(Int32.Parse(Request.QueryString["index"].ToString()));
            }
        }

        List<BlogLinksInfo> blist = blink.PageList(1, 100, "WHERE idBlog=" + id, "ORDER BY id ASC", out pc);

        StringBuilder sb = new StringBuilder();
        foreach (BlogLinksInfo bu in blist)
        {
            BlogInfo bf = blogs.Load(bu.idInfo, "", "");
            if (bf != null)
            {
                sb.AppendLine("[<a href=\"BlogLink.aspx?opr=delete&index=" + bu.id + "&id=" + id + "\">删除</a>] <a href=\"" + UrlHelper.MemberUrl(bf.idUser) + "\" target=_blank>" + bf.cLoginName + "</a> : <a href=\"" + UrlHelper.BlogUrl(bf.id) + "\" target=_blank>" + bf.cTitle + "</a><br>");
            }
        }
        PageResult = sb.ToString();

        if (PageResult.Length < 1)
        {
            PageBuffer = "本博客还不是专题，<a href=\"javascript:;\" onclick=\"BlogAdd(0," + blog.idUser + ",'" + blog.cLoginName + "'," + id + ",'" + blog.cTitle + "')\" style=\"color:#0000EE;text-decoration: underline;\">点击创建为专题</a><br>";
            //PageResult = "本博客还不是专题，<a href=\"javascript:;\" onclick=\"BlogAdd(0," + id + ",'" + blog.cTitle + "')\" style=\"color:#0000EE;text-decoration: underline;\">点击创建为专题</a>...";
        }

    }
}
/* Powered by 北京联高软件开发有限公司 Ltd. */
/* This file formatted by WizForm 2.1 at 09-14 16:40 */

