using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Admin_Discuss_Delete : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsAdmin())
        {
            Response.Write("没有操作权限！");
            return;
        }

        int recordIndex = 0;
        if (Request.QueryString["id"] != null)
        {
            try
            {
                recordIndex = Int32.Parse(XString.PureNumber(Request.QueryString["id"].ToString()));
            }
            catch (Exception ex)
            {
                Response.Write("编号(id)错误[" + ex.Message + "]！");
                return;
            }
        }
        else
        {
            Response.Write("数据错误(Querystring is null)！");
            return;
        }

        // 分库依据字段
        int _idinfo = 0;
        if (Request.QueryString["idinfo"] != null)
        {
            try
            {
                _idinfo = Int32.Parse(XString.PureNumber(Request.QueryString["idinfo"].ToString()));
            }
            catch (Exception ex)
            {
                Response.Write("数据(idinfo)错误[" + ex.Message + "]！");
                return;
            }
        }
        else
        {
            Response.Write("数据错误(Querystring is null)！");
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
            Response.Write("验证码错误(checksum is null)！");
            return;
        }
        if (String.Compare(checksum, XString.MD5(recordIndex.ToString()), true) != 0)
        {
            Response.Write("验证码错误(checksum is error)！");
            return;
        }

        if (recordIndex <= 0)
        {
            Response.Write("编号错误(id error)！");
            return;
        }

        // 读取数据(id)
        Discuss table = new Discuss();
        DiscussInfo record = table.Load(_idinfo, recordIndex, "", "");
        if (record == null)
        {
            Response.Write("数据错误(Index error)！");
            return;
        }

        if (table.Delete(_idinfo, recordIndex))
        {
            #region 修改积分
            MemberHistory history = new MemberHistory();
            history.Insert(record.idUser, 100800110, 1);
            #endregion

            #region 修改统计数
            MemberSummary ms = new MemberSummary();
            ms.UpdateByCommand(record.idUser, "iDiscuss=iDiscuss-1");
            Users.Discuss(record.idUser, -1);
            #endregion

            Response.Write("OK");
        }
        else
        {
            Response.Write("系统错误：" + table._err);
        }
    }
}
/* Powered by 北京联高软件开发有限公司 Ltd. */
/* This file formatted by WizForm 2.1 at 09-14 16:40 */
