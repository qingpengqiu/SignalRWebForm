using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DBM4 = Erun360.Model.DB4;
using Erun360.Common;
using DB4 = Erun360.BLL.DB4;
using System.Data;
using Utils;
public partial class Channels_Competetion_AddPhoto : PageBase
{
    public int id = 0;//赛事id
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        id = TypeChangeDefault.NullToInt(Request.QueryString["idcompete"], 0);
        if (id == 0)
        {
            AlertHelper.JQAlertGo("请选择赛事！", "/Channels/Competetion/RaceList.aspx", false);
            return;
        }
        if (!IsPostBack)
        {
            DBM4.tblRACE_SIGNUP mSign = new DB4.tblRACE_SIGNUP().GetCompeteModel(id);
            if (mSign != null)
            {
                ltlTitle.Text = mSign.cTitle;
                DBM4.tblRACE_SALES mSales = new DB4.tblRACE_SALES().GetModel(id, CurrentUser.uId);
                if (mSales != null)
                {
                    if (mSales.iState != 0)
                    {
                        Response.Redirect("/blog/" + mSign.idBlog + ".aspx");
                        return;
                    }
                }
                else
                {
                    AlertHelper.JQAlertGo("您还没有报名！", "/Channels/Competetion/RaceProject.aspx?idcompete=" + id, false);
                    return;
                }
                //int state = new DB4.tblRACE_SALES().GetState(CurrentUser.uId, id);
                //if (state == -2)
                //{
                //    AlertHelper.JQAlertGo("您还没有报名！", "/Channels/Competetion/RaceProject.aspx?idcompete=" + id, false);
                //    return;
                //}
                //else if (state !=0)
                //{
                //    AlertHelper.JQAlertGo("您还没有报名！", "/Channels/Competetion/RaceProject.aspx?idcompete=" + id, false);
                //    return;
                //}
                //DataTable dt = new DB4.tblRACE_SALES().GetList("idUser=" + CurrentUser.uId + " and idSignUp in(104,105,106,107) and iState=0").Tables[0];
                //if (dt.Rows.Count == 0)
                //{
                //    AlertHelper.JQAlertGo("您还没有报名！", "/Channels/Competetion/RaceProject.aspx?idcompete=" + id, false);
                //    return;
                //}

            }
            else
            {
                AlertHelper.JQAlertGo("访问错误！", "/Channels/Competetion/RaceList.aspx", false);
                return;
            }
        }
    }
    protected void btSubmit_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
         DBM4.tblRACE_SIGNUP mSign = new DB4.tblRACE_SIGNUP().GetCompeteModel(id);
         if (mSign != null)
         {
             DBM4.tblRACE_SALES mSales = new DB4.tblRACE_SALES().GetModel(id, CurrentUser.uId);
             if (mSales != null)
             {
                 if (mSales.iState != 0)
                 {
                     Response.Redirect("/blog/" + mSign.idBlog + ".aspx", true);
                     return;
                 }
                 else
                 {
                     DBM4.tblRACE_SALES modelsales = new DBM4.tblRACE_SALES();
                     if (fptjzm.HasFile)
                     {
                         string filename = fptjzm.FileName;
                         string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

                         if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
                         {
                             string fileShort = "/" + CurrentUser.uId + "_tjzm." + type;

                             HttpPostedFile file = fptjzm.PostedFile;
                             if (file.ContentLength > 51200000)
                             {
                                 AlertHelper.JQAlert("体检证明文件大小请不要超过5M！", false);
                                 return;
                             }
                             if (UpPhotoSaveAs(file, GetDir(CurrentUser.uId.ToString()), fileShort))
                             {
                                 string URL = GetDir(CurrentUser.uId.ToString()) + fileShort;
                                 modelsales.cMake = URL;
                             }
                             else
                             {
                                 AlertHelper.JQAlert("体检证明上传失败，请重新上传！", false);
                                 return;
                             }
                         }
                         else
                         {
                             AlertHelper.JQAlert("体检证明上传格式错误，请按重新上传！", false);
                             return;
                         }
                     }
                     else
                     {
                         AlertHelper.JQAlert("请上传体检证明！", false);
                     }
                     if (fpcjzs1.HasFile)
                     {
                         string filename = fpcjzs1.FileName;
                         string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

                         if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
                         {
                             string fileShort = "/" + CurrentUser.uId + "_zs1." + type;

                             HttpPostedFile file = fpcjzs1.PostedFile;
                             if (file.ContentLength > 51200000)
                             {
                                 AlertHelper.JQAlert("心电图文件大小请不要超过5M！", false);
                                 return;
                             }
                             if (UpPhotoSaveAs(file, GetDir(CurrentUser.uId.ToString()), fileShort))
                             {
                                 string URL = GetDir(CurrentUser.uId.ToString()) + fileShort;
                                 modelsales.cHealthUrl = URL;
                             }
                             else
                             {
                                 AlertHelper.JQAlert("心电图上传失败，请重新上传！", false);
                                 return;
                             }
                         }
                         else
                         {
                             AlertHelper.JQAlert("心电图上传格式错误，请重新上传！", false);
                             return;
                         }
                     }
                     else
                     {
                         AlertHelper.JQAlert("请上传心电图！", false);
                         return;
                     }
                     if (fpcjzs2.HasFile)
                     {
                         string filename = fpcjzs2.FileName;
                         string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

                         if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
                         {
                             string fileShort = "/" + CurrentUser.uId + "_cjzs." + type;

                             HttpPostedFile file = fpcjzs2.PostedFile;
                             if (file.ContentLength > 51200000)
                             {
                                 AlertHelper.JQAlert("成绩证书文件大小请不要超过5M！", false);
                                 return;
                             }
                             if (UpPhotoSaveAs(file, GetDir(CurrentUser.uId.ToString()), fileShort))
                             {
                                 string URL = GetDir(CurrentUser.uId.ToString()) + fileShort;
                                 modelsales.cOrigin = URL;
                             }
                             else
                             {
                                 AlertHelper.JQAlert("成绩证书上传失败，请重新上传！", false);
                                 return;
                             }
                         }
                         else
                         {
                             AlertHelper.JQAlert("成绩证书上传格式错误，请按重新上传！", false);
                             return;
                         }
                     }
                     else
                     {
                         AlertHelper.JQAlert("请上传成绩证书！", false);
                     }
                     modelsales.id = mSales.id;
                     if (new DB4.tblRACE_SALES().Update(modelsales))
                     {
                         AlertHelper.JQAlertGo("提交成功！", "/blog/" + mSign.idBlog + ".aspx", true);
                         return;
                     }
                     else
                     {
                         AlertHelper.JQAlert("提交失败！", false);
                         return;
                     }
                 }
             }
             else
             {
                 AlertHelper.JQAlertGo("您还没有报名！", "/Channels/Competetion/RaceProject.aspx?idcompete=" + id, false);
                 return;
             }
         }
         else
         {
             AlertHelper.JQAlertGo("访问错误！", "/Channels/Competetion/RaceList.aspx", false);
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