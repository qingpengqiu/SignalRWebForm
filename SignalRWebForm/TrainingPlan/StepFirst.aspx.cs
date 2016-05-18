using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB5_Model = Erun360.Model.DB5;
using DB5_DAL = Erun360.DAL.DB5;
using DB5_BLL = Erun360.BLL.DB5;

public partial class TrainingPlan_StepFirst : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
        }
        else if (new DB5_BLL.tblPlan_Person().GetGoingPlanPersonIdByUId(CurrentUser.uId) > 0)
        {
            Response.Redirect("/TrainingPlan/TrainingPlan.aspx");
        }
    }
}