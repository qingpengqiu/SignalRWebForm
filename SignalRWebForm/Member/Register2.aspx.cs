using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DBM1 = Erun360.Model.DB1;
using DB1 = Erun360.BLL.DB1;
using System.IO;
public partial class Member_Register2 : PageBase
{
    public string iCity = string.Empty;//
    public string iArea = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Response.Redirect("/Member/Login.aspx");
        }
        if (!IsPostBack)
        {
            BindDDLFriends();
            ShowInfo(CurrentUser.uId);
        }
    }
    protected void ShowInfo(int id)
    {
        DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(id);
        if (user != null)
        {
            name.Value = user.cName;
            idBlood.SelectedValue = user.idBlood.ToString();
            ddlEducation.SelectedValue = TypeChangeDefault.NullToString(user.idEducation, "0");
            idOccupation.SelectedValue = TypeChangeDefault.NullToString(user.idOccupation, "0");
            ddlCard.SelectedValue = TypeChangeDefault.NullToString(user.idNationIDType, "1");
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

            fileurl.Value = TypeChangeDefault.NullToString(user.cHealthUrl, "");
            if (fileurl.Value.IndexOf(GetDir(CurrentUser.uId.ToString())) == -1)
            {
                fileurl.Value = "";
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
    protected void renext_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Response.Redirect("/Member/Login.aspx");
        }
        DBM1.tblMEMBER model = new DBM1.tblMEMBER();       
        if (name.Value.Trim().Length <= 0 || name.Value.Trim().Length > 32)
        {
            AlertHelper.JQAlert("姓名为空或超过限制！", false);
            return;
        }
        model.cName = name.Value.Trim();        
        model.idBlood = TypeChange.NullToInt(idBlood.SelectedValue, -1);//血型


        model.idEducation = TypeChange.NullToInt(ddlEducation.SelectedValue, 0);//学历
        model.idOccupation = Convert.ToInt32(idOccupation.SelectedValue);//职业       
        model.idNationIDType = TypeChange.NullToInt(ddlCard.SelectedValue, 1);//证件类型       
        if (ddlCard.SelectedValue == "1")
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
        //if (tjzmOrcszs.HasFile)
        //{
        //    string filename = tjzmOrcszs.FileName;
        //    string type = filename.Substring(filename.LastIndexOf(".") + 1);    //获取文件类型

        //    if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
        //    {
        //        string fileShort = "/" + CurrentUser.uId + "_zs." + type;
        //        HttpPostedFile file = tjzmOrcszs.PostedFile;
        //        if (UpPhotoSaveAs(file, GetDir(CurrentUser.uId.ToString()), fileShort))
        //        {                    
        //            model.cHealthUrl = GetDir(CurrentUser.uId.ToString()) + fileShort;
        //        }
        //        else
        //        {
        //            AlertHelper.JQAlert("上传错误，请重新上传！", false);
        //            return;
        //        }
        //    }
        //    else
        //    {
        //        AlertHelper.JQAlert("图片类型错误正确格式为jpg/gif/bmp/png", false);
        //        return;
        //    }
        //}
        model.cHealthUrl = Request.Form["fileurl"];
        model.id = CurrentUser.uId;
        if(new DB1.tblMEMBER().Update(model))
        {
            DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
            //if (!uMember_History.Exists(100800104, CurrentUser.uId))
            //{
            //    uMember_History.Insert(CurrentUser.uId, 100800104, 20);
            //}
            if (!uMember_History.Exists(100800104, CurrentUser.uId))
            {
                if (!uMember_History.Exists(200810007, CurrentUser.uId))
                {
                    new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200810007, 1, 0, 1);
                    //uMember_History.Insert(CurrentUser.uId, 1, 200800115, 0);
                    //uMember_History.Insert(idUser, 100800100, 10);
                }
            }
            //new DB1.tblMEMBER_HISTORY().Insert(CurrentUser.uId, 100800104, 20);
            Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().UpdateUserModel(CurrentUser.uId);
            Response.Redirect("Register3.aspx");
        }
        else
        {
            AlertHelper.JQAlert("保存失败", false);
            Response.Redirect("Login.aspx");
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