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
using System.Text;
public partial class Admin_RaceJionHotelEdit : PageBase
{
    public int id = 0;//记录id
    private int idRace = 0;//赛事id
    private int idItem = 0;//项目id
    public int iFromTpye = 4;//订单类型
    public int idUser = 0;
    public string UserInfo = string.Empty;
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
        iFromTpye = TypeChangeDefault.NullToInt(Request.QueryString["iFromTpye"], 4);
        if (!IsPostBack)
        {
            DB6.tblOrder bll = new DB6.tblOrder();
            DBM6.tblOrder mOrder = bll.GetModel(id);
            if (mOrder != null)
            {
                idUser = mOrder.idUser ?? 0;
                DataTable dt = new DB6.tblHotel_Detail().GetList("cOrder_no='" + mOrder.cOrder_no + "'").Tables[0];
                StringBuilder sb = new StringBuilder();
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        sb.AppendLine(" <div><input type=\"hidden\" value=\"" + TypeChangeDefault.NullToString(dt.Rows[i]["id"], "") + "\" name=\"id" + i + "\"/>");
                        sb.AppendLine("<label>姓名</label><input type=\"text\" value=\"" + TypeChangeDefault.NullToString(dt.Rows[i]["cFullname"], "") + "\" name=\"cname" + i + "\"/>");
                        sb.AppendLine("<label>证件号码</label><input type=\"text\" value=\"" + TypeChangeDefault.NullToString(dt.Rows[i]["IdNo"], "") + "\" name=\"idcard" + i + "\"/></div>");

                    }
                    UserInfo = sb.ToString();
                }
                name.Value = mOrder.cName;
                mobile.Value = mOrder.cMobile;

                email.Value = mOrder.cMail;
                cMake2.Value = mOrder.cMake2;
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
            if (mOrder.iFromTpye == 4)
            {
                DataTable dt = new DB6.tblHotel_Detail().GetList("cOrder_no='" + mOrder.cOrder_no + "'").Tables[0];
                if (dt.Rows.Count > 0)
                {
                    DBM6.tblHotel_Detail model = new DBM6.tblHotel_Detail();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        idRow = TypeChangeDefault.NullToInt(Request.Form["id" + i.ToString()],0);
                        string cFullname = TypeChangeDefault.NullToString(Request.Form["cname" + i.ToString()],"");
                        if (cFullname.Length <= 0 || cFullname.Length > 32)
                        {
                            AlertHelper.JQAlert("姓名为空或超过限制！", false);
                            return;
                        }
                        model.cFullname = cFullname;
                        string IdNo = TypeChangeDefault.NullToString(Request.Form["idcard" + i.ToString()],"");
                        if (IdNo.Length <= 0 || IdNo.Length > 32)
                        {
                            AlertHelper.JQAlert("证件号码为空或超过限制！", false);
                            return;
                        }
                        model.IdNo = IdNo;
                        if (idRow > 0)
                        {
                            model.id = idRow;
                            new DB6.tblHotel_Detail().Update(model);
                        }
                    }
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