
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    public partial class Blog : SQLHelper
    {
        /// <summary>
        /// 我的博客或TA的博客
        /// </summary>
        /// <param name="idUser"></param>
        /// <param name="idBrowser"></param>
        /// <param name="groupIndex"></param>
        /// <param name="pageSize"></param>
        /// <param name="pageIndex"></param>
        /// <param name="pageCount"></param>
        /// <returns></returns>
        public string UsersBlog(int idUser, int idBrowser, int groupIndex, int pageSize, ref int pageIndex, ref int pageCount)
        {
            string sql = "WHERE idUser=" + idUser;
            if (groupIndex > 0)
            {
                sql = "WHERE idUser=" + idUser + " AND idPersonGroup=" + groupIndex;
            }

            List<BlogInfo> list = PageList(pageIndex, pageSize, sql, "ORDER BY id DESC", out pageCount);
            if (pageCount == 0) return "";

            if ((pageCount % pageSize) > 0)
            {
                pageCount = (pageCount - (pageCount % pageSize)) / pageSize + 1;
            }
            else
            {
                pageCount = pageCount / pageSize;
            }

            #region 性能优化相关
            StringBuilder sy = new StringBuilder();
            foreach (BlogInfo bu in list)
            {
                sy.Append(bu.id + ",");
            }

            int pc = 0;
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
                sb.Append("<div id=\"blog_m_mid\" ");
                if (idBrowser == bu.idUser)
                {
                    sb.Append(" onmouseover=\"document.getElementById('blog_editable_" + idx + "').style.display='';\"");
                    sb.Append(" onmouseout=\"document.getElementById('blog_editable_" + idx + "').style.display='none';\"");
                }
                sb.AppendLine(">");
                sb.AppendLine("<div id=\"blog_m_title\">");
                sb.AppendLine("<a href=\"" + UrlHelper.BlogUrl(bu.id) + "\">" + bu.cTitle + "</a>");
                sb.AppendLine("</div>");
                if (idBrowser == bu.idUser)
                {
                    sb.AppendLine("<div id=\"blog_editable_" + idx + "\" class=\"blog_m_edt\" style=\"display:none;\">");
                    sb.AppendLine("<span onclick=\"BlogEdit(" + bu.id + ")\" style=\"color:#0000EE;\">编辑</span> ");
                    sb.AppendLine("<span onclick=\"BlogDelete(" + idx + "," + bu.id + ",'" + XString.MD5(bu.id.ToString()) + "')\" style=\"color:#EE0000;\">删除</span>");
                    sb.AppendLine("</div>");
                }

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
                sb.AppendLine("" + bu.dCreate.ToString("yyyy-MM-dd HH:mm:ss") + " <a href=\"" + UrlHelper.BlogUrl(bu.id) + "\">&gt;&gt; 阅读全文</a>");
                sb.AppendLine("</div>");
                sb.AppendLine("<div id=\"blog_m_right\">");

                BlogSummaryInfo bg = (BlogSummaryInfo)hsmy[bu.id];
                if (bg == null) bg = new BlogSummaryInfo();

                sb.Append("<a href=\"" + UrlHelper.BlogUrl(bu.id) + "\">阅读</a>(" + bg.iShowTimes + ") ");
                sb.Append("关注(" + bg.iFocus + ") ");
                sb.Append("顶(" + bg.iDing + ") ");
                sb.AppendLine("<a href=\"" + UrlHelper.BlogUrl(bu.id) + "#AA\">评论</a>(" + bg.iDiscuss + ")");
                sb.AppendLine("</div>");
                sb.AppendLine("</div>");
                sb.AppendLine("<div id=\"blog_m_bot\"></div>");
                sb.AppendLine("<div id=\"blog_m_spc\"></div>");
                sb.AppendLine("</span>");

                idx++;
            }

            #region 下一页链接
            string PageNext = "<div class=\"v3\"><a href=\"" + UrlHelper.MemberUrl(idUser, pageIndex + 1) + "\">&gt;&gt;&gt; 下一页</a></div>";
            if (groupIndex > 0)
            {
                PageNext = "<div class=\"v3\"><a href=\"" + UrlHelper.MemberUrl(idUser, groupIndex, pageIndex + 1) + "\">&gt;&gt;&gt; 下一页</a></div>";
            }
            if (pageCount <= 1) PageNext = "";
            if (pageIndex >= pageCount) PageNext = "";

            if (PageNext.Length > 0)
            {
                sb.AppendLine("<div style=\"width:705px;height:30px;text-align:right;padding-right:10px;\" title=" + pageCount + ">");
                sb.AppendLine(PageNext);
                sb.AppendLine("</div>");
            }
            #endregion

            return sb.ToString();
        }

        /// <summary>
        /// 我的装备或TA的装备
        /// </summary>
        /// <param name="idUser"></param>
        /// <param name="idBrowser"></param>
        /// <param name="groupIndex"></param>
        /// <param name="pageSize"></param>
        /// <param name="pageIndex"></param>
        /// <param name="pageCount"></param>
        /// <returns></returns>
        public string UsersAttentions(string style, string qry, int idUser, int idBrowser, int pageSize, ref int pageIndex, ref int pageCount)
        {
            StringBuilder sql = new StringBuilder();

            #region 装备
            if (style == "Equipments")
            {
                // 我发的
                if (qry == "me")
                {
                    sql.Remove(0, sql.Length);
                    sql.Append("WHERE ");
                    sql.Append("idUser=" + idUser + " ");
                    sql.Append("AND ");
                    sql.Append("id IN (SELECT idBlog FROM [YP_DB_5].[dbo].[tblPRODUCTS])");
                }
                // 我关注的
                if (qry == "focus")
                {
                    sql.Remove(0, sql.Length);
                    sql.Append("WHERE ");
                    sql.Append("id IN (SELECT idInfo FROM [YP_DB_3].[dbo].[tblATTENTION] WHERE idUser=" + idUser + ")");
                    sql.Append("AND ");
                    sql.Append("id IN (SELECT idBlog FROM [YP_DB_5].[dbo].[tblPRODUCTS])");
                }
            }
            #endregion

            #region 竞赛
            if (style == "Competetions")
            {
                // 全部赛事
                if (qry == "all")
                {
                    sql.Remove(0, sql.Length);
                    sql.Append("WHERE ");
                    sql.Append("id IN (SELECT idBlog FROM [YP_DB_4].[dbo].[tblRACE_COMPETETION])");
                }
                // 我参与的
                if (qry == "join")
                {
                    sql.Remove(0, sql.Length);
                    sql.Append("WHERE ");
                    sql.Append("id IN (SELECT idBlog FROM [YP_DB_4].[dbo].[tblRACE_COMPETETION] WHERE id IN (SELECT idActivity FROM [YP_DB_4].[dbo].[tblRACE_JOIN] WHERE idUser=" + idUser + "))");
                }
                // 我关注的
                if (qry == "focus")
                {
                    sql.Remove(0, sql.Length);
                    sql.Append("WHERE ");
                    sql.Append("id IN (SELECT idInfo FROM [YP_DB_3].[dbo].[tblATTENTION] WHERE idUser=" + idUser + ") ");
                    sql.Append("AND ");
                    sql.Append("id IN (SELECT idBlog FROM [YP_DB_4].[dbo].[tblRACE_COMPETETION])");
                }
            }
            #endregion

            #region 约跑
            if (style == "Race")
            {
                if (qry == "all")
                {
                    sql.Remove(0, sql.Length);
                    sql.Append("WHERE ");
                    sql.Append("id IN (SELECT idBlog FROM [YP_DB_4].[dbo].[tblRACE_ACTIVITY])");
                }
                // 我发起的
                if (qry == "me")
                {
                    sql.Remove(0, sql.Length);
                    sql.Append("WHERE ");
                    sql.Append("idUser=" + idUser + " ");
                    sql.Append("AND ");
                    sql.Append("id IN (SELECT idBlog FROM [YP_DB_4].[dbo].[tblRACE_ACTIVITY])");
                }
                // 我参与的
                if (qry == "join")
                {
                    sql.Remove(0, sql.Length);
                    sql.Append("WHERE ");
                    sql.Append("id IN (SELECT idBlog FROM [YP_DB_4].[dbo].[tblRACE_ACTIVITY] WHERE id IN (SELECT idActivity FROM [YP_DB_4].[dbo].[tblRACE_JOIN] WHERE idUser=" + idUser + "))");
                }
                // 我关注的
                if (qry == "focus")
                {
                    sql.Remove(0, sql.Length);
                    sql.Append("WHERE ");
                    sql.Append("id IN (SELECT idInfo FROM [YP_DB_3].[dbo].[tblATTENTION] WHERE idUser=" + idUser + ") ");
                    sql.Append("AND ");
                    sql.Append("id IN (SELECT idBlog FROM [YP_DB_4].[dbo].[tblRACE_ACTIVITY])");
                }
                // 搜索
                if (qry.Contains("="))
                {
                    sql.Remove(0, sql.Length);
                    sql.Append("WHERE ");
                    //sql.Append("id IN (SELECT idInfo FROM [YP_DB_3].[dbo].[tblATTENTION] WHERE idUser=" + idUser + ") ");
                    //sql.Append("AND ");
                    sql.Append("id IN (SELECT idBlog FROM [YP_DB_4].[dbo].[tblRACE_ACTIVITY] WHERE " + qry + ")");
                }
            }
            #endregion

            List<BlogInfo> list = PageList(pageIndex, pageSize, sql.ToString(), "ORDER BY id DESC", out pageCount);
            if (pageCount == 0) return "";

            if ((pageCount % pageSize) > 0)
            {
                pageCount = (pageCount - (pageCount % pageSize)) / pageSize + 1;
            }
            else
            {
                pageCount = pageCount / pageSize;
            }

            #region 性能优化相关
            StringBuilder sy = new StringBuilder();
            foreach (BlogInfo bu in list)
            {
                sy.Append(bu.id + ",");
            }

            int pc = 0;
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
                string pre = "m";
                if (idBrowser != bu.idUser) pre = "k";

                sb.AppendLine("<span id=\"blog_total_" + idx + "\">");
                sb.AppendLine("<div id=\"blog_" + pre + "_top\"></div>");
                sb.Append("<div id=\"blog_" + pre + "_mid\" ");
                if (idBrowser == bu.idUser)
                {
                    sb.Append(" onmouseover=\"document.getElementById('blog_editable_" + idx + "').style.display='';\"");
                    sb.Append(" onmouseout=\"document.getElementById('blog_editable_" + idx + "').style.display='none';\"");
                }
                sb.AppendLine(">");
                sb.AppendLine("<div id=\"blog_m_title\">");
                if (idBrowser != bu.idUser)
                {
                    sb.AppendLine("<a href=\"" + UrlHelper.MemberUrl(bu.idUser) + "\">" + bu.cLoginName + "</a> : ");
                }
                sb.AppendLine("<a href=\"" + UrlHelper.BlogUrl(bu.id) + "\">" + bu.cTitle + "</a>");
                sb.AppendLine("</div>");
                if (idBrowser == bu.idUser)
                {
                    sb.AppendLine("<div id=\"blog_editable_" + idx + "\" class=\"blog_m_edt\" style=\"display:none;\">");
                    sb.AppendLine("<span onclick=\"BlogEdit(" + bu.id + ")\" style=\"color:#0000EE;\">编辑</span> ");
                    sb.AppendLine("<span onclick=\"BlogDelete(" + idx + "," + bu.id + ",'" + XString.MD5(bu.id.ToString()) + "')\" style=\"color:#EE0000;\">删除</span>");
                    sb.AppendLine("</div>");
                }

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
                sb.AppendLine("" + bu.dCreate.ToString("yyyy-MM-dd HH:mm:ss") + " <a href=\"" + UrlHelper.BlogUrl(bu.id) + "\">&gt;&gt; 阅读全文</a>");
                sb.AppendLine("</div>");
                sb.AppendLine("<div id=\"blog_m_right\">");

                BlogSummaryInfo bg = (BlogSummaryInfo)hsmy[bu.id];
                if (bg == null) bg = new BlogSummaryInfo();

                sb.Append("<a href=\"" + UrlHelper.BlogUrl(bu.id) + "\">阅读</a>(" + bg.iShowTimes + ") ");
                sb.Append("关注(" + bg.iFocus + ") ");
                sb.Append("顶(" + bg.iDing + ") ");
                sb.AppendLine("<a href=\"" + UrlHelper.BlogUrl(bu.id) + "#AA\">评论</a>(" + bg.iDiscuss + ")");
                sb.AppendLine("</div>");
                sb.AppendLine("</div>");
                sb.AppendLine("<div id=\"blog_" + pre + "_bot\"></div>");
                sb.AppendLine("<div id=\"blog_" + pre + "_spc\"></div>");
                sb.AppendLine("</span>");

                idx++;
            }

            #region 下一页链接
            string PageNext = "<div class=\"v3\"><a href=\"/Utility/My" + style + ".aspx?page=" + (pageIndex + 1) + "\">&gt;&gt;&gt; 下一页</a></div>";
            if (pageCount <= 1) PageNext = "";
            if (pageIndex >= pageCount) PageNext = "";

            if (PageNext.Length > 0)
            {
                sb.AppendLine("<div style=\"width:705px;height:30px;text-align:right;padding-right:10px;\" title=" + pageCount + ">");
                sb.AppendLine(PageNext);
                sb.AppendLine("</div>");
            }
            #endregion

            return sb.ToString();
        }


        /// <summary>
        /// 最新博客
        /// </summary>
        /// <param name="idUser"></param>
        /// <param name="idBrowser"></param>
        /// <param name="groupIndex"></param>
        /// <param name="pageSize"></param>
        /// <param name="pageIndex"></param>
        /// <param name="pageCount"></param>
        /// <returns></returns>
        public string NewestBlog(int pageIndex, int pageSize, string fname, string word)
        {
            StringBuilder sql = new StringBuilder();
            if (word.Length > 0)
            {
                if (fname == "loginname") { sql.Remove(0, sql.Length); sql.Append("WHERE cLoginName LIKE '%" + word + "%'"); }
                if (fname == "title") { sql.Remove(0, sql.Length); sql.Append("WHERE cTitle LIKE '%" + word + "%'"); }
                if (fname == "content") { sql.Remove(0, sql.Length); sql.Append("WHERE cContent LIKE '%" + word + "%'"); }
                if (fname == "video") { sql.Remove(0, sql.Length); sql.Append("WHERE cContent LIKE '%/[FLASH/]%' ESCAPE '/'"); }
                if (fname == "image") { sql.Remove(0, sql.Length); sql.Append("WHERE cContent LIKE '%/[IMG/]%' ESCAPE '/'"); }
            }
            else
            {
                sql.Append("WHERE id IN (SELECT TOP " + (pageSize * 2) + " idInfo FROM [YP_DB_2].[dbo].[tblBLOG_PUBLISH] ORDER BY id DESC)");
            }

            int pageCount = 0;
            List<BlogInfo> list = null;
            if (word == ".")
            {
                int pc1 = 0;
                BlogSummary bs1 = new BlogSummary();
                List<BlogSummaryInfo> slist = bs1.PageList(pageIndex, pageSize, "", "ORDER BY iShowTimes DESC", out pc1);
                if (slist == null) return "";
                if (pc1 == 0) return "";
                StringBuilder sx = new StringBuilder();
                Hashtable hash = new Hashtable();
                foreach (BlogSummaryInfo su in slist)
                {
                    sx.Append(su.idBlog + ",");
                    hash.Add(su.idBlog, su.iShowTimes.ToString());
                }
                list = PageList(1, pageSize, "WHERE id IN(" + XString.UnTail(sx.ToString()) + ")", "ORDER BY id DESC", out pageCount);

                foreach (BlogInfo bu in list)
                {
                    if (hash[bu.id] != null)
                    {
                        bu.iShowTimes = Int32.Parse((string)hash[bu.id]);
                    }
                }
                list.Sort(delegate(BlogInfo a, BlogInfo b) { return b.iShowTimes - a.iShowTimes; });
                pageCount = pc1;
            }
            else
            {
                list = PageList(pageIndex, pageSize, sql.ToString(), "ORDER BY id DESC", out pageCount);
            }
            if (list == null) return ""; // _err + " 1 " + _sql;
            if (pageCount == 0) return ""; // _err + " 2 " + _sql;

            #region 性能优化相关
            StringBuilder sy = new StringBuilder();
            foreach (BlogInfo bu in list)
            {
                sy.Append(bu.id + ",");
            }

            int pc = 0;
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
                string pre = "y";
                //if (idBrowser != bu.idUser) pre = "k";

                sb.AppendLine("<span id=\"blog_total_" + idx + "\">");
                sb.AppendLine("<div id=\"blog_" + pre + "_top\"></div>");
                sb.Append("<div id=\"blog_" + pre + "_mid\">");
                sb.AppendLine("<div id=\"blog_m_title\">");

                string lname = bu.cLoginName;
                if (fname == "loginname") lname = lname.Replace(word, "<font style=\"font-size:18px;color:#EE0000;\">" + word + "</font>");

                sb.AppendLine("<a href=\"" + UrlHelper.MemberUrl(bu.idUser) + "\">" + lname + "</a> : ");

                string ltitle = bu.cTitle;
                if (fname == "title") ltitle = ltitle.Replace(word, "<font style=\"font-size:18px;color:#EE0000;\">" + word + "</font>");

                sb.AppendLine("<a href=\"" + UrlHelper.BlogUrl(bu.id) + "\">" + ltitle + "</a>");
                sb.AppendLine("</div>");
                ImagesInfo img = (ImagesInfo)himg[bu.id];

                if (img != null)
                {
                    sb.AppendLine("<div id=\"blog_m_memo2\">");
                    //sb.AppendLine("" + XString.ContentTrunc(bu.cContent, 400) + "...<br>");
                    sb.AppendLine("" + PublishContent(bu.cContent, fname, word) + "...<br>");
                    sb.AppendLine("<img src=\"" + img.cImageUrl + "\" width=\"180\" style=\"border:solid 3px #CCCCCC;\" onclick=\"ImageShow(this)\">");
                }
                else
                {
                    sb.AppendLine("<div id=\"blog_m_memo\">");
                    //sb.AppendLine("" + XString.ContentTrunc(bu.cContent, 400) + "...<br>");
                    sb.AppendLine("" + PublishContent(bu.cContent, fname, word) + "...<br>");
                }

                sb.AppendLine("</div>");
                sb.AppendLine("<div id=\"blog_m_left\">");
                sb.AppendLine("" + bu.dCreate.ToString("yyyy-MM-dd HH:mm:ss") + " <a href=\"" + UrlHelper.BlogUrl(bu.id) + "\">&gt;&gt; 阅读全文</a>");
                sb.AppendLine("</div>");
                sb.AppendLine("<div id=\"blog_m_right\">");

                BlogSummaryInfo bg = (BlogSummaryInfo)hsmy[bu.id];
                if (bg == null) bg = new BlogSummaryInfo();

                sb.Append("<a href=\"" + UrlHelper.BlogUrl(bu.id) + "\">阅读</a>(" + bg.iShowTimes + ") ");
                sb.Append("关注(" + bg.iFocus + ") ");
                sb.Append("顶(" + bg.iDing + ") ");
                sb.AppendLine("<a href=\"" + UrlHelper.BlogUrl(bu.id) + "#AA\">评论</a>(" + bg.iDiscuss + ")");
                sb.AppendLine("</div>");
                sb.AppendLine("</div>");
                sb.AppendLine("<div id=\"blog_" + pre + "_bot\"></div>");
                sb.AppendLine("<div id=\"blog_" + pre + "_spc\"></div>");
                sb.AppendLine("</span>");

                idx++;
            }

            #region 下一页链接
            string PageNext = "<div class=\"v3\"><a href=\"/Utility/Search.aspx?word=" + word + "&page=" + (pageIndex + 1) + "\">&gt;&gt;&gt; 下一页</a></div>";
            if (pageCount <= 1) PageNext = "";
            if (pageIndex >= pageCount) PageNext = "";

            if (PageNext.Length > 0)
            {
                sb.AppendLine("<div style=\"width:705px;height:30px;text-align:right;padding-right:10px;\" title=" + pageCount + ">");
                sb.AppendLine(PageNext);
                sb.AppendLine("</div>");
            }
            #endregion

            return sb.ToString();
        }

        public string NewestBlog_new(int pageIndex, int pageSize, string fname, string word, out int num)
        {
            StringBuilder sql = new StringBuilder();
            if (word.Length > 0)
            {
                if (fname == "loginname") { sql.Remove(0, sql.Length); sql.Append("WHERE cLoginName LIKE '%" + word + "%'"); }
                if (fname == "title") { sql.Remove(0, sql.Length); sql.Append("WHERE cTitle LIKE '%" + word + "%'"); }
                if (fname == "content") { sql.Remove(0, sql.Length); sql.Append("WHERE cContent LIKE '%" + word + "%'"); }
                if (fname == "video") { sql.Remove(0, sql.Length); sql.Append("WHERE cContent LIKE '%/[FLASH/]%' ESCAPE '/'"); }
                if (fname == "image") { sql.Remove(0, sql.Length); sql.Append("WHERE cContent LIKE '%/[IMG/]%' ESCAPE '/'"); }
            }
            else
            {
                sql.Append("WHERE id IN (SELECT TOP " + (pageSize * 2) + " idInfo FROM [YP_DB_2].[dbo].[tblBLOG_PUBLISH] ORDER BY id DESC)");
            }
            num = 0;

            int pageCount = 0;
            List<BlogInfo> list = null;
            if (word == ".")
            {
                int pc1 = 0;
                BlogSummary bs1 = new BlogSummary();
                List<BlogSummaryInfo> slist = bs1.PageList(pageIndex, pageSize, "", "ORDER BY iShowTimes DESC", out pc1);
                if (slist == null) return "";
                if (pc1 == 0) return "";
                StringBuilder sx = new StringBuilder();
                Hashtable hash = new Hashtable();
                foreach (BlogSummaryInfo su in slist)
                {
                    sx.Append(su.idBlog + ",");
                    hash.Add(su.idBlog, su.iShowTimes.ToString());
                }

                list = PageList(1, pageSize, "WHERE id IN(" + XString.UnTail(sx.ToString()) + ")", "ORDER BY id DESC", out pageCount);

                foreach (BlogInfo bu in list)
                {
                    if (hash[bu.id] != null)
                    {
                        bu.iShowTimes = Int32.Parse((string)hash[bu.id]);
                    }
                }
                list.Sort(delegate(BlogInfo a, BlogInfo b) { return b.iShowTimes - a.iShowTimes; });
                pageCount = pc1;
            }
            else
            {
                list = PageList(pageIndex, pageSize, sql.ToString(), "ORDER BY id DESC", out pageCount);
            }
            num = pageCount;
            if (list == null) return ""; // _err + " 1 " + _sql;
            if (pageCount == 0) return ""; // _err + " 2 " + _sql;

            #region 性能优化相关
            StringBuilder sy = new StringBuilder();
            foreach (BlogInfo bu in list)
            {
                sy.Append(bu.id + ",");
            }

            int pc = 0;
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
            foreach (BlogInfo bu in list)
            {
                sb.AppendLine("<li>");
                string lname = bu.cLoginName;
                if (fname == "loginname") lname = lname.Replace(word, "<em>" + word + "</em>");

                sb.AppendLine("<a class=\"title\" target=\"_blank\" href=\"" + UrlHelper.MemberUrl(bu.idUser) + "\">" + lname + "</a> : ");

                string ltitle = bu.cTitle;
                if (fname == "title") ltitle = ltitle.Replace(word, "<em>" + word + "</em>");

                sb.AppendLine("<a class=\"title\" target=\"_blank\"  href=\"" + UrlHelper.BlogUrl(bu.id) + "\">" + ltitle + "</a>");
                sb.AppendLine("<span>" + bu.dCreate.ToString("yyyy-MM-dd HH:mm:ss") + "</span>");




                ImagesInfo img = (ImagesInfo)himg[bu.id];

                if (img != null)
                {
                    sb.AppendLine("<p>");
                    sb.AppendLine("" + PublishContent(bu.cContent, fname, word) + "");
                    sb.AppendLine("</p>");
                    sb.AppendLine("<img src=\"" + img.cImageUrl + "\" width=\"180\"  />");
                }
                else
                {
                    sb.AppendLine("<p>");
                    sb.AppendLine("" + PublishContent(bu.cContent, fname, word) + "");
                    sb.AppendLine("</p>");
                }
                sb.AppendLine("<div class=\"article-bot\">");
                sb.AppendLine("<a target=\"_blank\"href=\"" + UrlHelper.BlogUrl(bu.id) + "\">查看全文>></a>");
                BlogSummaryInfo bg = (BlogSummaryInfo)hsmy[bu.id];
                if (bg == null) bg = new BlogSummaryInfo();

                sb.Append("阅读(" + bg.iShowTimes + ") ");
                sb.Append("关注(" + bg.iFocus + ") ");
                sb.Append("顶(" + bg.iDing + ") ");
                sb.AppendLine("评论(" + bg.iDiscuss + ")");
                sb.AppendLine("</div>");
                sb.AppendLine("</li>");
            }


            #region 下一页链接
            string PageNext = "<div class=\"page\"><a href=\"/infocenter/Search.aspx?fname=" + fname + "&word=" + word + "&page=" + (pageIndex + 1) + "\">&gt;&gt;&gt; 下一页</a></div>";
            if (pageCount <= 1) PageNext = "";
            if (pageIndex >= pageCount) PageNext = "";
            if (num < pageSize) PageNext = "";
            if (PageNext.Length > 0)
            {
                sb.AppendLine("<div style=\"width:705px;height:30px;text-align:right;padding-right:10px;\" title=" + pageCount + ">");
                sb.AppendLine(PageNext);
                sb.AppendLine("</div>");
            }
            #endregion

            return sb.ToString();
        }
        public string NewestBlog_page(int pageIndex, int pageSize, string fname, string word, out int num)
        {
            StringBuilder sql = new StringBuilder();
            if (word.Length > 0)
            {
                if (fname == "loginname") { sql.Remove(0, sql.Length); sql.Append("WHERE cLoginName LIKE '%" + word + "%'"); }
                if (fname == "title") { sql.Remove(0, sql.Length); sql.Append("WHERE cTitle LIKE '%" + word + "%'"); }
                if (fname == "content") { sql.Remove(0, sql.Length); sql.Append("WHERE cContent LIKE '%" + word + "%'"); }
                if (fname == "video") { sql.Remove(0, sql.Length); sql.Append("WHERE cContent LIKE '%/[FLASH/]%' ESCAPE '/'"); }
                if (fname == "image") { sql.Remove(0, sql.Length); sql.Append("WHERE cContent LIKE '%/[IMG/]%' ESCAPE '/'"); }
            }
            else
            {
                sql.Append("WHERE id IN (SELECT distinct TOP " + (pageSize * 5) + " idInfo FROM [YP_DB_2].[dbo].[tblBLOG_PUBLISH] ORDER BY idInfo DESC)");
            }
            num = 0;

            int pageCount = 0;
            List<BlogInfo> list = null;
            if (word == ".")
            {
                int pc1 = 0;
                BlogSummary bs1 = new BlogSummary();
                List<BlogSummaryInfo> slist = bs1.PageList(pageIndex, pageSize, "", "ORDER BY iShowTimes DESC", out pc1);
                if (slist == null) return "";
                if (pc1 == 0) return "";
                StringBuilder sx = new StringBuilder();
                Hashtable hash = new Hashtable();
                foreach (BlogSummaryInfo su in slist)
                {
                    sx.Append(su.idBlog + ",");
                    hash.Add(su.idBlog, su.iShowTimes.ToString());
                }

                list = PageList(1, pageSize, "WHERE id IN(" + XString.UnTail(sx.ToString()) + ")", "ORDER BY id DESC", out pageCount);

                foreach (BlogInfo bu in list)
                {
                    if (hash[bu.id] != null)
                    {
                        bu.iShowTimes = Int32.Parse((string)hash[bu.id]);
                    }
                }
                list.Sort(delegate(BlogInfo a, BlogInfo b) { return b.iShowTimes - a.iShowTimes; });
                pageCount = pc1;
            }
            else
            {
                list = PageList(pageIndex, pageSize, sql.ToString(), "ORDER BY id DESC", out pageCount);
            }
            num = pageCount;
            if (list == null) return ""; // _err + " 1 " + _sql;
            if (pageCount == 0) return ""; // _err + " 2 " + _sql;

            #region 性能优化相关
            StringBuilder sy = new StringBuilder();
            foreach (BlogInfo bu in list)
            {
                sy.Append(bu.id + ",");
            }

            int pc = 0;
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
            foreach (BlogInfo bu in list)
            {
                sb.AppendLine("<li>");
                string lname = bu.cLoginName;
                if (word.Trim().Length > 0)
                    if (fname == "loginname") lname = lname.Replace(word, "<em>" + word + "</em>");

                sb.AppendLine("<a class=\"title\" target=\"_blank\" href=\"" + UrlHelper.MemberUrl(bu.idUser) + "\">" + lname + "</a> : ");

                string ltitle = bu.cTitle;
                if (word.Trim().Length > 0)
                    if (fname == "title") ltitle = ltitle.Replace(word, "<em>" + word + "</em>");

                sb.AppendLine("<a class=\"title\" target=\"_blank\"  href=\"" + UrlHelper.BlogUrl(bu.id) + "\">" + ltitle + "</a>");
                sb.AppendLine("<span>" + bu.dCreate.ToString("yyyy-MM-dd HH:mm:ss") + "</span>");
                ImagesInfo img = (ImagesInfo)himg[bu.id];

                if (img != null)
                {
                    sb.AppendLine("<p>");
                    sb.AppendLine("" + PublishContent(bu.cContent, fname, word) + "");
                    sb.AppendLine("</p>");
                    sb.AppendLine("<img src=\"" + img.cImageUrl + "\" width=\"180\"  />");
                }
                else
                {
                    sb.AppendLine("<p>");
                    sb.AppendLine("" + PublishContent(bu.cContent, fname, word) + "");
                    sb.AppendLine("</p>");
                }
                sb.AppendLine("<div class=\"article-bot\">");
                sb.AppendLine("<a target=\"_blank\"href=\"" + UrlHelper.BlogUrl(bu.id) + "\">查看全文>></a>");
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
        private string PublishContent(string s, string f, string w)
        {
            s = HTMLHelper.NoHTML(HTMLHelper.NoHTML(s));
            if (w.Length > 0 && f == "content")
            {
                int pos = s.IndexOf(w);
                int p1 = pos - 16;
                if (p1 < 0) p1 = 0;
                int p2 = pos + 200;
                if (p2 > s.Length - 1) p2 = s.Length - 1;
                string pa = "...";
                if (p1 < 1) pa = "";
                return pa + XString.ContentTrunc(s.Substring(p1, p2 - p1), 400).Replace(w, "<font style=\"font-size:12px;color:#EE0000;\">" + w + "</font>");
            }
            return XString.ContentTrunc(s, 400);
            //return XString.ContentTrunc(HTMLHelper.NoHTML(HTMLHelper.NoHTML(s)), 400);
        }
    }
}
