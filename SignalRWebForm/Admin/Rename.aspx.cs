using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Admin_Rename : System.Web.UI.Page
{

    // 页面信息
    public string PageResult = "";
    public string PageBuffer = "";
    public string PageNavigator = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsSuper())
        {
            Response.Redirect("/admin/");
            return;
        }

        if (Request.Form.Count > 0)
        {
            int idUser = 0;
            if (Request.Form["idUser"] != null)
            {
                idUser = Int32.Parse(Request.Form["idUser"].ToString());
            }

            string cLoginName = "";
            if (Request.Form["cLoginName"] != null)
            {
                cLoginName = XString.SqlSafe(Request.Form["cLoginName"].ToString());
            }

            string cLoginName2 = "";
            if (Request.Form["cLoginName2"] != null)
            {
                cLoginName2 = XString.SqlSafe(Request.Form["cLoginName2"].ToString());
            }

            PageResult = "用户ID或登录名错误";

            if (idUser > 0 && cLoginName.Length > 1 && cLoginName2.Length > 1)
            {
                UserInfo u = Users.Find(idUser);
                if (u != null)
                {
                    if (u.cLoginName == cLoginName)
                    {
                        try
                        {
                            ArrayList cmd = new ArrayList();

                            cmd.Add("UPDATE [YP_DB_1].[dbo].[tblMEMBER] SET cLoginName='" + cLoginName2 + "',iChecksum=CHECKSUM('" + cLoginName2 + "') WHERE id=" + idUser + ";");
                            cmd.Add("UPDATE [YP_DB_2].[dbo].[tblBLOG] SET cLoginName='" + cLoginName2 + "' WHERE idUser=" + idUser + ";");
                            cmd.Add("UPDATE [YP_DB_3].[dbo].[tblATTENTION] SET cLoginName='" + cLoginName2 + "' WHERE idUser=" + idUser + ";");
                            for (int i = 0; i < 10; i++)
                            {
                                cmd.Add("UPDATE [YP_DB_3].[dbo].[tblDISCUSS_" + i + "] SET cLoginName='" + cLoginName2 + "' WHERE idUser=" + idUser + ";");
                            }
                            cmd.Add("UPDATE [YP_DB_4].[dbo].[tblRACE_JOIN] SET cLoginName='" + cLoginName2 + "' WHERE idUser=" + idUser + ";");

                            SQLHelper.ExecuteSqlTran(cmd);

                            PageResult = "修改成功";
                        }
                        catch (Exception ex)
                        {
                            PageResult = "系统错误:" + ex.Message;
                        }
                    }
                }
            }
        }
    }
}
/* Powered by 北京联高软件开发有限公司 Ltd. */
/* This file formatted by WizForm 2.1 at 09-14 16:39 */

