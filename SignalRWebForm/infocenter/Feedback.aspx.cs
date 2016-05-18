using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
public partial class infocenter_Feedback : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnGetValue_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        //int Score = new DB1.tblMEMBER_HISTORY().GetScore("dCreate<'2014-06-03 00:00:00' and idUser =" + CurrentUser.uId, CurrentUser.uId) + 1000;
        //DB1.tblMEMBER_HISTORY BLL = new DB1.tblMEMBER_HISTORY();
        //DBM1.tblMEMBER_HISTORY model = new DBM1.tblMEMBER_HISTORY();
        //if (!BLL.Exists(200840003, CurrentUser.uId))
        //{
        //    new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200840003, 4, Score);
        //    AlertHelper.JQAlertGo("恭喜您成功领取积分！", "/infocenter/Integral.aspx?uId=" + CurrentUser.uId, true);
        //    return;
        //}
        //else
        //{
        //    AlertHelper.JQAlertGo("您已领过，请不要重复领取！", "/infocenter/Integral.aspx?uId=" + CurrentUser.uId, true);
        //    return;
        //}
        string dCreate = TypeChangeDefault.NullToDateTime(CurrentUser.dCreate, DateTime.Now).ToString("yyyy-MM-dd HH:mm");
        if (dCreate.CompareTo("2014-06-03 00:00:00") < 0)
        {
            int Score = new DB1.tblMEMBER_HISTORY().GetScore("dCreate<'2014-06-03 00:00:00' and idUser =" + CurrentUser.uId, CurrentUser.uId) + 1000;
            DB1.tblMEMBER_HISTORY BLL = new DB1.tblMEMBER_HISTORY();
            DBM1.tblMEMBER_HISTORY model = new DBM1.tblMEMBER_HISTORY();
            if (!BLL.Exists(200840003, CurrentUser.uId))
            {
                new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200840003, 4, Score);
                AlertHelper.JQAlertGo("恭喜您成功领取积分！", "/infocenter/Integral.aspx?uId=" + CurrentUser.uId, true);
                return;
            }
            else
            {
                AlertHelper.JQAlertGo("您已领过，请不要重复领取！", "/infocenter/Integral.aspx?uId=" + CurrentUser.uId, true);
                return;
            }
        }
        else
        {
            AlertHelper.JQAlertGo("您不符合领取要求！", UrlHelper.MemberUrl(CurrentUser.uId), true);
            return;
        }
       
    }
}