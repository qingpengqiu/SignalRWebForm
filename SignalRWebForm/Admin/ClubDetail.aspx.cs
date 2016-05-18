using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBM4 = Erun360.Model.DB4;
using DB4 = Erun360.BLL.DB4;
using DBM1 = Erun360.Model.DB1;
using DB1 = Erun360.BLL.DB1;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using Utils;
using System.Data;
public partial class Admin_ClubDetail : PageBase
{
    public DBM4.tblRACE_CLUB mClub = new DBM4.tblRACE_CLUB();

    int id;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle < 13)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
       
        if (Request.QueryString["id"] != null)
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
        }
        else
        { AlertHelper.JQAlertGo("该俱乐部不存在", UrlHelper.MemberUrl(CurrentUser.uId), false); }
        if (!IsPostBack)
        {
            mClub = new DB4.tblRACE_CLUB().GetModel(id);
        }

    }
    //通过
    protected void ibttg_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle < 13)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        DBM4.tblRACE_CLUB mClub = new DBM4.tblRACE_CLUB();
        mClub.id = id;
        mClub.iAudit = 5;
        if (new DB4.tblRACE_CLUB().Update(mClub))
        {
            mClub = new DB4.tblRACE_CLUB().GetModel(id);
            DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
            DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
            disModel.cContent = "您的俱乐部《<a href=\"/club/" + mClub.id + ".aspx\" target=\"_blank\">" + mClub.cTitle + "</a>》已审核通过！";
            disModel.idInfo = mClub.idUser;
            disModel.idUser = 100043387;
            disModel.cLoginname = "益跑管理员";
            // disModel.dCreate = DateTime.Now;
            int imessage = disBll.Add(disModel);
            if (imessage > 0)
            {
                DBM3.tblMessage mMessage = new DBM3.tblMessage();
                mMessage.cId = 100043387;
                mMessage.uId = mClub.idUser;
                mMessage.itype = 31;
                mMessage.idcode = imessage;
                new DB3.tblMessage().Add(mMessage);
            }
            AlertHelper.JQAlertGo("审核通过！", "ClubList.aspx", true);
        }
        else
        {
            AlertHelper.JQAlert("审核失败，请重试！", false);
        }
    }
    //驳回
    protected void ibtbh_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle < 13)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        DBM4.tblRACE_CLUB mClub = new DBM4.tblRACE_CLUB();
        mClub.id = id;
        mClub.iAudit = 1;
        if (new DB4.tblRACE_CLUB().Update(mClub))
        {
            mClub = new DB4.tblRACE_CLUB().GetModel(id);
            DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
            DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
            disModel.cContent = "您的俱乐部《" + mClub.cTitle + "》已被管理员驳回，请重新提交俱乐部申请！";
            disModel.idInfo = mClub.idUser;
            disModel.idUser = 100043387;
            disModel.cLoginname = "益跑管理员";
            // disModel.dCreate = DateTime.Now;
            int imessage = disBll.Add(disModel);
            if (imessage > 0)
            {
                DBM3.tblMessage mMessage = new DBM3.tblMessage();
                mMessage.cId = 100043387;
                mMessage.uId = mClub.idUser;
                mMessage.itype = 31;
                mMessage.idcode = imessage;
                new DB3.tblMessage().Add(mMessage);
            }
            AlertHelper.JQAlertGo("已驳回！", "ClubList.aspx", true);
        }
        else
        {
            AlertHelper.JQAlert("驳回失败，请重试！", false);
        }
    }
    protected void ibtbtg_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle < 13)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        DBM4.tblRACE_CLUB mClub = new DBM4.tblRACE_CLUB();
        mClub.id = id;
        mClub.iAudit = 2;
        if (new DB4.tblRACE_CLUB().Update(mClub))
        {
            mClub = new DB4.tblRACE_CLUB().GetModel(id);       
            DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
            DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
            disModel.cContent = "您的俱乐部《" + mClub.cTitle + "》已被管理员禁用，请联系益跑管理员！";
            disModel.idInfo = mClub.idUser;
            disModel.idUser = 100043387;
            disModel.cLoginname = "益跑管理员";
            // disModel.dCreate = DateTime.Now;
            int imessage = disBll.Add(disModel);
            if (imessage > 0)
            {
                DBM3.tblMessage mMessage = new DBM3.tblMessage();
                mMessage.cId = 100043387;
                mMessage.uId = mClub.idUser;
                mMessage.itype = 31;
                mMessage.idcode = imessage;
                new DB3.tblMessage().Add(mMessage);
            }
            AlertHelper.JQAlertGo("禁用成功！", "ClubList.aspx", true);
        }
        else
        {
            AlertHelper.JQAlert("禁用失败，请重试！", false);
        }
    }
    protected void ibtgb_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle < 13)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        DBM4.tblRACE_CLUB mClub = new DBM4.tblRACE_CLUB();
        mClub.id = id;
        mClub.iAudit = -1;
        if (new DB4.tblRACE_CLUB().Update(mClub))
        {
            mClub = new DB4.tblRACE_CLUB().GetModel(id);
            DBM1.tblMEMBER mMember = new DBM1.tblMEMBER();
            mMember.idMemberStyle = 0;
            mMember.id = mClub.idUser ?? 0;
            new DB1.tblMEMBER().Update(mMember);
            //删除俱乐部积分
            DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
            if (!uMember_History.Exists(200810027, mClub.idUser ?? 0))
            {
                new DB1.tblIntegral().InsertScore(mClub.idUser ?? 0, 200810027, 1, 0);
            }
            DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
            DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
            disModel.cContent = "您的俱乐部《" + mClub.cTitle + "》已被管理员关闭！";
            disModel.idInfo =mClub.idUser;
            disModel.idUser = 100043387;
            disModel.cLoginname = "益跑管理员";
            // disModel.dCreate = DateTime.Now;
            int imessage = disBll.Add(disModel);
            if (imessage > 0)
            {
                DBM3.tblMessage mMessage = new DBM3.tblMessage();
                mMessage.cId = 100043387;
                mMessage.uId = mClub.idUser;
                mMessage.itype = 31;
                mMessage.idcode = imessage;
                new DB3.tblMessage().Add(mMessage);
            }
            AlertHelper.JQAlertGo("关闭俱乐部！", "ClubList.aspx", true);
        }
        else
        {
            AlertHelper.JQAlert("关闭俱乐部失败，请重试！", false);
        }
    }
}