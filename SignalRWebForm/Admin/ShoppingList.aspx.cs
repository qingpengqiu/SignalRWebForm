using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
public partial class Admin_ShoppingList : PageBase
{
    private string itype = "1";
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
        if (!IsPostBack)
        {
            if (rdotype.SelectedIndex>0)
            {
                itype = rdotype.SelectedValue;
            }
            BindGood(itype);
            //pager.RecordCount = new DB1.tblShopping().GetRecordCount("iState=2");
            //pager.RecordCount = new DB1.tblShopping().GetRecordCount("");
            BindGV();
            //BindAllGV();
        }
    }
    protected void ddlShop_SelectedIndexChanged(object sender, EventArgs e)
    {
        pager.RecordCount = 0;
        BindGV();
    }
    protected void BindGood(string itype)
    {
        DataSet ds = new DB1.tblGoods().GetList("iType=" + itype);
        ddlShop.DataSource = ds;
        ddlShop.DataTextField = "cName";
        ddlShop.DataValueField = "id";
        ddlShop.DataBind();
    }
    protected void BindGV()
    {
        if (ddlShop.SelectedValue != "")
        {
            DataSet ds = new DB1.tblShopping().GetList(0, "idGood=" + ddlShop.SelectedValue, "dPay desc");
            GVmain.DataSource = ds;
            GVmain.DataBind();
        }
    }
    protected void btAll_Click(object sender, EventArgs e)
    {
        //pager.RecordCount = new DB1.tblShopping().GetRecordCount("iState=2");
        pager.RecordCount = new DB1.tblShopping().GetRecordCount("");
        BindAllGV();
    }
    protected void pager_PageChanged(object sender, EventArgs e)
    {
        BindAllGV();
    }
    protected void BindAllGV()
    {
        int pagesize = pager.PageSize;
        int pageindex = pager.CurrentPageIndex;
        //DataSet ds = new DB1.tblShopping().GetListByPage("iState=2", "dPay desc", pageindex, pagesize);
        DataSet ds = new DB1.tblShopping().GetListByPage("", "dPay desc", pageindex, pagesize);
        GVmain.DataSource = ds;
        GVmain.DataBind();
    }
    protected void rdotype_SelectedIndexChanged(object sender, EventArgs e)
    {

        BindGood(rdotype.SelectedValue);
        BindGV();
    }
    //导出购买记录
    protected void btdcgm_Click(object sender, EventArgs e)
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
        string str = System.DateTime.Now.ToString("yyyyMMddhhmmss") + ".xls";
        string idItem = TypeChangeDefault.NullToString(ddlShop.SelectedValue, "0");
      
        DataSet ds = new DB1.tblShopping().GetList(0, "iState=2 and idGood=" + idItem, "dPay desc");
        GVmain0.DataSource = ds;
        GVmain0.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
        GVmain0.DataBind();
       
        GridViewToExcel(GVmain0, "application/excel", str);
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
}