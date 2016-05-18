using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using Erun360.Common;
using ERUN360.Entity;
using Utils;
public partial class Admin_RaceProductSetup : PageBase
{
    DB4.tblRACE_COMPETETION bllcompetetion = new DB4.tblRACE_COMPETETION();
    DB4.tblRACE_SIGNUP bllsignup = new DB4.tblRACE_SIGNUP();
    DB4.tblRACE_SALES bllsales = new DB4.tblRACE_SALES();
    public int racenum = 0;
    public string idcompete = string.Empty;
    public string portrait = string.Empty;
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
            BindDDLFriends();
            PreLoadInfo();
        }
    }
    protected void BindDDLFriends()
    {
        DataSet ds = new DataSet();
        ds = bllcompetetion.GetDDL();
        
        DDLRace.DataSource =ds.Tables[0];
        DDLRace.DataTextField = "cTitle";
        DDLRace.DataValueField = "value";
        DDLRace.DataBind();
    }
    protected void PreLoadInfo()
    {
        DataSet ds = bllsignup.GetList(" idCompete=" + DDLRace.SelectedValue.Split('|')[0]);
        idcompete = DDLRace.SelectedValue.Split('|')[0];
        DataSet dsrecord = new DataSet();
        dsrecord.Tables.Add();
        DataColumn myDataColumn;
        myDataColumn = new DataColumn();
        myDataColumn.DataType = System.Type.GetType("System.String");
        myDataColumn.ColumnName = "inner";
        dsrecord.Tables[0].Columns.Add(myDataColumn);
        racenum = ds.Tables[0].Rows.Count;
        if (portrait.Trim() == "")
        {
            portrait = "/Html/images/up.png";
            avatarurl.Value = "/Html/images/up.png";
        }
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            DataRow drrecord = dsrecord.Tables[0].NewRow();
            drrecord["inner"] = "<input type='hidden' class='id' name='id" + i.ToString() + "' value='" + ds.Tables[0].Rows[i]["id"].ToString() + "'/><input type='text' name='item" + i.ToString() + "' id='item" + i.ToString() + "' class='item' value='" + ds.Tables[0].Rows[i]["cType"].ToString() + "' tabindex='3' /><input type='text' name='price" + i.ToString() + "' class='price' value='" + ds.Tables[0].Rows[i]["iCost"].ToString() + "' id='price" + i.ToString() + "'  tabindex='4' /><label for='price'>元&nbsp;&nbsp;&nbsp;&nbsp;</label><label for='number'>名额：</label><input type='text' name='number" + i.ToString() + "' id='number" + i.ToString() + "' value='" + ds.Tables[0].Rows[i]["iLimit"].ToString() + "' class='number' tabindex='5' /><label for='number'>人&nbsp;&nbsp;</label><label for='commemt" + i.ToString() + "'>备注：</label><input type='text' class='commemt' name='commemt" + i.ToString() + "' id='commemt" + i.ToString() + "'  value='" + ds.Tables[0].Rows[i]["cComment"].ToString() + "' tabindex='5' />";
                
            dsrecord.Tables[0].Rows.Add(drrecord);
        }
        this.rptrunrecord.DataSource = dsrecord.Tables[0];
        this.rptrunrecord.DataBind();
        if(racenum>0)
        {
            portrait = ds.Tables[0].Rows[0]["cURL"].ToString().Trim();
            avatarurl.Value = ds.Tables[0].Rows[0]["cURL"].ToString().Trim();
            if (portrait.Trim() == "")
            {
                portrait = "/Html/images/up.png";
                avatarurl.Value = "/Html/images/up.png";
            }
            
            signingup.Value = ds.Tables[0].Rows[0]["dJoinEnd"].ToString().Trim();
            if (ds.Tables[0].Rows[0]["iCloth"].ToString().Trim() == "1")
            {
                dressyes.Checked = true;
                dressno.Checked = false;
            }
            else
            {
                dressno.Checked = true;
                dressyes.Checked = false;
            }
            if (ds.Tables[0].Rows[0]["iShoe"].ToString().Trim() == "1")
            {
                shoesyes.Checked = true;
                shoesno.Checked = false;
            }
            else
            {
                shoesno.Checked = true;
                shoesyes.Checked = false;
            }
            if (ds.Tables[0].Rows[0]["ihealth"].ToString().Trim() == "1")
            {
                checkyes.Checked = true;
                checkno.Checked = false;
            }
            else
            {
                checkno.Checked = true;
                checkyes.Checked = false;
            }
        }
        //if (checksaled())
        //{
        //    this.Btnsubmit.Enabled = true;
        //}
        //else
        //{
        //    this.Btnsubmit.Enabled = false;
        //}
    }
    protected bool checksaled()
    {
        int num = bllsales.GetRecordCount(" idsignup in (select id from tblrace_signup where idcompete=" + DDLRace.SelectedValue.Split('|')[0] + ")");
        if (num > 0)
            return false;
        else
            return true;
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
        //bllsignup.Delete(Convert.ToInt32(DDLRace.SelectedValue.Split('|')[0]));
        DBM4.tblRACE_SIGNUP msignup = new DBM4.tblRACE_SIGNUP();
        for (int i = 0; i < 1000; i++)
        {
            string id = Convert.ToString(Request.Form["id" + i.ToString()]);
            string cType = Convert.ToString(Request.Form["item" + i.ToString()]);
            string iCost = Convert.ToString(Request.Form["price" + i.ToString()]);
            string iLimit = Convert.ToString(Request.Form["number" + i.ToString()]);
            string cComment = Convert.ToString(Request.Form["commemt" + i.ToString()]);
            if (cType != null)
            {
                if (cType != "" && iCost != "" && iLimit != "")
                {
                    msignup.idBlog =Convert.ToInt32(DDLRace.SelectedValue.Split('|')[1]);
                    msignup.idCompete = Convert.ToInt32(DDLRace.SelectedValue.Split('|')[0]);
                    msignup.cTitle = DDLRace.SelectedItem.Text;
                    msignup.dJoinEnd = Convert.ToDateTime(signingup.Value);
                    msignup.cType = cType;
                    msignup.iLimit =Convert.ToInt32(iLimit);
                    msignup.iCost = Convert.ToInt32(iCost);
                    msignup.cComment = cComment;
                    msignup.cURL = avatarurl.Value;
                    if (dressyes.Checked == true)
                    {
                        msignup.iCloth = 1;
                    }
                    else
                    {
                        msignup.iCloth = 0;
                    }
                    if (shoesyes.Checked == true)
                    {
                        msignup.iShoe = 1;
                    }
                    else
                    {
                        msignup.iShoe = 0;
                    }
                    if (checkyes.Checked == true)
                    {
                        msignup.ihealth = 1;
                    }
                    else
                    {
                        msignup.ihealth = 0;
                    }
                    msignup.dCreate = DateTime.Now;
                    try
                    {
                        if (id == "0")
                        {
                            bllsignup.Add(msignup);
                        }
                        else
                        {
                            msignup.id = Convert.ToInt32(id);
                            bllsignup.Update(msignup);
                        }
                    }
                    catch (Exception ex) { }
                }
            }
            else
            {
                break;
            }

        }
        //提示到前端
        Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('保存成功！','/admin/raceproductsetup.aspx','true');});</script>");
    }
    protected void DDLRace_SelectedIndexChanged(object sender, EventArgs e)
    {
        PreLoadInfo();
    }
}