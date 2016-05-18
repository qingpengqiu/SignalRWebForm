using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Erun360.BLL;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using Erun360.Model;
using System.Data;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;

public partial class infocenter_PostMessage : PageBase
{
    private int uId = 0;//通过参数传递过来的用户id  ClubId
    private int idClub = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Response.Redirect("/Member/Logout.aspx");
        }
        if (Request.QueryString["uId"] != null)
        {
            uId = int.Parse(Request.QueryString["uId"].ToString());
        }
        if (Request.QueryString["idClub"] != null)
        {
            idClub = int.Parse(Request.QueryString["idClub"].ToString());
        }
        //if (CurrentUser.uId != uId)
        //{
        //    Response.Redirect(UrlHelper.MemberUrl(CurrentUser.uId));
        //}
        if (!IsPostBack)
        {
            if (uId != 0)
            {
                DBM1.tblMEMBER model = new DBM1.tblMEMBER();
                model = new Erun360.BLL.DB1.tblMEMBER().GetModel(uId);
                if (model != null)
                {
                    nick.Value = model.cNickName;
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "racePrint", "<script language='javascript'>window.parent.location.href='" + UrlHelper.MemberUrl(CurrentUser.uId) + "';</script>");
                    //Response.Redirect(UrlHelper.MemberUrl(CurrentUser.uId));
                }
            }
        }
    }
    protected void btpost_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Response.Redirect("/Member/Logout.aspx");
        }
        if (nick.Value.Trim().Length <= 0 || nick.Value.Trim().Length > 64)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('请填写昵称','','false');});</script>");
            return;
        }

        if (Idmsg.Value.Trim().Length <= 0 || Idmsg.Value.Trim().Length >800)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('亲，你还没写留言哦！～','','false');});</script>");
            return;
        }        
       
        if (uId == 0)
        {
            DataTable dt = new DB3.tblATTENTION().GetList(" LEFT(idInfo,1)=1 and idUser="+CurrentUser.uId+" and idInfo in(SELECT [id]  FROM [YP_DB_1].[dbo].[tblMEMBER] where cNickName = '" + nick.Value.Trim() + "')").Tables[0];
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Add(TypeChangeDefault.NullToInt(dt.Rows[i]["idInfo"], 0));
                }
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('用户不存在,请确认用户！','','false');});</script>");

            }
        }
        else
        {
            Add(uId);
        }
    }

    private void Add(int uid)
    {
        DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
        DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();

        disModel.cLoginname = CurrentUser.cNickName;
        if (idClub != 0)
        {
            DBM4.tblRACE_CLUB mClub = new Erun360.BLL.DB4.tblRACE_CLUB().GetModel(idClub);
            if (mClub != null)
            {
                Idmsg.Value += "[<a target=\"_blank\" href=\"/club/" + idClub + ".aspx\">" + mClub.cTitle + "</a>]";
            }
        }

        disModel.cContent = Idmsg.Value.Trim();
        disModel.idInfo = uid;// TypeChangeDefault.NullToInt(dt.Rows[i]["idInfo"], 0);
        disModel.idUser = CurrentUser.uId;
        int imessage = disBll.Add(disModel);
        if (imessage > 0)
        {
            DBM3.tblMessage mMessage = new DBM3.tblMessage();
            mMessage.cId = CurrentUser.uId;
            mMessage.uId = uid;
            mMessage.itype = 31;
            mMessage.idcode = imessage;
            new DB3.tblMessage().Add(mMessage);
            Idmsg.Value = "";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('已留言，请等待TA的回复吧！～','','true');});</script>");
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('发生失败，请稍后重试！～','','false');});</script>");
        }
    }
}