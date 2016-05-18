using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
public partial class Admin_RaceJionotherEdit : PageBase
{
    public int id = 0;//记录id
    private int idRace = 0;//赛事id
    private int idItem = 0;//项目id
    public int iFromTpye = 2;//订单类型
    public int idUser = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if ((CurrentUser.uId != 100001183 && CurrentUser.uId != 100055041) && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        idRace = TypeChangeDefault.NullToInt(Request.QueryString["idRace"], 0);
        idItem = TypeChangeDefault.NullToInt(Request.QueryString["idItem"], 0);
        iFromTpye = TypeChangeDefault.NullToInt(Request.QueryString["iFromTpye"], 2);
        if (!IsPostBack)
        {
            DB6.tblOrder bll = new DB6.tblOrder();
            DBM6.tblOrder mOrder = bll.GetModel(id);
            if (mOrder != null)
            {
                idUser = mOrder.idUser ?? 0;
                if (iFromTpye == 5)
                {
                    DataTable dt = new DB6.tbltour_Detail().GetList("cOrder_no='" + mOrder.cOrder_no + "'").Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        name.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cFullname"], "");
                        mobile.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cMobile"].ToString(), "");
                        cCityname.Visible = false;
                        address.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cAddress"].ToString(), "");
                        cMake2.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cMake2"].ToString(), "");

                    }
                }
                else if (iFromTpye == 8)
                {
                    DataTable dt = new DB6.tblEquipment_Detail().GetList("cOrder_no='" + mOrder.cOrder_no + "'").Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        name.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cFullname"], "");
                        mobile.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cMobile"].ToString(), "");
                        cCityname.Visible = false;
                        address.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cAddress"].ToString(), "");
                        cMake2.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cMake2"].ToString(), "");

                    }
                }
                else if (iFromTpye == 9)
                {
                    DataTable dt = new DB6.tblAnnex_Detail().GetList("cOrder_no='" + mOrder.cOrder_no + "'").Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        name.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cFullname"], "");
                        mobile.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cMobile"].ToString(), "");
                        cCityname.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cCityname"].ToString(), "");
                        address.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cAddress"].ToString(), "");
                        //cMake2.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cMake2"].ToString(), "");
                        bz.Visible = false;
                    }
                }
                cMake3.Value = mOrder.cMake3;
                ltlorder.Text = mOrder.cOrder_no;
                ltlpay.Text = mOrder.cTrade_no;
                ltljifen.Text = mOrder.iScore > 0 ? "是" : "否";
            }
        }
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if ((CurrentUser.uId != 100001183 && CurrentUser.uId != 100055041) && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        int idRow = 0;
        DB6.tblOrder bll = new DB6.tblOrder();
        DBM6.tblOrder mOrder = bll.GetModel(id);
        if (mOrder != null)
        {
            if (iFromTpye == 5)
            {
                DataTable dt = new DB6.tbltour_Detail().GetList("cOrder_no='" + mOrder.cOrder_no + "'").Tables[0];
                if (dt.Rows.Count > 0)
                {
                    idRow = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString(), 0);
                }

                DBM6.tbltour_Detail model = new DBM6.tbltour_Detail();
                if (name.Value.Trim().Length <= 0 || name.Value.Trim().Length > 32)
                {
                    AlertHelper.JQAlert("姓名为空或超过限制！", false);
                    return;
                }
                model.cFullname = name.Value;

                if (mobile.Value.Trim().Length <= 0)
                {
                    AlertHelper.JQAlert("请填写手机号吗！", false);
                    return;
                }
                else if (!Erun360.Common.PageValidate.IsPhone(mobile.Value.Trim()))
                {
                    AlertHelper.JQAlert("电话格式错误！", false);
                    return;
                }
                model.cMobile = mobile.Value.Trim();
                if (address.Value.Trim().Length <= 0)
                {
                    AlertHelper.JQAlert("请填写地址！", false);
                    return;
                }
                model.cAddress = address.Value.Trim();
                if (cMake2.Value.Trim().Length <= 0)
                {
                    AlertHelper.JQAlert("请填写备注！", false);
                    return;
                }
                model.cMake2 = cMake2.Value.Trim();

                if (idRow > 0)
                {
                    model.id = idRow;
                    new DB6.tbltour_Detail().Update(model);
                }

            }
            else if (iFromTpye == 8)
            {
                DataTable dt = new DB6.tblEquipment_Detail().GetList("cOrder_no='" + mOrder.cOrder_no + "'").Tables[0];
                if (dt.Rows.Count > 0)
                {
                    idRow = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString(), 0);
                }

                DBM6.tblEquipment_Detail model = new DBM6.tblEquipment_Detail();
                if (name.Value.Trim().Length <= 0 || name.Value.Trim().Length > 32)
                {
                    AlertHelper.JQAlert("姓名为空或超过限制！", false);
                    return;
                }
                model.cFullname = name.Value;

                if (mobile.Value.Trim().Length <= 0)
                {
                    AlertHelper.JQAlert("请填写手机号吗！", false);
                    return;
                }
                else if (!Erun360.Common.PageValidate.IsPhone(mobile.Value.Trim()))
                {
                    AlertHelper.JQAlert("电话格式错误！", false);
                    return;
                }
                model.cMobile = mobile.Value.Trim();
                if (address.Value.Trim().Length <= 0)
                {
                    AlertHelper.JQAlert("请填写地址！", false);
                    return;
                }
                model.cAddress = address.Value.Trim();
                if (cMake2.Value.Trim().Length <= 0)
                {
                    AlertHelper.JQAlert("请填写备注！", false);
                    return;
                }
                model.cMake2 = cMake2.Value.Trim();

                if (idRow > 0)
                {
                    model.id = idRow;
                    new DB6.tblEquipment_Detail().Update(model);
                }

            }
            else if (iFromTpye == 9)
            {
                DataTable dt = new DB6.tblAnnex_Detail().GetList("cOrder_no='" + mOrder.cOrder_no + "'").Tables[0];
                if (dt.Rows.Count > 0)
                {
                    idRow = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString(), 0);
                }

                DBM6.tblAnnex_Detail model = new DBM6.tblAnnex_Detail();
                if (name.Value.Trim().Length <= 0 || name.Value.Trim().Length > 32)
                {
                    AlertHelper.JQAlert("姓名为空或超过限制！", false);
                    return;
                }
                model.cFullname = name.Value;

                if (mobile.Value.Trim().Length <= 0)
                {
                    AlertHelper.JQAlert("请填写手机号吗！", false);
                    return;
                }
                else if (!Erun360.Common.PageValidate.IsPhone(mobile.Value.Trim()))
                {
                    AlertHelper.JQAlert("电话格式错误！", false);
                    return;
                }
                model.cMobile = mobile.Value.Trim();
                if (address.Value.Trim().Length <= 0)
                {
                    AlertHelper.JQAlert("请填写地址！", false);
                    return;
                }
                model.cAddress = address.Value.Trim();

                if (idRow > 0)
                {
                    model.id = idRow;
                    new DB6.tblAnnex_Detail().Update(model);
                }
            }

            if (cMake3.Value.Trim().Length > 0)
            {
                mOrder.ID = id;
                mOrder.cMake3 = cMake3.Value.Trim();
                bll.Update(mOrder);
            }
        }
        Response.Redirect("RaceJion.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye + "&idItem=" + idItem + "#a" + id, true);
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("RaceJion.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye + "&idItem=" + idItem + "#a" + id, true);
    }
}