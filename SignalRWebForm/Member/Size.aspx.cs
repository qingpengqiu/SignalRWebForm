using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Member_Size : System.Web.UI.Page
{
    public string PageResult = "";
    public MemberSizeInfo record = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region 身份确认
        Member m = new Member();
        if (m.Default == null)
        {
            Response.Redirect("/member/");
            return;
        }
        #endregion

        if (Prison.Find(m.Default.id))
        {
            Response.Redirect("/Member/Logout.aspx");
        }

        MemberSize table = new MemberSize();

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
            if (Request.Form["UpdatedFields"] != null)
            {
                string[] fa = Request.Form["UpdatedFields"].ToString().Split(';');
                StringBuilder cmd = new StringBuilder();
                foreach (string fv in fa)
                {
                    if (fv.Trim().Length < 1) continue;
                    if (Request.Form[fv] != null)
                    {
                        cmd.Append(fv + "='" + XString.SqlSafe(Request.Form[fv].ToString()) + "',");
                    }
                }
                if (table.UpdateByCommand(recordIndex, cmd.ToString()))
                {
                    #region 积分:修改身体资料:仅一次
                    MemberHistory history = new MemberHistory();
                    if (history.Duplicate(recordIndex, 100800105, "") == false)
                    {
                        history.Insert(recordIndex, 100800105, 1);
                    }
                    #endregion

                    PageResult = "数据修改成功！";
                }
                else
                {
                    PageResult = "系统错误：" + table._err;
                }
            }
        }

        record = table.Load(m.Default.id, "", "");
        if (record == null)
        {
            Response.Redirect("/member/");
        }

    }
}
