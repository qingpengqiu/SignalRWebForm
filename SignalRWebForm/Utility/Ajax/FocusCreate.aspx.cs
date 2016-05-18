using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Ajax_FocusCreate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";

        #region 身份确认
        Member m = new Member();
        if (m.Default == null)
        {
            Response.Write("ERROR:您不是注册用户!");
            return;
        }
        #endregion

        if (Prison.Find(m.Default.id))
        {
            Response.Redirect("/Member/Logout.aspx");
        }

        int id = 0;
        if (Request.QueryString["id"] != null)
        {
            id = Int32.Parse(Request.QueryString["id"].ToString());
        }
        if (id < 100000000)
        {
            Response.Write("ERROR");
            return;
        }

        // 验证码校验
        string checksum = "";
        if (Request.QueryString["checksum"] != null)
        {
            checksum = Request.QueryString["checksum"].ToString().ToLower();
        }
        else
        {
            Response.Write("ERROR");
            return;
        }
        if (String.Compare(checksum, XString.MD5(id.ToString()), true) != 0)
        {
            Response.Write("ERROR");
            return;
        }

        Attention at = new Attention();
        AttentionInfo ad = new AttentionInfo();
        ad.idInfo = id;
        ad.idUser = m.Default.id;
        ad.cLoginName = m.Default.cLoginName;

        int result = 0;
        if (at.Insert(ad, out result))
        {
            #region 积分:关注
            MemberHistory history = new MemberHistory();
            // 关注者积分
            history.Insert(m.Default.id, 100800121, 1);
            // 关注博客等再次加分
            //if (id.ToString().Substring(0, 1) != "1")
            //{
            //    history.Insert(m.Default.id, 100800123, 1);
            //}
            #endregion

            if (id.ToString().Substring(0, 1) == "1")
            {
                #region 积分:关注
                // 被关注者积分
                history.Insert(id, 100800122, 1);
                #endregion

                #region 摘要:关注数量
                MemberSummary ms = new MemberSummary();
                ms.UpdateByCommand(id, "iFans=iFans+1");
                Users.Fans(id, 1);
                ms.UpdateByCommand(m.Default.id, "iFocus=iFocus+1");
                Users.Focus(m.Default.id, 1);
                #endregion

                Response.Write("OK");
            }
            else
            {
                #region 摘要:关注数量
                BlogSummary bs = new BlogSummary();
                bs.UpdateByCommand(id, "iFocus=iFocus+1");
                #endregion

                Response.Write("OK");
            }
        }
        else
        {
            Response.Write("ERROR:系统错误!");
        }
    }
}
