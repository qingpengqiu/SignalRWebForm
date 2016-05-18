using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBM4 = Erun360.Model.DB4;
using DB4 = Erun360.BLL.DB4;
using DBM1 = Erun360.Model.DB1;
using DB1 = Erun360.BLL.DB1;
using System.Data;
using System.Text;
public partial class infocenter_SearchClub : System.Web.UI.Page
{
    public string mJion = string.Empty;//我加入的俱乐部
    public string hot = string.Empty;//热门俱乐部
    public string hotBlog = string.Empty;//热门文章
    public string NewBlog = string.Empty;//最新文章
    string strWhere = " iAudit>3  ";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            pager.RecordCount = new DB4.tblRACE_CLUB().GetRecordCount(strWhere);
            //我加入的俱乐部
            Bind();
        }
        //热门俱乐部
        DataTable dtHot = new DB4.tblRACE_CLUB().GetHotClub().Tables[0];
        StringBuilder sbhot = new StringBuilder();
        if (dtHot.Rows.Count > 0)
        {
            for (int i = 0; i < dtHot.Rows.Count; i++)
            {
                DBM1.tblMEMBER member = new DB1.tblMEMBER().GetModelByCache(Convert.ToInt32(dtHot.Rows[i]["idUser"]));
                if (member != null)
                {
                    sbhot.AppendLine("<li>");
                    sbhot.AppendLine("<a href=\"" + UrlHelper.ClubUrl(Convert.ToInt32(dtHot.Rows[i]["id"])) + "\"><img src=\"" + member.cAvatar + "\" alt=\"\"></a>");
                    sbhot.AppendLine("<a href=\"" + UrlHelper.ClubUrl(Convert.ToInt32(dtHot.Rows[i]["id"])) + "\">" + dtHot.Rows[i]["cTitle"].ToString() + "</a>");
                    sbhot.AppendLine("<p>" + XString.ContentTrunc(HTMLHelper.NoHTML(dtHot.Rows[i]["cDescription"].ToString()), 20) + "</p>");
                    sbhot.AppendLine("</li>");
                }
            }
            //<li><a href=""><img src="/Html/images/rentou.png" alt=""></a>
            //            <p><a href="">光华管理学院--戈壁挑战</a>“作为工商界的成功人士，不仅仅是行动强者</p>
            //        </li>
        }
        else
        {
            sbhot.AppendLine("<li>暂无热门俱乐部</li>");
        }
        hot = sbhot.ToString();
        //热门文章
        DataTable dtBlog = new DB4.tblRACE_CLUB().GetHotBlog().Tables[0];
        StringBuilder sbBlog = new StringBuilder();
        if (dtBlog.Rows.Count > 0)
        {
            for (int i = 0; i < dtHot.Rows.Count; i++)
            {
                sbBlog.AppendLine("<li><a href=\"" + UrlHelper.BlogUrl(Convert.ToInt32(dtBlog.Rows[i]["id"])) + "\">" + XString.ContentTrunc(dtBlog.Rows[i]["cTitle"].ToString(), 20) + "</a></li>");
            }
        }
        else
        {
            sbBlog.AppendLine("<li>暂无热门文章</li>");
        }
        hotBlog = sbBlog.ToString();
        //最新文章
        DataTable dtNewBlog = new DB4.tblRACE_CLUB().GetNewBlog().Tables[0];
        StringBuilder sbNewBlog = new StringBuilder();
        if (dtNewBlog.Rows.Count > 0)
        {
            for (int i = 0; i < dtNewBlog.Rows.Count; i++)
            {
                sbNewBlog.AppendLine("<li><a href=\"" + UrlHelper.BlogUrl(Convert.ToInt32(dtNewBlog.Rows[i]["id"])) + "\">" + XString.ContentTrunc(dtNewBlog.Rows[i]["cTitle"].ToString(), 20) + "</a></li>");
            }
            //<li><a href="">首届大理苍山洱海越野赛将于11月</a></li>
        }
        else
        {
            sbNewBlog.AppendLine("<li>暂无最新文章</li>");
        }
        NewBlog = sbNewBlog.ToString();

    }
    protected void IBtnSearch_Click(object sender, ImageClickEventArgs e)
    {

        if (this.keyclub.Value.Trim().Length > 0)
        {
            strWhere += " and cTitle like '%" + keyclub.Value.Trim() + "%'";
        }
        if (idCity.Value != "0")
        {
            strWhere += " and idCity =" + idCity.Value + "";
            idCity.Value = "0";
        }
        if (idStyle.SelectedIndex != 0)
        {
            strWhere += " and iStyle =" + idStyle.SelectedIndex + "";
        }
        pager.RecordCount = new DB4.tblRACE_CLUB().GetRecordCount(strWhere);
        Bind();
    }
    protected void pager_PageChanged(object sender, EventArgs e)
    {
        Bind();
    }
    private void Bind()
    {
        int pagesize = pager.PageSize;
        int pageindex = pager.CurrentPageIndex;
        DataTable dt = new DB4.tblRACE_CLUB().GetListByPage(strWhere, " id ", pageindex, pagesize).Tables[0];
        StringBuilder sb = new StringBuilder();
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DBM1.tblMEMBER member = new DB1.tblMEMBER().GetModelByCache(Convert.ToInt32(dt.Rows[i]["idUser"]));
                if (member != null)
                {
                    sb.AppendLine("<li>");
                    sb.AppendLine("<a href=\"" + UrlHelper.ClubUrl(Convert.ToInt32(dt.Rows[i]["id"])) + "\"><img src=\"" + member.cAvatar + "\" alt=\"\"></a>");
                    sb.AppendLine("<a href=\"" + UrlHelper.ClubUrl(Convert.ToInt32(dt.Rows[i]["id"])) + "\">" + dt.Rows[i]["cTitle"].ToString() + "</a><br>");
                    //sb.AppendLine("文章：33 | 图片：453 | 活动：2 | 成员：88");
                    sb.AppendLine("<span>文章：" + new DB4.tblRACE_LINKS().GetBlogCountByCache(Convert.ToInt32(dt.Rows[i]["id"])) + " | 成员：" + new DB4.tblRACE_CLUB_MEMBER().GetCountByCache(Convert.ToInt32(dt.Rows[i]["id"])) + "</span>");
                    sb.AppendLine("<p>" + XString.ContentTrunc(HTMLHelper.NoHTML(dt.Rows[i]["cDescription"].ToString()), 160) + "</p>");
                    sb.AppendLine("</li>");
                }

            }
        }
        else
        {
            sb.AppendLine("<li>没搜到哦</li>");
        }
        mJion = sb.ToString();
    }
}