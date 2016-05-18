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
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using System.Text;
using Newtonsoft.Json;
public partial class Admin_Backstage_ExportOrders : PageBase
{
    DB6.tblRace_Competition bllcompetetion = new DB6.tblRace_Competition();
    DB6.tblRace_Item bllsignup = new DB6.tblRace_Item();
    DB6.tblOrder bllsales = new DB6.tblOrder();
    DB6.tblTeam BLLTeam = new DB6.tblTeam();
    public int idRace = 0;//赛事id
    public int idItem = 0;
    public int id = 0;
    public string bj = string.Empty;
    public int sid = 0;
    public int Race = 0;
    public StringBuilder sbshu = new StringBuilder();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle != 99)
        {
            if (CurrentUser.uId != 100055041)
            {
                if (CurrentUser.uId != 100001183)
                {
                    AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
                    return;
                }
            }
        }
        sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
        idRace = TypeChangeDefault.NullToInt(Request.QueryString["idRace"], 0);
        idItem = TypeChangeDefault.NullToInt(Request.QueryString["idItem"], 0);
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        Race = TypeChangeDefault.NullToInt(Request.QueryString["Race"], 0);
        if (!IsPostBack)
        {
            //rdbid.Visible = true;
            
            BindDDL();
            if (sid != 0)
            {
                DDLRace.Value = sid.ToString();
            }
            if (Race != 0)
            {
                DDLRace.Value = Race.ToString();
                DDLRace_SelectedIndexChanged();
            }
            if (idRace == 0)
            {
                idRace = TypeChangeDefault.NullToInt(DDLRace.Value, 0);
            }
            //BindRadioList(idRace,rdbid.SelectedValue);
            if (idItem == 0)
            {
                //RadioButtonList1.Items[0].Selected = true;
                idItem = TypeChangeDefault.NullToInt(RadioButtonList1.SelectedValue, 0);
            }
            if (id == 0)
            {
                id = TypeChangeDefault.NullToInt(rdbid.SelectedValue, 0);
            }            
        }
    }
    #region 绑定数据
    private void BindData(int idss,int idrace,string idtem)
    {
        DataSet ds = new DataSet();
        if (idtem == "5" || idtem == "8")
        {
            ds = new DB6.tblOrder().GetList(0, "iFromTpye=" + idtem + " and cFromToID=" + idrace + " and  iTypeID=" + idss + "", "iStatus desc");
        }
        else
        {
            ds = new DB6.tblOrder().GetList(0, "iFromTpye=" + idtem + " and cFromToID=" + idrace + " and  iItemID=" + idss + "", "iStatus desc");
        }
        ds.Tables[0].Columns.Add("bj");
        ds.Tables[0].Columns.Add("fj");
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            if (rdbid.SelectedValue == "2")
            {
                var x = JsonConvert.DeserializeObject<DBM6.tblRace_Detail>(ds.Tables[0].Rows[i]["passenger"].ToString());
                if (x != null)
                {
                    if (x.cECG != null)
                    {
                        ds.Tables[0].Rows[i]["fj"] = "<a href='" + x.cECG + "' target=\"_blank\">附件</a>";
                    }
                }
            }
            if (TypeChangeDefault.NullToInt(ds.Tables[0].Rows[i]["iStatus"].ToString(), 0) < 2 )
            {
                if (TypeChangeDefault.NullToInt(ds.Tables[0].Rows[i]["iStatus"].ToString(), 0) > -1)
                {
                    if (TypeChangeDefault.NullToInt(ds.Tables[0].Rows[i]["iStatus"].ToString(), 0) == 1)
                    {
                        if (rdbid.SelectedValue != "2")
                        {
                            ds.Tables[0].Rows[i]["bj"] = "<a href='ExportUpState.aspx?id=" + ds.Tables[0].Rows[i]["id"] + "&iditype=" + rdbid.SelectedValue + "' target=\"_blank\">编辑</a>   <a class=\"focus-b article-up-iframe cboxElement\" href=\"/infocenter/PostMessage.aspx?uId=" + ds.Tables[0].Rows[i]["idUser"] + "\">给TA留言</a>";
                        }
                        else
                        {
                            ds.Tables[0].Rows[i]["bj"] = "<a href='ExportUpState.aspx?id=" + ds.Tables[0].Rows[i]["id"] + "&iditype=" + rdbid.SelectedValue + "' target=\"_blank\">编辑</a>   <a class=\"focus-b article-up-iframe cboxElement\" href=\"/infocenter/PostMessage.aspx?uId=" + ds.Tables[0].Rows[i]["idUser"] + "\">给TA留言</a>";
                        }
                    }
                    else
                    {
                        if (rdbid.SelectedValue == "2")
                        {
                            DBM6.tblRace_Item time = new DB6.tblRace_Item().GetModel(TypeChangeDefault.NullToInt(idss, 0));
                            if (time != null )
                            {
                                if (time.iAudit == 1)
                                {
                                    ds.Tables[0].Rows[i]["bj"] = "<a href='/action/Advert.ashx?id=" + ds.Tables[0].Rows[i]["id"] + "'>审核</a>  <a class=\"focus-b article-up-iframe cboxElement\" href=\"/infocenter/PostMessage.aspx?uId=" + ds.Tables[0].Rows[i]["idUser"] + "\">给TA留言</a>";
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                if (rdbid.SelectedValue != "2")
                {
                    ds.Tables[0].Rows[i]["bj"] = "<a href='HotelDetail.aspx?id=" + ds.Tables[0].Rows[i]["cOrder_no"] + "&iditype=" + rdbid.SelectedValue + "' target=\"_blank\">编辑信息</a>  <a class=\"focus-b article-up-iframe cboxElement\" href=\"/infocenter/PostMessage.aspx?uId=" + ds.Tables[0].Rows[i]["idUser"] + "\">给TA留言</a>";
                }
                else
                {
                    ds.Tables[0].Rows[i]["bj"] = "<a href='Editinformation.aspx?id=" + ds.Tables[0].Rows[i]["cOrder_no"] + "' target=\"_blank\">编辑信息</a>  <a class=\"focus-b article-up-iframe cboxElement\" href=\"/infocenter/PostMessage.aspx?uId="+ds.Tables[0].Rows[i]["idUser"]+"\">给TA留言</a>";
                }
            }
            //}
            //else
            //{

            //    ds.Tables[0].Rows[i]["bj"] = "<a href='ExportUpState.aspx?id=" + ds.Tables[0].Rows[i]["id"] + "' target=\"_self\">编辑</a>";
            //}
        }

        Repeater1.DataSource = ds;
        Repeater1.DataBind();
    }
    public void DDLRace_SelectedIndexChanged()
    {
        //rdbid.SelectedValue = "2";
        
        BindRadioList(DDLRace.Value, "2");
        BindData(0, 0, "0");
        RadioButtonList1.Visible = false;
        //idRace = TypeChangeDefault.NullToInt(DDLRace.SelectedValue, 0);
        //idItem = 0;
        //Response.Redirect("ExportOrders.aspx?idRace=" + idRace + "&idItem=" + idItem);
    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rdbid.SelectedValue != "4")
        {            
            idRace = TypeChangeDefault.NullToInt(DDLRace.Value, 0);
            idItem = TypeChangeDefault.NullToInt(RadioButtonList1.SelectedValue, 0);
            BindData(idItem, idRace, rdbid.SelectedValue);
        }
        else
        {
            jdradio.Visible = true;

            DataSet ds = new DB6.tblHotel_Item().GetList("  idHotel=" + RadioButtonList1.SelectedValue);
            jdradio.DataSource = ds;
            jdradio.DataTextField = "cItemName";
            jdradio.DataValueField = "ID";
            jdradio.DataBind();
        }
        //Response.Redirect("ExportOrders.aspx?idRace=" + idRace + "&idItem=" + idItem+"&id="+rdbid.SelectedValue);
    }
    protected void BindDDL()
    {
        DataSet ds = bllcompetetion.GetSignupcompete();
        DDLRace.DataSource = ds;
        DDLRace.DataTextField = "cTitle";
        DDLRace.DataValueField = "ID";
        DDLRace.DataBind();
    }
    protected void BindRadioList(string idRace,string dd)
    {
        jdradio.Visible = false;
        
        if ( dd== "2")
        {
            DataSet ds = bllsignup.GetList("  idcompete=" + idRace);
            RadioButtonList1.DataSource = ds;
            RadioButtonList1.DataTextField = "cItemName";
            RadioButtonList1.DataValueField = "ID";
            RadioButtonList1.DataBind();
        }
        if (dd == "4")
        {
            DataSet ds = new DB6.tblHotel().GetList("  idcompete=" + idRace);
            RadioButtonList1.DataSource = ds;
            RadioButtonList1.DataTextField = "cName";
            RadioButtonList1.DataValueField = "ID";
            RadioButtonList1.DataBind();
            
        }
        if (dd == "5")
        {
            DataSet ds = new DB6.tbltour().GetList("  idcompete=" + idRace);
            RadioButtonList1.DataSource = ds;
            RadioButtonList1.DataTextField = "cName";
            RadioButtonList1.DataValueField = "ID";
            RadioButtonList1.DataBind();
        }
        if (dd == "8")
        {
            DataSet ds = new DB6.tblEquipment().GetList("  idcompete=" + idRace);
            RadioButtonList1.DataSource = ds;
            RadioButtonList1.DataTextField = "cName";
            RadioButtonList1.DataValueField = "ID";
            RadioButtonList1.DataBind();

        }
        if (dd == "9")
        {
            DataSet ds = new DB6.tblAnnex().GetList("  idcompete=" + idRace);
            RadioButtonList1.DataSource = ds;
            RadioButtonList1.DataTextField = "cName";
            RadioButtonList1.DataValueField = "ID";
            RadioButtonList1.DataBind();
        }
        if (rdbid.SelectedValue != null)
        {
            RadioButtonList1.Visible = true;
        }
        //else
        //{
        //    RadioButtonList1.Visible = false;
        //}
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

        if (CurrentUser.idMemberStyle != 99)
        {
            if (CurrentUser.uId != 100055041)
            {
                if (CurrentUser.uId != 100001183)
                {
                    AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
                    return;
                }
            }
        }
        if (idItem == 0)
        {
            //RadioButtonList1.Items[0].Selected = true;
            idItem = TypeChangeDefault.NullToInt(RadioButtonList1.SelectedValue, 0);
        }
        string str = System.DateTime.Now.ToString("yyyyMMddhhmmss") + ".xls";
        if (rdbid.SelectedValue == "4")
        {
            DataSet ds = new DB6.tblHotel_Detail().GetList(0, "idItem=" + idItem, "id");

            gvZbJd.DataSource = ds;
            gvZbJd.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
            gvZbJd.DataBind();
            GridViewToExcel(gvZbJd, "application/excel", str);
        }
        if (rdbid.SelectedValue == "5")
        {
            DataSet ds = new DB6.tbltour_Detail().GetList(0, "idItem=" + idItem, "id");

            gvZbJd.DataSource = ds;
            gvZbJd.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
            gvZbJd.DataBind();
            GridViewToExcel(gvZbJd, "application/excel", str);
        }
        if (rdbid.SelectedValue == "8")
        {
            DataSet ds = new DB6.tblEquipment_Detail().GetList(0, "idItem=" + idItem, "id");

            gvZbJd.DataSource = ds;
            gvZbJd.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
            gvZbJd.DataBind();
            GridViewToExcel(gvZbJd, "application/excel", str);
        }
        if (rdbid.SelectedValue == "9")
        {
            DataSet ds = new DB6.tblAnnex_Detail().GetList(0, "idItem=" + idItem, "id");

            gvZbJd.DataSource = ds;
            gvZbJd.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
            gvZbJd.DataBind();
            GridViewToExcel(gvZbJd, "application/excel", str);
        }
        if (rdbid.SelectedValue == "2")
        {
            //DataSet ds = new DB6.tblRace_Detail().GetList(0, "idItem=" + idItem, "id");

            string sqlstr = @"SELECT tblRace_Detail.*, tblOrder.cItemName AS cType, tblOrder.iCost as iCost,tblOrder.iStatus,case  when tblOrder.iScore >0 then '是' else '否' end iScore FROM YP_DB_6.dbo.tblRace_Detail INNER JOIN YP_DB_6.dbo.tblOrder ON tblRace_Detail.idCompete = tblOrder.cFromToID AND tblRace_Detail.idUser = tblOrder.idUser AND tblRace_Detail.cOrder_no = tblOrder.cOrder_no and tblOrder.iFromTpye = 2 ";
            DataTable dss = new DB6.tblRace_Detail().GetExcle(sqlstr, " WHERE (tblOrder.iStatus > 1) and (tblRace_Detail.idItem = " + idItem + ")").Tables[0];
            string zdsql = @"SELECT tblTeam.iSNo FROM YP_DB_6.dbo.tblTeam INNER JOIN YP_DB_6.dbo.tblTeam_Group ON tblTeam.iSNo = tblTeam_Group.iSNo";

            dss.Columns.Add("iSNo");
            for (int zd = 0; zd < dss.Rows.Count; zd++)
            {
                DataTable zds = new DB6.tblRace_Detail().GetExcleAll(zdsql, " WHERE tblTeam.IdUser = " + dss.Rows[zd]["idUser"] + " and tblTeam_Group.idCompete = " + dss.Rows[zd]["idCompete"] + "").Tables[0];
                if (zds.Rows.Count > 0)
                {
                    dss.Rows[zd]["iSNo"] = zds.Rows[0]["iSNo"].ToString();
                }
            }
            gvAll.DataSource = dss;
            gvAll.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
            gvAll.DataBind();
            GridViewToExcel(gvAll, "application/excel", str);
        }
    }
   
    protected void btEcexl_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.idMemberStyle != 99)
        {
            if (CurrentUser.uId != 100055041)
            {
                if (CurrentUser.uId != 100001183)
                {
                    AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
                    return;
                }
            }
        }
        if (idRace == 0)
        {
            idRace = TypeChangeDefault.NullToInt(DDLRace.Value, 0);
        }
        string str = System.DateTime.Now.ToString("yyyyMMddhhmmss") + ".xls";
        DataSet ds = new DataSet();

        if (rdbid.SelectedValue == "4")
        {
            ds = new DB6.tblHotel_Detail().GetList(0, "idCompete=" + idRace, "id");
            gvZbJd.DataSource = ds;
            gvZbJd.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
            gvZbJd.DataBind();

            GridViewToExcel(gvZbJd, "application/excel", str);
        }
        if (rdbid.SelectedValue == "5")
        {
            ds = new DB6.tbltour_Detail().GetList(0, "idCompete=" + idRace, "id");
            gvZbJd.DataSource = ds;
            gvZbJd.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
            gvZbJd.DataBind();

            GridViewToExcel(gvZbJd, "application/excel", str);
        }
        if (rdbid.SelectedValue == "8")
        {
            ds = new DB6.tblEquipment_Detail().GetList(0, "idCompete=" + idRace, "id");
            gvZbJd.DataSource = ds;
            gvZbJd.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
            gvZbJd.DataBind();

            GridViewToExcel(gvZbJd, "application/excel", str);
        }
        if (rdbid.SelectedValue == "9")
        {
            ds = new DB6.tblAnnex_Detail().GetList(0, "idCompete=" + idRace, "id");
            gvZbJd.DataSource = ds;
            gvZbJd.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
            gvZbJd.DataBind();

            GridViewToExcel(gvZbJd, "application/excel", str);
        }
        if (rdbid.SelectedValue == "2")
        {
            
            //ds = new DB6.tblRace_Detail().GetList(0, "idCompete=" + idRace, "id");
            //gvAll.DataSource = ds;
            //gvAll.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
            //gvAll.DataBind();

            //GridViewToExcel(gvAll, "application/excel", str);
            string sqlstr = @"SELECT tblRace_Detail.*, tblOrder.cItemName AS cType, tblOrder.iCost as iCost,tblOrder.iStatus,case  when tblOrder.iScore >0 then '是' else '否' end iScore FROM YP_DB_6.dbo.tblRace_Detail INNER JOIN YP_DB_6.dbo.tblOrder ON tblRace_Detail.idCompete = tblOrder.cFromToID AND tblRace_Detail.idUser = tblOrder.idUser AND tblRace_Detail.cOrder_no = tblOrder.cOrder_no and tblOrder.iFromTpye = 2 ";
            DataTable dss = new DB6.tblRace_Detail().GetExcle(sqlstr, " WHERE (tblOrder.iStatus > 1) and (tblRace_Detail.idCompete = " + idRace + ")").Tables[0];
            string zdsql = @"SELECT tblTeam.iSNo FROM YP_DB_6.dbo.tblTeam INNER JOIN YP_DB_6.dbo.tblTeam_Group ON tblTeam.iSNo = tblTeam_Group.iSNo";

            dss.Columns.Add("iSNo");
            for (int zd = 0; zd < dss.Rows.Count; zd++)
            {
                DataTable zds = new DB6.tblRace_Detail().GetExcleAll(zdsql, " WHERE tblTeam.IdUser = " + dss.Rows[zd]["idUser"] + " and tblTeam_Group.idCompete = " + dss.Rows[zd]["idCompete"] + "").Tables[0];
                if (zds.Rows.Count > 0)
                {
                    dss.Rows[zd]["iSNo"] = zds.Rows[0]["iSNo"].ToString();
                }
            }
            gvAll.DataSource = dss;
            gvAll.Attributes.Add("style", "vnd.ms-excel.numberformat:@");
            gvAll.DataBind();
            GridViewToExcel(gvAll, "application/excel", str);
        }


       
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
        //DataTable dt = BLLTeam.GetList("idItem=" + idItem + " and IdUser=" + IdUser).Tables[0];
        //if (dt.Rows.Count > 0)
        //{
        //    return dt.Rows[0]["iSNo"].ToString();
        //}
        return "";
    }
    //根据项目id和用户id获取当前用户的附属产品
    public string GetAnnexLog(string idItem, string IdUser)
    {
        //DataTable dt = new DB6.tblOrder().GetList("iState=2 and idItem=" + idItem + " and IdUser=" + IdUser).Tables[0];
        //string strLog = string.Empty;
        //for (int i = 0; i < dt.Rows.Count; i++)
        //{
        //    strLog += dt.Rows[i]["cName"].ToString() + "(" + dt.Rows[i]["fPrice"].ToString() + ")";
        //}
        return "";
    }
    public string GetidOccupation(string id)
    {
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(Server.MapPath("/XML/Strings.xml"));
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("Strings/idOccupations/idOccupation[ValueField='" + id + "']");//查找
        XmlNode xmlNode = xmlNodeList.Item(0);
        return  xmlNode["TextField"].InnerText;
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
    protected void rdbid_Selected(object sender, EventArgs e)
    {
        BindData(0, 0, "0");
        BindRadioList(DDLRace.Value, rdbid.SelectedValue);
    }
    protected void jdradio_SelectedIndexChanged(object sender, EventArgs e)
    {
        idRace = TypeChangeDefault.NullToInt(DDLRace.Value, 0);

        idItem = TypeChangeDefault.NullToInt(jdradio.SelectedValue, 0);
        BindData(idItem, idRace, rdbid.SelectedValue);
    }
}