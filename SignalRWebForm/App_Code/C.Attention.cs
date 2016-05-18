
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    public partial class Attention : SQLHelper
    {
        /// <summary>
        /// 我关注的博主的博客 我关注的博客最新信息
        /// </summary>
        /// <param name="iduser"></param>
        /// <returns></returns>
        public Hashtable GetAttentions(int iduser)
        {
            int pageCount = 0;
            Hashtable hash = new Hashtable();

            List<AttentionInfo> alist = PageList(1, 1000, "WHERE idUser=" + iduser, "ORDER BY id ASC", out pageCount);
            if (pageCount == 0) return hash;

            foreach (AttentionInfo au in alist)
            {
                if (hash[au.idInfo] == null)
                {
                    hash.Add(au.idInfo, au);
                }
            }
            return hash;
        }

        public string MyAttentions(int iduser, Hashtable hash)
        {
            int pageCount = 0;

            List<BlogInfo> recent = new List<BlogInfo>();
            if (!CacheHelper.Get("CACHE_RECENT_BLOGS", out recent))
            {
                Blog blogs = new Blog();
                //recent = blogs.PageList(1, 1000, "WHERE dCreate>'" + DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd HH:mm:ss") + "'", "ORDER BY id DESC", out pageCount);
                recent = blogs.PageList(1, 1000, "", "ORDER BY id DESC", out pageCount);
                CacheHelper.Save("CACHE_RECENT_BLOGS", recent);
            }

            #region 性能优化相关
            StringBuilder sy = new StringBuilder();
            foreach (BlogInfo bu in recent)
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

            int idx = 1;
            StringBuilder sb = new StringBuilder();
            foreach (BlogInfo bu in recent)
            {
                if (bu.idUser == iduser) continue;
                if (idx > 20) break;

                if (hash[bu.idUser] != null || hash[bu.id] != null)
                {
                    sb.AppendLine("<span id=\"blog_k2all_" + idx + "\">");
                    sb.AppendLine("<div id=\"blog_k_top\"></div>");
                    sb.Append("<div id=\"blog_k_mid\" ");
                    sb.AppendLine(">");
                    sb.AppendLine("<div id=\"blog_m_title\">");
                    sb.AppendLine("<a href=\"" + UrlHelper.MemberUrl(bu.idUser) + "\">" + bu.cLoginName + "</a> : <a href=\"" + UrlHelper.BlogUrl(bu.id) + "\">" + bu.cTitle + "</a>");
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
                    sb.AppendLine("" + bu.dCreate.ToString("yyyy-MM-dd HH:mm:ss") + " <a href=\"" + UrlHelper.BlogUrl(bu.id) + "\">&gt;&gt; 阅读全文</a>");
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
                    sb.AppendLine("<div id=\"blog_k_bot\"></div>");
                    sb.AppendLine("<div id=\"blog_k_spc\"></div>");
                    sb.AppendLine("</span>");

                    idx++;
                }
            }
            return sb.ToString();
        }
    }
}
