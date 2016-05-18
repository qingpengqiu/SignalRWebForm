
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    public partial class BlogPublish : SQLHelper
    {
        public string Topics(int idPosition, int pageSize, ref int pageIndex, ref int pageCount)
        {
            List<BlogPublishInfo> items = PageList(pageIndex, pageSize, "WHERE idPosition=" + idPosition, "ORDER BY id DESC", out pageCount);
            if (pageCount == 0) { return ""; }

            StringBuilder sx = new StringBuilder();
            foreach (BlogPublishInfo bv in items)
            {
                sx.Append(bv.idInfo + ",");
            }

            if ((pageCount % pageSize) > 0)
            {
                pageCount = (pageCount - (pageCount % pageSize)) / pageSize + 1;
            }
            else
            {
                pageCount = pageCount / pageSize;
            }

            int pc = 0;

            Blog blogs = new Blog();
            List<BlogInfo> list = blogs.PageList(1, pageSize, "WHERE id IN(" + XString.UnTail(sx.ToString()) + ")", "ORDER BY id DESC", out pc);
            if (pc == 0) { return ""; }

            #region 性能
            StringBuilder sy = new StringBuilder();
            foreach (BlogInfo bu in list)
            {
                sy.Append(bu.id + ",");
            }

            Images imgs = new Images();
            List<ImagesInfo> mlist = imgs.PageList(1, 100, "idInfo IN(" + XString.UnTail(sy.ToString()) + ")", "ORDER BY id ASC", out pc);
            Hashtable himg = new Hashtable();
            if (pc > 0)
            {
                foreach (ImagesInfo mu in mlist)
                {
                    if (himg[mu.idInfo] == null)
                    {
                        himg.Add(mu.idInfo, mu);
                    }
                }
            }
            BlogSummary bs = new BlogSummary();
            List<BlogSummaryInfo> glist = bs.PageList(1, 100, "idBlog IN(" + XString.UnTail(sy.ToString()) + ")", "ORDER BY idBlog ASC", out pc);
            Hashtable hsmy = new Hashtable();
            if (pc > 0)
            {
                foreach (BlogSummaryInfo mv in glist)
                {
                    if (hsmy[mv.idBlog] == null)
                    {
                        hsmy.Add(mv.idBlog, mv);
                    }
                }
            }

            #endregion

            StringBuilder sb = new StringBuilder();
            int idx = 1;
            foreach (BlogInfo bu in list)
            {
                sb.AppendLine("<span id=\"blog_total_" + idx + "\">");
                sb.AppendLine("<div id=\"blog_m_top\"></div>");
                sb.Append("<div id=\"blog_m_mid\">");
                sb.AppendLine("<div id=\"blog_m_title\">");
                sb.AppendLine("<a href=\"" + UrlHelper.MemberUrl(bu.idUser) + "\">" + bu.cLoginName + "</a> : <a href=\"" + UrlHelper.BlogUrl(bu.id) + "\">" + bu.cTitle + "</a>");
                sb.AppendLine("</div>");
                sb.AppendLine("<div id=\"blog_editable_" + idx + "\" class=\"blog_m_edt\" style=\"display:none;\">");
                sb.AppendLine("</div>");

                ImagesInfo img = (ImagesInfo)himg[bu.id];

                if (img != null)
                {
                    sb.AppendLine("<div id=\"blog_m_memo2\">");
                    sb.AppendLine("" + XString.ContentTrunc(bu.cContent, 400) + "...<br>");
                    sb.AppendLine("<img src=\"" + img.cImageUrl + "\" width=\"180\" style=\"border:solid 3px #CCCCCC;\" onclick=\"ImageShow(this)\">");
                }
                else
                {
                    sb.AppendLine("<div id=\"blog_m_memo\">");
                    sb.AppendLine("" + XString.ContentTrunc(bu.cContent, 400) + "...<br>");
                }

                sb.AppendLine("</div>");
                sb.AppendLine("<div id=\"blog_m_left\">");
                sb.AppendLine("<a href=\"" + UrlHelper.MemberUrl(bu.idUser) + "\">" + bu.cLoginName + "</a> :" + bu.dCreate.ToString("yyyy-MM-dd HH:mm:ss") + " <a href=\"" + UrlHelper.BlogUrl(bu.id) + "\">&gt;&gt; 阅读全文</a>");
                sb.AppendLine("</div>");
                sb.AppendLine("<div id=\"blog_m_right\">");

                BlogSummaryInfo bg = (BlogSummaryInfo)hsmy[bu.id];
                if (bg == null) bg = new BlogSummaryInfo();

                sb.Append("阅读(" + bg.iShowTimes + ") ");
                sb.Append("关注(" + bg.iFocus + ") ");
                sb.Append("顶(" + bg.iDing + ") ");
                sb.AppendLine("评论(" + bg.iDiscuss + ")");
                sb.AppendLine("</div>");
                sb.AppendLine("</div>");
                sb.AppendLine("<div id=\"blog_m_bot\"></div>");
                sb.AppendLine("<div id=\"blog_m_spc\"></div>");
                sb.AppendLine("</span>");

                idx++;
            }

            string PageNext = "<div class=\"v3\"><a href=\"" + UrlHelper.TopicsUrl(idPosition, pageIndex + 1) + "\">&gt;&gt;&gt; 下一页</a></div>";
            if (pageCount <= 1) PageNext = "";
            if (pageIndex >= pageCount) PageNext = "";

            if (PageNext.Length > 0)
            {
                sb.AppendLine("<div style=\"width:705px;height:30px;text-align:right;padding-right:10px;\" title=" + pageCount + ">");
                sb.AppendLine(PageNext);
                sb.AppendLine("</div>");
            }

            return sb.ToString();
        }

        public string Topics_new(int idPosition, int pageSize, ref int pageIndex, ref int pageCount)
        {
            List<BlogPublishInfo> items = PageList(pageIndex, pageSize, "WHERE idPosition=" + idPosition, "ORDER BY id DESC", out pageCount);
            if (pageCount == 0) { return ""; }
            if (items == null)
            {
                //
                string PageNext1 = "<div class=\"page\" style=\"line-height: 142px;\"><a href=\"/infocenter/Topics.aspx?id=" + idPosition + "\">&gt;&gt;&gt; 木有了，返回首页吧</a></div>";
                StringBuilder sb1 = new StringBuilder();
                sb1.AppendLine("<div style=\"width:705px;height:30px;text-align:right;padding-right:10px;\" title=" + pageCount + ">");
                sb1.AppendLine(PageNext1);
                sb1.AppendLine("</div>");

                return sb1.ToString();
            }
            StringBuilder sx = new StringBuilder();
            foreach (BlogPublishInfo bv in items)
            {
                sx.Append(bv.idInfo + ",");
            }

            if ((pageCount % pageSize) > 0)
            {
                pageCount = (pageCount - (pageCount % pageSize)) / pageSize + 1;
            }
            else
            {
                pageCount = pageCount / pageSize;
            }

            int pc = 0;

            Blog blogs = new Blog();
            List<BlogInfo> list = blogs.PageList(1, pageSize, "WHERE id IN(" + XString.UnTail(sx.ToString()) + ")", "ORDER BY id DESC", out pc);
            if (pc == 0) { return ""; }

            #region 性能
            StringBuilder sy = new StringBuilder();
            foreach (BlogInfo bu in list)
            {
                sy.Append(bu.id + ",");
            }

            Images imgs = new Images();
            List<ImagesInfo> mlist = imgs.PageList(1, 100, "id in (select max(id) from [YP_DB_3].[dbo].[tblIMAGES] group by idInfo) and idInfo IN(" + XString.UnTail(sy.ToString()) + ")", "ORDER BY id ASC", out pc);
            Hashtable himg = new Hashtable();
            if (pc > 0)
            {
                foreach (ImagesInfo mu in mlist)
                {
                    if (himg[mu.idInfo] == null)
                    {
                        himg.Add(mu.idInfo, mu);
                    }
                }
            }
            BlogSummary bs = new BlogSummary();
            List<BlogSummaryInfo> glist = bs.PageList(1, 100, "idBlog IN(" + XString.UnTail(sy.ToString()) + ")", "ORDER BY idBlog ASC", out pc);
            Hashtable hsmy = new Hashtable();
            if (pc > 0)
            {
                foreach (BlogSummaryInfo mv in glist)
                {
                    if (hsmy[mv.idBlog] == null)
                    {
                        hsmy.Add(mv.idBlog, mv);
                    }
                }
            }

            #endregion

            StringBuilder sb = new StringBuilder();
            foreach (BlogInfo bu in list)
            {
                sb.AppendLine("<li>");
                sb.AppendLine("<a  class=\"title\" href=\"" + UrlHelper.MemberUrl(bu.idUser) + "\">" + bu.cLoginName + ":</a><a href=\"" + UrlHelper.BlogUrl(bu.id) + "\" class=\"title\">" + bu.cTitle + "</a>");
                sb.AppendLine("<span>" + bu.dCreate.ToString("yyyy-MM-dd HH:mm:ss") + "</span>");
                ImagesInfo img = (ImagesInfo)himg[bu.id];

                if (img != null)
                {
                    sb.AppendLine("<p>");
                    sb.AppendLine("" + XString.ContentTrunc(HTMLHelper.NoHTML(HTMLHelper.NoHTML(bu.cContent)), 400) + "");
                    sb.AppendLine("</p>");
                    sb.AppendLine("<img src=\"" + img.cImageUrl + "\" width=\"180\" style=\"border:solid 3px #CCCCCC;\" />");
                }
                else
                {
                    sb.AppendLine("<p>");
                    sb.AppendLine("" + XString.ContentTrunc(HTMLHelper.NoHTML(HTMLHelper.NoHTML(bu.cContent)), 400) + "");
                    sb.AppendLine("</p>");
                }
                sb.AppendLine("<div class=\"article-bot\">");
                sb.AppendLine("<a href=\"" + UrlHelper.BlogUrl(bu.id) + "\">查看全文>></a>");
                BlogSummaryInfo bg = (BlogSummaryInfo)hsmy[bu.id];
                if (bg == null) bg = new BlogSummaryInfo();

                sb.Append("阅读(" + bg.iShowTimes + ") ");
                sb.Append("关注(" + bg.iFocus + ") ");
                sb.Append("顶(" + bg.iDing + ") ");
                sb.AppendLine("评论(" + bg.iDiscuss + ")");
                sb.AppendLine("</div>");
                sb.AppendLine("</li>");
            }
            int pagedex = pageIndex + 1;
            string PageNext = "<div class=\"page\"><a href=\"/infocenter/Topics.aspx?id=" + idPosition + "&page=" + pagedex + "\">&gt;&gt;&gt; 下一页</a></div>";
            if (pageCount <= 1) PageNext = "";
            if (pageIndex >= pageCount) PageNext = "";

            if (PageNext.Length > 0)
            {
                sb.AppendLine("<div style=\"width:705px;height:30px;text-align:right;padding-right:10px;\" title=" + pageCount + ">");
                sb.AppendLine(PageNext);
                sb.AppendLine("</div>");
            }

            return sb.ToString();
        }
        public string Topics_page(int idPosition, int pageSize, int pageIndex)
        {
            int pageCount = 0;
            List<BlogPublishInfo> items = PageList(pageIndex, pageSize, "WHERE idPosition=" + idPosition, "ORDER BY id DESC", out pageCount);
           
            StringBuilder sx = new StringBuilder();
            foreach (BlogPublishInfo bv in items)
            {
                sx.Append(bv.idInfo + ",");
            }
            int pc = 0;
            Blog blogs = new Blog();
            List<BlogInfo> list = blogs.PageList(1, pageSize, "WHERE id IN(" + XString.UnTail(sx.ToString()) + ")", "ORDER BY id DESC", out pc);
            if (pc == 0) { return ""; }
            #region 性能
            StringBuilder sy = new StringBuilder();
            foreach (BlogInfo bu in list)
            {
                sy.Append(bu.id + ",");
            }

            Images imgs = new Images();
            List<ImagesInfo> mlist = imgs.PageList(1, 100, "id in (select max(id) from [YP_DB_3].[dbo].[tblIMAGES] group by idInfo) and idInfo IN(" + XString.UnTail(sy.ToString()) + ")", "ORDER BY id ASC", out pc);
            Hashtable himg = new Hashtable();
            if (pc > 0)
            {
                foreach (ImagesInfo mu in mlist)
                {
                    if (himg[mu.idInfo] == null)
                    {
                        himg.Add(mu.idInfo, mu);
                    }
                }
            }
            BlogSummary bs = new BlogSummary();
            List<BlogSummaryInfo> glist = bs.PageList(1, 100, "idBlog IN(" + XString.UnTail(sy.ToString()) + ")", "ORDER BY idBlog ASC", out pc);
            Hashtable hsmy = new Hashtable();
            if (pc > 0)
            {
                foreach (BlogSummaryInfo mv in glist)
                {
                    if (hsmy[mv.idBlog] == null)
                    {
                        hsmy.Add(mv.idBlog, mv);
                    }
                }
            }

            #endregion

            StringBuilder sb = new StringBuilder();
            foreach (BlogInfo bu in list)
            {
                sb.AppendLine("<li>");
                sb.AppendLine("<a  class=\"title\"  target=\"_blank\" href=\"" + UrlHelper.MemberUrl(bu.idUser) + "\">" + bu.cLoginName + ":</a><a  target=\"_blank\" href=\"" + UrlHelper.BlogUrl(bu.id) + "\" class=\"title\">" + bu.cTitle + "</a>");
                sb.AppendLine("<span>" + bu.dCreate.ToString("yyyy-MM-dd HH:mm:ss") + "</span>");
                ImagesInfo img = (ImagesInfo)himg[bu.id];

                if (img != null)
                {
                    sb.AppendLine("<p>");
                    sb.AppendLine("" + XString.ContentTrunc(HTMLHelper.NoHTML(HTMLHelper.NoHTML(bu.cContent)), 400) + "");
                    sb.AppendLine("</p>");
                    sb.AppendLine("<img src=\"" + img.cImageUrl + "\"/>");
                }
                else
                {
                    sb.AppendLine("<p>");
                    sb.AppendLine("" + XString.ContentTrunc(HTMLHelper.NoHTML(HTMLHelper.NoHTML(bu.cContent)), 400) + "");
                    sb.AppendLine("</p>");
                }
                sb.AppendLine("<div class=\"article-bot\">");
                sb.AppendLine("<a  target=\"_blank\" href=\"" + UrlHelper.BlogUrl(bu.id) + "\">查看全文>></a>");
                BlogSummaryInfo bg = (BlogSummaryInfo)hsmy[bu.id];
                if (bg == null) bg = new BlogSummaryInfo();

                sb.Append("阅读(" + bg.iShowTimes + ") ");
                sb.Append("关注(" + bg.iFocus + ") ");
                sb.Append("顶(" + bg.iDing + ") ");
                sb.AppendLine("评论(" + bg.iDiscuss + ")");
                sb.AppendLine("</div>");
                sb.AppendLine("</li>");
            }
            return sb.ToString();
        }
    }
}
