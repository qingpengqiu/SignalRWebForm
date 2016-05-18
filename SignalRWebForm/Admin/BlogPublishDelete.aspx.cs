using System;
using System.Text;
using System.Web;
using System.Web.UI;
using DB1 = Erun360.BLL.DB1;
using ERUN360.Entity;

public partial class _Admin_BlogPublish_Delete : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsAdmin())
        {
            Response.Redirect("/admin/");
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
        BlogPublish table = new BlogPublish();
        BlogPublishInfo record = table.Load(recordIndex, "", "");
        if (record == null)
        {
            Response.Write("数据错误(Index error)！");
            return;
        }

        if (table.Delete(recordIndex))
        {
            TCache.Clear("CACHE_OF_PAGE_" + record.idPosition);
            TCache.Clear("CACHE_PAGE_TOPICS_" + record.idPosition);

            #region 积分:发布到首页或其它页面

            Blog b = new Blog();
            BlogInfo blog_record = b.Load(recordIndex, "", "");
            if(blog_record!=null)
            {
                MemberHistory history = new MemberHistory();
                if (record.idPosition < 301000000)
                {
                    // 首页                    
                    //history.Insert(blog_record.idUser, 100800112, -1);
                }
                else
                {
                    // 其它页面
                    //history.Insert(blog_record.idUser, 100800111, -1);
                }
            }            
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
/* This file formatted by WizForm 2.1 at 09-17 09:18 */
