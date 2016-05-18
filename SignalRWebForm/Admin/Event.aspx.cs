using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
public partial class Admin_Event : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.uId != 100001183 && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (!IsPostBack)
        {
            pager.RecordCount = new DB4.tblEvent().GetRecordCount("");
            BindAllGV();
        }

    }
    protected void BindAllGV()
    {
        int pagesize = pager.PageSize;
        int pageindex = pager.CurrentPageIndex;
        DataSet ds = new DB4.tblEvent().GetListByPage("", "dCreate desc", pageindex, pagesize);
        rptRace.DataSource = ds;
        rptRace.DataBind();
    }
    protected void pager_PageChanged(object sender, EventArgs e)
    {
        BindAllGV();
    }
}