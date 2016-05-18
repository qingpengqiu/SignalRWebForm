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
public partial class Admin_AdEdit : PageBase
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
                DBM2.tblAD mAD = new DB2.tblAD().GetModel(id);
                if (mAD != null)
                {
                    name.Value = mAD.cName;
                    Idmsg.Value = mAD.cWord;
                    lbtt.Text = mAD.cImageUrl;
                    clink.Value = mAD.cLink;
                    cImg = mAD.cImageUrl;
                    state.SelectedIndex = mAD.iState ?? 0;
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
        DBM2.tblAD mAD = new DBM2.tblAD();
        if (name.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填品牌名称！", false);
            return;
        }
        else if (name.Value.Trim().Length > 64)
        {
            AlertHelper.JQAlert("品牌名称超出64汉字限制！", false);
            return;
        }
        mAD.cName = TypeChangeDefault.NullToString(name.Value.Trim(), "");

        if (Idmsg.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写分词！", false);
            return;
        }
        else if (Idmsg.Value.Trim().Length > 1024)
        {
            AlertHelper.JQAlert("分词超出512汉字限制！", false);
            return;
        }
        mAD.cWord = Idmsg.Value.Trim();

        if (ggtp.HasFile)
        {
            string cImage = ggtp.FileName;
            string type = cImage.Substring(cImage.LastIndexOf(".") + 1);    //获取文件类型

            if (type == "jpg" || type == "gif" || type == "bmp" || type == "png")
            {
                string f_pre = DateTime.Now.ToString("HHmmss");
                string pathFile = DateTime.Now.ToString("yyyy-MM-dd");

                string fileShort = "/" + CurrentUser.uId + "_" + f_pre + "." + type;

                HttpPostedFile file = ggtp.PostedFile;
                UpPhotoSaveAs(file, pathFile, fileShort);
                mAD.cImageUrl = HostInfo.imgName + "/utility/uploads/" + pathFile + fileShort;
            }
            else
            {
                AlertHelper.JQAlert("广告图片类型错误，正确格式为jpg/gif/bmp/png");
                return;
            }
        }
        //else
        //{
        //    if (cImg.Trim().Length > 0)
        //    {
        //        mAD.cImageUrl = cImg;
        //    }
        //    else
        //    {
        //        mAD.cImageUrl = @"/Html/images/ypimg.png";
        //    }
        //}

        //if (state.SelectedIndex == 0)
        //{
        //    AlertHelper.JQAlert("请选择广告状态！", false);
        //    return;
        //}
        mAD.cLink = TypeChangeDefault.NullToString(clink.Value.Trim(), "");
        mAD.iState = TypeChangeDefault.NullToInt(state.Value.Trim(), 0);
        mAD.idUser = CurrentUser.uId;
        mAD.dCreate = DateTime.Now;
        if (id != 0)
        {
            mAD.id = id;
            if (new DB2.tblAD().Update(mAD))
            {
                UpdateAD();
                AlertHelper.JQAlertGo("修改成功！", "AdList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            //if (new DB3.tblRecom().GetRecordCount(" idUser=" + name.Value.Trim()) > 0)
            //{
            //    AlertHelper.JQAlert("该用户已存在！", false);
            //    return;
            //}

            if (new DB2.tblAD().Add(mAD) > 0)
            {
                UpdateAD();
                AlertHelper.JQAlertGo("添加成功！", "AdList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
            }
        }
    }
    private void UpPhotoSaveAs(HttpPostedFile uploadFile, string Path, string FileName)
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
    }
    /// <summary>
    /// 获取广告
    /// </summary>
    public static Dictionary<DBM2.tblAD, string[]> UpdateAD()
    {
        string CacheKey = "tblAD";
        Erun360.Common.DataCache.RemoveAllCache(CacheKey);
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);       
        if (objModel == null)
        {
            try
            {
                Dictionary<DBM2.tblAD, string[]> singleWord = new Dictionary<DBM2.tblAD, string[]>();
                //objModel = new DB2.tblAD().GetModelList(" and iState>0");
                List<DBM2.tblAD> adList = new DB2.tblAD().GetModelList(" and iState>0");
                foreach (DBM2.tblAD mAD in adList)
                {
                    //Regex regex = new Regex(@"|", RegexOptions.None);
                    string[] result = mAD.cWord.Split('|');
                    singleWord.Add(mAD, result);
                }
                objModel = singleWord;
                if (objModel != null)
                {
                    int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            catch { }
        }
        return (Dictionary<DBM2.tblAD, string[]>)objModel;

    }
}