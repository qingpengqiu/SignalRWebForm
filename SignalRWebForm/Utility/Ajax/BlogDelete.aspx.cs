using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Admin_Ajax_BlogDelete : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";

        #region 身份确认
        Member m = new Member();
        if (m.Default == null)
        {
            Response.Write("您未注册");
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
        Blog table = new Blog();
        BlogInfo record = table.Load(recordIndex, "", "");
        if (record == null)
        {
            Response.Write("数据错误(Index error)！");
            return;
        }

        if (record.idUser != m.Default.id)
        {
            Response.Write("不是你的博客！");
            return;
        }

        if (table.Delete(recordIndex))
        {
            #region 修改统计数据
            MemberSummary ms = new MemberSummary();
            ms.UpdateByCommand(m.Default.id, "iBlogCount=iBlogCount-1");
            Users.Blogs(m.Default.id, -1);
            #endregion

            #region 修改积分
            MemberHistory history = new MemberHistory();
            history.Insert(m.Default.id, 100800107, -1);
            #endregion

            #region 清除相应内存数据库信息
            TCache.Clear("CACHE_PAGE_MEMBER_" + record.idUser);
            TCache.Clear("CACHE_PAGE_MEMBER_ME_" + record.idUser);
            CacheHelper.Clear("CACHE_RECENT_BLOGS");
            #endregion

            Response.Write("OK");
        }
        else
        {
            Response.Write("系统错误：" + table._err);
        }
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-17 09:17 */
