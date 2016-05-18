using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
public partial class Admin_RaceRecordEdit : PageBase
{
    public int id = 0;//记录id
    private int idRace = 0;//赛事id
    private int idItem = 0;//项目id
    public int iduser = 0;
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
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        idRace = TypeChangeDefault.NullToInt(Request.QueryString["idRace"], 0);
        idItem = TypeChangeDefault.NullToInt(Request.QueryString["idItem"], 0);
        if (!IsPostBack)
        {
            BindDDLFriends();
            if (id != 0)
            {
                DBM4.tblRACE_SALES model = new DB4.tblRACE_SALES().GetModel(id);
                if (model != null)
                {
                    iduser = model.idUser??0;
                    birday.Value = TypeChangeDefault.NullToDateTime(model.dBirthday, DateTime.Now).ToString("yyyy-MM-dd");
                    name.Value = model.cName;
                    idgender.SelectedValue = model.idGender.ToString();
                    idBlood.SelectedValue = model.idBlood.ToString();
                    birday.Value = TypeChangeDefault.NullToDateTime(model.dBirthday, DateTime.Now).ToString("yyyy-MM-dd");
                    ddlEducation.SelectedValue = TypeChangeDefault.NullToString(model.idEducation, "0");
                    idOccupation.SelectedValue = TypeChangeDefault.NullToString(model.idOccupation, "0");
                    ddlCard.SelectedValue = TypeChangeDefault.NullToString(model.idNationIDType, "1");
                    idCard.Value = TypeChangeDefault.NullToString(model.cNationID, "");
                    mobile.Value = TypeChangeDefault.NullToString(model.cMobile, "");
                    email.Value = TypeChangeDefault.NullToString(model.cMail, "");
                    cCityname.Value = TypeChangeDefault.NullToString(model.cCityname, "");
                    address.Value = TypeChangeDefault.NullToString(model.cAddress, "");
                    zipcode.Value = TypeChangeDefault.NullToString(model.cZipcode, "");
                    string[] Contact = TypeChangeDefault.NullToString(model.cEmergerContact, "").Trim().Split('|');
                    if (Contact.Length > 1)
                    {
                        emerger.Value = Contact[0];
                        emermobile.Value = Contact[1];
                    }
                    size.SelectedValue = model.cCloth;
                    state.SelectedValue = model.iState.ToString();
                    cRemark1.Value = model.cRemark1;
                    //附件
                    if (model.cHealthUrl.IndexOf(GetDir(model.idUser.ToString())) != -1)
                    {
                        ltlImg.Text += "<a target='_blank' href='" + HostInfo.imgName + "/Utility/uploads/" + model.cHealthUrl + "'><img src='/Html/images/img_icon.png'/></a>";
                    }
                    if (model.cMake.IndexOf(GetDir(model.idUser.ToString())) != -1)
                    {
                        ltlImg.Text += "<a target='_blank' href='" + HostInfo.imgName + "/Utility/uploads/" + model.cMake + "'><img src='/Html/images/img_icon.png'/></a>";
                    }
                    if (model.cRemark2.IndexOf(GetDir(model.idUser.ToString())) != -1)
                    {
                        ltlImg.Text += "<a target='_blank' href='" + HostInfo.imgName + "/Utility/uploads/" + model.cRemark2 + "'><img src='/Html/images/img_icon.png'/></a>";
                    }
                    if (model.cRemark3.IndexOf(GetDir(model.idUser.ToString())) != -1)
                    {
                        ltlImg.Text += "<a target='_blank' href='" + HostInfo.imgName + "/Utility/uploads/" + model.cRemark3 + "'><img src='/Html/images/img_icon.png'/></a>";
                    }
                    if (model.cRemark4.IndexOf(GetDir(model.idUser.ToString())) != -1)
                    {
                        ltlImg.Text += "<a target='_blank' href='" + HostInfo.imgName + "/Utility/uploads/" + model.cRemark4 + "'><img src='/Html/images/img_icon.png'/></a>";
                    }
                    ltlorder.Text = model.idOrder;
                   
                    //备注
                    if (model.cRemark2.IndexOf(GetDir(model.idUser.ToString())) == -1)
                    {
                        ltlbz1.Text = model.cRemark2;
                    }
                    if (model.cRemark3.IndexOf(GetDir(model.idUser.ToString())) == -1)
                    {
                        ltlbz2.Text = model.cRemark3;
                    }
                    if (model.cRemark4.IndexOf(GetDir(model.idUser.ToString())) == -1)
                    {
                        ltlbz3.Text = model.cRemark4;
                    }
                    ltljifen.Text = model.cRemark5 == "1" ? "是" : "否";
                }
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

        if (CurrentUser.uId != 100001183 && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        DBM4.tblRACE_SALES model = new DBM4.tblRACE_SALES();
        if (name.Value.Trim().Length <= 0 || name.Value.Trim().Length > 32)
        {
            AlertHelper.JQAlert("姓名为空或超过限制！", false);
            return;
        }
        model.cName = name.Value.Trim();
        model.idGender = TypeChange.NullToInt(idgender.SelectedValue, -1);//性别
        model.idBlood = TypeChange.NullToInt(idBlood.SelectedValue, -1);//血型
        if (birday.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请选择生日！", false);
            return;
        }
        model.dBirthday = TypeChangeDefault.NullToDateTime(birday.Value.Trim(), DateTime.Now);//生日

        model.idEducation = TypeChange.NullToInt(ddlEducation.SelectedValue, 0);//学历
        model.idOccupation = Convert.ToInt32(idOccupation.SelectedValue);//职业       
        model.idNationIDType = TypeChange.NullToInt(ddlCard.SelectedValue, 1);//证件类型       
        if (ddlCard.SelectedValue == "1")
        {
            if (idCard.Value.Trim().Length != 18)
            {
                AlertHelper.JQAlert("身份证格式错误！", false);
                return;
            }
            else
            {
                if (!Erun360.Common.PageValidate.IsNumber(idCard.Value.Trim().Substring(0, 17)))
                {
                    AlertHelper.JQAlert("身份证格式错误！", false);
                    return;
                }
            }
        }
        model.cNationID = idCard.Value.Trim();
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
        if (email.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写邮箱！", false);
            return;
        }
        else
        {
            if (!Erun360.Common.PageValidate.IsEmail(email.Value.Trim()))
            {
                AlertHelper.JQAlert("邮箱格式错误！", false);
                return;
            }
        }
        model.cMail = email.Value.Trim();

        if (address.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写地址！", false);
            return;
        }
        model.cAddress = address.Value.Trim();
        if (zipcode.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写邮编！", false);
            return;
        }
        model.cZipcode = zipcode.Value.Trim();
        if (emerger.Value.Trim().Length <= 0 || emermobile.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写紧急联系人及联系电话！", false);
            return;
        }
        model.cEmergerContact = emerger.Value.Trim() + "|" + emermobile.Value.Trim();

        //model.id = CurrentUser.uId;
        model.cCloth = size.SelectedValue;
        model.id = id;
        //付款成功，状态不能修改
        int iState = new DB4.tblRACE_SALES().GetState(id);
        if (iState < 2)
        {
            model.iState = TypeChange.NullToInt(state.SelectedValue, -1);//默认已过期 
            //审核通过，更改审核状态和提交时间戳，避免过期
            if (iState == 0 && model.iState == 1)
            {
                model.dConfirm = DateTime.Now;
            }
        }
        if (cRemark1.Value.Trim().Length > 128)
        {
            AlertHelper.JQAlert("备注超出限制！", false);
            return;
        }
        model.cRemark1 = cRemark1.Value.Trim();
        if (new DB4.tblRACE_SALES().Update(model))
        {
            DBM4.tblRACE_SALES modelSales = new DB4.tblRACE_SALES().GetModel(id);
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
            AlertHelper.JQAlertGo("保存成功！", "RaceRecord.aspx?idRace=" + idRace + "&idItem=" + idItem + "#a" + id, true);
        }
        else
        {
            AlertHelper.JQAlertGo("保存失败！", "RaceRecord.aspx", false);
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
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("RaceRecord.aspx?idRace=" + idRace + "&idItem=" + idItem + "#a" + id, true);
    }
}