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
using DB2 = Erun360.BLL.DB2;
using DBM4 = Erun360.Model.DB4;
using Erun360.Common;
using ERUN360.Entity;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
public partial class Admin_RaceListRecord : PageBase
{
    DB4.tblRACE_COMPETETION bllcompetetion = new DB4.tblRACE_COMPETETION();
    DB4.tblRACE_SIGNUP bllsignup = new DB4.tblRACE_SIGNUP();
    DB4.tblRACE_SALES bllsales = new DB4.tblRACE_SALES();
    DB4.tblTeam BLLTeam = new DB4.tblTeam();
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
            Session["update"] = "0";
            BindDDL();
            if (DDLRace.Items.Count > 0)
            {
                DDLRace.Items[0].Selected = true;
                BindRadioList();
                if (RadioButtonList1.Items.Count > 0)
                {
                    RadioButtonList1.Items[0].Selected = true;
                    BindGV();
                }
            }
        }
    }
    protected void BindDDL()
    {
        DataSet ds = bllcompetetion.GetSignupcompete();
        DDLRace.DataSource = ds;
        DDLRace.DataTextField = "cTitle";
        DDLRace.DataValueField = "ID";
        DDLRace.DataBind();
    }
    protected void BindRadioList()
    {
        DataSet ds = bllsignup.GetList("  idcompete=" + DDLRace.SelectedValue);
        RadioButtonList1.DataSource = ds;
        RadioButtonList1.DataTextField = "cType";
        RadioButtonList1.DataValueField = "ID";
        RadioButtonList1.DataBind();
    }
    protected void BindGV()
    {
        Session["update"] = "0";
        DataSet ds = bllsales.GetList(0, " idSignUp=" + RadioButtonList1.SelectedValue, "dCreate");
        GVmain.DataSource = ds;
        GVmain.DataBind();
    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Session["update"].ToString() == "1")
        {
            DBindGV();
        }
        else
        {
            BindGV();
        }
        //BindGV();
    }
    protected void DDLRace_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindRadioList();
        if (RadioButtonList1.Items.Count > 0)
        {

            RadioButtonList1.Items[0].Selected = true;
            BindGV();
        }
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
    protected void GVmain_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (Session["update"].ToString() == "1")
        {
            DBindGV();
        }
        else
        {
            BindGV();
        }
        //BindGV();
    }
    protected void GVmain_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GVmain.EditIndex = -1;
        //BindGV();
        if (Session["update"].ToString() == "1")
        {
            DBindGV();
        }
        else
        {
            BindGV();
        }
    }
    protected void GVmain_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GVmain.EditIndex = e.NewEditIndex;
        //BindGV();
        if (Session["update"].ToString() == "1")
        {
            DBindGV();
        }
        else
        {
            BindGV();
        }
    }
    protected void GVmain_RowUpdating(object sender, GridViewUpdateEventArgs e)
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
        DBM4.tblRACE_SALES mSales = new DBM4.tblRACE_SALES();

        mSales.id = Convert.ToInt16(((Label)(GVmain.Rows[e.RowIndex].FindControl("sid"))).Text);
        //string score = ((Label)this.GVList.Rows[e.NewSelectedIndex].FindControl("lb_score")).Text;

        //if (Convert.ToInt16(((TextBox)(GVmain.Rows[e.RowIndex].FindControl("iState"))).Text) == 1)
        //{

        //}
        mSales.iState = Convert.ToInt16(((TextBox)(GVmain.Rows[e.RowIndex].FindControl("iState"))).Text);
        mSales.cCloth = ((TextBox)(GVmain.Rows[e.RowIndex].Cells[2].Controls[0])).Text.ToString().Trim();

        mSales.cName = ((TextBox)(GVmain.Rows[e.RowIndex].Cells[4].Controls[0])).Text.ToString().Trim();
        mSales.idGender = Convert.ToInt16(((TextBox)(GVmain.Rows[e.RowIndex].FindControl("idGender"))).Text);
        //mSales.idBlood = Convert.ToInt16(((TextBox)(GVmain.Rows[e.RowIndex].FindControl("idBlood"))).Text);
        //mSales.dBirthday = Convert.ToDateTime(((TextBox)(GVmain.Rows[e.RowIndex].FindControl("dBirthday"))).Text);
        //mSales.idNationIDType = Convert.ToInt16(((TextBox)(GVmain.Rows[e.RowIndex].FindControl("idNationIDType"))).Text);
        mSales.cNationID = ((TextBox)(GVmain.Rows[e.RowIndex].Cells[6].Controls[0])).Text.ToString().Trim();
        mSales.cMobile = ((TextBox)(GVmain.Rows[e.RowIndex].Cells[7].Controls[0])).Text.ToString().Trim();
        mSales.cMail = ((TextBox)(GVmain.Rows[e.RowIndex].Cells[8].Controls[0])).Text.ToString().Trim();

        //mSales.cAddress = ((TextBox)(GVmain.Rows[e.RowIndex].Cells[10].Controls[0])).Text.ToString().Trim();
        //mSales.cZipcode = ((TextBox)(GVmain.Rows[e.RowIndex].Cells[11].Controls[0])).Text.ToString().Trim();
        //mSales.cEmergerContact = ((TextBox)(GVmain.Rows[e.RowIndex].Cells[10].Controls[0])).Text.ToString().Trim();
        mSales.cRemark1 = ((TextBox)(GVmain.Rows[e.RowIndex].Cells[9].Controls[0])).Text.ToString().Trim();
        int iState = new DB4.tblRACE_SALES().GetState(mSales.id);
        //付款成功，状态不能修改
        if (iState > 1)
        {
            mSales.iState = null;
        }
        if (mSales.iState > 3)
        {
            AlertHelper.JQAlertGo("你操作有误，请输入正确的值", UrlHelper.MemberUrl(CurrentUser.uId), false);
            return;
        }
        if (new DB4.tblRACE_SALES().Update(mSales))
        {

            DBM4.tblRACE_SALES modelSales = new DB4.tblRACE_SALES().GetModel(mSales.id);
            
            DBM4.tblRACE_SIGNUP modelSignup = new DB4.tblRACE_SIGNUP().GetModel(modelSales.idSignUp ?? 0);
            if (modelSignup != null)
            {
                //状态有变为-1
                if ((iState == 0 || iState == 1) && modelSales.iState == -1)
                {
                    //附属产品数量加1
                    new DB4.tblAnnex().UpdateItemNum(modelSales.idUser ?? 0, modelSignup.idCompete ?? 0);
                    //附属产品记录置过期 -1
                    new DB4.tblAnnexLog().UpdateState(modelSales.idUser ?? 0, modelSignup.idCompete ?? 0, -1);
                    if (modelSales.cRemark5 == "1")
                    {
                        new DB1.tblIntegral().InsertScore(modelSales.idUser ?? 0, 200830003, 3, modelSignup.iScore ?? 0);
                    }
                }
                if (modelSignup.iAudit == 1)
                {
                    if (iState == 0 && modelSales.iState == 1)
                    {
                        DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                        DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                        //<a target="_blank" href="">2014年金山岭长城国际马拉松赛测试测试</a>
                        disModel.cContent = "您在《<a href=\"/blog/" + modelSignup.idBlog + ".aspx\" target=\"_blank\">" + modelSignup.cTitle + "</a>》报名中已通过审核！<a target=\"_blank\" href=\"/Channels/Competetion/RacePay.aspx?orderid=" + modelSales.idOrder + "\">去付款</a>，谢谢！";
                        disModel.idInfo = modelSales.idUser;
                        disModel.idUser = 100001183;
                        disModel.cLoginname = "益跑赛事";
                        // disModel.dCreate = DateTime.Now;
                        int imessage = disBll.Add(disModel);
                        if (imessage > 0)
                        {
                            DBM3.tblMessage mMessage = new DBM3.tblMessage();
                            mMessage.cId = 100001183;
                            mMessage.uId = modelSales.idUser;
                            mMessage.itype = 31;
                            mMessage.idcode = imessage;
                            new DB3.tblMessage().Add(mMessage);
                        }
                    }
                }
            }

        }

        GVmain.EditIndex = -1;
        if (Session["update"].ToString() == "1")
        {
            DBindGV();
        }
        else
        {
            BindGV();
        }
        //BindGV();
    }
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
            return;
        }
        DateTime dt = System.DateTime.Now;
        string str = dt.ToString("yyyyMMddhhmmss");
        str = str + ".xls";
        DataSet ds = bllsales.GetList(0, " iState>=2 and idSignUp=" + RadioButtonList1.SelectedValue, " iState ");

        GVmain0.DataSource = ds;
        GVmain0.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
        GVmain0.DataBind();

        GridViewToExcel(GVmain0, "application/excel", str);

        // Export(gvRecord, "application/ms-excel", str);
    }
    /// <summary>
    /// 将网格数据导出到Excel
    /// </summary>
    /// <param name="ctrl">网格名称(如GridView1)</param>
    /// <param name="FileType">要导出的文件类型(Excel:application/ms-excel)</param>
    /// <param name="FileName">要保存的文件名</param>
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
    /// <summary>
    /// ReLoad this VerifyRenderingInServerForm is neccessary
    /// </summary>
    /// <param name="control"></param>
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void GVmain_PreRender(object sender, EventArgs e)
    {

    }
    protected void GVmain_PageIndexChanged(object sender, EventArgs e)
    {

    }
    protected void GVmain_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.GVmain.PageIndex = e.NewPageIndex;
        if (Session["update"].ToString() == "1")
        {
            DBindGV();
        }
        else
        {
            BindGV();
        }
        //BindGV();
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
        string str = System.DateTime.Now.ToString("yyyyMMddhhmmss")+ ".xls";
        DataSet ds = bllsales.GetList(0, " iState>=2 and idSignUp in(SELECT [id]  FROM [YP_DB_4].[dbo].[tblRACE_SIGNUP] where idCompete=" + DDLRace.SelectedValue + ")", " cType ");

        gvAll.DataSource = ds;
        gvAll.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
        gvAll.DataBind();

        GridViewToExcel(gvAll, "application/excel", str);
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
         DBindGV();
    }
    protected void DBindGV()
    {
        Session["update"] = "1";
        DataSet ds = bllsales.GetList(0, " iState=0 and  idSignUp=" + RadioButtonList1.SelectedValue, "dCreate");
        GVmain.DataSource = ds;
        GVmain.DataBind();

    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Session["update"] = "0";
        BindGV();
    }
}
