using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Ajax_FocusErase : System.Web.UI.Page
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

        int id = 0;
        if (Request.QueryString["id"] != null)
        {
            id = Int32.Parse(Request.QueryString["id"].ToString());
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
        if (at.Delete(id, m.Default.id))
        {
            MemberHistory history = new MemberHistory();
            history.Insert(m.Default.id, 100800121, -1);

            if (id.ToString().Substring(0, 1) == "1")
            {
                // 取消被关注者的积分
                history.Insert(id, 100800122, -1);

                #region 摘要:关注数量
                MemberSummary ms = new MemberSummary();
                ms.UpdateByCommand(id, "iFans=iFans-1");
                Users.Fans(id, -1);
                ms.UpdateByCommand(m.Default.id, "iFocus=iFocus-1");
                Users.Focus(m.Default.id, -1);
                #endregion
            }
            else
            {
                #region 摘要:关注数量
                BlogSummary bs = new BlogSummary();
                bs.UpdateByCommand(id, "iFocus=iFocus-1");
                #endregion
            }

            Response.Write("OK");
        }
        else
        {
            Response.Write("ERROR");
        }
    }
}
