using System;
using System.Text;
using System.Web;
using System.Web.UI;
using DB1 = Erun360.BLL.DB1;
using ERUN360.Entity;

public partial class _Utility_Ajax_RaceJoinCreate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        #region ���ȷ��
        Member m = new Member();
        if (m.Default == null)
        {
            Response.Write("��ûע�ᣡ");
            return;
        }
        #endregion

        if (Prison.Find(m.Default.id))
        {
            Response.Redirect("/Member/Logout.aspx");
        }

        int id = 0;
        if (Request.QueryString["id"] == null)
        {
            Response.Write("������1��");
            return;
        }
        id = Int32.Parse(Request.QueryString["id"].ToString());
        if (id == 0)
        {
            Response.Write("������1��");
            return;
        }

        int onwer = 0;
        if (Request.QueryString["onwer"] == null)
        {
            Response.Write("������2��");
            return;
        }
        onwer = Int32.Parse(Request.QueryString["onwer"].ToString());
        if (onwer == 0)
        {
            Response.Write("������2��");
            return;
        }

        RaceJoinInfo record = new RaceJoinInfo();
        record.idOnwer = onwer;
        record.idActivity = id;
        record.idUser = m.Default.id;
        record.cLoginName = m.Default.cLoginName;

        int recordIndex = 0;
        RaceJoin table = new RaceJoin();
        if (table.Insert(record, out recordIndex))
        {
            #region ����:�μӻ��Լ�ܣ����£�
            //MemberHistory history = new MemberHistory();
            //// �����߻���
            //history.Insert(onwer, 100800116, 1);
            //// �����߻���
            //history.Insert(m.Default.id, 200810015, 1);
            //����ע
            new DB1.tblIntegral().InsertScore(onwer, 200810016, 1, 0);
            //��ע
            new DB1.tblIntegral().InsertScore(m.Default.id, 200810015, 1, 0);
            #endregion

            Response.Write("OK");
            return;
        }

        Response.Write("ϵͳ����");

    }
}


