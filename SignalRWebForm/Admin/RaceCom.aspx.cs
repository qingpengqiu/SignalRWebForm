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
using Erun360.Common;
using ERUN360.Entity;

public partial class Admin_RaceCom : PageBase
{
    public string portrait = string.Empty;
    public string idcompete = string.Empty;
    private string id = string.Empty;
    string items = string.Empty;
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
            if (Request.QueryString["id"] != null)
            {
                id = Request.QueryString["id"].ToString();
                DDLRace.SelectedValue = id;
            }            
            BindFscp();
            BindDDLFriends();
            PreLoadInfo();
        }
    }
    protected void Btnsubmit_Click(object sender, EventArgs e)
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
        DBM4.tblRACE_SIGNUP mSignUp = new DBM4.tblRACE_SIGNUP();
        mSignUp.idCompete = Convert.ToInt32(DDLRace.SelectedValue);
        mSignUp.dJoinEnd = Convert.ToDateTime(signingup.Value);
        mSignUp.cTitle = DDLRace.SelectedItem.Text;
        mSignUp.cURL = avatarurl.Value;
        string fscp = string.Empty;//附属产品
        foreach (ListItem li in cbxFscp.Items)
        {
            if (li.Selected)    //表示某一项被选中了
            {
                fscp += li.Value + ",";
            }
        }
        mSignUp.cItem = fscp.TrimEnd(',');
        if (new DB4.tblRACE_SIGNUP().ExistsCompete(Convert.ToInt32(DDLRace.SelectedValue)))
        {
            //if (new DB4.tblRACE_SIGNUP().UpdateRaceByidCompete(mSignUp.idCompete ?? 0, mSignUp.dJoinEnd.ToString(), mSignUp.cURL.ToString()))
            if (new DB4.tblRACE_SIGNUP().UpdateRaceByidCompete(mSignUp.idCompete ?? 0, mSignUp.dJoinEnd.ToString(), mSignUp.cURL.ToString(),mSignUp.cTitle, mSignUp.cItem))
            {
                Erun360.Common.DataCache.RemoveAllCache("tblRACE_COMPETETIONM");
                AlertHelper.JQAlertGo("发布成功！", "RaceCom.aspx?id=" + DDLRace.SelectedValue, true);
            }
            else
            {
                AlertHelper.JQAlert("发布失败，请重试！", false);
            }
        }
        else
        {
            AlertHelper.JQAlert("请先添加项目及费用再提交！", false);
        }
    }
    protected void BindDDLFriends()
    {
        DataSet ds = new DB4.tblRACE_COMPETETION().GetList(" DATEDIFF([second], getdate() , dJoinEnd)>0");
        DDLRace.DataSource = ds;
        DDLRace.DataTextField = "cTitle";
        DDLRace.DataValueField = "id";
        DDLRace.DataBind();
    }
    protected void BindFscp()
    {
        DataSet ds = new DB4.tblAnnex().GetList(" iState>0 and iNum>0");
        cbxFscp.DataSource = ds;
        cbxFscp.DataTextField = "cName";
        cbxFscp.DataValueField = "id";
        cbxFscp.DataBind();
    }
    protected void PreLoadInfo()
    {        
        idcompete = DDLRace.SelectedValue;
        DataSet ds = new DB4.tblRACE_SIGNUP().GetList(" idCompete=" + DDLRace.SelectedValue);
        this.rptrunrecord.DataSource = ds;
        this.rptrunrecord.DataBind();
        if (ds.Tables[0].Rows.Count > 0)
        {
            signingup.Value = Convert.ToDateTime(ds.Tables[0].Rows[0]["dJoinEnd"]).ToString("yyyy-MM-dd HH:mm"); 
            portrait = ds.Tables[0].Rows[0]["cURL"].ToString();
            avatarurl.Value = ds.Tables[0].Rows[0]["cURL"].ToString();
            items = ds.Tables[0].Rows[0]["cItem"].ToString();
            string[] ca = items.Split(',');
            DataTable dt = new DB4.tblAnnex().GetList(" iState>0 and iNum>0").Tables[0];            
            for (int i = 0; i < dt.Rows.Count; i++)//给CheckBoxList选中的复选框 赋值                  
            {
                for (int j = 0; j < ca.Length; j++)
                {
                    //cbxFscp.Items[i].Selected = false;
                    if (dt.Rows[i]["id"].ToString() == ca[j])
                    {
                        cbxFscp.Items[i].Selected = true;
                    }
                }
            }
        }
        else
        {
            portrait = "/Html/images/up.png";
            avatarurl.Value = "/Html/images/up.png";
        }      
    }
    protected void DDLRace_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dt = new DB4.tblAnnex().GetList(" iState>0 and iNum>0").Tables[0];
        for (int i = 0; i < dt.Rows.Count; i++)//给CheckBoxList选中的复选框 赋值                  
        {
            cbxFscp.Items[i].Selected = false;
        }
        PreLoadInfo();
    }
}