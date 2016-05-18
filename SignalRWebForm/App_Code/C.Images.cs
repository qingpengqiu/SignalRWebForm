
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    public partial class Images : SQLHelper
    {
        public string Gallery(int iduser, int pageSize, ref int pageIndex, ref int pageCount)
        {
            List<ImagesInfo> list = PageList(pageIndex, pageSize, "WHERE idUser=" + iduser, "ORDER BY id ASC", out pageCount);
            if (pageCount == 0) return "";

            StringBuilder sx = new StringBuilder();
            foreach (ImagesInfo lv in list)
            {
                if (lv.idInfo > 0)
                {
                    sx.Append(lv.idInfo + ",");
                }
            }
            if (sx.ToString().Length < 2)
            {
                return "";
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
            //List<BlogInfo> blist = blogs.PageList(pageIndex, pageSize, "WHERE id IN(" + XString.UnTail(sx.ToString()) + ")", "ORDER BY id DESC", out pc);
            List<BlogInfo> blist = blogs.PageList(1, pageSize, "WHERE id IN(" + XString.UnTail(sx.ToString()) + ")", "ORDER BY id DESC", out pc);
            if (pc == 0) return "";
            if (blist == null) return "";

            Hashtable hash = new Hashtable();
            foreach (BlogInfo bv in blist)
            {
                if (hash[bv.id] == null)
                {
                    hash.Add(bv.id, bv);
                }
            }

            StringBuilder s0 = new StringBuilder();
            StringBuilder s1 = new StringBuilder();
            StringBuilder s2 = new StringBuilder();

            int idx = 0;
            foreach (ImagesInfo lv in list)
            {
                StringBuilder sy = new StringBuilder();
                sy.AppendLine("<div id=\"imgList\" style=\"width:290px;margin-bottom:20px;font-size:12px;line-height:20px;text-align:center;\" title=\"" + lv.cImageUrl + "\">");
                if (lv.idInfo > 0)
                {
                    sy.AppendLine("<img src=\"/images/ajax-loader.gif\"><br>");
                    BlogInfo bh = (BlogInfo)hash[lv.idInfo];
                    if (bh != null)
                    {
                        sy.AppendLine("<a href=\"" + UrlHelper.BlogUrl(lv.idInfo) + "\">" + bh.cTitle + "</a>");
                    }
                }
                else
                {
                    sy.AppendLine("<img src=\"/images/ajax-loader.gif\"><br>");
                }
                sy.AppendLine("</div>");

                if (idx % 3 == 0) s0.AppendLine(sy.ToString());
                if (idx % 3 == 1) s1.AppendLine(sy.ToString());
                if (idx % 3 == 2) s2.AppendLine(sy.ToString());
                idx++;
            }

            StringBuilder sb = new StringBuilder();

            sb.AppendLine("<div style=\"float:left;width:325px;\">" + s0.ToString() + "</div>");
            sb.AppendLine("<div style=\"float:left;width:325px;\">" + s1.ToString() + "</div>");
            sb.AppendLine("<div style=\"float:right;width:300px;\">" + s2.ToString() + "</div>");

            string PageNext = "<div class=\"v3\"><a href=\"" + UrlHelper.GalleryUrl(iduser, pageIndex + 1) + "\">&gt;&gt;&gt; ÏÂÒ»Ò³</a></div>";
            if (pageCount <= 1) PageNext = "";
            if (pageIndex >= pageCount) PageNext = "";

            if (PageNext.Length > 0)
            {
                sb.AppendLine("<div style=\"clear:both;width:930px;height:50px;text-align:right;padding:10px;border-top:solid 3px #FFFFFF;\">");
                sb.AppendLine(PageNext);
                sb.AppendLine("</div>");
            }

            return sb.ToString();
        }
    }
}
