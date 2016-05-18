using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
public partial class Admin_IntegralEdit : PageBase
{
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

    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
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
        int idUser = TypeChangeDefault.NullToInt(txtUserId.Value.Trim(), 0);
        if (idUser == 0)
        {
            AlertHelper.JQAlert("请填写用户id");
            return;
        }
        int count = new DB1.tblMEMBER().GetRecordCount("id=" + idUser);
        if (count == 0)
        {
            AlertHelper.JQAlert("该用户不存在");
            return;
        }
        int iScore = TypeChangeDefault.NullToInt(txtScore.Value.Trim(), 0);
        if (iScore == 0)
        {
            AlertHelper.JQAlert("请填写积分值！");
            return;
        }
        if (txtMark.Value.Trim().Length == 0 || txtMark.Value.Trim().Length >200)
        {
            AlertHelper.JQAlert("请填写原因或原因超过限制(200字以内)！");
            return;
        }
        DBM1.tblMEMBER_HISTORY mHistory = new DBM1.tblMEMBER_HISTORY();
        mHistory.idCreator = CurrentUser.uId;
        if (ddlScore.SelectedItem.Value == "200830001")
        {
            mHistory.idGroup = 200830001;
            mHistory.iScore = iScore;
        }
        else if (ddlScore.SelectedItem.Value == "200830002")
        {
            mHistory.idGroup = 200830002;
            mHistory.iScore = iScore * -1;
        }
        else
        {
            AlertHelper.JQAlert("请选择积分类型");
            return;
        }
        mHistory.idUser = idUser;

        mHistory.cMark = txtMark.Value.Trim();
        if (new DB1.tblMEMBER_HISTORY().Add(mHistory) > 0)
        {
            AlertHelper.JQAlertGo("添加成功！", "IntegralList.aspx", true);
        }
        else
        {
            AlertHelper.JQAlert("添加失败，请重试！", false);
        }
    }
}