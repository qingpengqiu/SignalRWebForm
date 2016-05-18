using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Member_Query : System.Web.UI.Page
{
    public string PageResult = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        #region 身份确认
        Member m = new Member();
        MemberInfo u = m.Default;
        if (u != null)
        {
            //Response.Redirect("/member/success.aspx");
            Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(m.Default.id);
            Response.Redirect(UrlHelper.MemberUrl(u.id));
            return;
        }
        #endregion

        if (Request.Form.Count > 0)
        {
            #region 来源判别
            if (!Me.HostRequired)
            {
                Response.Redirect("/");
            }
            #endregion

            int finishedFieldCount = 0;

            string idGender = "";
            if (Request.Form["idGender"] != null) idGender = XString.SqlSafe(Request.Form["idGender"].ToString());

            string dBirthday = "";
            if (Request.Form["dBirthday"] != null) dBirthday = XString.SqlSafe(Request.Form["dBirthday"].ToString());

            string cName = "";
            if (Request.Form["cName"] != null)
            {
                try
                {
                    cName = XString.SqlSafe(Request.Form["cName"].ToString());
                    if (cName.Length < 2 || cName.Length > 16)
                    {
                        PageResult = "(姓名)数据长度超出允许范围！请检查！"; return;
                    }
                    finishedFieldCount++;
                }
                catch (Exception ex)
                {
                    PageResult = "数据(姓名)格式错误[" + ex.Message + "]！请检查！";
                    return;
                }
            }
            else
            {
                PageResult = "必须输入数据(姓名)！";
            }

            string cAnswer = "";
            if (Request.Form["cAnswer"] != null)
            {
                try
                {
                    cAnswer = XString.SqlSafe(Request.Form["cAnswer"].ToString());
                    if (cAnswer.Length < 3 || cAnswer.Length > 32)
                    {
                        PageResult = "(密码答案)数据长度超出允许范围！请检查！"; return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "数据(密码答案)格式错误[" + ex.Message + "]！请检查！";
                    return;
                }
                finishedFieldCount++;
            }
            else
            {
                PageResult = "必须输入数据(密码答案)！";
            }

            // 数据检查完成！添加记录！
            if (finishedFieldCount >= 2 && PageResult.Length == 0)
            {
                int idx = m.Query(idGender, cName, dBirthday, cAnswer);

                if (idx > 0)
                {
                    Response.Redirect("/member/password.aspx");
                }
                else
                {
                    PageResult = "信息错误";
                }
            }
        }
    }
}
