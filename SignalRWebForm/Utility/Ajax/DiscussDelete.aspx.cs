using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Utility_Ajax_DiscussDelete : System.Web.UI.Page
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
            #region 修改统计数
            MemberSummary ms = new MemberSummary();
            ms.UpdateByCommand(m.Default.id, "iDiscuss=iDiscuss-1");
            Users.Discuss(m.Default.id, -1);
            #endregion

            #region 修改积分
            MemberHistory history = new MemberHistory();
            history.Insert(m.Default.id, 100800109, -1);
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
