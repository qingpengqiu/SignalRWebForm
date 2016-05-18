using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Admin_Weibo_Update : System.Web.UI.Page
{
    // 页面反馈信息

    public string PageResult = "";
    public WeiboInfo record = new WeiboInfo();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsAdmin())
        {
            Response.Redirect("/admin/");
        }

        // 读取(id)数据
        int recordIndex = 0;
        if (Request["id"] != null)
        {
            recordIndex = Int32.Parse(XString.PureNumber(Request["id"].ToString()));
        }
        else
        {
            PageResult = "数据错误(Request[id] is null)！";
            return;
        }

        Weibo table = new Weibo();

        if (Request.Form.Count > 0)
        {
            if (Request.Form["UpdatedFields"] != null)
            {
                string[] fa = Request.Form["UpdatedFields"].ToString().Split(';');
                StringBuilder cmd = new StringBuilder();
                foreach (string fv in fa)
                {
                    if (fv.Trim().Length < 1) continue;
                    if (Request.Form[fv] != null)
                    {
                        cmd.Append(XString.SqlSafe(fv) + "='" + XString.SqlSafe(Request.Form[fv].ToString()) + "',");
                    }
                }
                if (table.UpdateByCommand(recordIndex, cmd.ToString()))
                {
                    PageResult = "数据修改成功！";
                }
                else
                {
                    PageResult = "系统错误：" + table._err;
                }
            }

        }

        record = table.Load(recordIndex, "", "");
        if (record == null)
        {
            PageResult = "数据错误(Index error)！";
            return;
        }
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 10-09 13:39 */
