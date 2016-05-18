using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Utility_Include_DiscussCreate : System.Web.UI.Page
{
    // 页面反馈信息
    public string PageResult = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        int idBlog = 0;
        if (Request.Form["idBlog"] != null)
        {
            idBlog = Int32.Parse(Request.Form["idBlog"].ToString());
        }

        #region 身份确认
        Member m = new Member();
        MemberInfo u = m.Default;
        if (u == null)
        {
            //PageResult = "没有操作权限！";
            Response.Redirect(UrlHelper.BlogUrl(idBlog));
            return;
        }
        #endregion

        if (Prison.Find(u.id))
        {
            Response.Redirect("/Member/Logout.aspx");
        }

        // 接收数据并处理（保存）
        DiscussInfo record = new DiscussInfo();
        if (Request.Form.Count > 0)
        {
            #region 来源判别
            if (!Me.HostRequired)
            {
                Response.Redirect("/");
            }
            #endregion

            record.idInfo = idBlog;
            record.idUser = u.id;
            record.cLoginName = u.cLoginName;

            int finishedFieldCount = 0;
            if (Request.Form["cContent"] != null)
            {
                try
                {
                    record.cContent = XString.SqlSafe(Request.Form["cContent"].ToString());
                }
                catch (Exception ex)
                {
                    PageResult = "数据(内容)格式错误[" + ex.Message + "]！请检查！";
                    return;
                }
                finishedFieldCount++;
            }

            if (GCommon.BadContent(record.cContent))
            {
                PageResult = "非法评论！";
                return;
            }

            // 数据检查完成！添加记录！
            if (finishedFieldCount > 0 && PageResult.Length == 0 && record.cContent.Length > 0)
            {
                Discuss table = new Discuss();
                int recordIndex = 0;
                if (table.Insert(record, out recordIndex))
                {
                    #region 积分:发表评论
                    MemberHistory history = new MemberHistory();
                    history.Insert(u.id, 100800109, 1);
                    #endregion

                    #region 摘要:评论数量
                    if (record.idInfo > 200000000)
                    {
                        BlogSummary bs = new BlogSummary();
                        bs.UpdateByCommand(record.idInfo, "iDiscuss=iDiscuss+1");

                        MemberSummary ms = new MemberSummary();
                        ms.UpdateByCommand(m.Default.id, "iDiscuss=iDiscuss+1");
                        Users.Discuss(m.Default.id, 1);
                    }
                    #endregion

                    Response.Redirect(UrlHelper.BlogUrl(idBlog) + "#AA");
                }
                else
                {
                    Response.Redirect("/");
                }
            }
        }
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-17 09:18 */

