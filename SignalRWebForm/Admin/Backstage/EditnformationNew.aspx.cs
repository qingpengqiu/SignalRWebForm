using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using System.Text;
using System.Data;

public partial class Admin_Backstage_EditnformationNew : PageBase
{

    //public string  id = "";
    public int iditpe = 0;
    public int id = 0;
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
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        iditpe = TypeChangeDefault.NullToInt(Request.QueryString["iditpe"], 0);
        DataSet model = new DataSet();
        if (iditpe == 4)
        {
            model = new DB6.tblHotel_Detail().GetList("id='" + id + "'");
        }
        if (iditpe == 5)
        {
            model = new DB6.tbltour_Detail().GetList("id='" + id + "'");
        }
        if (iditpe == 8)
        {
            model = new DB6.tblEquipment_Detail().GetList("id='" + id + "'");
        }
        if (iditpe == 9)
        {
            model = new DB6.tblAnnex_Detail().GetList("id='" + id + "'");
        }
        if (iditpe == 0)
        {
            AlertHelper.JQAlertGo("数据错误", UrlHelper.MemberUrl(CurrentUser.uId), false);
            return;
        }
        if (!IsPostBack)
        {
            if (model.Tables[0].Rows.Count > 0)
            {
                name.Value = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cFullname"], "");
                idgender.SelectedValue = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cGender"], "");
                idBlood.SelectedValue = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["idBlood"], "");
                birday.Value = TypeChangeDefault.NullToDateTime(model.Tables[0].Rows[0]["dBirthday"].ToString(), DateTime.Now).ToString("yyyy-MM-dd");                
                ddlCard.SelectedValue = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["IdType"].ToString(), "1");
                idCard.Value = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["IdNo"].ToString(), "");
                mobile.Value = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cMobile"].ToString(), "");
                email.Value = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cMail"].ToString(), "");
                cCityname.Value = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cCityname"].ToString(), "");
                address.Value = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cAddress"].ToString(), "");
                zipcode.Value = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cZipcode"].ToString(), "");
                ltlorder.Text = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cOrder_no"].ToString(), "");
                //idid = TypeChangeDefault.NullToInt(model.Tables[0].Rows[0]["id"].ToString(), 0);
                idgj.Value = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cNational"].ToString(), "");
            }
        }
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        if (name.Value == string.Empty)
        {
            AlertHelper.JQAlertGo("姓名不能为空！", "", false);
            return;
        }
        if (idCard.Value == string.Empty)
        {
            AlertHelper.JQAlertGo("证件号不能为空！", "", false);
            return;
        }
        if (address.Value == string.Empty)
        {
            AlertHelper.JQAlertGo("地址不能为空！", "", false);
            return;
        }
        if (mobile.Value == string.Empty)
        {
            AlertHelper.JQAlertGo("手机号不能为空！", "", false);
            return;
        }
        if (iditpe == 4)
        {
            DBM6.tblHotel_Detail model = new DBM6.tblHotel_Detail();
            model.id = id;
            model.cFullname = name.Value;
            model.cGender = idgender.SelectedValue;
            model.idBlood = idBlood.SelectedValue;
            model.dBirthday = TypeChangeDefault.NullToDateTime(birday.Value, DateTime.Now);
            model.IdType = ddlCard.SelectedValue;
            model.IdNo = idCard.Value;
            model.cMobile = mobile.Value;
            model.cMail = email.Value;
            model.cCityname = cCityname.Value;
            model.cAddress = address.Value;
            model.cZipcode = zipcode.Value;
            model.cNational = idgj.Value;
            bool i = new DB6.tblHotel_Detail().Update(model);
            if (i)
            {
                AlertHelper.JQAlertGo("修改成功", "HotelDetail.aspx?id=" + ltlorder.Text + "&iditype=4", true);
            }
        }
        if (iditpe == 5)
        {
            DBM6.tbltour_Detail model = new DBM6.tbltour_Detail();
            model.id = id;
            model.cFullname = name.Value;
            model.cGender = idgender.SelectedValue;
            model.idBlood = idBlood.SelectedValue;
            model.dBirthday = TypeChangeDefault.NullToDateTime(birday.Value, DateTime.Now);
            model.IdType = ddlCard.SelectedValue;
            model.IdNo = idCard.Value;
            model.cMobile = mobile.Value;
            model.cMail = email.Value;
            model.cCityname = cCityname.Value;
            model.cAddress = address.Value;
            model.cZipcode = zipcode.Value;
            model.cNational = idgj.Value;
            bool i = new DB6.tbltour_Detail().Update(model);
            if (i)
            {
                AlertHelper.JQAlertGo("修改成功", "HotelDetail.aspx?id=" + ltlorder.Text + "&iditype=5", true);
            }
        }
        if (iditpe == 8)
        {
            DBM6.tblEquipment_Detail model = new DBM6.tblEquipment_Detail();
            model.id = id;
            model.cFullname = name.Value;
            model.cGender = idgender.SelectedValue;
            model.idBlood = idBlood.SelectedValue;
            model.dBirthday = TypeChangeDefault.NullToDateTime(birday.Value, DateTime.Now);
            model.IdType = ddlCard.SelectedValue;
            model.IdNo = idCard.Value;
            model.cMobile = mobile.Value;
            model.cMail = email.Value;
            model.cCityname = cCityname.Value;
            model.cAddress = address.Value;
            model.cZipcode = zipcode.Value;
            model.cNational = idgj.Value;
            bool i = new DB6.tblEquipment_Detail().Update(model);
            if (i)
            {
                AlertHelper.JQAlertGo("修改成功", "HotelDetail.aspx?id=" + ltlorder.Text + "&iditype=8", true);
            }
        }
        if (iditpe == 9)
        {
            DBM6.tblAnnex_Detail model = new DBM6.tblAnnex_Detail();
            model.id = id;
            model.cFullname = name.Value;
            model.cGender = idgender.SelectedValue;
            model.idBlood = idBlood.SelectedValue;
            model.dBirthday = TypeChangeDefault.NullToDateTime(birday.Value,DateTime.Now);
            model.IdType = ddlCard.SelectedValue;
            model.IdNo = idCard.Value;
            model.cMobile = mobile.Value;
            model.cMail = email.Value;
            model.cCityname = cCityname.Value;
            model.cAddress = address.Value;
            model.cZipcode = zipcode.Value;
            model.cNational = idgj.Value;
            bool i =new DB6.tblAnnex_Detail().Update(model);
            if (i)
            {
                AlertHelper.JQAlertGo("修改成功", "HotelDetail.aspx?id=" + ltlorder.Text + "&iditype=9", true);
            }

        }
    }
}