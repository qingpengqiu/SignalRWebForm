<%@ WebHandler Language="C#" Class="fileupload" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using Erun360.Common;
using System.IO;
using Erun360.Model;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
public class fileupload : IHttpHandler, IReadOnlySessionState
{
    private static readonly object SequenceLock = new object();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.Charset = "utf-8";
        if (context.Session["CurrentUser"] == null)
        {
            context.Response.Write("{\"link\": \"\"}");
            return;
        }
        var files = context.Request.Files;
        if (files.Count <= 0) { return; }
        HttpPostedFile oFile = files[0];
        if (oFile == null)
        {
            context.Response.Write("{\"link\": \"\"}");
            return;
        }
        // 这里用锁的机制，提高并发控制能力
        lock (SequenceLock)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            String fileExt = System.IO.Path.GetExtension(HttpUtility.UrlDecode(oFile.FileName)).ToLower();
            if (oFile != null)
            {
                if (oFile.ContentLength > 2048000)
                {
                    context.Response.Write("{\"link\": \"\"}");
                    return;
                }
                Random rand = new Random ();
                string FileName = DateTime.Now.ToString("yyyyMMddHHmmssfff") + rand.Next(0, 100) + fileExt;
                if (fileExt == ".jpg" || fileExt == ".gif" || fileExt == ".bmp" || fileExt == ".png" || fileExt == ".swf")
                {
                    string hashdir = GetHashDir(model.uId.ToString());
                    if (UpPhotoSaveAs(oFile, hashdir, FileName, "_134", true, 134, 0, "W"))
                    {
                      
                        string URL = HostInfo.imgName + "/Utility/Uploads/" + hashdir + "/" + FileName;
                        string thumb = URL.Insert(URL.LastIndexOf('.'), "_134");
                        DB3.tblIMAGES imgBll = new DB3.tblIMAGES();
                        DBM3.tblIMAGES imgModel = new DBM3.tblIMAGES();
                        imgModel.idUser = model.uId;
                        imgModel.idInfo = 0;
                        imgModel.cImageUrl = URL;
                        imgModel.cThumbUrl = thumb;
                        imgModel.dCreate = DateTime.Now;
                        imgBll.Add(imgModel);
                       
                        context.Response.Write("{\"link\": \"" + URL + "\"}");
                        return;
                    }
                    else
                    {
                        context.Response.Write("{\"link\": \"\"}");
                        return;
                    }
                }
                else
                {
                    context.Response.Write("{\"link\": \"\"}");
                    return;
                }
            }
            else
            {
                context.Response.Write("{\"link\": \"\"}");
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
