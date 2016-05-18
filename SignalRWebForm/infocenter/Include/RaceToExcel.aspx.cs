using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using Utils;

public partial class infocenter_Include_RaceToExcel : PageBase
{
    private int idRace = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        idRace = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if (!IsPostBack)
        {
            DBM4.tblRACE_ACTIVITY model = new DB4.tblRACE_ACTIVITY().GetModel(idRace);
            if (model != null)
            {
                if (model.idUser != CurrentUser.uId)
                {
                    AlertHelper.JQAlertGo("操作失败！", UrlHelper.MemberUrl(CurrentUser.uId), false);
                }
                DateTime dt = System.DateTime.Now;
                string str = dt.ToString("yyyyMMddhhmmss");
                str = str + ".xls";
                DataSet ds = new DB4.tblRACE_JOIN().getMember(0, " idActivity= " + idRace, " dCreate desc ", "");

                GVmain0.DataSource = ds;
                GVmain0.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
                GVmain0.DataBind();

                GridViewToExcel(GVmain0, "application/excel", str);
            }
            else {
                AlertHelper.JQAlertGo("操作失败！", UrlHelper.MemberUrl(CurrentUser.uId), false);
            }
        }
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
}