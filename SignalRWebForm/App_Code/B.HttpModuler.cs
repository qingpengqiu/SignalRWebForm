
using System;
using System.Text;
using System.Web;
using System.Net;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.IO.Compression;
using DB2 = Erun360.BLL.DB2;
namespace Legalsoft.Basic
{
    /// <summary>
    /// 页面重写的核心程序
    /// </summary>
    public class ReModuler : IHttpModule
    {
        void IHttpModule.Dispose() { }

        void IHttpModule.Init(HttpApplication context)
        {
            context.BeginRequest += new EventHandler(context_BeginRequest);
        }
        DB2.tblBLOG bll = new DB2.tblBLOG();
        public void context_BeginRequest(object sender, EventArgs e)
        {
            HttpApplication app = (HttpApplication)sender;
            //HttpContext context = app.Context;
            //if (File.Exists(Path.Combine(context.Server.MapPath("~"), "offline.html")))
            //{
            //    string ip = context.Request.UserHostAddress;
            //    string adminIP = System.Configuration.ConfigurationManager.AppSettings["AdminIP"];
            //    if (ip != adminIP)
            //    {
            //        context.RewritePath("~/offline.html");
            //    }
            //}
            string scr = "";
            if (app.Request["SCRIPT_NAME"] != null) scr = app.Request["SCRIPT_NAME"].ToString().ToLower();

            bool Rewritable = false;

            string path = "";
            string qry = "";

            if (!scr.Contains(".aspx"))
            {
                //return;
                if (scr.Replace("/", "").ToLower() == "2014rw50")
                {
                    path = "/infocenter/singleBlog.aspx";
                    qry = "bId=200013540";
                    Rewritable = true;
                }
                else if (scr.Replace("/", "").ToLower() == "tnf100")
                {
                    path = "/infocenter/singleBlog.aspx";
                    qry = "bId=200014474";
                    Rewritable = true;
                }
                else
                {
                    return;
                }
            }

            //博客
            if (scr.StartsWith("/blog/"))
            {
                //string[] re = scr.Replace(".aspx", " ").Replace("/blog/", "yid=").Split(' ');
                //qry = re[0];

                path = "/infocenter/singleBlog.aspx";
                string[] qa = scr.Replace(".aspx", " ").Replace("/blog/", "bId=").Split(' ');
                qry = qa[0];
                string[] ids = qa[0].Split('=');
                int idblog = TypeChange.NullToInt(ids[1], 0);
                int count = bll.GetRecordCount("id='" + idblog + "' and idHref=0");
                int equipcount = bll.GetRecordCount("id='" + idblog + "' and left(idHref,1)=5");
                if (count > 0)
                {
                    path = "/article/content.aspx";
                    qry = "sid=" + idblog;
                }
                else if (idblog == 0)
                {
                    path = "/article/content.aspx";
                    qry = "sid=" + idblog;
                }

                if (equipcount > 0)
                {
                    path = "/article/equipcontent.aspx";
                    qry = "sid=" + idblog;
                }

                Rewritable = true;
            }
            ////赛事
            //if (scr.StartsWith("/event/"))
            //{
            //    path = "/infocenter/singleEvent.aspx";
            //    string[] qa = scr.Replace(".aspx", " ").Replace("/event/", "bId=").Split(' ');
            //    qry = qa[0];
            //    Rewritable = true;
            //}
            ////装备
            //if (scr.StartsWith("/equip/"))
            //{
            //    path = "/infocenter/singleEquip.aspx";
            //    string[] qa = scr.Replace(".aspx", " ").Replace("/equip/", "bId=").Split(' ');
            //    qry = qa[0];
            //    Rewritable = true;
            //}
            //用户首页
            if (scr.StartsWith("/user/"))
            {
                path = "/infocenter/Default.aspx";
                scr = scr.Replace(".aspx", "").Replace("/user/", "");
                string[] qa = scr.Split('_');
                if (qa.Length == 1) qry = "uId=" + qa[0];
                if (qa.Length == 2) qry = "uId=" + qa[0] + "&bId=" + qa[1];
                //if (qa.Length == 3) qry = "id=" + qa[0] + "&group=" + qa[1] + "&page=" + qa[2];

                Rewritable = true;
            }
            //if (scr.StartsWith("/blog/"))
            //{
            //    path = "/utility/blog.aspx";
            //    string[] qa = scr.Replace(".aspx", " ").Replace("/blog/", "id=").Split(' ');
            //    qry = qa[0];
            //    Rewritable = true;
            //}
            //专家专栏
            if (scr.StartsWith("/topics/"))
            {
                path = "/infocenter/topics.aspx";
                scr = scr.Replace(".aspx", "").Replace("/topics/", "");
                string[] qa = scr.Split('_');
                if (qa.Length == 1) qry = "id=" + qa[0];
                if (qa.Length == 2) qry = "id=" + qa[0] + "&page=" + qa[1];
                Rewritable = true;
            }
            //if (scr.StartsWith("/topics/"))
            //{
            //    path = "/utility/topics.aspx";
            //    scr = scr.Replace(".aspx", "").Replace("/topics/", "");
            //    string[] qa = scr.Split('_');
            //    if (qa.Length == 1) qry = "id=" + qa[0];
            //    if (qa.Length == 2) qry = "id=" + qa[0] + "&page=" + qa[1];
            //    Rewritable = true;
            //}
            //相册
            if (scr.StartsWith("/gallery/"))
            {
                path = "/utility/gallery.aspx";
                scr = scr.Replace(".aspx", "").Replace("/gallery/", "");
                string[] qa = scr.Split('_');
                if (qa.Length == 1) qry = "id=" + qa[0];
                if (qa.Length == 2) qry = "id=" + qa[0] + "&page=" + qa[1];
                Rewritable = true;
            }
            //专题
            if (scr.StartsWith("/subjects/"))
            {
                path = "/utility/subjects.aspx";
                scr = scr.Replace(".aspx", "").Replace("/subjects/", "");
                string[] qa = scr.Split('_');
                if (qa.Length == 1) qry = "id=" + qa[0];
                if (qa.Length == 2) qry = "id=" + qa[0] + "&page=" + qa[1];
                Rewritable = true;
            }

            //if (scr.StartsWith("/race/"))
            //{
            //    path = "/utility/racehistory.aspx";
            //    scr = scr.Replace(".aspx", "").Replace("/race/", "");
            //    string[] qa = scr.Split('_');
            //    if (qa.Length == 1) qry = "id=" + qa[0];
            //    if (qa.Length == 2) qry = "id=" + qa[0] + "&page=" + qa[1];
            //    Rewritable = true;
            //}

            //if (scr.StartsWith("/user/"))
            //{
            //    path = "/utility/member.aspx";
            //    scr = scr.Replace(".aspx", "").Replace("/user/", "");
            //    string[] qa = scr.Split('_');
            //    if (qa.Length == 1) qry = "id=" + qa[0];
            //    if (qa.Length == 2) qry = "id=" + qa[0] + "&page=" + qa[1];
            //    if (qa.Length == 3) qry = "id=" + qa[0] + "&group=" + qa[1] + "&page=" + qa[2];

            //    Rewritable = true;
            //}
            //俱乐部
            if (scr.StartsWith("/club/"))
            {
                path = "/infocenter/Club.aspx";
                string[] qa = scr.Replace(".aspx", " ").Replace("/club/", "id=").Split(' ');
                qry = qa[0];
                Rewritable = true;
            }
            //训练成绩
            if (scr.StartsWith("/score/"))
            {
                path = "/infocenter/Trained.aspx";
                string[] qa = scr.Replace(".aspx", " ").Replace("/score/", "uId=").Split(' ');
                qry = qa[0];
                Rewritable = true;
            }
            //约跑
            if (scr.StartsWith("/race/"))
            {
                path = "/infocenter/ClubInfo.aspx";
                string[] qa = scr.Replace(".aspx", " ").Replace("/race/", "id=").Split(' ');
                qry = qa[0];
                Rewritable = true;
            }

            //鞋
            if (scr.StartsWith("/shoe/"))
            {
                path = "/SmartChooseShoe/Shoe.aspx";
                string[] qa = scr.Replace(".aspx", " ").Replace("/shoe/", "id=").Split(' ');
                qry = qa[0];
                Rewritable = true;
            }
            if (Rewritable == false) { return; }

            app.Context.RewritePath(path, String.Empty, qry);
        }



    }
}
