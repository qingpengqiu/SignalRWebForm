using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Member_Password : System.Web.UI.Page
{
    public string PageResult = "";
    public int iduser = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region 身份确认
        Member m = new Member();
        if (m.Default == null)
        {
            Response.Redirect("/member/login.aspx");
            return;
        }
        #endregion

        if (Prison.Find(m.Default.id))
        {
            Response.Redirect("/Member/Logout.aspx");
        }

        iduser = m.Default.id;

        if (Request.Form.Count > 0)
        {
            #region 来源判别
            if (!Me.HostRequired)
            {
                Response.Redirect("/");
            }
            #endregion

            int recordIndex = 0;
            if (Request["idUser"] != null)
            {
                recordIndex = Int32.Parse(XString.PureNumber(Request["idUser"].ToString()));
            }

            if (iduser != recordIndex)
            {
                Response.Redirect("/");
            }

            if (Request.Form["cPassword"] != null)
            {
                StringBuilder cmd = new StringBuilder();
                cmd.Append("cPassword='" + XString.MD5(XString.SqlSafe(Request.Form["cPassword"].ToString().ToLower())) + "',");
                if (m.UpdateByCommand(recordIndex, cmd.ToString()))
                {
                    Users.Password(recordIndex, XString.MD5(XString.SqlSafe(Request.Form["cPassword"].ToString().ToLower())));

                    //Response.Redirect("/Member/Success.aspx");
                    Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(m.Default.id);
                    Response.Redirect(UrlHelper.MemberUrl(m.Default.id));
                }
                else
                {
                    PageResult = "系统错误：" + m._err;
                }
            }
        }
    }
}
