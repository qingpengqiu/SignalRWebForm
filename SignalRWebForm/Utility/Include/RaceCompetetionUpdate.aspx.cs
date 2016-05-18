using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Utility_RaceCompetetion_Update : System.Web.UI.Page
{
    // 页面反馈信息

    public string PageResult = "";
    public RaceCompetetionInfo record = new RaceCompetetionInfo();

    protected void Page_Load(object sender, EventArgs e)
    {
        #region 身份确认
        Member m = new Member();
        MemberInfo u = m.Default;
        if (u == null)
        {
            PageResult = "没有操作权限！";
            return;
        }
        #endregion

        // 读取数据(id)
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

        RaceCompetetion table = new RaceCompetetion();

        record = table.Load(recordIndex, "", "");
        if (record == null)
        {
            PageResult = "数据错误(Index error)！";
            return;
        }

        // 非信息所有者不可修改
        //if (record.idUser != u.id)
        //{
        //    Response.Redirect("/");
        //}

        if (Request.Form.Count > 0)
        {
            #region 有限字段的修改
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
                    TCache.Clear("CACHE_COMPETETION" + String.Format("{0:D4}{1:D2}", record.dRaceBegin.Year, record.dRaceBegin.Month));
                    PageResult = "数据修改成功！";
                }
                else
                {
                    PageResult = "系统错误：" + table._err;
                }
            }
            #endregion
        }
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-17 09:18 */

