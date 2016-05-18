using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;

public partial class Admin_FocusmapEdit : PageBase
{
    private int id = 0;
    public string cImg = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.idMemberStyle < 13)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (Request.QueryString["id"] != null)
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
        }
        if (!IsPostBack)
        {
            if (id != 0)
            {
                DBM2.tblFocusmap mFocusmap = new DB2.tblFocusmap().GetModel(id);
                if (mFocusmap != null)
                {
                   
                    Idmsg.Value = mFocusmap.cTitle;                   
                    clink.Value = mFocusmap.cLink;
                    cImg = mFocusmap.cImageUrl;
                    state.SelectedIndex = mFocusmap.iStatus ?? 0;
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

        if (CurrentUser.idMemberStyle < 13)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        DBM2.tblFocusmap model = new DBM2.tblFocusmap();
        if (ggtp.HasFile)
        {
            string filename = ggtp.FileName;
            string type = filename.Substring(filename.LastIndexOf(".") + 1);    //获取文件类型

            if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
            {
                string hashdir = GetDir(CurrentUser.uId.ToString())+"/map";
                string f_pre = DateTime.Now.ToString("HHmmssfff");
                string fileShort = "/" + CurrentUser.uId + "_" + f_pre + "." + type;
                HttpPostedFile file = ggtp.PostedFile;
                if (UpPhotoSaveAs(file, hashdir, fileShort))
                {
                    model.cImageUrl = HostInfo.imgName + "/utility/uploads/" + hashdir + fileShort;
                }
                else
                {
                    AlertHelper.JQAlert("上传错误，请重新上传！", false);
                    return;
                }
            }
            else
            {
                AlertHelper.JQAlert("图片类型错误正确格式为jpg/gif/bmp/png", false);
                return;
            }
        }
        
        if (Idmsg.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填文字描述！", false);
            return;
        }
        else if (Idmsg.Value.Trim().Length > 1024)
        {
            AlertHelper.JQAlert("文字描述超出512汉字限制！", false);
            return;
        }
        model.cTitle = Idmsg.Value.Trim();

        model.cLink = TypeChangeDefault.NullToString(clink.Value.Trim(), "");
        model.iStatus = TypeChangeDefault.NullToInt(state.Value.Trim(), 0);
        model.idUser = CurrentUser.uId;
        model.dCreate = DateTime.Now;
        string CacheKey = "tblFocusmap";
        if (id != 0)
        {
            model.id = id;
            if (new DB2.tblFocusmap().Update(model))
            {
                Erun360.Common.DataCache.RemoveAllCache(CacheKey);
                AlertHelper.JQAlertGo("修改成功！", "FocusmapList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            if (new DB2.tblFocusmap().Add(model) > 0)
            {               
                Erun360.Common.DataCache.RemoveAllCache(CacheKey);
                AlertHelper.JQAlertGo("添加成功！", "FocusmapList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
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