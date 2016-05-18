<%@ WebHandler Language="C#" Class="Upload" %>

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using Erun360.Model;
using System.Text;
using System.Web.SessionState;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
public class Upload : IHttpHandler, IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        Result result = new Result();
        result.avatarUrls = new System.Collections.ArrayList();
        result.success = false;
        result.msg = "Failure!";
        if (context.Request.Files.Count > 0)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            byte[] bytesurl = Encoding.ASCII.GetBytes(model.uId.ToString());
            byte[] hashValue = ((System.Security.Cryptography.HashAlgorithm)System.Security.Cryptography.CryptoConfig.CreateFromName("MD5")).ComputeHash(bytesurl);
            string hashurl = hashValue[0].ToString("x4");
            string pathbase = "/" + hashurl.Substring(0, 2) + "/" + hashurl.Substring(2, 2) + "/" + context.Request.QueryString["u"].Split('|')[0].Trim() + "/";
            //String pathbase = DateTime.Now.ToString("yyyy-MM-dd") + "/";
            //遍历所有文件域
            foreach (string fieldName in context.Request.Files.AllKeys)
            {
                HttpPostedFile file = context.Request.Files[fieldName];
                //原始图片(file 域的名称：__source，如果客户端定义可以上传的话，可在此处理）。
                if (fieldName == "__source")
                {
                    result.sourceUrl = pathbase + context.Request.QueryString["u"].Split('|')[1].Trim() + ".jpg";
                    UpPhotoSaveAs(file, pathbase, context.Request.QueryString["u"].Split('|')[1].Trim() + ".jpg");
                }
                //头像图片(file 域的名称：__avatar1,2,3...)。
                else if (fieldName == "__avatar1")
                {
                    //string virtualPath = string.Format("/upload/csharp_avatar{0}_{1}.jpg", avatarNumber, fileName);
                    string virtualPath = string.Format(pathbase + "{0}_{1}.jpg", context.Request.QueryString["u"].Split('|')[1].Trim(), 150);
                    result.avatarUrls.Add(virtualPath);
                    UpPhotoSaveAs(file, pathbase, context.Request.QueryString["u"].Split('|')[1].Trim() + "_150.jpg");
                }
                else if (fieldName == "__avatar2")
                {
                    //string virtualPath = string.Format("/upload/csharp_avatar{0}_{1}.jpg", avatarNumber, fileName);
                    string virtualPath = string.Format(pathbase + "{0}_{1}.jpg", context.Request.QueryString["u"].Split('|')[1].Trim(), 50);
                    result.avatarUrls.Add(virtualPath);
                    UpPhotoSaveAs(file, pathbase, context.Request.QueryString["u"].Split('|')[1].Trim() + "_50.jpg");
                }
                else if (fieldName == "__avatar3")
                {
                    //string virtualPath = string.Format("/upload/csharp_avatar{0}_{1}.jpg", avatarNumber, fileName);
                    string virtualPath = string.Format(pathbase + "{0}_{1}.jpg", context.Request.QueryString["u"].Split('|')[1].Trim(), 32);
                    result.avatarUrls.Add(virtualPath);
                    UpPhotoSaveAs(file, pathbase, context.Request.QueryString["u"].Split('|')[1].Trim() + "_32.jpg");
                }
            }
            DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
            if (!uMember_History.Exists(200810006, model.uId))
                {
                    new DB1.tblIntegral().InsertScore(model.uId, 200810006, 1, 0, 1);
                }
            result.success = true;
            result.msg = "Success!";
            //返回图片的保存结果（返回内容为json字符串，可自行构造，该处使用Newtonsoft.Json构造）
            context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(result));


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
    /**
     * 重命名文件
     * @return string
     */
    private string reName(HttpPostedFile uploadFile)
    {
        return System.Guid.NewGuid() + getFileExt(uploadFile);
    }
    /**
     * 获取文件扩展名
     * @return string
     */
    private string getFileExt(HttpPostedFile uploadFile)
    {
        string[] temp = uploadFile.FileName.Split('.');
        return "." + temp[temp.Length - 1].ToLower();
    }
    public bool IsReusable {
        get {
            return false;
        }
    }
    /// <summary>
    /// 表示图片的上传结果。
    /// </summary>
    private struct Result
    {
        /// <summary>
        /// 表示图片是否已上传成功。
        /// </summary>
        public bool success;
        /// <summary>
        /// 自定义的附加消息。
        /// </summary>
        public string msg;
        /// <summary>
        /// 表示原始图片的保存地址。
        /// </summary>
        public string sourceUrl;
        /// <summary>
        /// 表示所有头像图片的保存地址，该变量为一个数组。
        /// </summary>
        public System.Collections.ArrayList avatarUrls;
    }
}