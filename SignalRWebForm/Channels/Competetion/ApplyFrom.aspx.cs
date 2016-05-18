using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DBM4 = Erun360.Model.DB4;
using Erun360.Common;
using DB4 = Erun360.BLL.DB4;
using System.IO;
public partial class Channels_Competetion_ApplyFrom : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
    }
    protected void btSumit_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DBM4.tblSelfServiceRace model = new DBM4.tblSelfServiceRace();
        int idtype = 0;
        string fshort = DateTime.Now.ToString("_yyMMddHHmmssfff_");
        model.idUser = CurrentUser.uId;
        if (person.Checked)
        {
            idtype = 0;           
            model.ikind = idtype;//个人发起
            if (cUserName.Value.Trim().Length > 64)
            {
                AlertHelper.JQAlert("名称超过64个汉字限制！", false);
                return;
            }
            model.cName = cUserName.Value.Trim();
            model.idNationIDType = TypeChange.NullToInt(ddlCard.SelectedValue, 1);//证件类型
            if (prependedDropdownButton.Value.Trim().Length > 22)
            {
                AlertHelper.JQAlert("证件号码超过22个字符限制！", false);
                return;
            }
            model.cNationID = prependedDropdownButton.Value.Trim();//证件号码
            if (mobile.Value.Trim().Length > 20)
            {
                AlertHelper.JQAlert("手机超过20个字符限制！", false);
                return;
            }
            model.cMobile = mobile.Value.Trim();//手机
            if (email.Value.Trim().Length > 60)
            {
                AlertHelper.JQAlert("邮箱超过60个字符限制！", false);
                return;
            }
            model.cMail = email.Value.Trim();//邮箱
            if (addressA.Value.Trim().Length > 120)
            {
                AlertHelper.JQAlert("邮寄地址超过120个汉字限制！", false);
                return;
            }
            model.cAddress = addressA.Value.Trim();//邮寄地址          
            //model.cBackUrl = email.Value.Trim();//邮箱
            if (FileFace.HasFile)
            {
                string filename = FileFace.FileName;
                string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

                if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
                {
                    //string fileShort = "/" + CurrentUser.uId + "_zm." + type;
                    string fileShort = "/" + CurrentUser.uId + fshort +"zm." +type;
                    HttpPostedFile file = FileFace.PostedFile;
                    if (file.ContentLength > 51200000)
                    {
                        AlertHelper.JQAlert("证件正面文件大小请不要超过5M！", false);
                        return;
                    }
                    if (UpPhotoSaveAs(file, GetDir(CurrentUser.uId.ToString()), fileShort))
                    {
                        string URL = GetDir(CurrentUser.uId.ToString()) + fileShort;                      
                        model.cFaceUrl = URL;//邮箱
                    }
                    else
                    {
                        AlertHelper.JQAlert("证件正面上传失败，请重新上传！", false);
                        return;
                    }
                }
                else
                {
                    AlertHelper.JQAlert("证件正面上传格式错误，请重新上传！", false);
                    return;
                }
            } //证件正面
            else
            {
                AlertHelper.JQAlert("请上传证件正面！", false);
                return;
            }

            if (FileBack.HasFile)
            {
                string filename = FileBack.FileName;
                string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

                if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
                {
                    string fileShort = "/" + CurrentUser.uId + fshort + "fm." + type;
                    HttpPostedFile file = FileBack.PostedFile;
                    if (file.ContentLength > 51200000)
                    {
                        AlertHelper.JQAlert("证件反面文件大小请不要超过5M！", false);
                        return;
                    }
                    if (UpPhotoSaveAs(file, GetDir(CurrentUser.uId.ToString()), fileShort))
                    {
                        string URL = GetDir(CurrentUser.uId.ToString()) + fileShort;
                        model.cBackUrl = URL;//邮箱
                    }
                    else
                    {
                        AlertHelper.JQAlert("证件反面上传失败，请重新上传！", false);
                        return;
                    }
                }
                else
                {
                    AlertHelper.JQAlert("证件反面上传格式错误，请重新上传！", false);
                    return;
                }
            } //证件反面
            else
            {
                AlertHelper.JQAlert("请上传证件反面！", false);
                return;
            }
            if (idPMark.Value.Trim().Length > 250)
            {
                AlertHelper.JQAlert("个人备注说明超过250个汉字限制！", false);
                return;
            }
            model.cMemo = idPMark.Value.Trim();
        }
        else if (Company.Checked)
        {
            idtype = 1;//公司发起
            model.ikind = idtype;
            if (CompanyName.Value.Trim().Length > 120)
            {
                AlertHelper.JQAlert("公司名称超过120个汉字限制！", false);
                return;
            }
            model.cName = CompanyName.Value.Trim();
            if (Companyaddress.Value.Trim().Length > 120)
            {
                AlertHelper.JQAlert("住所超过120个汉字限制！", false);
                return;
            }
            model.cAddress = Companyaddress.Value.Trim();//邮寄地址
            //model.cLegalPerson  法人
            if (CompanyType.Value.Trim().Length > 120)
            {
                AlertHelper.JQAlert("公司类型超过120个汉字限制！", false);
                return;
            }
            model.cType = CompanyType.Value.Trim();//公司类型
            if (CompanyScope.Value.Trim().Length > 250)
            {
                AlertHelper.JQAlert("经营范围超过250个汉字限制！", false);
                return;
            }
            model.cScope = CompanyScope.Value.Trim();//经营范围
            if (CompanyTelephone.Value.Trim().Length > 21)
            {
                AlertHelper.JQAlert("座机超过21个字符限制！", false);
                return;
            }
            model.cTelephone = CompanyTelephone.Value.Trim();//座机
            if (CompanyHeader.Value.Trim().Length > 16)
            {
                AlertHelper.JQAlert("负责人超过16个汉字限制！", false);
                return;
            }
            model.cHeader = CompanyHeader.Value.Trim();//负责人
            if (CompanyMobile.Value.Trim().Length > 20)
            {
                AlertHelper.JQAlert("联系方式超过20个字符限制！", false);
                return;
            }
            model.cMobile = CompanyMobile.Value.Trim();//联系方式
           
            if (CompanyFileFace.HasFile)
            {
                string filename = CompanyFileFace.FileName;
                string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

                if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
                {
                    //string fileShort = "/" + CurrentUser.uId + "_zm." + type;
                    string fileShort = "/" + CurrentUser.uId + fshort + "zm." + type;
                    HttpPostedFile file = CompanyFileFace.PostedFile;
                    if (file.ContentLength > 51200000)
                    {
                        AlertHelper.JQAlert("证件正本文件大小请不要超过5M！", false);
                        return;
                    }
                    if (UpPhotoSaveAs(file, GetDir(CurrentUser.uId.ToString()), fileShort))
                    {
                        string URL = GetDir(CurrentUser.uId.ToString()) + fileShort;
                        model.cFaceUrl = URL;//邮箱
                    }
                    else
                    {
                        AlertHelper.JQAlert("证件正本上传失败，请重新上传！", false);
                        return;
                    }
                }
                else
                {
                    AlertHelper.JQAlert("证件正本上传格式错误，请重新上传！", false);
                    return;
                }
            } //证件正面
            else
            {
                AlertHelper.JQAlert("请上传证件正本！", false);
                return;
            }

            if (CompanyFileBack.HasFile)
            {
                string filename = CompanyFileBack.FileName;
                string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

                if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
                {
                    string fileShort = "/" + CurrentUser.uId + fshort + "fm." + type;
                    HttpPostedFile file = CompanyFileBack.PostedFile;
                    if (file.ContentLength > 51200000)
                    {
                        AlertHelper.JQAlert("证件副本文件大小请不要超过5M！", false);
                        return;
                    }
                    if (UpPhotoSaveAs(file, GetDir(CurrentUser.uId.ToString()), fileShort))
                    {
                        string URL = GetDir(CurrentUser.uId.ToString()) + fileShort;
                        model.cBackUrl = URL;//邮箱
                    }
                    else
                    {
                        AlertHelper.JQAlert("证件副本上传失败，请重新上传！", false);
                        return;
                    }
                }
                else
                {
                    AlertHelper.JQAlert("证件副本上传格式错误，请重新上传！", false);
                    return;
                }
            } //证件反面
            else
            {
                AlertHelper.JQAlert("请上传证件副本！", false);
                return;
            }
        }

        if (RaceTitle.Value.Trim().Length > 120)
        {
            AlertHelper.JQAlert("赛事名称超过120个汉字限制！", false);
            return;
        }
        model.cRaceTitle = RaceTitle.Value.Trim();//赛事名称
        model.dRacetime = TypeChangeDefault.NullToDateTime(RaceTime.Value.Trim(), DateTime.Now);//时间
        if (RaceAddress.Value.Trim().Length > 250)
        {
            AlertHelper.JQAlert("赛事地点超过250个汉字限制！", false);
            return;
        }
        model.cRaceAddress = RaceAddress.Value.Trim();//地点
        if (RaceType.Value.Trim().Length > 250)
        {
            AlertHelper.JQAlert("活动类型超过250个汉字限制！", false);
            return;
        }
        model.cStyle = RaceType.Value.Trim();//活动类型
        model.iScale = TypeChange.NullToInt(RaceNum.Value.Trim(), 0);//预计规模
        if (RaceContent.Text.Trim().Length > 1000)
        {
            AlertHelper.JQAlert("参赛包内容超过1000个汉字限制！", false);
            return;
        }
        model.cRacepack = RaceContent.Text.Trim();//参赛包内容       
        model.tRegulation = RaceRules.Text.Trim();//具体规程上传
        //model.cRaceTitle = RaceTitle.Value.Trim();//赛事宣传图片
        if (RaceFile.HasFile)
        {
            string filename = RaceFile.FileName;
            string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

            if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
            {
                //string fileShort = "/" + CurrentUser.uId + "_zm." + type;
                string fileShort = "/" + CurrentUser.uId + fshort + "xcp." + type;
                HttpPostedFile file = RaceFile.PostedFile;
                if (file.ContentLength > 51200000)
                {
                    AlertHelper.JQAlert("赛事宣传图片文件大小请不要超过5M！", false);
                    return;
                }
                if (UpPhotoSaveAs(file, GetDir(CurrentUser.uId.ToString()), fileShort))
                {
                    string URL = GetDir(CurrentUser.uId.ToString()) + fileShort;
                    model.cSRacePicUrl = URL;//邮箱
                }
                else
                {
                    AlertHelper.JQAlert("赛事宣传图片上传失败，请重新上传！", false);
                    return;
                }
            }
            else
            {
                AlertHelper.JQAlert("赛事宣传图片上传格式错误，请重新上传！", false);
                return;
            }
        } //证件正面
        else
        {
            AlertHelper.JQAlert("请上传赛事宣传图片！", false);
            return;
        }
        if (RaceMark.Text.Trim().Length > 250)
        {
            AlertHelper.JQAlert("赛事备注备注超过250个汉字限制！", false);
            return;
        }
        model.cMark = RaceMark.Text.Trim();//备注说明
        model.iStatus = 1;
        int  result=  new DB4.tblSelfServiceRace().Add(model);
        if (result > 0)
        {
            AlertHelper.JQAlertGo("您的赛事资料已提交成功，请等待审核", "/Channels/Competetion/RaceList.aspx", true);
            return;
        }
        else
        {
            AlertHelper.JQAlert("您的赛事资料已提交失败，请重新提交！", false);
            return;
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