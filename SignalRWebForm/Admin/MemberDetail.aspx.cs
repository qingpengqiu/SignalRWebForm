using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
public partial class _Admin_Member_Detail : System.Web.UI.Page
{

    // ҳ����Ϣ
    public string PageBuffer = "";
    public MemberInfo record = new MemberInfo();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsAdmin())
        {
            PageBuffer = "û�в���Ȩ�ޣ�";
            return;
        }
        //if (!IsPostBack)
        //{
          
        //}
        // ��ȡ����
        Member table = new Member();
        if (Request["id"] != null)
        {
            int recordIndex = Int32.Parse(XString.PureNumber(Request.QueryString["id"].ToString()));
            record = table.Load(recordIndex, "", "");
            if (record == null)
            {
                record = new MemberInfo();
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
    protected void btPassWord_Click(object sender, EventArgs e)
    {
        DBM1.tblMEMBER model = new DBM1.tblMEMBER();
        model.id = Int32.Parse(XString.PureNumber(Request.QueryString["id"].ToString()));
        model.cPassword = "96e79218965eb72c92a549dd5a330112";
        new DB1.tblMEMBER().Update(model);
        lbPassWord.Text = "����������Ϊ111111";
    }
}