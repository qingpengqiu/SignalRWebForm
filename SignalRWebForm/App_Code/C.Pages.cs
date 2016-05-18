
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

public static class UrlHelper
{
    #region BLOG
    public static string BlogUrl(int id)
    {
        return "/blog/" + id + ".aspx";
    }
    public static string BlogHref(int id, string title)
    {
        return "<a href=\"" + BlogUrl(id) + "\" title=\"" + XString.XmlSafe(title) + "\">" + XString.XmlSafe(title) + "</a>";
    }
    #endregion
    #region equip
    //public static string EquipUrl(int id)
    //{
    //    return "/equip/" + id + ".aspx";
    //}
    //public static string EquipHref(int id, string title)
    //{
    //    return "<a href=\"" + EquipUrl(id) + "\" title=\"" + XString.XmlSafe(title) + "\">" + XString.XmlSafe(title) + "</a>";
    //}
    #endregion
    #region event
    //public static string EventUrl(int id)
    //{
    //    return "/event/" + id + ".aspx";
    //}
    //public static string EventHref(int id, string title)
    //{
    //    return "<a href=\"" + EventUrl(id) + "\" title=\"" + XString.XmlSafe(title) + "\">" + XString.XmlSafe(title) + "</a>";
    //}
    #endregion
    #region MEMBER
    public static string MemberUrl(int id)
    {
        return "/user/" + id + ".aspx";
    }
    public static string MemberHref(int id, string title)
    {
        return "<a href=\"" + MemberUrl(id) + "\" title=\"" + XString.XmlSafe(title) + "\">" + XString.XmlSafe(title) + "</a>";
    }

    public static string MemberUrl(int id, int page)
    {
        return "/user/" + id + "_" + page + ".aspx";
    }

    public static string MemberUrl(int id, int group, int page)
    {
        return "/user/" + id + "_" + group + "_" + page + ".aspx";
    }
    #endregion

    #region GALLERY

    public static string GalleryUrl(int id)
    {
        return "/gallery/" + id + ".aspx";
    }
    public static string GalleryHref(int id, string title)
    {
        return "<a href=\"" + GalleryUrl(id) + "\" title=\"" + XString.XmlSafe(title) + "\">" + XString.XmlSafe(title) + "</a>";
    }

    public static string GalleryUrl(int id, int page)
    {
        return "/gallery/" + id + "_" + page + ".aspx";
    }
    #endregion

    #region TOPICS

    public static string TopicsUrl(int id)
    {
        return "/topics/" + id + ".aspx";
    }
    public static string TopicsHref(int id, string title)
    {
        return "<a href=\"" + TopicsUrl(id) + "\" title=\"" + XString.XmlSafe(title) + "\">" + XString.XmlSafe(title) + "</a>";
    }

    public static string TopicsUrl(int id, int page)
    {
        return "/topics/" + id + "_" + page + ".aspx";
    }
    #endregion

    #region SUBJECTS

    public static string SubjectsUrl(int id)
    {
        return "/subjects/" + id + ".aspx";
    }
    public static string SubjectsHref(int id, string title)
    {
        return "<a href=\"" + SubjectsUrl(id) + "\" title=\"" + XString.XmlSafe(title) + "\">" + XString.XmlSafe(title) + "</a>";
    }

    public static string SubjectsUrl(int id, int page)
    {
        return "/subjects/" + id + "_" + page + ".aspx";
    }
    #endregion
    //2013-06-08 add by  zhangx
    #region race 训练成绩（跑量）
    public static string ScoreUrl(int id)
    {
        return "/score/" + id + ".aspx";
    }
    //约跑
    public static string RaceUrl(int id)
    {
        return "/race/" + id + ".aspx";
    }
    public static string RaceHref(int id, string title)
    {
        return "<a href=\"" + SubjectsUrl(id) + "\" title=\"" + XString.XmlSafe(title) + "\">" + XString.XmlSafe(title) + "</a>";
    }

    public static string RaceUrl(int id, int page)
    {
        return "/race/" + id + "_" + page + ".aspx";
    }
    #endregion
    #region club
    public static string ClubUrl(int id)
    {
        return "/club/" + id + ".aspx";
    }
    #endregion
    #region shoe
    public static string ShoeUrl(int id)
    {
        return "/shoe/" + id + ".aspx";
    }
    #endregion
}

namespace ERUN360.Entity
{
    public class HotInfo
    {
        public int id = 0;
        public int idUser = 0;
        public int idHref = 0;        
        public string Author = "";
        public int ImageIndex = 0;
        public string Image = "";
        public string Title = "";
        public string Subtract = "";
        public int Focus = 0;
        public DateTime Create = DateTime.Now;
    }
    public class PageInfos
    {
        public string Focusmap()
        {
            string CacheKey = "tblFocusmap";
            object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
            if (objModel == null)
            {
                try
                {
                    string head = "\t\t\t\t";
                    StringBuilder sb = new StringBuilder();
                    head = "\t\t\t";
                    sb.AppendLine(head + "<a target=\"_blank\" id=\"bigImage\">");
                    sb.AppendLine(head + "\t<div id=\"preImage\">");
                    sb.AppendLine(head + "\t<div id=\"preTitle\">");
                    sb.AppendLine(head + "\t<div id=\"longText\">");
                    sb.AppendLine(head + "\t</div>");
                    sb.AppendLine(head + "\t<div id=\"had_right\">");
                    sb.AppendLine(head + "\t\t<div id=\"had_icon1\" class=\"had_yes\" onmouseover=\"RollStop(-1)\" onmouseout=\"RollBegin()\" onblur=\"RollBegin()\">1</div>");
                    sb.AppendLine(head + "\t\t<div id=\"had_icon2\" class=\"had_no\" onmouseover=\"RollStop(0)\" onmouseout=\"RollBegin()\" onblur=\"RollBegin()\">2</div>");
                    sb.AppendLine(head + "\t\t<div id=\"had_icon3\" class=\"had_no\" onmouseover=\"RollStop(1)\" onmouseout=\"RollBegin()\" onblur=\"RollBegin()\">3</div>");
                    sb.AppendLine(head + "\t\t<div id=\"had_icon4\" class=\"had_no\" onmouseover=\"RollStop(2)\" onmouseout=\"RollBegin()\" onblur=\"RollBegin()\">4</div>");
                    sb.AppendLine(head + "\t\t<div id=\"had_icon5\" class=\"had_no\" onmouseover=\"RollStop(3)\" onmouseout=\"RollBegin()\" onblur=\"RollBegin()\">5</div>");
                    sb.AppendLine(head + "\t</div>");
                    sb.AppendLine(head + "\t</div>");
                    sb.AppendLine(head + "\t</div>");
                    sb.AppendLine(head + "</a>");

                    sb.AppendLine(head + "<script language=\"javascript\">");
                    sb.AppendLine(head + "var homeAds = [");
                    DataTable dt = new Erun360.BLL.DB2.tblFocusmap().GetList(5, "iStatus =1 and len(isnull(idChannel,''))=1 ", "dCreate desc,id desc").Tables[0];
                    for (int i = 0; i < 5 && i < dt.Rows.Count; i++)
                    {
                        sb.AppendLine(head + "\t['" + dt.Rows[i]["cImageUrl"].ToString() + "','" + dt.Rows[i]["cTitle"].ToString() + "','" + dt.Rows[i]["cLink"].ToString() + "'],");
                    }

                    sb.AppendLine(head + "];");
                    sb.AppendLine(head + "</script>");
                    sb.AppendLine(head + "<script language=\"javascript\" src=\"/Common/jRoll.js\"></script>");
                    objModel = sb.ToString();
                    if (objModel != null)
                    {
                        int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                        Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                    }
                }
                catch { }
            }
            return (string)objModel;
        }

        public string Show(int idPosition)
        {
            #region 缓存机制
            string cacheName = "CACHE_OF_PAGE_" + idPosition;
            string cacheBuffer = (string)TCache.LoadString(cacheName);
            if (cacheBuffer.Length > 0)
            {
                return cacheBuffer;
            }
            #endregion

            // 读取发布信息
            int page_count = 0;
            BlogPublish bp = new BlogPublish();
            List<BlogPublishInfo> list = bp.PageList(1, 20, "WHERE idPosition=" + idPosition, "ORDER BY id DESC", out page_count);
            if (page_count == 0) return "...";
            if (list.Count == 0) return "...";

            // 建立博客ID列表
            StringBuilder sn = new StringBuilder();
            foreach (BlogPublishInfo bu in list)
            {
                sn.Append(bu.idInfo + ",");
            }

            // 建立图片ID列表
            StringBuilder sf = new StringBuilder();
            foreach (BlogPublishInfo bu in list)
            {
                if (bu.idImage > 0)
                {
                    sf.Append(bu.idImage + ",");
                }
            }

            // 读取相关博客信息，并建立相应的哈希表
            Blog blogs = new Blog();
            List<BlogInfo> blist = blogs.PageList(1, 20, "WHERE id IN (" + XString.UnTail(sn.ToString()) + ")", "ORDER BY id DESC", out page_count);
            Hashtable hash = new Hashtable();
            foreach (BlogInfo bv in blist)
            {
                if (hash[bv.id] == null)
                {
                    hash.Add(bv.id, bv);
                }
            }

            // 读取相关博客关联信息，并建立相应的哈希表
            BlogLinks links = new BlogLinks();
            List<BlogLinksInfo> klist = links.PageList(1, 100, "WHERE idBlog IN (" + XString.UnTail(sn.ToString()) + ")", "ORDER BY id DESC", out page_count);
            Hashtable hlnk = new Hashtable();
            foreach (BlogLinksInfo bv in klist)
            {
                if (hlnk[bv.idBlog] == null)
                {
                    hlnk.Add(bv.idBlog, bv.idInfo);
                }
            }

            // 读取相关图片信息，并建立相应的哈希表
            Hashtable himg = new Hashtable();
            if (sf.Length > 0)
            {
                Images imgs = new Images();
                List<ImagesInfo> glist = imgs.PageList(1, 10, "WHERE id IN (" + XString.UnTail(sf.ToString()) + ")", "ORDER BY id DESC", out page_count);
                foreach (ImagesInfo bm in glist)
                {
                    if (himg[bm.id] == null)
                    {
                        himg.Add(bm.id, bm.cImageUrl);
                    }
                }
            }

            // 创建用于显示的信息列表
            List<HotInfo> items = new List<HotInfo>();
            foreach (BlogPublishInfo bu in list)
            {
                BlogInfo blog = (BlogInfo)hash[bu.idInfo];
                if (blog != null)
                {
                    HotInfo h = new HotInfo();
                    h.id = blog.id;
                    h.idUser = blog.idUser;
                    h.Author = blog.cLoginName;
                    UserInfo u = Users.Find(h.idUser);
                    h.Image = "/images/temp/02.gif";
                    if (u != null)
                    {
                       
                        h.Image = u.cAvatar;
                        if (bu.idImage > 0)
                        {
                            if (himg[bu.idImage] != null)
                            {
                                h.ImageIndex = bu.idImage;
                                h.Image = (string)himg[bu.idImage];
                            }
                        }
                        h.Author = u.cNickName;
                    }
                    h.Title = blog.cTitle;
                    // $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                    // 2012-10-23
                    if (bu.cTitle.Length > 0) h.Title = bu.cTitle;
                    // $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

                    //h.Subtract = XString.Trunc(blog.cContent, 128);
                    h.Subtract = XString.ContentTrunc(HTMLHelper.NoHTML(HTMLHelper.NoHTML(blog.cContent.ToString())), 128);
                    items.Add(h);
                }
            }
            if (items.Count == 0) return "no results";

            StringBuilder sb = new StringBuilder();
            string head = "\t\t\t\t";

            // 按位置显示相应页面信息
            string ks = "";

            idPosition = Int32.Parse(idPosition.ToString().Substring(3, 6));
            // 赛事城市
            if (idPosition == 117100)
            {
                sb.AppendLine(head + "<div style=\"float:left\">");
                sb.AppendLine("<div class=\"tw twss\">");
                sb.AppendLine(head + "\t\t<a href=\"" + UrlHelper.BlogUrl(items[0].id) + "\" target=\"_blank\"><img src=\"" + items[0].Image + "\" width=\"100\" height=\"100\"></a>");
                ks = "";
                if (hlnk[items[0].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[0].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
                sb.AppendLine(head + "\t\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[0].id) + "\" class=\"title\" target=\"_blank\" title=\"" + items[0].Title + "\">" + items[0].Title + "</a>");
                sb.AppendLine(head + "\t\t<span>by：<a href=\"" + UrlHelper.MemberUrl(items[0].idUser) + "\" target=\"_blank\" title=\"" + items[0].Author + "\">" + items[0].Author + "</a></span>");
                sb.AppendLine(head + "\t\t<p>" + items[0].Subtract + "...</p>");
                sb.AppendLine(head + "\t</div>");
                sb.AppendLine(head + "<ul class=\"htlist\">");
                for (int i = 1; i <= 7 && i < items.Count; i++)
                {
                    ks = "";
                    sb.AppendLine(head + "\t<li>");
                    if (hlnk[items[i].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[i].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
                    sb.AppendLine(head + "\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\" title=\"" + items[i].Title + "\">" + items[i].Title + "</a></li>");
                }
                sb.AppendLine(head + "</ul>");
                sb.AppendLine(head + "</div>");
                sb.AppendLine(head + "<ul class=\"htlist htlistr\">");
                for (int i = 8; i <= 19 && i < items.Count; i++)
                {
                    ks = "";
                    sb.AppendLine(head + "\t<li>");
                    if (hlnk[items[i].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[i].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
                    sb.AppendLine(head + "\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\" title=\"" + items[i].Title + "\">" + items[i].Title + "</a></li>");
                }
                sb.AppendLine(head + "</ul>");

            }

            // 赛事城市
            if (idPosition >= 111100 && idPosition <= 114100)
            {
                sb.AppendLine("<div class=\"tw\">");
                sb.AppendLine(head + "\t\t<a href=\"" + UrlHelper.BlogUrl(items[0].id) + "\" target=\"_blank\"><img src=\"" + items[0].Image + "\" width=\"100\" height=\"100\"></a>");
                ks = "";
                if (hlnk[items[0].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[0].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
                sb.AppendLine(head + "\t\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[0].id) + "\" class=\"title\" target=\"_blank\" title=\"" + items[0].Title + "\">" + items[0].Title + "</a>");
                sb.AppendLine(head + "\t\t<span>by：<a href=\"" + UrlHelper.MemberUrl(items[0].idUser) + "\" target=\"_blank\" title=\"" + items[0].Author + "\">" + items[0].Author + "</a></span>");
                sb.AppendLine(head + "\t\t<p>" + items[0].Subtract + "...</p>");
                sb.AppendLine(head + "\t</div>");
                sb.AppendLine(head + "<ul class=\"htlist\">");
                for (int i = 1; i <= 15 && i < items.Count; i++)
                {
                    ks = "";
                    sb.AppendLine(head + "\t<li>");
                    if (hlnk[items[i].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[i].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
                    sb.AppendLine(head + "\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\" title=\"" + items[i].Title + "\">" + items[i].Title + "</a></li>");
                }
                sb.AppendLine(head + "</ul>");
            }

            // 第三段
            if ((idPosition >= 114101 && idPosition <= 117099) || (idPosition >= 117101 && idPosition <= 118100))
            {
                sb.AppendLine("<div class=\"tw\">");
                sb.AppendLine(head + "\t\t<a href=\"" + UrlHelper.BlogUrl(items[0].id) + "\" target=\"_blank\"><img src=\"" + items[0].Image + "\" width=\"100\" height=\"100\"></a>");
                ks = "";
                if (hlnk[items[0].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[0].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
                sb.AppendLine(head + "\t\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[0].id) + "\" class=\"title\" target=\"_blank\" title=\"" + items[0].Title + "\">" + items[0].Title + "</a>");
                sb.AppendLine(head + "\t\t<span>by：<a href=\"" + UrlHelper.MemberUrl(items[0].idUser) + "\" target=\"_blank\" title=\"" + items[0].Author + "\">" + items[0].Author + "</a></span>");
                sb.AppendLine(head + "\t\t<p>" + items[0].Subtract + "...</p>");
                sb.AppendLine(head + "\t</div>");
                sb.AppendLine(head + "<ul class=\"htlist\">");
                for (int i = 1; i <= 7 && i < items.Count; i++)
                {
                    ks = "";
                    sb.AppendLine(head + "\t<li>");
                    if (hlnk[items[i].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[i].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
                    sb.AppendLine(head + "\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\" title=\"" + items[i].Title + "\">" + items[i].Title + "</a></li>");
                }
                sb.AppendLine(head + "</ul>");
            }

            // 第一段右侧第1个
            if (idPosition == 102110)
            {
                sb.AppendLine(head + "<li class=\"ceshu1\">");
                ks = "";
                if (hlnk[items[0].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[0].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";

                sb.AppendLine(head + "\t<em><a href=\"" + UrlHelper.MemberUrl(items[0].idUser) + "\" target=\"_blank\"  title=\"" + items[0].Author + "\">" + items[0].Author + "</a></em>");
                sb.AppendLine(head + "\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[0].id) + "\" target=\"_blank\" title=\"" + items[0].Title + "\">" + items[0].Title + "</a></li> ");
                for (int i = 1; i <= 4 && i < items.Count; i++)
                {
                    ks = "";
                    sb.AppendLine(head + "<li>");
                    if (hlnk[items[i].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[i].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
                    sb.AppendLine(head + "\t<em><a href=\"" + UrlHelper.MemberUrl(items[i].idUser) + "\" target=\"_blank\" title=\"" + items[i].Author + "\">" + items[i].Author + "</a></em>");
                    sb.AppendLine(head + "\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\" title=\"" + items[i].Title + "\">" + items[i].Title + "</a></li>");
                }
            }
            // 第一段右侧第2,3,4个
            if (idPosition >= 102120 && idPosition <= 102140)
            {
                sb.AppendLine(head + "<li class=\"ceshu2\">");
                ks = "";
                if (hlnk[items[0].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[0].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
                sb.AppendLine(head + "\t<em><a href=\"" + UrlHelper.MemberUrl(items[0].idUser) + "\" target=\"_blank\"  title=\"" + items[0].Author + "\">" + items[0].Author + "</a></em>");
                sb.AppendLine(head + "\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[0].id) + "\" target=\"_blank\" title=\"" + items[0].Title + "\">" + items[0].Title + "</a>");
                sb.AppendLine(head + "</li>");
                for (int i = 1; i <= 4 && i < items.Count; i++)
                {
                    sb.AppendLine(head + "<li>");
                    ks = "";
                    if (hlnk[items[i].id] != null) ks = "<a href=\"" + UrlHelper.SubjectsUrl(items[i].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
                    sb.AppendLine(head + "\t<em><a href=\"" + UrlHelper.MemberUrl(items[i].idUser) + "\" target=\"_blank\" title=\"" + items[i].Author + "\">" + items[i].Author + "</a></em>");
                    sb.AppendLine(head + "\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\" title=\"" + items[i].Title + "\">" + items[i].Title + "</a></li>");

                }
            }
            // 第二段左侧专家专栏
            if (idPosition == 103100)
            {
                for (int i = 0; i < 4 && i < items.Count; i++)
                {
                    if ((i % 2) == 0)
                    {
                        sb.AppendLine(head + "<li>");
                    }
                    else
                    {
                        sb.AppendLine(head + "<li class=\"lir\">");
                    }
                    sb.AppendLine(head + "\t\t<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\"><img src=\"" + items[i].Image + "\" width=\"100\" height=\"100\"></a>");


                    ks = "";
                    if (hlnk[items[i].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[i].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
                    sb.AppendLine(head + "\t\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\" class=\"title\" title=\"" + items[i].Title + "\">" + items[i].Title + "</a>");
                    sb.AppendLine(head + "\t\t<span>by：<a href=\"" + UrlHelper.MemberUrl(items[i].idUser) + "\" target=\"_blank\"  title=\"" + items[i].Author + "\">" + items[i].Author + "</a></span>");
                    sb.AppendLine(head + "<p>" + "\t\t" + items[i].Subtract + "</p>");
                    sb.AppendLine(head + "</li>");
                }
            }

            // 第3段左侧编辑推荐
            if (idPosition == 104100)
            {
                for (int i = 0; i < 4 && i < items.Count; i++)
                {
                    if ((i % 2) == 0)
                    {
                        sb.AppendLine(head + "<li>");
                    }
                    else
                    {
                        sb.AppendLine(head + "<li class=\"lir\">");
                    }
                    sb.AppendLine(head + "\t\t<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\"><img src=\"" + items[i].Image + "\" width=\"100\" height=\"100\"></a>");


                    ks = "";
                    if (hlnk[items[i].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[i].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
                    sb.AppendLine(head + "\t\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\" class=\"title\" title=\"" + items[i].Title + "\">" + items[i].Title + "</a>");
                    sb.AppendLine(head + "\t\t<span>by：<a href=\"" + UrlHelper.MemberUrl(items[i].idUser) + "\" target=\"_blank\"  title=\"" + items[i].Author + "\">" + items[i].Author + "</a></span>");
                    sb.AppendLine(head + "<p>" + "\t\t" + items[i].Subtract + "</p>");
                    sb.AppendLine(head + "</li>");
                }
            }

            // 右侧视频
            if (idPosition == 130100)
            {
                Images hmg = new Images();
                for (int i = 0; i < 6 && i < items.Count; i++)
                {
                    string simg = items[i].Image;
                    if (simg.Length < 1 || simg.Contains("/undefined"))
                    {
                        simg = "";
                        int pcnt = 0;
                        List<ImagesInfo> xlist = hmg.PageList(1, 10, "WHERE idInfo=" + items[i].id, "ORDER BY id DESC", out pcnt);
                        if (pcnt > 0) { simg = xlist[0].cImageUrl; }
                        if (simg.Length < 1) simg = "/images/undefined-video.jpg";
                    }

                    sb.AppendLine(head + "<li>");
                    sb.AppendLine(head + "\t<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" alt=\"" + items[i].Title + "\" title=\"" + items[i].Title + "\" target=\"_blank\"><img src=\"" + simg + "\" width=\"120\" height=\"102\">" + items[i].Title + "</a>");
                    sb.AppendLine(head + "</li>");
                }
            }

            // 右侧图片
            if (idPosition == 140100)
            {
                Images hmg = new Images();
                for (int i = 0; i < 4 && i < items.Count; i++)
                {
                    string simg = items[i].Image;
                    if (simg.Length < 1 || simg.Contains("undefined"))
                    {
                        simg = "";
                        int pcnt = 0;
                        List<ImagesInfo> xlist = hmg.PageList(1, 10, "WHERE idInfo=" + items[i].id, "ORDER BY id DESC", out pcnt);
                        if (pcnt > 0) { simg = xlist[0].cImageUrl; }
                        if (simg.Length < 1) simg = "/images/undefined-image.jpg";
                    }
                    //string simg = "/images/undefined-image.jpg";
                    //int pcnt = 0;
                    //List<ImagesInfo> xlist = hmg.PageList(1, 10, "WHERE idInfo=" + items[i].id, "ORDER BY id DESC", out pcnt);
                    //if (pcnt > 0) { simg = xlist[0].cImageUrl; }

                    sb.AppendLine(head + "<li>");
                    sb.AppendLine(head + "\t<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" alt=\"" + items[i].Title + "\" title=\"" + items[i].Title + "\" target=\"_blank\"><img src=\"" + simg + "\" width=\"120\" height=\"102\">" + items[i].Title + "</a>");
                    sb.AppendLine(head + "</li>");
                }
            }

            // 左侧动画
            if (idPosition == 101100)
            {
                head = "\t\t\t";
                sb.AppendLine(head + "<a target=\"_blank\" id=\"bigImage\">");
                sb.AppendLine(head + "\t<div id=\"preImage\">");
                sb.AppendLine(head + "\t<div id=\"preTitle\">");
                sb.AppendLine(head + "\t<div id=\"longText\">");
                sb.AppendLine(head + "\t</div>");
                sb.AppendLine(head + "\t<div id=\"had_right\">");
                sb.AppendLine(head + "\t\t<div id=\"had_icon1\" class=\"had_yes\" onmouseover=\"RollStop(-1)\" onmouseout=\"RollBegin()\" onblur=\"RollBegin()\">1</div>");
                sb.AppendLine(head + "\t\t<div id=\"had_icon2\" class=\"had_no\" onmouseover=\"RollStop(0)\" onmouseout=\"RollBegin()\" onblur=\"RollBegin()\">2</div>");
                sb.AppendLine(head + "\t\t<div id=\"had_icon3\" class=\"had_no\" onmouseover=\"RollStop(1)\" onmouseout=\"RollBegin()\" onblur=\"RollBegin()\">3</div>");
                sb.AppendLine(head + "\t\t<div id=\"had_icon4\" class=\"had_no\" onmouseover=\"RollStop(2)\" onmouseout=\"RollBegin()\" onblur=\"RollBegin()\">4</div>");
                sb.AppendLine(head + "\t\t<div id=\"had_icon5\" class=\"had_no\" onmouseover=\"RollStop(3)\" onmouseout=\"RollBegin()\" onblur=\"RollBegin()\">5</div>");
                sb.AppendLine(head + "\t</div>");
                sb.AppendLine(head + "\t</div>");
                sb.AppendLine(head + "\t</div>");
                sb.AppendLine(head + "</a>");

                sb.AppendLine(head + "<script language=\"javascript\">");
                sb.AppendLine(head + "var homeAds = [");
                for (int i = 0; i < 5 && i < items.Count; i++)
                {
                    if (items[i].ImageIndex > 0)
                    {
                        sb.AppendLine(head + "\t['" + items[i].Image + "','" + items[i].Title + "','" + UrlHelper.BlogUrl(items[i].id) + "'],");
                    }
                    else
                    {
                        sb.AppendLine(head + "\t['/images/temp/A0" + (i + 1) + ".jpg','" + items[i].Title + "','" + UrlHelper.BlogUrl(items[i].id) + "'],");
                    }
                }
                sb.AppendLine(head + "];");
                sb.AppendLine(head + "</script>");
                sb.AppendLine(head + "<script language=\"javascript\" src=\"/Common/jRoll.js\"></script>");
            }

            cacheBuffer = sb.ToString();
            TCache.SaveString(cacheName, cacheBuffer, 30);

            return cacheBuffer;
        }

        public string Focus(int idPosition, int number)
        {
            #region 缓存机制
            //string cacheName = "CACHE_OF_HOTS_" + idPosition;
            string cacheBuffer = ""; // (string)TCache.LoadString(cacheName);
            if (cacheBuffer.Length > 0)
            {
                return cacheBuffer;
            }
            #endregion

            // 读取发布信息
            int page_count = 0;
            BlogPublish bp = new BlogPublish();
            List<BlogPublishInfo> list = bp.PageList(1, 100, "WHERE idPosition>=" + idPosition + " AND idPosition<" + (idPosition + 1000000), "ORDER BY id DESC", out page_count);
            if (page_count == 0) return "no issues";
            if (list.Count == 0) return "no issues";

            // 建立博客ID列表
            StringBuilder sn = new StringBuilder();
            foreach (BlogPublishInfo bu in list)
            {
                sn.Append(bu.idInfo + ",");
            }

            // 读取相关博客信息，并建立相应的哈希表
            Blog blogs = new Blog();
            List<BlogInfo> blist = blogs.PageList(1, 100, "WHERE id IN (" + XString.UnTail(sn.ToString()) + ")", "ORDER BY id DESC", out page_count);

            if (blist == null) return "A:" + XString.UnTail(sn.ToString());

            Hashtable hash = new Hashtable();
            foreach (BlogInfo bv in blist)
            {
                hash.Add(bv.id, bv);
            }

            // 读取相关博客摘要信息，并建立相应的哈希表
            BlogSummary summary = new BlogSummary();
            List<BlogSummaryInfo> slist = summary.PageList(1, 100, "WHERE idBlog IN (" + XString.UnTail(sn.ToString()) + ")", "", out page_count);

            if (slist == null) return "B:" + XString.UnTail(sn.ToString());

            Hashtable hast = new Hashtable();
            foreach (BlogSummaryInfo sv in slist)
            {
                hast.Add(sv.idBlog, sv);
            }

            // 创建用于显示的信息列表
            List<HotInfo> items = new List<HotInfo>();
            foreach (BlogPublishInfo bu in list)
            {
                BlogInfo bg = (BlogInfo)hash[bu.idInfo];
                if (bg == null) continue;

                BlogSummaryInfo sg = (BlogSummaryInfo)hast[bu.idInfo];
                if (sg == null) continue;

                HotInfo h = new HotInfo();
                h.id = bg.id;
                h.idUser = bg.idUser;
                h.Author = bg.cLoginName;
                h.Image = "/images/temp/02.gif";
                h.Title = bg.cTitle;
                h.Focus = sg.iFocus;
                //h.Subtract = XString.Trunc(bg.cContent, 128);
                h.Subtract = XString.ContentTrunc(HTMLHelper.NoHTML(bg.cContent.ToString()), 128);
                items.Add(h);

            }
            if (items.Count == 0) return "...";

            items.Sort(delegate(HotInfo a, HotInfo b) { return b.Focus - a.Focus; });
            string substr = "";
            StringBuilder sb = new StringBuilder();
            string head = "\t\t\t\t";
            for (int i = 0; i < number && i < items.Count; i++)
            {
                substr = XString.Trunc(items[i].Title, 24);
                sb.AppendLine(head + "\t<li><em><a href=\"" + UrlHelper.MemberUrl(items[i].idUser) + "\" target=\"_blank\" title=\"" + items[i].Author + "\">" + items[i].Author + "</a></em>");
                sb.AppendLine(head + "\t<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\" title=\"" + items[i].Title + "\">" + substr + "</a></li>");
            }

            cacheBuffer = sb.ToString();
            //TCache.SaveString(cacheName, cacheBuffer, 20);

            return cacheBuffer;
        }
    }
    //public class PageInfos
    //{
    //    public string Show(int idPosition)
    //    {
    //        #region 缓存机制
    //        string cacheName = "CACHE_OF_PAGE_" + idPosition;
    //        string cacheBuffer = (string)TCache.LoadString(cacheName);
    //        if (cacheBuffer.Length > 0)
    //        {
    //            return cacheBuffer;
    //        }
    //        #endregion

    //        // 读取发布信息
    //        int page_count = 0;
    //        BlogPublish bp = new BlogPublish();
    //        List<BlogPublishInfo> list = bp.PageList(1, 20, "WHERE idPosition=" + idPosition, "ORDER BY id DESC", out page_count);
    //        if (page_count == 0) return "...";
    //        if (list.Count == 0) return "...";

    //        // 建立博客ID列表
    //        StringBuilder sn = new StringBuilder();
    //        foreach (BlogPublishInfo bu in list)
    //        {
    //            sn.Append(bu.idInfo + ",");
    //        }

    //        // 建立图片ID列表
    //        StringBuilder sf = new StringBuilder();
    //        foreach (BlogPublishInfo bu in list)
    //        {
    //            if (bu.idImage > 0)
    //            {
    //                sf.Append(bu.idImage + ",");
    //            }
    //        }

    //        // 读取相关博客信息，并建立相应的哈希表
    //        Blog blogs = new Blog();
    //        List<BlogInfo> blist = blogs.PageList(1, 20, "WHERE id IN (" + XString.UnTail(sn.ToString()) + ")", "ORDER BY id DESC", out page_count);
    //        Hashtable hash = new Hashtable();
    //        foreach (BlogInfo bv in blist)
    //        {
    //            if (hash[bv.id] == null)
    //            {
    //                hash.Add(bv.id, bv);
    //            }
    //        }

    //        // 读取相关博客关联信息，并建立相应的哈希表
    //        BlogLinks links = new BlogLinks();
    //        List<BlogLinksInfo> klist = links.PageList(1, 100, "WHERE idBlog IN (" + XString.UnTail(sn.ToString()) + ")", "ORDER BY id DESC", out page_count);
    //        Hashtable hlnk = new Hashtable();
    //        foreach (BlogLinksInfo bv in klist)
    //        {
    //            if (hlnk[bv.idBlog] == null)
    //            {
    //                hlnk.Add(bv.idBlog, bv.idInfo);
    //            }
    //        }

    //        // 读取相关图片信息，并建立相应的哈希表
    //        Hashtable himg = new Hashtable();
    //        if (sf.Length > 0)
    //        {
    //            Images imgs = new Images();
    //            List<ImagesInfo> glist = imgs.PageList(1, 10, "WHERE id IN (" + XString.UnTail(sf.ToString()) + ")", "ORDER BY id DESC", out page_count);
    //            foreach (ImagesInfo bm in glist)
    //            {
    //                if (himg[bm.id] == null)
    //                {
    //                    himg.Add(bm.id, bm.cImageUrl);
    //                }
    //            }
    //        }

    //        // 创建用于显示的信息列表
    //        List<HotInfo> items = new List<HotInfo>();
    //        foreach (BlogPublishInfo bu in list)
    //        {
    //            BlogInfo blog = (BlogInfo)hash[bu.idInfo];
    //            if (blog != null)
    //            {
    //                HotInfo h = new HotInfo();
    //                h.id = blog.id;
    //                h.idHref = blog.idHref;
    //                h.idUser = blog.idUser;
    //                h.Author = blog.cLoginName;
    //                UserInfo u = Users.Find(h.idUser);
    //                h.Image = "/images/temp/02.gif";
    //                if (u != null)
    //                {
    //                    h.Image = u.cAvatar;
    //                    if (bu.idImage > 0)
    //                    {
    //                        if (himg[bu.idImage] != null)
    //                        {
    //                            h.ImageIndex = bu.idImage;
    //                            h.Image = (string)himg[bu.idImage];
    //                        }
    //                    }
    //                }
    //                h.Title = blog.cTitle;
    //                // $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    //                // 2012-10-23
    //                if (bu.cTitle.Length > 0) h.Title = bu.cTitle;
    //                // $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

    //                //h.Subtract = XString.Trunc(blog.cContent, 128);
    //                h.Subtract = XString.ContentTrunc(HTMLHelper.NoHTML(HTMLHelper.NoHTML(blog.cContent.ToString())), 128);
    //                items.Add(h);
    //            }
    //        }
    //        if (items.Count == 0) return "no results";

    //        StringBuilder sb = new StringBuilder();
    //        string head = "\t\t\t\t";

    //        // 按位置显示相应页面信息
    //        string ks = "";

    //        idPosition = Int32.Parse(idPosition.ToString().Substring(3, 6));
    //        // 赛事城市
    //        if (idPosition == 117100)
    //        {
    //            sb.AppendLine(head + "<ul class=\"htlist htlistr\">");
    //            for (int i = 8; i <= 19 && i < items.Count; i++)
    //            {
    //                ks = "";
    //                sb.AppendLine(head + "\t<li>");
    //                if (hlnk[items[i].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[i].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
    //                sb.AppendLine(head + "\t" + ks + "<a href=\"" + UrlHelper.EventUrl(items[i].id) + "\" target=\"_blank\" title=\"" + items[i].Title + "\">" + items[i].Title + "</a></li>");
    //            }
    //            sb.AppendLine(head + "</ul>");
    //            sb.AppendLine("<div class=\"tw twss\">");
    //            sb.AppendLine(head + "\t\t<a href=\"" + UrlHelper.EventUrl(items[0].id) + "\" target=\"_blank\"><img src=\"" + items[0].Image + "\" width=\"100\" height=\"100\"></a>");
    //            ks = "";
    //            if (hlnk[items[0].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[0].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
    //            sb.AppendLine(head + "\t\t" + ks + "<a href=\"" + UrlHelper.EventUrl(items[0].id) + "\" class=\"title\" target=\"_blank\" title=\"" + items[0].Title + "\">" + items[0].Title + "</a>");
    //            sb.AppendLine(head + "\t\t<span>by：<a href=\"" + UrlHelper.MemberUrl(items[0].idUser) + "\" target=\"_blank\" title=\"" + items[0].Author + "\">" + items[0].Author + "</a></span>");
    //            sb.AppendLine(head + "\t\t<p>" + items[0].Subtract + "...</p>");
    //            sb.AppendLine(head + "\t</div>");
    //            sb.AppendLine(head + "<ul class=\"htlist\">");
    //            for (int i = 1; i <= 7 && i < items.Count; i++)
    //            {
    //                ks = "";
    //                sb.AppendLine(head + "\t<li>");
    //                if (hlnk[items[i].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[i].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
    //                sb.AppendLine(head + "\t" + ks + "<a href=\"" + UrlHelper.EventUrl(items[i].id) + "\" target=\"_blank\" title=\"" + items[i].Title + "\">" + items[i].Title + "</a></li>");
    //            }
    //            sb.AppendLine(head + "</ul>");

    //        }
           
    //        // 赛事城市
    //        if (idPosition >= 111100 && idPosition <= 114100)
    //        {
    //            int type = Int32.Parse(items[0].idHref.ToString().Substring(0, 1));

    //            sb.AppendLine("<div class=\"tw\">");
    //            sb.AppendLine(head + "\t\t<a href=\"" + UrlHelper.BlogUrl(items[0].id) + "\" target=\"_blank\"><img src=\"" + items[0].Image + "\" width=\"100\" height=\"100\"></a>");
    //            ks = "";
    //            if (hlnk[items[0].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[0].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
    //            sb.AppendLine(head + "\t\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[0].id) + "\" class=\"title\" target=\"_blank\" title=\"" + items[0].Title + "\">" + items[0].Title + "</a>");
    //            sb.AppendLine(head + "\t\t<span>by：<a href=\"" + UrlHelper.MemberUrl(items[0].idUser) + "\" target=\"_blank\" title=\"" + items[0].Author + "\">" + items[0].Author + "</a></span>");
    //            sb.AppendLine(head + "\t\t<p>" + items[0].Subtract + "...</p>");
    //            sb.AppendLine(head + "\t</div>");
    //            sb.AppendLine(head + "<ul class=\"htlist\">");
    //            for (int i = 1; i <= 15 && i < items.Count; i++)
    //            {
    //                ks = "";
    //                sb.AppendLine(head + "\t<li>");
    //                if (hlnk[items[i].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[i].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
    //                sb.AppendLine(head + "\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\" title=\"" + items[i].Title + "\">" + items[i].Title + "</a></li>");
    //            }
    //            sb.AppendLine(head + "</ul>");
    //        }

    //        // 第三段
    //        if ((idPosition >= 114101 && idPosition <= 117099) || (idPosition >= 117101 && idPosition <= 118100))
    //        {
    //            sb.AppendLine("<div class=\"tw\">");
    //            sb.AppendLine(head + "\t\t<a href=\"" + UrlHelper.BlogUrl(items[0].id) + "\" target=\"_blank\"><img src=\"" + items[0].Image + "\" width=\"100\" height=\"100\"></a>");
    //            ks = "";
    //            if (hlnk[items[0].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[0].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
    //            sb.AppendLine(head + "\t\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[0].id) + "\" class=\"title\" target=\"_blank\" title=\"" + items[0].Title + "\">" + items[0].Title + "</a>");
    //            sb.AppendLine(head + "\t\t<span>by：<a href=\"" + UrlHelper.MemberUrl(items[0].idUser) + "\" target=\"_blank\" title=\"" + items[0].Author + "\">" + items[0].Author + "</a></span>");
    //            sb.AppendLine(head + "\t\t<p>" + items[0].Subtract + "...</p>");
    //            sb.AppendLine(head + "\t</div>");
    //            sb.AppendLine(head + "<ul class=\"htlist\">");
    //            for (int i = 1; i <= 7 && i < items.Count; i++)
    //            {
    //                ks = "";
    //                sb.AppendLine(head + "\t<li>");
    //                if (hlnk[items[i].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[i].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
    //                sb.AppendLine(head + "\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\" title=\"" + items[i].Title + "\">" + items[i].Title + "</a></li>");
    //            }
    //            sb.AppendLine(head + "</ul>");
    //        }

    //        // 第一段右侧第1个
    //        if (idPosition == 102110)
    //        {
    //            sb.AppendLine(head + "<li class=\"ceshu1\">");
    //            ks = "";
    //            if (hlnk[items[0].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[0].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";

    //            sb.AppendLine(head + "\t<em><a href=\"" + UrlHelper.MemberUrl(items[0].idUser) + "\" target=\"_blank\"  title=\"" + items[0].Author + "\">" + items[0].Author + "</a></em>");
    //            sb.AppendLine(head + "\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[0].id) + "\" target=\"_blank\" title=\"" + items[0].Title + "\">" + items[0].Title + "</a></li> ");
    //            for (int i = 1; i <= 4 && i < items.Count; i++)
    //            {
    //                ks = "";
    //                sb.AppendLine(head + "<li>");
    //                if (hlnk[items[i].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[i].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
    //                sb.AppendLine(head + "\t<em><a href=\"" + UrlHelper.MemberUrl(items[i].idUser) + "\" target=\"_blank\" title=\"" + items[i].Author + "\">" + items[i].Author + "</a></em>");
    //                sb.AppendLine(head + "\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\" title=\"" + items[i].Title + "\">" + items[i].Title + "</a></li>");
    //            }
    //        }
    //        // 第一段右侧第2,3,4个
    //        if (idPosition >= 102120 && idPosition <= 102140)
    //        {
    //            sb.AppendLine(head + "<li class=\"ceshu2\">");
    //            ks = "";
    //            if (hlnk[items[0].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[0].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
    //            sb.AppendLine(head + "\t<em><a href=\"" + UrlHelper.MemberUrl(items[0].idUser) + "\" target=\"_blank\"  title=\"" + items[0].Author + "\">" + items[0].Author + "</a></em>");
    //            sb.AppendLine(head + "\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[0].id) + "\" target=\"_blank\" title=\"" + items[0].Title + "\">" + items[0].Title + "</a>");
    //            sb.AppendLine(head + "</li>");
    //            for (int i = 1; i <= 4 && i < items.Count; i++)
    //            {
    //                sb.AppendLine(head + "<li>");
    //                ks = "";
    //                if (hlnk[items[i].id] != null) ks = "<a href=\"" + UrlHelper.SubjectsUrl(items[i].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
    //                sb.AppendLine(head + "\t<em><a href=\"" + UrlHelper.MemberUrl(items[i].idUser) + "\" target=\"_blank\" title=\"" + items[i].Author + "\">" + items[i].Author + "</a></em>");
    //                sb.AppendLine(head + "\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\" title=\"" + items[i].Title + "\">" + items[i].Title + "</a></li>");

    //            }
    //        }
    //        // 第二段左侧专家专栏
    //        if (idPosition == 103100)
    //        {
    //            for (int i = 0; i < 4 && i < items.Count; i++)
    //            {
    //                if ((i % 2) == 0)
    //                {
    //                    sb.AppendLine(head + "<li>");
    //                }
    //                else
    //                {
    //                    sb.AppendLine(head + "<li class=\"lir\">");
    //                }
    //                sb.AppendLine(head + "\t\t<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\"><img src=\"" + items[i].Image + "\" width=\"100\" height=\"100\"></a>");


    //                ks = "";
    //                if (hlnk[items[i].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[i].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
    //                sb.AppendLine(head + "\t\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\" class=\"title\" title=\"" + items[i].Title + "\">" + items[i].Title + "</a>");
    //                sb.AppendLine(head + "\t\t<span>by：<a href=\"" + UrlHelper.MemberUrl(items[i].idUser) + "\" target=\"_blank\"  title=\"" + items[i].Author + "\">" + items[i].Author + "</a></span>");
    //                sb.AppendLine(head + "<p>" + "\t\t" + items[i].Subtract + "</p>");
    //                sb.AppendLine(head + "</li>");
    //            }
    //        }

    //        // 第3段左侧编辑推荐
    //        if (idPosition == 104100)
    //        {
    //            for (int i = 0; i < 4 && i < items.Count; i++)
    //            {
    //                if ((i % 2) == 0)
    //                {
    //                    sb.AppendLine(head + "<li>");
    //                }
    //                else
    //                {
    //                    sb.AppendLine(head + "<li class=\"lir\">");
    //                }
    //                sb.AppendLine(head + "\t\t<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\"><img src=\"" + items[i].Image + "\" width=\"100\" height=\"100\"></a>");


    //                ks = "";
    //                if (hlnk[items[i].id] != null) ks = " <a href=\"" + UrlHelper.SubjectsUrl(items[i].id) + "\" target=\"_blank\" class=\"subject\">[专题]</a> ";
    //                sb.AppendLine(head + "\t\t" + ks + "<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\" class=\"title\" title=\"" + items[i].Title + "\">" + items[i].Title + "</a>");
    //                sb.AppendLine(head + "\t\t<span>by：<a href=\"" + UrlHelper.MemberUrl(items[i].idUser) + "\" target=\"_blank\"  title=\"" + items[i].Author + "\">" + items[i].Author + "</a></span>");
    //                sb.AppendLine(head + "<p>" + "\t\t" + items[i].Subtract + "</p>");
    //                sb.AppendLine(head + "</li>");
    //            }
    //        }

    //        // 右侧视频
    //        if (idPosition == 130100)
    //        {
    //            Images hmg = new Images();
    //            for (int i = 0; i < 6 && i < items.Count; i++)
    //            {
    //                string simg = items[i].Image;
    //                if (simg.Length < 1 || simg.Contains("/undefined"))
    //                {
    //                    simg = "";
    //                    int pcnt = 0;
    //                    List<ImagesInfo> xlist = hmg.PageList(1, 10, "WHERE idInfo=" + items[i].id, "ORDER BY id DESC", out pcnt);
    //                    if (pcnt > 0) { simg = xlist[0].cImageUrl; }
    //                    if (simg.Length < 1) simg = "/images/undefined-video.jpg";
    //                }

    //                sb.AppendLine(head + "<li>");
    //                sb.AppendLine(head + "\t<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" alt=\"" + items[i].Title + "\" title=\"" + items[i].Title + "\" target=\"_blank\"><img src=\"" + simg + "\" width=\"120\" height=\"102\">" + items[i].Title + "</a>");
    //                sb.AppendLine(head + "</li>");
    //            }
    //        }

    //        // 右侧图片
    //        if (idPosition == 140100)
    //        {
    //            Images hmg = new Images();
    //            for (int i = 0; i < 4 && i < items.Count; i++)
    //            {
    //                string simg = items[i].Image;
    //                if (simg.Length < 1 || simg.Contains("undefined"))
    //                {
    //                    simg = "";
    //                    int pcnt = 0;
    //                    List<ImagesInfo> xlist = hmg.PageList(1, 10, "WHERE idInfo=" + items[i].id, "ORDER BY id DESC", out pcnt);
    //                    if (pcnt > 0) { simg = xlist[0].cImageUrl; }
    //                    if (simg.Length < 1) simg = "/images/undefined-image.jpg";
    //                }
    //                //string simg = "/images/undefined-image.jpg";
    //                //int pcnt = 0;
    //                //List<ImagesInfo> xlist = hmg.PageList(1, 10, "WHERE idInfo=" + items[i].id, "ORDER BY id DESC", out pcnt);
    //                //if (pcnt > 0) { simg = xlist[0].cImageUrl; }

    //                sb.AppendLine(head + "<li>");
    //                sb.AppendLine(head + "\t<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" alt=\"" + items[i].Title + "\" title=\"" + items[i].Title + "\" target=\"_blank\"><img src=\"" + simg + "\" width=\"120\" height=\"102\">" + items[i].Title + "</a>");
    //                sb.AppendLine(head + "</li>");
    //            }
    //        }

    //        // 左侧动画
    //        if (idPosition == 101100)
    //        {
    //            head = "\t\t\t";
    //            sb.AppendLine(head + "<a target=\"_blank\" id=\"bigImage\">");
    //            sb.AppendLine(head + "\t<div id=\"preImage\">");
    //            sb.AppendLine(head + "\t<div id=\"preTitle\">");
    //            sb.AppendLine(head + "\t<div id=\"longText\">");
    //            sb.AppendLine(head + "\t</div>");
    //            sb.AppendLine(head + "\t<div id=\"had_right\">");
    //            sb.AppendLine(head + "\t\t<div id=\"had_icon1\" class=\"had_yes\" onmouseover=\"RollStop(-1)\" onmouseout=\"RollBegin()\" onblur=\"RollBegin()\">1</div>");
    //            sb.AppendLine(head + "\t\t<div id=\"had_icon2\" class=\"had_no\" onmouseover=\"RollStop(0)\" onmouseout=\"RollBegin()\" onblur=\"RollBegin()\">2</div>");
    //            sb.AppendLine(head + "\t\t<div id=\"had_icon3\" class=\"had_no\" onmouseover=\"RollStop(1)\" onmouseout=\"RollBegin()\" onblur=\"RollBegin()\">3</div>");
    //            sb.AppendLine(head + "\t\t<div id=\"had_icon4\" class=\"had_no\" onmouseover=\"RollStop(2)\" onmouseout=\"RollBegin()\" onblur=\"RollBegin()\">4</div>");
    //            sb.AppendLine(head + "\t\t<div id=\"had_icon5\" class=\"had_no\" onmouseover=\"RollStop(3)\" onmouseout=\"RollBegin()\" onblur=\"RollBegin()\">5</div>");
    //            sb.AppendLine(head + "\t</div>");
    //            sb.AppendLine(head + "\t</div>");
    //            sb.AppendLine(head + "\t</div>");
    //            sb.AppendLine(head + "</a>");

    //            sb.AppendLine(head + "<script language=\"javascript\">");
    //            sb.AppendLine(head + "var homeAds = [");
    //            for (int i = 0; i < 5 && i < items.Count; i++)
    //            {
    //                if (items[i].ImageIndex > 0)
    //                {
    //                    sb.AppendLine(head + "\t['" + items[i].Image + "','" + items[i].Title + "','" + UrlHelper.BlogUrl(items[i].id) + "'],");
    //                }
    //                else
    //                {
    //                    sb.AppendLine(head + "\t['/images/temp/A0" + (i + 1) + ".jpg','" + items[i].Title + "','" + UrlHelper.BlogUrl(items[i].id) + "'],");
    //                }
    //            }
    //            sb.AppendLine(head + "];");
    //            sb.AppendLine(head + "</script>");
    //            sb.AppendLine(head + "<script language=\"javascript\" src=\"/Common/jRoll.js\"></script>");
    //        }

    //        cacheBuffer = sb.ToString();
    //        TCache.SaveString(cacheName, cacheBuffer);

    //        return cacheBuffer;
    //    }

    //    public string Focus(int idPosition, int number)
    //    {
    //        #region 缓存机制
    //        //string cacheName = "CACHE_OF_HOTS_" + idPosition;
    //        string cacheBuffer = ""; // (string)TCache.LoadString(cacheName);
    //        if (cacheBuffer.Length > 0)
    //        {
    //            return cacheBuffer;
    //        }
    //        #endregion

    //        // 读取发布信息
    //        int page_count = 0;
    //        BlogPublish bp = new BlogPublish();
    //        List<BlogPublishInfo> list = bp.PageList(1, 100, "WHERE idPosition>=" + idPosition + " AND idPosition<" + (idPosition + 1000000), "ORDER BY id DESC", out page_count);
    //        if (page_count == 0) return "no issues";
    //        if (list.Count == 0) return "no issues";

    //        // 建立博客ID列表
    //        StringBuilder sn = new StringBuilder();
    //        foreach (BlogPublishInfo bu in list)
    //        {
    //            sn.Append(bu.idInfo + ",");
    //        }

    //        // 读取相关博客信息，并建立相应的哈希表
    //        Blog blogs = new Blog();
    //        List<BlogInfo> blist = blogs.PageList(1, 100, "WHERE id IN (" + XString.UnTail(sn.ToString()) + ")", "ORDER BY id DESC", out page_count);

    //        if (blist == null) return "A:" + XString.UnTail(sn.ToString());

    //        Hashtable hash = new Hashtable();
    //        foreach (BlogInfo bv in blist)
    //        {
    //            hash.Add(bv.id, bv);
    //        }

    //        // 读取相关博客摘要信息，并建立相应的哈希表
    //        BlogSummary summary = new BlogSummary();
    //        List<BlogSummaryInfo> slist = summary.PageList(1, 100, "WHERE idBlog IN (" + XString.UnTail(sn.ToString()) + ")", "", out page_count);

    //        if (slist == null) return "B:" + XString.UnTail(sn.ToString());

    //        Hashtable hast = new Hashtable();
    //        foreach (BlogSummaryInfo sv in slist)
    //        {
    //            hast.Add(sv.idBlog, sv);
    //        }

    //        // 创建用于显示的信息列表
    //        List<HotInfo> items = new List<HotInfo>();
    //        foreach (BlogPublishInfo bu in list)
    //        {
    //            BlogInfo bg = (BlogInfo)hash[bu.idInfo];
    //            if (bg == null) continue;

    //            BlogSummaryInfo sg = (BlogSummaryInfo)hast[bu.idInfo];
    //            if (sg == null) continue;

    //            HotInfo h = new HotInfo();
    //            h.id = bg.id;
    //            h.idUser = bg.idUser;
    //            //h.idHref = bg.idHref;
    //            h.Author = bg.cLoginName;
    //            h.Image = "/images/temp/02.gif";
    //            h.Title = bg.cTitle;
    //            h.Focus = sg.iFocus;
    //            //h.Subtract = XString.Trunc(bg.cContent, 128);
    //            h.Subtract = XString.ContentTrunc(HTMLHelper.NoHTML(bg.cContent.ToString()), 128);
    //            items.Add(h);

    //        }
    //        if (items.Count == 0) return "...";

    //        items.Sort(delegate(HotInfo a, HotInfo b) { return b.Focus - a.Focus; });
    //        string substr = "";
    //        StringBuilder sb = new StringBuilder();
    //        string head = "\t\t\t\t";
    //        for (int i = 0; i < number && i < items.Count; i++)
    //        {
    //            substr = XString.Trunc(items[i].Title, 24);
    //            sb.AppendLine(head + "\t<li><em><a href=\"" + UrlHelper.MemberUrl(items[i].idUser) + "\" target=\"_blank\" title=\"" + items[i].Author + "\">" + items[i].Author + "</a></em>");
    //            sb.AppendLine(head + "\t<a href=\"" + UrlHelper.BlogUrl(items[i].id) + "\" target=\"_blank\" title=\"" + items[i].Title + "\">" + substr + "</a></li>");
    //        }

    //        cacheBuffer = sb.ToString();
    //        //TCache.SaveString(cacheName, cacheBuffer, 20);

    //        return cacheBuffer;
    //    }
    //}
}
