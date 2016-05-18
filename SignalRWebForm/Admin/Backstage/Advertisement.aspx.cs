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
using System.IO;
using ERUN360.Entity;

public partial class Admin_Backstage_Advertisement : PageBase
{
    public string portrait = string.Empty;
    public int sid = 0;
    public int id = 0;
    public string jdtt = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        //if (CurrentUser.idMemberStyle < 12)
        //{
        //    AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        //    return;
        //}
        // 马雪蛟
        if (CurrentUser.uId != 100015607 && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if(!IsPostBack)
        {
            ddlrace();
            if(id != 0)
            {
                DBM6.tblAdvert adt = new DB6.tblAdvert().GetModel(id);
                cName.Value = adt.cName;
                cPosition.SelectedValue = adt.cPosition.ToString();
                cLick.Value = adt.cLick;
                portrait = adt.cHead;
                iState.Value = adt.cState.ToString();
                dbegintime.Value = adt.begintime.ToString();
                dendtime.Value = adt.endtime.ToString();
                lbtt.Text = adt.cHead;
                cMack.Value = adt.cMack;
            }
        }
    }
    public void ddlrace()
    {
        DataSet ds = new DB6.tblAdvert_Nav_Config().GetAllList();

        cPosition.DataSource = ds;
        cPosition.DataTextField = "cName";
        cPosition.DataValueField = "id";
        cPosition.DataBind();
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (cName.Value == string.Empty)
        {
            AlertHelper.JQAlertGo("广告名称不能为空！!", "", false);
            return;
        }
        if(dbegintime.Value == string.Empty)
        {
            AlertHelper.JQAlertGo("开始时间不能为空！!", "", false);
            return;
        }
        if (dendtime.Value == string.Empty)
        {
            AlertHelper.JQAlertGo("结束时间不能为空！!", "", false);
            return;
        }
        DBM6.tblAdvert mdol = new DBM6.tblAdvert();

        //头图
        if (hdtt.HasFile)
        {
            string filename = hdtt.FileName;
            string type = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();    //获取文件类型

            if (type == "jpg" || type == "gif" || type == "bmp" || type == "png" || type == "swf")
            {
                string f_pre = DateTime.Now.ToString("HHmmssfff");
                string fileShort = CurrentUser.uId + "_" + f_pre + "." + type;
                //string ndme = DateTime.Now.ToString("yyyy") + "/" + DateTime.Now.ToString("MM") + "/" + DateTime.Now.ToString("dd") + "/";
                // hdtt.PostedFile.FileName;
                HttpPostedFile file = hdtt.PostedFile;
                if (file.ContentLength > 5242880)
                {
                    AlertHelper.JQAlert("文件大小请不要超过5M！", false);
                    return;
                }
                if (cMack.Value == "0" && type == "swf")
                {
                    AlertHelper.JQAlert("上传类型不匹配！", false);
                    return;
                }
                if (cMack.Value == "1" && type != "swf")
                {
                    AlertHelper.JQAlert("上传类型不匹配！", false);
                    return;
                }
                if (type == "swf")
                {
                    string savePath = "/Images/Flash/";
                    string path = Server.MapPath(savePath);
                    if (!System.IO.Directory.Exists(path))
                     {
                         System.IO.Directory.CreateDirectory(path);
                     }
                    string ned = DateTime.Now.ToString("yyMMddmmss") + hdtt.FileName;
                    path = path + "\\" + ned;
                     hdtt.SaveAs(path);//保存文件
                     mdol.cHead = HostInfo.wwwName + savePath + ned;
                }
                else if (UpPhotoSaveAs(file, GetDir(CurrentUser.uId.ToString()), fileShort))
                {
                    string URL = GetDir(CurrentUser.uId.ToString())+"/" + fileShort;

                    mdol.cHead = HostInfo.imgName + "/Utility/Uploads/" + URL;
                }
                else
                {
                    AlertHelper.JQAlert("上传失败，请重新上传！", false);
                    return;
                }
            }
            else
            {
                AlertHelper.JQAlert("上传错误，请按要求重新上传！", false);
                return;
            }
        }
        else
        {
            mdol.cHead = lbtt.Text;
        }
        mdol.cMack = cMack.Value;
        if (id == 0)
        {
            mdol.cState = TypeChangeDefault.NullToInt(iState.Value, -1);
            mdol.cName = cName.Value;
            mdol.cLick = cLick.Value;
            //mdol.cHead = avatarurl.Value;
            mdol.cPosition = TypeChangeDefault.NullToInt(cPosition.SelectedValue, -1);
            mdol.begintime = TypeChangeDefault.NullToDateTime(dbegintime.Value, DateTime.Now);
            mdol.endtime = TypeChangeDefault.NullToDateTime(dendtime.Value, DateTime.Now);

            new DB6.tblAdvert().Add(mdol);
            AlertHelper.JQAlertGo("保存成功!", "Advertisementlb.aspx", true);
        }
        else
        {
            mdol.id = id;
            mdol.cState = TypeChangeDefault.NullToInt(iState.Value, -1);
            mdol.cName = cName.Value;
            mdol.cLick = cLick.Value;
            //mdol.cHead = avatarurl.Value;
            mdol.cPosition = TypeChangeDefault.NullToInt(cPosition.SelectedValue, -1);
            mdol.begintime = TypeChangeDefault.NullToDateTime(dbegintime.Value, DateTime.Now);
            mdol.endtime = TypeChangeDefault.NullToDateTime(dendtime.Value, DateTime.Now);

            new DB6.tblAdvert().Update(mdol);
            AlertHelper.JQAlertGo("修改成功!", "Advertisementlb.aspx", true);
        }
    }
    /// <summary>
    /// 获取文件哈西目录
    /// </summary>
    /// <param name="uId"></param>
    /// <returns></returns>
    protected string GetDir(string uId)
    {
        string CacheKey = "FileDir-" + uId;
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        if (objModel == null)
        {
            try
            {
                //byte[] bytesurl = Encoding.ASCII.GetBytes(uId);
                //byte[] hashValue = ((System.Security.Cryptography.HashAlgorithm)System.Security.Cryptography.CryptoConfig.CreateFromName("MD5")).ComputeHash(bytesurl);
                //string hashurl = hashValue[0].ToString("x4");
                string hashurl = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(uId, "MD5");
                string FileDir = hashurl.Substring(0, 2) + "/" + hashurl.Substring(2, 2);
                objModel = FileDir;
                if (objModel != null)
                {
                    int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            catch
            {
                objModel = "";
            }
        }

        return objModel.ToString();
    }
    public bool UpPhotoSaveAs(HttpPostedFile uploadFile, string Path, string FileName)
    {
        HttpPostedFile face = uploadFile;
        //FileSaveAs picWebService = new FileSaveAs();
        //Advertisem picWebService = new Advertisem();
        SaveFile.FileSaveAsSoapClient picWebService = new SaveFile.FileSaveAsSoapClient();
        int upPhotoLength = face.ContentLength;
        byte[] PhotoArray = new Byte[upPhotoLength];
        Stream PhotoStream = face.InputStream;
        PhotoStream.Read(PhotoArray, 0, upPhotoLength);
        bool flag = picWebService.UploadFile(PhotoArray, Path, FileName);
        face.InputStream.Close();
        return flag;
    }
    protected void cPosition_SelectedIndexChanged(object sender, EventArgs e)
    {
        string sql = @"select * from tblAdvert where begintime = (
SELECT     MIN(begintime) AS begintime
FROM         tblAdvert
WHERE begintime < '" + DateTime.Now + "' and '" + DateTime.Now + "' < endtime and cState =2 and cPosition =" + cPosition.SelectedValue + ")";
        DataTable ds = new DB6.tblAdvert().QueryByPage(sql, "cPosition =" + cPosition.SelectedValue + "", "cHead,cLick", 1, 10).Tables[0];
        if (ds.Rows.Count > 0)
        {
            DBM6.tblAdvert_Nav_Config dbc = new DB6.tblAdvert_Nav_Config().GetModel(TypeChangeDefault.NullToInt(cPosition.SelectedValue,0));
            cPlable.Text = "("+ "已存在广告"+", 上架时间:" + ds.Rows[0]["begintime"] + "--" + ds.Rows[0]["endtime"]+")";
            Label1.Text = "(图片大小：" + dbc.Width + "*" + dbc.Height + ")";
        }
    }
}