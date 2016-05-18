using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Admin_Blog_Detail : System.Web.UI.Page
{

    // ҳ����Ϣ
    public string PageBuffer = "";
    public BlogInfo record = new BlogInfo();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsAdmin())
        {
            PageBuffer = "û�в���Ȩ�ޣ�";
            return;
        }

        // ��ȡ����
        Blog table = new Blog();
        if (Request["id"] != null)
        {
            int recordIndex = Int32.Parse(XString.PureNumber(Request.QueryString["id"].ToString()));
            record = table.Load(recordIndex, "", "");
            if (record == null)
            {
                record = new BlogInfo();
                PageBuffer = "��Ч���ݴ���(Data null)��";
                return;
            }
        }
        else
        {
            PageBuffer = "���ݴ���(Querystring is null)��";
            return;
        }
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-14 16:40 */
