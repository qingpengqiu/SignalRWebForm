<%@ WebHandler Language="C#" Class="fileUp" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using Erun360.Common;
using System.IO;
using Erun360.Model;
public class fileUp : IHttpHandler, IReadOnlySessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        //HttpPostedFile oFile = context.Request.Files["files"];
        if (context.Session["CurrentUser"] == null)
        {
            context.Response.Write("{\"msg\":\"您未登录，请登录\",\"status\":\"0\"}");
            return;
        }
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
        bool Thumb = false;
        string idHash = TypeChangeDefault.NullToString(context.Request["id"], "");//赛事id，用户id....
        int Thumbnail = TypeChangeDefault.NullToInt(context.Request["slt"], 0);//是否生产缩略图
        string ThumbName = TypeChangeDefault.NullToString(context.Request["size"], "");//截取文件大小
        int width = TypeChangeDefault.NullToInt(context.Request["w"], 0);//截取宽度
        int height = TypeChangeDefault.NullToInt(context.Request["h"], 0);//截取高度       
        if (idHash.Trim().Length == 0)//默认以当前登入用户id哈希路径
        {
            idHash = model.uId.ToString();

        }
        if (Thumb)
        {
            if (ThumbName.Trim().Length == 0)
            {
                context.Response.Write("[{ \"message\":\"缩略图大小不为空！\", \"status\":\"0\" }]");
                return;
            }
            if (width == 0)
            {
                context.Response.Write("[{ \"message\":\"缩略图宽度不为空！\", \"status\":\"0\" }]");
                return;
            }
            if (width == 0)
            {
                context.Response.Write("[{ \"message\":\"缩略图高度不为空！\", \"status\":\"0\" }]");
                return;
            }
        }
        string fName = TypeChangeDefault.NullToString(context.Request["filename"], "");//获取文件名称（针对中文处理）

        HttpPostedFile oFile = context.Request.Files["upload_file"];
        if (oFile != null && oFile.FileName != "")
        {
            if (oFile.ContentLength > 51200000)
            {
                context.Response.Write("[{ \"message\":\"文件大小请不要超过5M！\", \"status\":\"0\" }]");
                return;
            }
            string f_pre = string.Empty;
            string type = string.Empty;
            f_pre = idHash + "_" + DateTime.Now.ToString("yyyyMMddHHmmssfff");
            if (fName.Trim().Length > 0)
            {
                type = fName.Substring(fName.LastIndexOf(".") + 1).ToLower();    //获取文件类型
            }
            else
            {
                type = oFile.FileName.Substring(oFile.FileName.LastIndexOf(".") + 1).ToLower();    //获取文件类型

            }
            string FileName = f_pre + "." + type;

            if (type == "jpg" || type == "gif" || type == "bmp" || type == "png" || type == "swf")
            {
                string hashdir = GetHashDir(idHash);
                if (UpPhotoSaveAs(oFile, hashdir, FileName, "_" + ThumbName, Thumb, 300, 300, "Cut"))
                {
                    string URL = HostInfo.imgName + "/Utility/Uploads/" + hashdir + "/" + FileName;
                    context.Response.Write("[{\"status\":\"1\",\"message\":\"上传成功!\",\"url\":\"" + URL + "\"}]");
                    return;
                }
                else
                {
                    context.Response.Write("[{ \"message\":\"上传失败！\", \"status\":\"0\" }]");
                    return;
                }             
            }
            else
            {
                context.Response.Write("[{ \"message\":\"请上传图片格式文件！\", \"status\":\"0\" }]");
                return;
            }
        }
        else
        {
           
            string img = context.Request.Params["upload_file"];
            img = img.Substring(img.IndexOf("base64,") + 7);
            byte[] buffer = null;  
            buffer = Convert.FromBase64String(img);

            string hashdir = GetHashDir(idHash);
            SaveFile.FileSaveAsSoapClient picWebService = new SaveFile.FileSaveAsSoapClient();

            string f_pre = string.Empty;
            string type ="jpg";
            f_pre = idHash + "_" + DateTime.Now.ToString("yyyyMMddHHmmssfff");
            string FileName = f_pre + "." + type;
            bool flag = picWebService.UploadFile(buffer, hashdir, FileName);
            if (flag)
            {
                string URL = HostInfo.imgName + "/Utility/Uploads/" + hashdir + "/" + FileName;
                context.Response.Write("[{\"status\":\"1\",\"message\":\"上传成功!\",\"url\":\"" + URL + "\"}]");
                return;
            }
            else
            {
                context.Response.Write("[{ \"message\":\"上传失败！\", \"status\":\"0\" }]");
                return;
            }           
        }
    }
    /// <summary>
    /// 图片上传并生成自定义大小缩略图
    /// </summary>
    /// <param name="uploadFile">上传文件控件</param>
    /// <param name="Path">文件相对存储路径（哈希路径：/AF/17/）</param>
    /// <param name="FileName">上传文件名称（10000.jpg）</param>
    /// <param name="thumName">缩略图尺寸（也是缩略图名称10000_300.jpg）</param>
    /// <param name="Thumbnail">是否生成缩略图</param>
    /// <param name="width">缩略图宽度</param>
    /// <param name="height">缩略图高度</param>
    /// <param name="mode">按什么方式截取</param> 
    /// <returns></returns>
    private bool UpPhotoSaveAs(HttpPostedFile uploadFile, string Path, string FileName, string thumName, bool Thumbnail = false, int width = 0, int height = 0, string mode = "Cut")
    {
        HttpPostedFile face = uploadFile;
        //FileSaveAs picWebService = new FileSaveAs();

        SaveFile.FileSaveAsSoapClient picWebService = new SaveFile.FileSaveAsSoapClient();
        int upPhotoLength = face.ContentLength;
        byte[] PhotoArray = new Byte[upPhotoLength];
        Stream PhotoStream = face.InputStream;
        PhotoStream.Read(PhotoArray, 0, upPhotoLength);
        bool flag = picWebService.UploadFileAndThumbnail(PhotoArray, Path, FileName, thumName, Thumbnail, width, height, mode);
        //bool flag = picWebService.UploadFileAndThumbnail(PhotoArray, Path, FileName, "_300", true, 300, 300, "Cut");
        face.InputStream.Close();
        return flag;
    }
    /// <summary>
    /// 文件上传
    /// </summary>
    /// <param name="uploadFile"></param>
    /// <param name="Path"></param>
    /// <param name="FileName"></param>
    protected bool UpPhotoSaveAs(HttpPostedFile uploadFile, string Path, string FileName)
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
    /// <summary>
    /// 获取文件哈西目录
    /// </summary>
    /// <param name="uId"></param>
    /// <returns></returns>
    protected string GetHashDir(string uId)
    {
        string CacheKey = "FileDir-" + uId;
        object objModel = DataCache.GetCache(CacheKey);
        if (objModel == null)
        {
            try
            {
                string hashurl = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(uId, "MD5");
                string FileDir = hashurl.Substring(0, 2) + "/" + hashurl.Substring(2, 2);
                objModel = FileDir;
                if (objModel != null)
                {
                    int ModelCache = ConfigHelper.GetConfigInt("ModelCache");
                    DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            catch
            {
                objModel = "";
            }
        }

        return objModel.ToString();
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
