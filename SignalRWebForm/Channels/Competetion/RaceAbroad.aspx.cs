using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DBM4 = Erun360.Model.DB4;
using Erun360.Common;
using DB4 = Erun360.BLL.DB4;
using System.Xml.Linq;
using Utils;
using System.Collections.Specialized;

public partial class Channels_Competetion_RaceAbroad : PageBase
{
    private int idItem = 0;//项目id
    private string idAdd = "0";//附加产品id
    public int id = 0;//赛事id
    public string la = string.Empty;//语言
    public string Detail = string.Empty;
    public double fPrice = 0;
    public int iFlag = 0;//是否使用积分1使用
    public string iCity = string.Empty;//
    public string iArea = string.Empty;
    //public int iAbroad = 0;//是否为国外赛事1是0否
    protected void Page_Load(object sender, EventArgs e)
    {
        la = TypeChangeDefault.NullToString(Request.QueryString["la"], "cn");
        idItem = TypeChangeDefault.NullToInt(Request.QueryString["p"], 0);
        idAdd = TypeChangeDefault.NullToString(Request.QueryString["o"], "0");
        id = TypeChangeDefault.NullToInt(Request.QueryString["idcompete"], 0);
        iFlag = TypeChangeDefault.NullToInt(Request.QueryString["integral"], 0);
        la = la == "en" ? "en" : "cn";
        if (id == 0)
        {
            AlertHelper.JQAlertGo("请选择赛事！", "/Channels/Competetion/RaceList.aspx", false);
            return;
        }
        if (idItem == 0)
        {
            AlertHelper.JQAlertGo("请选择比赛项目！", "/Channels/Competetion/RaceProject.aspx?idcompete=" + id + "&la=" + la, false);
            return;
        }
        if (CurrentUser == null)
        {
            AlertHelper.JQAlertGo("您无权访问此页！", "/Channels/Competetion/RaceProject.aspx?idcompete=" + id + "&la=" + la, false);
            return;
        }
        if (!IsPostBack)
        {
            Initialize(la);
            BindIdOccupation(la);
            if (idAdd.Trim().Length == 0)
                idAdd = "0";
            DBM4.tblRACE_SIGNUP model = new DB4.tblRACE_SIGNUP().GetModel(idItem);
            if (model == null)
            {
                AlertHelper.JQAlertGo("赛事不存在！", "/Channels/Competetion/RaceList.aspx", false);
                return;
            }
            int iAbroad = model.idCity >= 3501 ? 1 : 0;//判断是否为国际赛事
            if (iAbroad == 0)
            {
                Response.Redirect("/Channels/Competetion/RaceProject2.aspx?idcompete=" + id + "&la=" + la + "&p=" + idItem + "&o=" + idAdd + "&integral=" + iFlag, true);
            }
           
            #region 用户报名信息
            iAbroadUserInit();
            #endregion

            int count = new DB4.tblRACE_SALES().GetRecordCount(" iState>-1 and idSignUp=" + idItem);
            if (count >= model.iLimit)
            {
                AlertHelper.JQAlertGo("报名已满！", "/Channels/Competetion/RaceList.aspx", false);
                return;
            }
            if (DateTime.Compare(DateTime.Now, TypeChangeDefault.NullToDateTime(model.dJoinEnd, DateTime.Now.AddDays(-1))) > 0)
            {
                AlertHelper.JQAlertGo("报名已过期请,选择其他的赛事！", "/Channels/Competetion/RaceList.aspx", false);
                return;
            }
            int state = new DB4.tblRACE_SALES().GetState(CurrentUser.uId, id);
            if (0 == state)
            {
                AlertHelper.JQAlertGo("正在审核中,请审核通过后付款！", "/blog/" + model.idBlog + ".aspx", false);
                return;
            }
            else if (1 == state)
            {
                DBM4.tblRACE_SALES mSale = new DB4.tblRACE_SALES().GetModel(id, CurrentUser.uId);
                if (mSale != null)
                {
                    Response.Redirect("/Channels/Competetion/RacePay.aspx?orderid=" + mSale.idOrder);
                }
                else
                {
                    AlertHelper.JQAlertGo("出错了，请重新报名！", "/blog/" + model.idBlog + ".aspx", false);
                    return;
                }
            }
            else if (2 == state)
            {
                AlertHelper.JQAlertGo("您已报名！", "/user/" + CurrentUser.uId.ToString() + ".aspx", false);
                return;
            }
            else if (3 == state)
            {
                AlertHelper.JQAlertGo("您已组队！", "/infocenter/Competition.aspx?uId=" + CurrentUser.uId.ToString(), false);
                return;
            }
            #region 默认配置
            if (iFlag == 1)
            {
                if (model.iScore == 0)
                {
                    Detail = model.cType + "￥" + model.iCost + "元";
                    fPrice = TypeChangeDefault.NullToDouble(model.iCost, 0);
                }
                else
                {
                    int iScore = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + CurrentUser.uId, CurrentUser.uId);
                    if (iScore < model.iScore)
                    {
                        Detail = model.cType + "￥" + model.iCost + "元";
                        fPrice = TypeChangeDefault.NullToDouble(model.iCost, 0);
                        AlertHelper.JQAlertGo("您的积分不足，无法使用积分！", "/Channels/Competetion/RaceProject.aspx?idcompete=" + id + "&la=" + la, false);
                        return;
                    }
                    else
                    {
                        Detail = model.cType + "￥" + model.iCost + "元 - " + model.iScore + "积分兑换" + model.iMoney + "元";
                        fPrice = TypeChangeDefault.NullToDouble(model.iCost - model.iMoney, 0);
                    }
                }
            }
            else
            {
                Detail = model.cType + "￥" + model.iCost + "元";
                fPrice = TypeChangeDefault.NullToDouble(model.iCost, 0);
            }
            ltlTitle.Text = model.cTitle;
            //if (1 == model.iCloth || 1 == model.iShoe)
            //{
            //    // 尺寸
            //    if (1 == model.iCloth)
            //        idsize.ColSpan = 2;
            //    //鞋号
            //    if (1 == model.iShoe)
            //        idShoe.ColSpan = 2;
            //}
            // 尺寸
            if (1 == model.iCloth)
                idsize.Visible = true;
            else
                idsize.Visible = false;
            //鞋号
            //if (1 == model.iShoe)
            //    idShoe.Visible = true;
            //else
            //    idShoe.Visible = false;
            //体检证明或成绩证书
            if (1 == model.ihealth)
                idFJSC.Visible = true;
            else
                idFJSC.Visible = false;
            #endregion
            #region 赛事价格显示
            DataTable dt = new DB4.tblAnnex().GetList("iState>0 and iNum>0 and id in(" + idAdd + ") ").Tables[0];
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Detail += "+" + dt.Rows[i]["cName"].ToString() + "￥" + dt.Rows[i]["fPrice"].ToString() + "元";
                    fPrice += TypeChangeDefault.NullToDouble(dt.Rows[i]["fPrice"], 0);
                }
            }
            ltlDetail.Text = Detail;
            ltlfPrice.Text = fPrice.ToString();
            #endregion
            #region 扩展字段
            Ext_Field(idItem);
            #endregion
        }
    }

    //初始化国际赛事用户信息
    private void iAbroadUserInit()
    {
        DBM1.tblMember_Partner user = new DB1.tblMember_Partner().GetModel(CurrentUser.uId);
        if (user != null)
        {
            surname.Value = user.csurname;
            cname.Value = user.cname;
            idgender.SelectedValue = user.idGender.ToString();
            idBlood.SelectedValue = user.idBlood.ToString();
            birday.Value = TypeChangeDefault.NullToDateTime(user.dBirthday, DateTime.Now).ToString("yyyy-MM-dd");
            ddlEducation.SelectedValue = TypeChangeDefault.NullToString(user.idEducation, "0");
            idOccupation.SelectedValue = TypeChangeDefault.NullToString(user.idOccupation, "0");
            prependedDropdownButton.Value = TypeChangeDefault.NullToString(user.cNationID, "");
            Placeofissue.Value = user.cPlace;
            Dateofissue.Value = TypeChangeDefault.NullToDateTime(user.dIssue, DateTime.Now).ToString("yyyy-MM-dd");
            Dateofexpiry.Value = TypeChangeDefault.NullToDateTime(user.dExpiry, DateTime.Now).ToString("yyyy-MM-dd");


            mobile.Value = TypeChangeDefault.NullToString(user.cMobile, "");
            email.Value = TypeChangeDefault.NullToString(user.cMail, "");
            if (TypeChangeDefault.NullToString(user.idCity, "0").Length == 3)
            {
                iCity = TypeChangeDefault.NullToString(user.idCity, "0").Trim().Substring(0, 1);
                iArea = TypeChangeDefault.NullToString(user.idCity, "0").Substring(1, 2);
            }
            else if (TypeChangeDefault.NullToString(user.idCity, "0").Length == 4)
            {
                iCity = TypeChangeDefault.NullToString(user.idCity, "0").Trim().Substring(0, 2);
                iArea = TypeChangeDefault.NullToString(user.idCity, "0").Substring(2, 2);
            }
            cCityname.Value = TypeChangeDefault.NullToString(user.cCityname, "");
            idCity.Value = TypeChangeDefault.NullToString(user.idCity, "0");
            string[] m_address = TypeChangeDefault.NullToString(user.cAddress, "").Trim().Split('|');
            if (m_address.Length > 1)
            {
                address.Value = m_address[0];
                addressen.Value = m_address[1];
            }
            else
            {
                address.Value = TypeChangeDefault.NullToString(user.cAddress, "");
            }
            //address.Value = TypeChangeDefault.NullToString(user.cAddress, "");
           
            //addressen.Value = "";//地址
            zipcode.Value = TypeChangeDefault.NullToString(user.cZipcode, "");

            string[] Contact = TypeChangeDefault.NullToString(user.cEmergerContact, "").Trim().Split('|');
            if (Contact.Length > 1)
            {
                emerger.Value = Contact[0];
                emermobile.Value = Contact[1];
            }

            fileurl.Value = TypeChangeDefault.NullToString(user.cHealthUrl, "");
            if (fileurl.Value.IndexOf(GetDir(CurrentUser.uId.ToString())) == -1)
            {
                fileurl.Value = "";
            }
        }
        else
        {
            birday.Value = TypeChangeDefault.NullToDateTime("", DateTime.Now).ToString("yyyy-MM-dd");           
            Dateofissue.Value = TypeChangeDefault.NullToDateTime("", DateTime.Now).ToString("yyyy-MM-dd");
            Dateofexpiry.Value = TypeChangeDefault.NullToDateTime("", DateTime.Now).ToString("yyyy-MM-dd"); 
        }
    }
    protected void btSubmit_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        //DBM1.tblMEMBER model = new DBM1.tblMEMBER();
        DBM1.tblMember_Partner model = new DBM1.tblMember_Partner();
        DBM4.tblRACE_SALES modelsales = new DBM4.tblRACE_SALES();
        if (surname.Value.Trim().Length <= 0 || surname.Value.Trim().Length > 32)
        {
            AlertHelper.JQAlert("姓为空或超过限制！", false);
            return;
        }
        if (cname.Value.Trim().Length <= 0 || cname.Value.Trim().Length > 32)
        {
            AlertHelper.JQAlert("名为空或超过限制！", false);
            return;
        }     
        model.csurname = surname.Value.Trim().ToUpper();
        model.cname = cname.Value.Trim().ToUpper();
        model.cFullname = surname.Value.Trim().ToUpper() + "-" + cname.Value.Trim().ToUpper();//缺乏报名表
        modelsales.cName = surname.Value.Trim().ToUpper() + "-" + cname.Value.Trim().ToUpper();//缺乏报名表
        model.idGender = TypeChange.NullToInt(idgender.SelectedValue, -1);//性别
        modelsales.idGender = TypeChange.NullToInt(idgender.SelectedValue, -1);
        model.idBlood = TypeChange.NullToInt(idBlood.SelectedValue, -1);//血型
        modelsales.idBlood = TypeChange.NullToInt(idBlood.SelectedValue, -1);
        if (birday.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请选择生日！", false);
            return;
        }
        model.dBirthday = TypeChangeDefault.NullToDateTime(birday.Value.Trim(), DateTime.Now);//生日
        modelsales.dBirthday = TypeChangeDefault.NullToDateTime(birday.Value.Trim(), DateTime.Now);
        model.idEducation = TypeChange.NullToInt(ddlEducation.SelectedValue, 0);//学历
        modelsales.idEducation = TypeChange.NullToInt(ddlEducation.SelectedValue, 0);//学历
        model.idOccupation = Convert.ToInt32(idOccupation.SelectedValue);//职业
        modelsales.idOccupation = Convert.ToInt32(idOccupation.SelectedValue);//职业
        model.idNationIDType = 4;//证件类型
        modelsales.idNationIDType = 4;//证件类型 护照
      
        model.cNationID = prependedDropdownButton.Value.Trim();//证件号码
        modelsales.cNationID = prependedDropdownButton.Value.Trim();
        model.cPlace = Placeofissue.Value.Trim();//签发地点
        modelsales.cShoe = Placeofissue.Value.Trim();//签发地点
        model.dIssue = TypeChange.NullToDateTime(Dateofissue.Value.Trim(), DateTime.Now);//签发时间
        modelsales.cOrigin = Dateofissue.Value.Trim();//签发时间
        model.dExpiry = TypeChange.NullToDateTime(Dateofexpiry.Value.Trim(), DateTime.Now);//有效期
        modelsales.cMake = Dateofexpiry.Value.Trim();//有效期
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
        model.cMobile = mobile.Value.Trim();//手机号码
        modelsales.cMobile = mobile.Value.Trim();
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
        model.cMail = email.Value.Trim();//邮箱
        modelsales.cMail = email.Value.Trim();
        if (idCity.Value.Trim() == "0")
        {
            AlertHelper.JQAlert("请选择居住城市！", false);
            return;
        }
        if (string.IsNullOrEmpty(cCityname.Value.Trim()))
        {
            AlertHelper.JQAlert("请选择居住城市！", false);
            return;
        }
        model.idCity = TypeChangeDefault.NullToInt(idCity.Value, 0);
        model.cCityname = cCityname.Value.Trim();//城市
        modelsales.cCityname = cCityname.Value.Trim();
        if (address.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写地址！", false);
            return;
        }
        model.cAddress = address.Value.Trim() + "|" + addressen.Value.Trim();//地址
        modelsales.cAddress = address.Value.Trim() +"|"+ addressen.Value.Trim();//地址
        if (zipcode.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写邮编！", false);
            return;
        }
        model.cZipcode = zipcode.Value.Trim();//邮编
        modelsales.cZipcode = zipcode.Value.Trim();
        if (emerger.Value.Trim().Length <= 0 || emermobile.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写紧急联系人及联系电话！", false);
            return;
        }
        model.cEmergerContact = emerger.Value.Trim() + "|" + emermobile.Value.Trim();//紧急联系人联系电话
        modelsales.cEmergerContact = emerger.Value.Trim() + "|" + emermobile.Value.Trim();
        model.idUser = CurrentUser.uId;
        model.cNational = idgj.Value.Trim();//国籍
        modelsales.cGJ = idgj.Value.Trim();//国籍
        if (idsize.Visible)
        {
            model.cCloth = size.SelectedValue;//服装尺码
            modelsales.cCloth = size.SelectedValue;//服装尺码
        }
        else
        {
            model.cCloth = "";//服装尺码
            modelsales.cCloth = "";
        }
        //if (idShoe.Visible)
        //{
        //    if (shoeno.Value.Trim().Length <= 0)
        //    {
        //        AlertHelper.JQAlert("请填写鞋号！", false);
        //        return;
        //    }
        //    modelsales.cShoe = shoeno.Value.Trim();//鞋号
        //}
        //else
        //    modelsales.cShoe = "";
        #region 体检证明或成绩证书
        if (idFJSC.Visible)
        {
            if (FileUpload1.HasFile)
            {
                string filename = FileUpload1.FileName;
                string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

                if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
                {
                    string fileShort = "/" + CurrentUser.uId + "_zs." + type;

                    HttpPostedFile file = FileUpload1.PostedFile;
                    if (file.ContentLength > 51200000)
                    {
                        AlertHelper.JQAlert("文件大小请不要超过5M！", false);
                        return;
                    }
                    if (UpPhotoSaveAs(file, GetDir(CurrentUser.uId.ToString()), fileShort))
                    {
                        string URL = GetDir(CurrentUser.uId.ToString()) + fileShort;
                        model.cHealthUrl = URL;
                        modelsales.cHealthUrl = URL;
                        fileurl.Value = URL;
                    }
                    else
                    {
                        AlertHelper.JQAlert("上传失败，请重新上传！", false);
                        return;
                    }
                }
                else
                {
                    AlertHelper.JQAlert("上传格式错误，请按要求重新上传！", false);
                    return;
                }
            }
            else
            {
                if (fileurl.Value.Trim().Length <= 0)
                {
                    AlertHelper.JQAlert("请上传体检证明或成绩证书！", false);
                    return;
                }
                string zs = "/" + CurrentUser.uId + "_zs.";
                if (fileurl.Value.IndexOf(zs) < 0)
                {
                    AlertHelper.JQAlert("请重新上传体检证明或成绩证书！", false);
                    return;
                    //存在
                }
                modelsales.cHealthUrl = fileurl.Value;
            }
        }
        else
            modelsales.cHealthUrl = "";
        #endregion
        //model.cFirst = firstjoin.SelectedValue;
        //model.cresult = BestTime.Value.Trim();
        modelsales.iCost = decimal.Parse(ltlfPrice.Text);
        modelsales.dCreate = DateTime.Now;
        model.dCreate = DateTime.Now;
        DBM4.tblRACE_SIGNUP mSign = new DB4.tblRACE_SIGNUP().GetModel(idItem);
        if (mSign == null)
        {
            AlertHelper.JQAlertGo("项目不存在，请重新选择", "/Channels/Competetion/RaceList.aspx", false);
            return;
        }

        NameValueCollection FieldVars = new NameValueCollection();
        int Success = 0;//是否上传成功
        #region 扩展字段
        if (field1.Visible)
        {
            if (fileurl1.HasFile)
            {
                string tip = SaveImages(fileurl1, ltlfield1.Text, out Success);
                if (Success == 0)
                {
                    AlertHelper.JQAlert(tip, false);
                    return;
                }
                FieldVars.Add("fileurl1", tip);
            }
            else
            {
                AlertHelper.JQAlert("请上传" + ltlfield1.Text + "！", false);
                return;
            }
        }
        if (field2.Visible)
        {
            if (fileurl2.HasFile)
            {
                string tip = SaveImages(fileurl2, ltlfield2.Text, out Success);
                if (Success == 0)
                {
                    AlertHelper.JQAlert(tip, false);
                    return;
                }
                FieldVars.Add("fileurl2", tip);
            }
            else
            {
                AlertHelper.JQAlert("请上传" + ltlfield2.Text + "！", false);
                return;
            }
        }
        if (field3.Visible)
        {
            if (fileurl3.HasFile)
            {
                string tip = SaveImages(fileurl3, ltlfield3.Text, out Success);
                if (Success == 0)
                {
                    AlertHelper.JQAlert(tip, false);
                    return;
                }
                FieldVars.Add("fileurl3", tip);
            }
            else
            {
                AlertHelper.JQAlert("请上传" + ltlfield3.Text + "！", false);
                return;
            }
        }
        if (txtfield1.Visible)
        {
            if (bzfield1.Value.Trim().Length <= 0)
            {
                AlertHelper.JQAlert(ltlbztip1.Text.Trim(), false);
                return;
            }
            FieldVars.Add("bzfield1", bzfield1.Value.Trim());
        }
        if (txtfield2.Visible)
        {
            if (bzfield2.Value.Trim().Length <= 0)
            {
                AlertHelper.JQAlert(ltlbztip2.Text.Trim(), false);
                return;
            }
            FieldVars.Add("bzfield2", bzfield2.Value.Trim());
        }
        if (txtfield3.Visible)
        {
            if (bzfield3.Value.Trim().Length <= 0)
            {
                AlertHelper.JQAlert(ltlbztip3.Text.Trim(), false);
                return;
            }
            FieldVars.Add("bzfield3", bzfield3.Value.Trim());
        }
        if (rbfield1.Visible)
        {
            FieldVars.Add("rbyes1", rbyes1.SelectedValue);
        }
        if (rbfield2.Visible)
        {
            FieldVars.Add("rbyes2", rbyes1.SelectedValue);
        }
        if (rbfield3.Visible)
        {
            FieldVars.Add("rbyes3", rbyes1.SelectedValue);
        }
        Dictionary<string, string> dictField = GetField(idItem);
        foreach (String s in FieldVars.AllKeys)
        {
            switch (dictField.FirstOrDefault(d => d.Key == s).Value)
            {
                case "cRemark2":
                    modelsales.cRemark2 = FieldVars[s];
                    break;
                case "cRemark3":
                    modelsales.cRemark3 = FieldVars[s];
                    break;
                case "cRemark4":
                    modelsales.cRemark4 = FieldVars[s];
                    break;
                case "cOrigin":
                    modelsales.cOrigin = FieldVars[s];
                    break;
                case "cMake":
                    modelsales.cMake = FieldVars[s];
                    break;
            }

        }
        #endregion
        modelsales.idSignUp = mSign.id;
        modelsales.cTitle = mSign.cTitle;
        modelsales.cType = mSign.cType;
        modelsales.idUser = CurrentUser.uId;

        if (iFlag == 1)
        {
            int iScore = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + CurrentUser.uId, CurrentUser.uId);
            if (iScore < mSign.iScore)
            {
                AlertHelper.JQAlertGo("您的积分不足，无法使用积分！", "/Channels/Competetion/RaceProject.aspx?idcompete=" + id + "&la=" + la, false);
                return;
            }
        }
        modelsales.cRemark5 = iFlag.ToString();//积分标识，是否使用积分
        string orderid = new DB4.tblRACE_SALES().GetMaxOrderId();
        if (orderid == "")
        {
            orderid = DateTime.Now.ToString("yyyyMMdd") + "00001";
        }
        else
        {
            orderid = DateTime.Now.ToString("yyyyMMdd") + (Convert.ToInt32(orderid.Substring(8, 5)) + 1).ToString().PadLeft(5, '0');
        }
        modelsales.idOrder = orderid;
        if (1 == mSign.iAudit)
            modelsales.iState = 0;
        else
            modelsales.iState = 1;
        int count = new DB4.tblRACE_SALES().GetRecordCount(" iState>-1 and idSignUp=" + idItem);
        if (count >= mSign.iLimit)
        {
            AlertHelper.JQAlertGo("报名已满！", "/blog/" + mSign.idBlog + ".aspx", false);
            return;
        }
        DBM4.tblRACE_SALES clent = new DB4.tblRACE_SALES().GetModel(id, CurrentUser.uId);
        modelsales.dConfirm = DateTime.Now;
        if (clent != null)
        {
            //modelsales.idOrder = clent.idOrder;
            if (0 == clent.iState)
            {
                AlertHelper.JQAlertGo("您已提交审核,请审核通过后付款！", "/blog/" + mSign.idBlog + ".aspx", true);
                return;
            }
            else if (1 == clent.iState)
            {
                AlertHelper.JQAlertGo("您已报名,请付款！", "/blog/" + mSign.idBlog + ".aspx", true);
                return;
            }
            else if (2 == clent.iState)
            {
                AlertHelper.JQAlertGo("您已经报名成功！", "/blog/" + mSign.idBlog + ".aspx", true);
                return;
            }
            else if (3 == clent.iState)
            {
                AlertHelper.JQAlertGo("您已经报名并组队成功！", "/blog/" + mSign.idBlog + ".aspx", true);
                return;
            }
            else
            {
                modelsales.id = clent.id;
                new DB4.tblRACE_SALES().Update(modelsales);
                //new DB1.tblMember_Partner().Update(model);
                if (new DB1.tblMember_Partner().Exists(CurrentUser.uId))
                {
                    new DB1.tblMember_Partner().Update(model);
                }
                else
                {
                    new DB1.tblMember_Partner().Add(model);
                }
                AddAnnex();
                if (iFlag == 1)
                {
                    new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200840002, 4, TypeChangeDefault.NullToDecimal(mSign.iScore, 0), "赛事花费，项目" + mSign.id.ToString());
                }
                if (1 == mSign.iAudit)
                {
                    AlertHelper.JQAlertGo("提交成功,请审核通过后付款！", "/blog/" + mSign.idBlog + ".aspx", true);
                    return;
                }
                else
                {
                    AlertHelper.JQAlertGo("提交成功！", "/Channels/Competetion/RacePay.aspx?orderid=" + modelsales.idOrder, true);
                    return;
                }
            }

        }
        else
        {

            new DB4.tblRACE_SALES().Add(modelsales);
            if (new DB1.tblMember_Partner().Exists(CurrentUser.uId))
            {
                new DB1.tblMember_Partner().Update(model);
            }
            else
            {
                new DB1.tblMember_Partner().Add(model);
            }
            //new DB1.tblMEMBER().Update(model);
            AddAnnex();
            if (iFlag == 1)
            {
                new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200840002, 4, TypeChangeDefault.NullToDecimal(mSign.iScore, 0), "赛事花费，项目" + mSign.id.ToString());
            }
            if (1 == mSign.iAudit)
            {
                AlertHelper.JQAlertGo("提交成功,请审核通过后付款！", "/blog/" + mSign.idBlog + ".aspx", true);
                return;
            }
            else
            {
                AlertHelper.JQAlertGo("提交成功！", "/Channels/Competetion/RacePay.aspx?orderid=" + modelsales.idOrder, true);
                return;
            }
        }
    }
    ///绑定职业
    protected void BindIdOccupation(string la)
    {
        string CacheKey = "idOccupation-" + la;
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        if (objModel == null)
        {
            string path = string.Empty;
            if (la == "en")
                path = Server.MapPath("/XML/Stringsen.xml");
            else
                path = Server.MapPath("/XML/Strings.xml");
            DataSet ds = new DataSet();
            ds.ReadXml(path);
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
    //初始化中英文
    protected void Initialize(string la)
    {
        Dictionary<string, string> dict = Getcn_en(la);
        ltlSelect.Text = dict.FirstOrDefault(d => d.Key == "5").Value;
        ltlTotal.Text = dict.FirstOrDefault(d => d.Key == "6").Value;
        //ltlName.Text = dict.FirstOrDefault(d => d.Key == "7").Value;
        ltllastname.Text = dict.FirstOrDefault(d => d.Key == "27").Value;
        ltlfamilyname.Text = dict.FirstOrDefault(d => d.Key == "28").Value;

        ltlGender.Text = dict.FirstOrDefault(d => d.Key == "8").Value;
        ltlBlood.Text = dict.FirstOrDefault(d => d.Key == "9").Value;
        ltlBirthday.Text = dict.FirstOrDefault(d => d.Key == "10").Value;

        ltlEducation.Text = dict.FirstOrDefault(d => d.Key == "11").Value;
        ltlOccupation.Text = dict.FirstOrDefault(d => d.Key == "12").Value;
        ltlGJ.Text = dict.FirstOrDefault(d => d.Key == "13").Value;

        ltlCard.Text = dict.FirstOrDefault(d => d.Key == "14").Value;
        ltlMobile.Text = dict.FirstOrDefault(d => d.Key == "15").Value;
        ltlEmail.Text = dict.FirstOrDefault(d => d.Key == "16").Value;

        ltlAddress.Text = dict.FirstOrDefault(d => d.Key == "17").Value;
        ltlZipCode.Text = dict.FirstOrDefault(d => d.Key == "18").Value;
        ltlEmerger.Text = dict.FirstOrDefault(d => d.Key == "19").Value;


        ltlEmermobile.Text = dict.FirstOrDefault(d => d.Key == "20").Value;
        ltlShirts.Text = dict.FirstOrDefault(d => d.Key == "21").Value;
        //ltlShoes.Text = dict.FirstOrDefault(d => d.Key == "22").Value;
        ltlTjzm.Text = dict.FirstOrDefault(d => d.Key == "23").Value;

        ltlPlaceofissue.Text = dict.FirstOrDefault(d => d.Key == "29").Value;
        ltlDateofissue.Text = dict.FirstOrDefault(d => d.Key == "30").Value;
        ltlDateofexpiry.Text = dict.FirstOrDefault(d => d.Key == "31").Value;
        //ltlfirstjoin.Text = dict.FirstOrDefault(d => d.Key == "32").Value;
        //ltlBestTime.Text = dict.FirstOrDefault(d => d.Key == "33").Value;
        ltladdressen.Text = dict.FirstOrDefault(d => d.Key == "34").Value;
    }
    /// <summary>
    /// 获取中英文对照字典
    /// </summary>
    public static Dictionary<string, string> Getcn_en(string en)
    {
        string CacheKey = "GetVersionAbroad-" + en;
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        //objModel = null;
        if (objModel == null)
        {
            try
            {
                Dictionary<string, string> version = new Dictionary<string, string>();
                string xmlPath = HttpContext.Current.Server.MapPath("/XML/AbroadRace.xml");
                XDocument doc = XDocument.Load(xmlPath);
                var language = en;
                var tipList = doc.Descendants("text");
                foreach (var item in tipList)
                {
                    version.Add(item.Element("id").Value, HTMLHelper.ZipHtml(item.Element(language).Value));
                }
                objModel = version;
                if (objModel != null)
                {
                    int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            catch { }
        }
        return (Dictionary<string, string>)objModel;
    }
    //更改附属产品数量，并添加购买日志，状态为1预定，
    public void AddAnnex()
    {
        DBM4.tblAnnexLog mLog = new DBM4.tblAnnexLog();
        mLog.idUser = CurrentUser.uId;
        mLog.idCompete = id;

        string[] fscp = idAdd.Split(',');
        for (int j = 0; j < fscp.Length; j++)
        {
            int idAnnex = TypeChange.NullToInt(fscp[j], -1);
            mLog.idAnnex = idAnnex;
            mLog.idItem = idItem;
            DBM4.tblAnnex mAnnex = new DB4.tblAnnex().GetModel(idAnnex);
            if (mAnnex != null)
            {
                mLog.iState = 1;
                mLog.cName = mAnnex.cName;
                mLog.fPrice = mAnnex.fPrice;
                mLog.dCreate = DateTime.Now;
                new DB4.tblAnnexLog().Add(mLog);
                mAnnex.iNum = mAnnex.iNum - 1;
                mAnnex.id = idAnnex;
                new DB4.tblAnnex().Update(mAnnex);
            }
        }
    }
    private bool UpPhotoSaveAs(HttpPostedFile uploadFile, string Path, string FileName)
    {
        HttpPostedFile face = uploadFile;
        //FileSaveAs picWebService = new FileSaveAs();

        SaveFile.FileSaveAsSoapClient picWebService = new SaveFile.FileSaveAsSoapClient();
        int upPhotoLength = face.ContentLength;
        byte[] PhotoArray = new Byte[upPhotoLength];
        Stream PhotoStream = face.InputStream;
        PhotoStream.Read(PhotoArray, 0, upPhotoLength);
        bool flag = picWebService.UploadFile(PhotoArray, Path, FileName);
        face.InputStream.Close();
        return flag;
    }
    public void Ext_Field(int idItem)
    {
        //文件上传
        DataTable dtfileurl = new DB4.tblRace_SignUp_ext().GetList(5, "iditem=" + idItem, "data_type,sales_field").Tables[0];
        if (dtfileurl.Rows.Count > 0)
        {
            int fcount = 0, bcount = 0, rcount = 0;
            for (int i = 0; i < dtfileurl.Rows.Count; i++)
            {
                if (dtfileurl.Rows[i]["data_type"].ToString() == "1")//附件上传
                {
                    switch (fcount)
                    {
                        case 0: field1.Visible = true;
                            ltlfield1.Text = la == "en" ? dtfileurl.Rows[i]["enName"].ToString() : dtfileurl.Rows[i]["cnName"].ToString();
                            ltltip1.Text = la == "en" ? dtfileurl.Rows[i]["enTip"].ToString() : dtfileurl.Rows[i]["cnTip"].ToString();
                            break;
                        case 1: field2.Visible = true;
                            ltlfield2.Text = la == "en" ? dtfileurl.Rows[i]["enName"].ToString() : dtfileurl.Rows[i]["cnName"].ToString();
                            ltltip2.Text = la == "en" ? dtfileurl.Rows[i]["enTip"].ToString() : dtfileurl.Rows[i]["cnTip"].ToString();
                            break;
                        case 2: field3.Visible = true;
                            ltlfield3.Text = la == "en" ? dtfileurl.Rows[i]["enName"].ToString() : dtfileurl.Rows[i]["cnName"].ToString();
                            ltltip3.Text = la == "en" ? dtfileurl.Rows[i]["enTip"].ToString() : dtfileurl.Rows[i]["cnTip"].ToString();
                            break;
                    }
                    fcount++;
                }
                else if (dtfileurl.Rows[i]["data_type"].ToString() == "2")//文本字段
                {
                    switch (bcount)
                    {
                        case 0: txtfield1.Visible = true;
                            ltlbzfield1.Text = la == "en" ? dtfileurl.Rows[i]["enName"].ToString() : dtfileurl.Rows[i]["cnName"].ToString();
                            ltlbztip1.Text = la == "en" ? dtfileurl.Rows[i]["enTip"].ToString() : dtfileurl.Rows[i]["cnTip"].ToString();
                            break;
                        case 1: txtfield2.Visible = true;
                            ltlbzfield2.Text = la == "en" ? dtfileurl.Rows[i]["enName"].ToString() : dtfileurl.Rows[i]["cnName"].ToString();
                            ltlbztip2.Text = la == "en" ? dtfileurl.Rows[i]["enTip"].ToString() : dtfileurl.Rows[i]["cnTip"].ToString();
                            break;
                        case 2: txtfield3.Visible = true;
                            ltlbzfield3.Text = la == "en" ? dtfileurl.Rows[i]["enName"].ToString() : dtfileurl.Rows[i]["cnName"].ToString();
                            ltlbztip3.Text = la == "en" ? dtfileurl.Rows[i]["enTip"].ToString() : dtfileurl.Rows[i]["cnTip"].ToString();
                            break;
                    }
                    bcount++;
                }
                else if (dtfileurl.Rows[i]["data_type"].ToString() == "3")//是否字段
                {
                    switch (rcount)
                    {
                        case 0: rbfield1.Visible = true;
                            ltlrb1.Text = la == "en" ? dtfileurl.Rows[i]["enName"].ToString() : dtfileurl.Rows[i]["cnName"].ToString();
                            break;
                        case 1: rbfield2.Visible = true;
                            ltlrb2.Text = la == "en" ? dtfileurl.Rows[i]["enName"].ToString() : dtfileurl.Rows[i]["cnName"].ToString();
                            break;
                        case 2: rbfield3.Visible = true;
                            ltlrb3.Text = la == "en" ? dtfileurl.Rows[i]["enName"].ToString() : dtfileurl.Rows[i]["cnName"].ToString();
                            break;
                    }
                    rcount++;
                }
            }
        }

    }
    /// <summary>
    /// 附件上传
    /// </summary>
    /// <param name="fileurl">上传控件</param>
    /// <param name="tip">提示信息</param>
    /// <param name="Success">1成功0失败</param>
    /// <returns>返回上传文件路径及是否成功</returns>
    private string SaveImages(FileUpload fileurl, string tip, out int Success)
    {
        string URL = string.Empty;
        string filename = fileurl.FileName;
        string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型
        if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
        {
            string fileShort = "/" + idItem + DateTime.Now.ToString("_yyMMddHHmmssfff.") + type;
            HttpPostedFile file = fileurl.PostedFile;
            if (file.ContentLength > 51200000)
            {
                Success = 0;
                return tip + "文件大小请不要超过5M！";
            }
            if (UpPhotoSaveAs(file, GetDir(CurrentUser.uId.ToString()), fileShort))
            {
                URL = GetDir(CurrentUser.uId.ToString()) + fileShort;
            }
            else
            {
                Success = 0;
                return tip + "上传失败，请重新上传！";
            }
        }
        else
        {
            Success = 0;
            return tip + "上传错误，请按要求重新上传！";
        }
        Success = 1;
        return URL;
    }
    /// <summary>
    /// 获取扩展字段对应赛事报名字段
    /// </summary>
    /// <param name="idItem">项目id</param>
    /// <returns></returns>
    public static Dictionary<string, string> GetField(int idItem)
    {
        string CacheKey = "GetField-" + idItem;
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        if (objModel == null)
        {
            try
            {
                Dictionary<string, string> vers = new Dictionary<string, string>();
                DataTable dtfileurl = new DB4.tblRace_SignUp_ext().GetList(5, "iditem=" + idItem, "data_type,sales_field").Tables[0];
                if (dtfileurl.Rows.Count > 0)
                {
                    int fcount = 0, bcount = 0, rcount = 0;
                    for (int i = 0; i < dtfileurl.Rows.Count; i++)
                    {
                        if (dtfileurl.Rows[i]["data_type"].ToString() == "1")//附件上传
                        {
                            switch (fcount)
                            {
                                case 0:
                                    vers.Add("fileurl1", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                                case 1:
                                    vers.Add("fileurl2", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                                case 2:
                                    vers.Add("fileurl3", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                            }
                            fcount++;
                        }
                        else if (dtfileurl.Rows[i]["data_type"].ToString() == "2")//文本字段
                        {
                            switch (bcount)
                            {
                                case 0:
                                    vers.Add("bzfield1", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                                case 1:
                                    vers.Add("bzfield2", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                                case 2:
                                    vers.Add("bzfield3", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                            }
                            bcount++;
                        }
                        else if (dtfileurl.Rows[i]["data_type"].ToString() == "3")//是否字段
                        {
                            switch (rcount)
                            {
                                case 0: vers.Add("rbyes1", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                                case 1: vers.Add("rbyes2", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                                case 2: vers.Add("rbyes3", dtfileurl.Rows[i]["sales_field"].ToString());
                                    break;
                            }
                            rcount++;

                        }
                    }
                }
                objModel = vers;
                if (objModel != null)
                {
                    int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            catch { }
        }
        return (Dictionary<string, string>)objModel;
    }
}