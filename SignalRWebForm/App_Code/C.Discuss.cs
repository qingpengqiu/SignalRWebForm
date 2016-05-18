
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    public partial class Discuss : SQLHelper
    {
        /// <summary>
        /// 给我的留言以及关注博客信息
        /// 用于我的首页
        /// </summary>
        /// <param name="iduser"></param>
        /// <returns></returns>
        public string MyNotes(int iduser, Hashtable hash)
        {
            int pageCount = 0;
            List<DiscussInfo> diz_items = PageList(iduser, 1, 20, "WHERE idInfo=" + iduser + " AND dCreate>'" + DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd HH:mm:ss") + "'", "ORDER BY id DESC", out pageCount);

            StringBuilder sb = new StringBuilder();
            sb.AppendLine("<div id=\"blog_n_top\"></div>");
            sb.Append("<div id=\"blog_n_mid\">");
            int idx1 = 1;
            sb.Append("<table width=\"100%\" border=\"0\" bordercolor=\"#000000\">");
            foreach (DiscussInfo ds in diz_items)
            {
                if (idx1 > 20) break;
                sb.AppendLine("<tr id=\"blog_kall_" + idx1 + "\">");
                sb.AppendLine("<td style=\"width:120px;text-align:left;font-size:12px;color:#666666;\" nowrap>" + ds.dCreate.ToString("MM-dd HH:mm") + " ");
                sb.AppendLine(" <a href=\"" + UrlHelper.MemberUrl(ds.idUser) + "\">" + ds.cLoginName + "</a> 留言：</td>");
                sb.AppendLine("<td style=\"color:#990000;\">" + XString.Trunc(ds.cContent,50) + " ...</td>");
                sb.AppendLine("<td style=\"width:90px;text-align:right;\" nowrap>");
                sb.AppendLine("<a href=\"/utility/mynotes.aspx\">全部</a> ");
                sb.AppendLine("<a href=\"javascript:\" onclick=\"DizDelete(" + ds.idInfo + "," + ds.id + "," + idx1 + ",'" + XString.MD5(ds.id.ToString()) + "')\">删除</a> ");
                sb.AppendLine("</td>");
                sb.AppendLine("</tr>");
                idx1++;
            }

            // 关注的人跑步记录显示,合并10个表的记录！
            // 需要考虑：（1）不要太多！（2）去掉重复的人
            List<RaceHistoryInfo> race_items = new List<RaceHistoryInfo>();
            if (!CacheHelper.Get("CACHE_RECENT_RACEHISTORY", out race_items))
            {
                race_items = new List<RaceHistoryInfo>();
                RaceHistory rh = new RaceHistory();
                for (int i = 0; i < 10; i++)
                {
                    race_items.AddRange(rh.PageList(i, 1, 200, "WHERE dCreate>'" + DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd HH:mm:ss") + "'", "ORDER BY id DESC", out pageCount));
                }
            }
            if (race_items.Count > 0)
            {
                // 排序
                race_items.Sort(delegate(RaceHistoryInfo a, RaceHistoryInfo b) { return Comparer<DateTime>.Default.Compare(b.dCreate, a.dCreate); });

                Hashtable husr = new Hashtable();
                int idx2 = 0;
                foreach (RaceHistoryInfo ds in race_items)
                {
                    if (idx2 > 10) break;
                    if (ds.idUser == iduser) continue;
                    if (hash[ds.idUser] == null) continue;

                    // 避免重复
                    if (husr[ds.idUser] != null) continue;
                    husr.Add(ds.idUser, ds.idUser);

                    sb.AppendLine("<tr>");
                    sb.AppendLine("<td style=\"width:120px;text-align:left;font-size:12px;color:#666666;\" nowrap>" + ds.dCreate.ToString("MM-dd HH:mm") + " ");
                    sb.AppendLine(" <a href=\"" + UrlHelper.MemberUrl(ds.idUser) + "\">" + ds.cName + "</a> 跑了：</td>");
                    sb.AppendLine("<td style=\"color:#990000;\">" + ds.iDistance + " Km，用时 " + ds.dRunTime.ToString("yyyy-MM-dd HH:mm:ss").Substring(11) + " " + ds.cMemo + " " + ds.cEquipment + "</td>");
                    sb.AppendLine("<td style=\"width:60px;text-align:right;\" nowrap><a href=\"/race/" + ds.idUser + ".aspx\">全部</a></td>");
                    sb.AppendLine("</tr>");
                    idx2++;
                }

                idx1 += idx2;

                CacheHelper.Save("CACHE_RECENT_RACEHISTORY", race_items);
            }

            sb.Append("</table>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div id=\"blog_n_bot\"></div>");
            sb.AppendLine("<div id=\"blog_n_spc\"></div>");

            if (idx1 == 1) return "";
            return sb.ToString();
        }
      
        /// <summary>
        /// 我给别人的留言
        /// </summary>
        /// <param name="iduser"></param>
        /// <returns></returns>
        public string MyNotes(int iduser)
        {
            List<DiscussInfo> items = new List<DiscussInfo>();
            for (int idx = 0; idx < 10; idx++)
            {
                int pc = 0;
                items.AddRange(PageList(idx, 1, 30, "WHERE (idInfo=" + iduser + " OR idUser=" + iduser + ")", "ORDER BY id DESC", out pc));
            }
            items.Sort(delegate(DiscussInfo a, DiscussInfo b) { return Comparer<DateTime>.Default.Compare(b.dCreate, a.dCreate); });

            StringBuilder sb = new StringBuilder();
            int idx1 = 1;
            foreach (DiscussInfo ds in items)
            {
                if (ds.idInfo > 200000000) continue;


                if (ds.idUser == iduser)
                {
                    UserInfo who = Users.Find(ds.idInfo);
                    if (who == null) continue;
                    sb.AppendLine("<div id=\"blog_kall_" + idx1 + "\" style=\"clear:both;\">");
                    sb.AppendLine("<div style=\"float:right;width:333px;height:125px;background-image:url(/images/diz-back.jpg);background-position:-337px -0px;\">");
                    sb.AppendLine("<div style=\"padding:20px;padding-left:40px;padding-right:40px;font-size:12px;color:#666666;\">");
                    sb.AppendLine(ds.dCreate.ToString("yy-MM-dd HH:mm") + " -> <a href=\"" + UrlHelper.MemberUrl(ds.idInfo) + "\">" + who.cLoginName + "</a> <a href=\"javascript:\" onclick=\"DizDelete(" + ds.idInfo + "," + ds.id + "," + idx1 + ",'" + XString.MD5(ds.id.ToString()) + "')\">[删]</a>：<br>");
                    sb.AppendLine("<font style=\"color:#990000;\">" + XString.TruncBreak(ds.cContent, 33, 4) + "</font><br>");
                    sb.AppendLine("</div>");
                    sb.AppendLine("</div>");
                    sb.AppendLine("</div>");
                }
                else
                {
                    UserInfo who = Users.Find(ds.idUser);
                    if (who == null) continue;
                    sb.AppendLine("<div id=\"blog_kall_" + idx1 + "\" style=\"clear:both;\">");
                    sb.AppendLine("<div style=\"float:left;width:333px;height:125px;background-image:url(/images/diz-back.jpg);\">");
                    sb.AppendLine("<div style=\"padding:20px;padding-right:40px;font-size:12px;color:#666666;\">");
                    sb.AppendLine(ds.dCreate.ToString("yy-MM-dd HH:mm") + " <a href=\"" + UrlHelper.MemberUrl(ds.idUser) + "\">" + who.cLoginName + "</a> <- <a href=\"javascript:\" onclick=\"DizDelete(" + ds.idInfo + "," + ds.id + "," + idx1 + ",'" + XString.MD5(ds.id.ToString()) + "')\">[删]</a> <a href=\"javascript:\" onclick=\"PopupShow(480,160,'给TA留言','/utility/include/discussUser.aspx?id=" + ds.idUser + "')\">[回复]</a>：<br>");
                    sb.AppendLine("<font style=\"color:#990000;\">" + XString.TruncBreak(ds.cContent, 33, 4) + "</font><br>");
                    sb.AppendLine("</div>");
                    sb.AppendLine("</div>");
                    sb.AppendLine("</div>");
                }
                idx1++;
            }

            if (idx1 == 1) return "没有相关信息...";
            return sb.ToString();
        }

        /// <summary>
        /// 我的所有评论
        /// </summary>
        /// <param name="iduser"></param>
        /// <returns></returns>
        public string MyDiscuss(int iduser)
        {
            #region 获取我关注的博客列表
            List<DiscussInfo> items = new List<DiscussInfo>();
            for (int idx = 0; idx < 10; idx++)
            {
                int pc = 0;
                items.AddRange(PageList(idx, 1, 30, "WHERE idInfo>=200000000 AND idUser=" + iduser, "ORDER BY id DESC", out pc));
            }
            items.Sort(delegate(DiscussInfo a, DiscussInfo b) { return Comparer<DateTime>.Default.Compare(b.dCreate, a.dCreate); });
            #endregion

            #region 获取最新的博客
            int pageCount = 0;
            List<BlogInfo> recent = new List<BlogInfo>();
            if (!CacheHelper.Get("CACHE_RECENT_BLOGS", out recent))
            {
                Blog blogs = new Blog();
                //recent = blogs.PageList(1, 1000, "WHERE dCreate>'" + DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd HH:mm:ss") + "'", "ORDER BY id DESC", out pageCount);
                recent = blogs.PageList(1, 1000, "", "ORDER BY id DESC", out pageCount);
                CacheHelper.Save("CACHE_RECENT_BLOGS", recent);
            }
            Hashtable hash = new Hashtable();
            foreach (BlogInfo bu in recent)
            {
                if (hash[bu.id] == null)
                {
                    hash.Add(bu.id, bu);
                }
            }
            #endregion

            StringBuilder sb = new StringBuilder();
            int idx1 = 1;
            foreach (DiscussInfo ds in items)
            {
                BlogInfo bg = (BlogInfo)hash[ds.idInfo];
                if (bg == null) { idx1++; continue; }

                sb.AppendLine("<div style=\"clear:both;height:160px;border-top:dotted 1px #CCCCCC;padding-top:20px;\">");
                sb.AppendLine("<div style=\"float:left;width:333px;height:125px;\">");
                sb.AppendLine("<a href=\"" + UrlHelper.MemberUrl(ds.idUser) + "\" style=\"font-size:16px;\">" + bg.cLoginName + "</a><br><a href=\"" + UrlHelper.BlogUrl(ds.idInfo) + "\" style=\"font-size:16px;\">" + bg.cTitle + "</a>");
                sb.AppendLine("</div>");
                sb.AppendLine("<div id=\"blog_kall_" + idx1 + "\" style=\"float:right;width:333px;height:125px;background-image:url(/images/diz-back.jpg);background-position:-337px -0px;\">");
                sb.AppendLine("<div style=\"padding:20px;padding-left:40px;padding-right:40px;font-size:12px;\">");
                sb.AppendLine(ds.dCreate.ToString("yy-MM-dd HH:mm") + " 我评论 <a href=\"javascript:\" onclick=\"DizDelete(" + ds.idInfo + "," + ds.id + "," + idx1 + ",'" + XString.MD5(ds.id.ToString()) + "')\">[删]</a>：<br>");
                sb.AppendLine("<font style=\"color:#990000;\">" + UBB.MoodToHtml(ds.cContent) + "</font>");
                sb.AppendLine("</div>");
                sb.AppendLine("</div>");
                sb.AppendLine("</div>");
                idx1++;
            }
            if (idx1 == 1) return "没有相关信息...";
            return sb.ToString();
        }
    }
}
