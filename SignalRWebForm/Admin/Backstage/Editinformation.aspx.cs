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
using Newtonsoft.Json;

public partial class Admin_Backstage_Editinformation : PageBase
{
    public string id = string.Empty;//记录id
    private int idRace = 0;//赛事id
    public int idItem = 0;//项目id
    public int fjx = 0;
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
        id = TypeChangeDefault.NullToString(Request.QueryString["id"], "");
        idRace = TypeChangeDefault.NullToInt(Request.QueryString["idRace"], 0);
        fjx = TypeChangeDefault.NullToInt(Request.QueryString["fjx"], 0);
        DataSet model = new DB6.tblRace_Detail().GetList("cOrder_no='" + id + "'");
        if (model.Tables[0].Rows.Count > 0)
        {
            idItem = TypeChangeDefault.NullToInt(model.Tables[0].Rows[0]["id"], 0);
        }
        else
        {
            //DataTable dt = new DB6.tblOrder().GetList("cOrder_no='" + id + "'").Tables[0];
            //GetEventDetail(dt.Rows[0]["passenger"].ToString(), dt.Rows[0]["cParentOrder"].ToString());
            AlertHelper.JQAlertGo("没有该订单的详情！","", false);
        }
        if (!IsPostBack)
        {
            BindDDLFriends();
            if (id != string.Empty)
            {
                
                if (model.Tables[0].Rows.Count > 0)
                {
                   
                    //iduser = model.idUser ?? 0;
                    //birday.Value = TypeChangeDefault.NullToDateTime(model.Tables[0].Rows[0]["dBirthday"], DateTime.Now).ToString("yyyy-MM-dd");
                    name.Value = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cFullname"], "");
                    idgender.SelectedValue = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cGender"], "");
                    idBlood.SelectedValue = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["idBlood"], "");
                    birday.Value = TypeChangeDefault.NullToDateTime(model.Tables[0].Rows[0]["dBirthday"].ToString(), DateTime.Now).ToString("yyyy-MM-dd");
                    ddlEducation.SelectedValue = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["idEducation"].ToString(), "0");
                    idOccupation.SelectedValue = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["idOccupation"].ToString(), "0");
                    ddlCard.SelectedValue = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["IdType"].ToString(), "1");
                    idCard.Value = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["IdNo"].ToString(), "");
                    mobile.Value = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cMobile"].ToString(), "");
                    email.Value = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cMail"].ToString(), "");
                    cCityname.Value = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cCityname"].ToString(), "");
                    size.SelectedValue = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cCloth"].ToString(), "");
                    address.Value = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cAddress"].ToString(), "");
                    zipcode.Value = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cZipcode"].ToString(), "");
                    string[] Contact = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cEmergerContact"], "").Trim().Split('|');
                    if (Contact.Length > 1)
                    {
                        emerger.Value = Contact[0];
                        emermobile.Value = Contact[1];
                    }
                    ltlorder.Text = TypeChangeDefault.NullToString(model.Tables[0].Rows[0]["cOrder_no"].ToString(), "");
                }
            }
        }
    }
    protected void BindDDLFriends()
    {
        string path = Server.MapPath("/XML/Strings.xml");
        DataSet ds = new DataSet();
        ds.ReadXml(path);
        string CacheKey = "idOccupation";
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        if (objModel == null)
        {
            try
            {
                objModel = ds;
                if (objModel != null)
                {
                    int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            catch { }
        }
        idOccupation.DataSource = ((DataSet)objModel).Tables["idOccupation"];
        idOccupation.DataTextField = "TextField";
        idOccupation.DataValueField = "ValueField";
        idOccupation.DataBind();
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
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
        DBM6.tblRace_Detail modgl = new DBM6.tblRace_Detail();
        modgl.id = idItem;
        modgl.cFullname = name.Value;
        modgl.cGender = idgender.SelectedValue;
        modgl.cAddress = address.Value;
        modgl.idBlood = idBlood.SelectedValue;
        modgl.cMail = email.Value;
        modgl.IdNo = idCard.Value;
        modgl.cEmergerContact = emerger.Value.Trim() + "|" + emermobile.Value.Trim();
        modgl.cZipcode = zipcode.Value;
        modgl.cMobile = mobile.Value;
        modgl.idOccupation = TypeChangeDefault.NullToInt(idOccupation.SelectedValue, 0);
        modgl.dBirthday = TypeChangeDefault.NullToDateTime(birday.Value, DateTime.Now);
        modgl.IdType = ddlCard.SelectedValue;
        modgl.idEducation = TypeChangeDefault.NullToInt(ddlEducation.SelectedValue, 0);
        modgl.cNational = idgj.Value;
        modgl.cCloth = size.SelectedValue;
        bool i = new DB6.tblRace_Detail().Update(modgl);
        if (i)
        {
            AlertHelper.JQAlertGo("修改成功！", "", true);
        }
    }
    #region 购买赛事详情
    private static void GetEventDetail(string passenger, string cParentOrder)
    {
        var x = JsonConvert.DeserializeObject<DBM6.tblRace_Detail>(passenger);
        DBM6.tblRace_Detail model = new DBM6.tblRace_Detail
        {
            idCompete = x.idCompete,
            cCompetitionName = x.cCompetitionName,
            idItem = x.idItem,
            cItemName = x.cItemName,
            idUser = x.idUser,
            csurname = x.csurname,
            cname = x.cname,
            cFullname = x.cFullname,
            cGender = x.cGender,
            idBlood = x.idBlood,
            dBirthday = x.dBirthday,
            IdType = x.IdType,
            IdNo = x.IdNo,
            cNational = x.cNational,
            cMobile = x.cMobile,
            cMail = x.cMail,
            idCity = x.idCity,
            cCityname = x.cCityname,
            cAddress = x.cAddress,
            cZipcode = x.cZipcode,
            idEducation = x.idEducation,
            idOccupation = x.idOccupation,
            cEmergerContact = x.cEmergerContact,
            cPlace = x.cPlace,
            dIssue = x.dIssue,
            dExpiry = x.dExpiry,
            cFirst = x.cFirst,
            cresult = x.cresult,
            dCreate = new DB6.tblOrder().GetTime(0),
            cCloth = x.cCloth,
            cShoe = x.cShoe,
            cHealthUrl = x.cHealthUrl,
            cECG = x.cECG,
            cFinished = x.cFinished,
            cMake = x.cMake,
            //cParentOrder = x.cParentOrder,
            cOrder_no = x.cOrder_no,
            cMake1 = x.cMake1,
            cMake2 = x.cMake2,
            cMake3 = x.cMake3,
            cMake4 = x.cMake4
        };
        model.cParentOrder = cParentOrder;
        new DB6.tblRace_Detail().Add(model);
    }
    #endregion
}