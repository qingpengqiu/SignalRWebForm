﻿using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DB4 = Erun360.BLL.DB4;
using DBM1 = Erun360.Model.DB1;
using DBM4 = Erun360.Model.DB4;

public partial class Channels_Competetion_RaceAddInfo : PageBase
{
    public string iCity = string.Empty;//
    public string iArea = string.Empty;
    public string bm = "";//报满
    public int id = 0;//赛事id
    public string Item = string.Empty;//备注
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (Request.QueryString["idcompete"] != null)
        {
            id = TypeChangeDefault.NullToInt(Request.QueryString["idcompete"], 0);
        }
        if (!IsPostBack)
        {
            DBM4.tblRACE_SIGNUP model = new DB4.tblRACE_SIGNUP().GetCompeteModel(id);
            if (model == null)
            {
                AlertHelper.JQAlertGo("该赛事不存在！", "/user/" + CurrentUser.uId.ToString() + ".aspx", false);
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

            Session["bm"] = "";
            #region 用户报名信息
            DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(CurrentUser.uId);
            name.Value = user.cName;
            idgender.SelectedValue = user.idGender.ToString();
            idblood.SelectedValue = user.idBlood.ToString();
            birday.Value = TypeChangeDefault.NullToDateTime(user.dBirthday, DateTime.Now).ToString("yyyy-MM-dd");
            education.SelectedIndex = TypeChangeDefault.NullToInt(user.idEducation, 0);
            idOccupation.SelectedValue = TypeChangeDefault.NullToString(user.idOccupation, "0");
            idCard.SelectedIndex = TypeChangeDefault.NullToInt(user.idNationIDType, 0);
            prependedDropdownButton.Value = TypeChangeDefault.NullToString(user.cNationID, "");
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

            address.Value = TypeChangeDefault.NullToString(user.cAddress, "");
            zipcode.Value = TypeChangeDefault.NullToString(user.cZipcode, "");

            string[] Contact = TypeChangeDefault.NullToString(user.cEmergerContact, "").Trim().Split('|');
            if (Contact.Length > 1)
            {
                emerger.Value = Contact[0];
                emermobile.Value = Contact[1];
            }
            BindIdOccupation();

            fileurl.Value = TypeChangeDefault.NullToString(user.cHealthUrl, "");
            #endregion
            #region 赛事信息
            trupload.Visible = false;
            sizetd.Visible = false;
            Divshoe.Visible = false;
            BindEntries(id);
            #endregion

        }
        bm = Session["bm"].ToString();
    }
    //绑定职业
    protected void BindIdOccupation()
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
    protected void Ctnsubmit_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        DBM1.tblMEMBER model = new DBM1.tblMEMBER();
        DBM4.tblRACE_SALES modelsales = new DBM4.tblRACE_SALES();
        if (name.Value.Trim().Length <= 0 || name.Value.Trim().Length > 32)
        {
            AlertHelper.JQAlert("姓名为空或超过限制！", false);
            return;
        }
        model.cName = name.Value.Trim();
        modelsales.cName = name.Value.Trim();
        model.idGender = TypeChange.NullToInt(idgender.SelectedValue, -1);//性别
        model.idBlood = TypeChange.NullToInt(idblood.SelectedValue, -1);//血型
        if (birday.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请选择生日！", false);
            return;
        }
        model.dBirthday = TypeChangeDefault.NullToDateTime(birday.Value.Trim(), DateTime.Now);//生日

        model.idEducation = education.SelectedIndex;//学历
        model.idOccupation = Convert.ToInt32(idOccupation.SelectedValue);//职业
        if (idCard.SelectedIndex == 0)
        {
            AlertHelper.JQAlert("请选择证件类型！", false);
            return;
        }
        model.idNationIDType = idCard.SelectedIndex;//证件类型
        if (idCard.SelectedIndex == 0)
        {
            AlertHelper.JQAlert("请选择证件类型！", false);
            return;
        }
        else if (idCard.SelectedIndex == 1)
        {
            if (prependedDropdownButton.Value.Trim().Length != 18)
            {
                AlertHelper.JQAlert("身份证格式错误！", false);
                return;
            }
            else
            {
                if (!Erun360.Common.PageValidate.IsNumber(prependedDropdownButton.Value.Trim().Substring(0, 17)))
                {
                    AlertHelper.JQAlert("身份证格式错误！", false);
                    return;
                }
            }
        }
        model.cNationID = prependedDropdownButton.Value.Trim();
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
        model.cCityname = cCityname.Value.Trim();
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
        model.id = CurrentUser.uId;

        modelsales.idGender = TypeChange.NullToInt(idgender.SelectedValue, -1);
        modelsales.idBlood = TypeChange.NullToInt(idblood.SelectedValue, -1);
        modelsales.dBirthday = TypeChangeDefault.NullToDateTime(birday.Value.Trim(), DateTime.Now);
        modelsales.idEducation = education.SelectedIndex;//学历
        modelsales.idOccupation = Convert.ToInt32(idOccupation.SelectedValue);//职业
        modelsales.idNationIDType = idCard.SelectedIndex;//证件类型
        modelsales.cNationID = prependedDropdownButton.Value.Trim();
        modelsales.cMobile = mobile.Value.Trim();
        modelsales.cMail = email.Value.Trim();
        modelsales.cCityname = cCityname.Value.Trim();
        modelsales.cAddress = address.Value.Trim();
        modelsales.cZipcode = zipcode.Value.Trim();
        modelsales.cEmergerContact = emerger.Value.Trim() + "|" + emermobile.Value.Trim();

        if (rdoEntries.SelectedValue == "")
        {
            AlertHelper.JQAlert("请填选择参赛项目！", false);
            return;
        }
        modelsales.idSignUp = TypeChangeDefault.NullToInt(rdoEntries.SelectedValue.Split('|')[0], 0);
        modelsales.idUser = CurrentUser.uId;
        //赛事类别id
        int idType = TypeChangeDefault.NullToInt(rdoEntries.SelectedValue.Split('|')[0], 0);
        DBM4.tblRACE_SIGNUP mSign = new DB4.tblRACE_SIGNUP().GetModel(idType);
        modelsales.cTitle = mSign.cTitle;
        modelsales.cType = mSign.cType;


        if (1 == mSign.iCloth)
            modelsales.cCloth = size.SelectedValue;
        else
            modelsales.cCloth = "";

        if (1 == mSign.iShoe)
        {
            if (shoeno.Value.Trim().Length <= 0)
            {
                AlertHelper.JQAlert("请填写鞋号！", false);
                return;
            }
            modelsales.cShoe = shoeno.Value.Trim();
        }
        else
            modelsales.cShoe = "";

        if (1 == mSign.ihealth)
        {
            if (FileUpload1.HasFile)
            {
                string filename = FileUpload1.FileName;
                string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

                if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
                {
                    string fileShort = "/" + CurrentUser.uId + "_zs." + type;

                    HttpPostedFile file = FileUpload1.PostedFile;

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
        #region 个性化定制显示
        if (gj.Visible)
        {
            if (string.IsNullOrEmpty(idgj.Value.Trim()))
            {
                AlertHelper.JQAlert("请填写国籍！", false);
                return;
            }
        }
        if (mSign.idCompete == 300000430)
        {
            modelsales.cGJ = idgj.Value;
            modelsales.cOrigin = idtjfs.SelectedValue;
        }
        #endregion
        modelsales.iCost = mSign.iCost;

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
        modelsales.dCreate = DateTime.Now;
        modelsales.dConfirm = DateTime.Now;
        if (1 == mSign.iAudit)
            modelsales.iState = 0;
        else
            modelsales.iState = 1;
        DBM4.tblRACE_SALES clent = new DB4.tblRACE_SALES().GetModel(id, CurrentUser.uId);
        if (clent != null)
        {
            if (0== clent.iState)
            {
                AlertHelper.JQAlertGo("您已提交审核,请审核通过后付款！", "/blog/" + mSign.idBlog + ".aspx", true);
            }
            else if (1 == clent.iState)
            {
                AlertHelper.JQAlertGo("您已报名,请付款！", "/blog/" + mSign.idBlog + ".aspx", true);
            }
            else if (2 == clent.iState)
            {
                AlertHelper.JQAlertGo("您已经报名成功！", "/blog/" + mSign.idBlog + ".aspx", true);
            }
            else
            {
                modelsales.id = clent.id;
                new DB4.tblRACE_SALES().Update(modelsales);
                new DB1.tblMEMBER().Update(model);
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
            new DB1.tblMEMBER().Update(model);
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
    //绑定参赛项目
    protected void BindEntries(int id)
    {
        //List<DBM4.tblRACE_SIGNUP> modelList = new DB4.tblRACE_SIGNUP().GetModelList(" and idCompete="+id);
        ////DataSet ds = new DB4.tblRACE_SIGNUP().GetsignupList(id);
        //rdoEntries.DataSource = modelList;
        //rdoEntries.DataTextField = "cType";
        //rdoEntries.DataValueField = "id";
        //rdoEntries.DataBind();
        DataSet ds = new DB4.tblRACE_SIGNUP().GetsignupList(id);
        rdoEntries.DataSource = ds;
        rdoEntries.DataTextField = "text";
        rdoEntries.DataValueField = "value1";
        rdoEntries.DataBind();
        //处理该项目是否报满
        int num = ds.Tables[0].Rows.Count;
        for (int i = 0; i < num; i++)
        {
            int countsales = new DB4.tblRACE_SALES().GetRecordCount(" iState>-1 and idsignup=" + rdoEntries.Items[i].Value.Split('|')[0]);

            if (countsales >= Convert.ToInt32(rdoEntries.Items[i].Value.Split('|')[1]))
            {
                Session["bm"] += rdoEntries.Items[i].Text.Split('￥')[0] + "已报满；";
                rdoEntries.Items[i].Enabled = false;
            }
        }
    }
    protected void rdoEntries_SelectedIndexChanged(object sender, EventArgs e)
    {
        int idcompete = TypeChange.NullToInt(rdoEntries.SelectedValue.Split('|')[0], 0);
        DBM4.tblRACE_SIGNUP model = new DB4.tblRACE_SIGNUP().GetModel(idcompete);
        if (model != null)
        {
            // 尺寸
            if (1 == model.iCloth)
                sizetd.Visible = true;
            else
                sizetd.Visible = false;

            //鞋号
            if (1 == model.iShoe)
                Divshoe.Visible = true;
            else
                Divshoe.Visible = false;
            if (1 == model.ihealth)
                trupload.Visible = true;
            else
                trupload.Visible = false;

            if (model.cComment != null)
            {
                if (model.cComment.Trim().Length > 0)
                {
                    Item = model.cType + "：" + TypeChangeDefault.NullToString(model.cComment, "") + "；";
                }
            }
            if (model.idCompete == 300000430)
            {
                if (model.iCost == 800)
                {
                    gj.Visible = true;
                    idgj.Value = "";
                }
                else
                {
                    idgj.Value = "中国";
                    gj.Visible = false;
                }
                jtfs.Visible = true;
            }
            else
            {
                gj.Visible = false;
                jtfs.Visible = false;
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
}