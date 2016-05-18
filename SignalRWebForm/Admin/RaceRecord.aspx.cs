using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using System.Data;
using System.IO;
using System.Xml.Linq;
using System.Xml;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
public partial class Admin_RaceRecord : PageBase
{
    DB4.tblRACE_COMPETETION bllcompetetion = new DB4.tblRACE_COMPETETION();
    DB4.tblRACE_SIGNUP bllsignup = new DB4.tblRACE_SIGNUP();
    DB4.tblRACE_SALES bllsales = new DB4.tblRACE_SALES();
    DB4.tblTeam BLLTeam = new DB4.tblTeam();
    public int idRace = 0;//赛事id
    public int idItem = 0;
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
        idRace = TypeChangeDefault.NullToInt(Request.QueryString["idRace"], 0);
        idItem = TypeChangeDefault.NullToInt(Request.QueryString["idItem"], 0);
        if (!IsPostBack)
        {
            BindDDL();
            if (idRace == 0)
            {
                idRace = TypeChangeDefault.NullToInt(DDLRace.SelectedValue, 0);
            }
            BindRadioList(idRace);
            if (idItem == 0)
            {
                RadioButtonList1.Items[0].Selected = true;
                idItem = TypeChangeDefault.NullToInt(RadioButtonList1.SelectedValue, 0);
            }
            DBM4.tblRACE_SIGNUP model = bllsignup.GetModel(idItem);
            if (model == null)
            {
                AlertHelper.JQAlertGo("赛事与项目不一致", "RaceRecord.aspx", false);
                return;
            }
            if (idRace != model.idCompete)
            {
                AlertHelper.JQAlertGo("赛事与项目不一致", "RaceRecord.aspx", false);
                return;
            }
            RadioButtonList1.ClearSelection();
            RadioButtonList1.Items.FindByValue(idItem.ToString()).Selected = true;
            DDLRace.SelectedValue = idRace.ToString();           
            BindData();

        }
    }    
    #region 绑定数据 
    private void BindData()
    {
        //DataSet ds = new DB4.tblRACE_SALES().GetListByPage("", "id desc", 1, 40);
        DataSet ds = bllsales.GetList(0, " idSignUp=" + idItem, "dCreate");
        Repeater1.DataSource = ds;
        Repeater1.DataBind();
    }
    protected void DDLRace_SelectedIndexChanged(object sender, EventArgs e)
    {
        idRace = TypeChangeDefault.NullToInt(DDLRace.SelectedValue, 0);
        idItem = 0;        
        Response.Redirect("RaceRecord.aspx?idRace=" + idRace + "&idItem=" + idItem);
    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        idRace = TypeChangeDefault.NullToInt(DDLRace.SelectedValue, 0);
        idItem = TypeChangeDefault.NullToInt(RadioButtonList1.SelectedValue, 0);
        Response.Redirect("RaceRecord.aspx?idRace=" + idRace + "&idItem=" + idItem);
    }
    protected void BindDDL()
    {
        DataSet ds = bllcompetetion.GetSignupcompete();
        DDLRace.DataSource = ds;
        DDLRace.DataTextField = "cTitle";
        DDLRace.DataValueField = "ID";
        DDLRace.DataBind();
    }
    protected void BindRadioList(int idRace)
    {
        DataSet ds = bllsignup.GetList("  idcompete=" + idRace);
        RadioButtonList1.DataSource = ds;
        RadioButtonList1.DataTextField = "cType";
        RadioButtonList1.DataValueField = "ID";
        RadioButtonList1.DataBind();
    }
    #endregion
    #region 导出execl
    protected void Button1_Click(object sender, EventArgs e)
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
        if (idItem == 0)
        {
            RadioButtonList1.Items[0].Selected = true;
            idItem = TypeChangeDefault.NullToInt(RadioButtonList1.SelectedValue, 0);
        }
        string str = System.DateTime.Now.ToString("yyyyMMddhhmmss") + ".xls";
        DataSet ds = bllsales.GetList(0, " iState>=2 and idSignUp=" + idItem, " iState ");

        gvAll.DataSource = ds;
        gvAll.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
        gvAll.DataBind();

        GridViewToExcel(gvAll, "application/excel", str);
    }
    protected void btEcexl_Click(object sender, EventArgs e)
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
        if (idRace == 0)
        {
            idRace = TypeChangeDefault.NullToInt(DDLRace.SelectedValue, 0);
        }
        string str = System.DateTime.Now.ToString("yyyyMMddhhmmss") + ".xls";
        DataSet ds = bllsales.GetList(0, " iState>=2 and idSignUp in(SELECT [id]  FROM [YP_DB_4].[dbo].[tblRACE_SIGNUP] where idCompete=" + idRace + ")", " cType ");

        gvAll.DataSource = ds;
        gvAll.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
        gvAll.DataBind();

        GridViewToExcel(gvAll, "application/excel", str);
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    public static void GridViewToExcel(Control ctrl, string FileType, string FileName)
    {
        HttpContext.Current.Response.Charset = "GB2312";
        HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.UTF8;//注意编码
        HttpContext.Current.Response.AppendHeader("Content-Disposition",
            "attachment;filename=" + HttpUtility.UrlEncode(FileName, System.Text.Encoding.UTF8).ToString());
        HttpContext.Current.Response.ContentType = FileType;//image/JPEG;text/HTML;image/GIF;vnd.ms-excel/msword
        ctrl.Page.EnableViewState = false;
        StringWriter tw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(tw);
        ctrl.RenderControl(hw);
        HttpContext.Current.Response.Write(tw.ToString());
        HttpContext.Current.Response.End();
    }
    //根据项目id和用户id获取当前用户的组队编号
    public string GetTeamID(string idItem, string IdUser)
    {
        DataTable dt = BLLTeam.GetList("idItem=" + idItem + " and IdUser=" + IdUser).Tables[0];
        if (dt.Rows.Count > 0)
        {
            return dt.Rows[0]["iSNo"].ToString();
        }
        return "";
    }
    //根据项目id和用户id获取当前用户的附属产品
    public string GetAnnexLog(string idItem, string IdUser)
    {
        DataTable dt = new DB4.tblAnnexLog().GetList("iState=2 and idItem=" + idItem + " and IdUser=" + IdUser).Tables[0];
        string strLog = string.Empty;
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            strLog += dt.Rows[i]["cName"].ToString() +"("+ dt.Rows[i]["fPrice"].ToString()+")";
        }
        return strLog;
    }
    public string GetidOccupation(string id)
    {
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(Server.MapPath("/XML/Strings.xml"));
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("Strings/idOccupations/idOccupation[ValueField='"+id+"']");//查找
        XmlNode xmlNode = xmlNodeList.Item(0);
        return xmlNode["TextField"].InnerText;
    }
    public string GetNick(string idUser)
    {
        DBM1.tblMEMBER model = new DB1.tblMEMBER().GetModel(Convert.ToInt32(idUser));
        if (model != null)
        {
            return model.cNickName;
        }
        return "";
    }
    #endregion

}