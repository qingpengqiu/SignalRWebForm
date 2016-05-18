using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Erun360.BLL;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Data;
using Utils;
public partial class Admin_IntegralList : PageBase
{
    private int idUser = 0;
    DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.idMemberStyle < 12)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (!IsPostBack)
        {
            //Bind();
        }

    }
   
    protected void pager_PageChanged(object sender, EventArgs e)
    {
        Bind(TypeChangeDefault.NullToInt(lbUser.Value, 0));
    }
    private void Bind(int  idUser)
    {
        pager.RecordCount = uMember_History.GetRecordCount(" idUser =" + idUser, idUser);
        int pagesize = pager.PageSize;
        int pageindex = pager.CurrentPageIndex;
        DataTable dt = uMember_History.GetListByPage(" idUser=" + idUser, " dCreate desc", pageindex, pagesize, idUser).Tables[0];
        //DataTable dt = new DB1.tblMEMBER_HISTORY().GetList(" idUser=" + idUser,idUser).Tables[0];
        this.rptrunrecord.DataSource = dt;
        this.rptrunrecord.DataBind();
    }
    
    protected void btQuery_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.idMemberStyle < 12)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        idUser = TypeChangeDefault.NullToInt(txtUserID.Text, 0);
        if (idUser == 0)
        {
            lbCont.Text = "请填写用户id";
            return;
        }
        int count = new DB1.tblMEMBER().GetRecordCount("id=" + idUser);
        if (count == 0)
        {
            lbCont.Text = "该用户不存在，请重新输入！";           
            return;
        }
        lbUser.Value = idUser.ToString();
        lbCont.Text = "总积分" + uMember_History.GetScore("idUser =" + idUser, idUser).ToString();
       
        Bind(idUser);
    }
    public string Group(string idGroup)
    {

        if (idGroup.StartsWith("2008"))
        {

            return new DB1.tblIntegral().FindTitle(Convert.ToInt32(idGroup));
        }
        return new DB1.tblGROUPS().FindTitle(idGroup);
    }
}