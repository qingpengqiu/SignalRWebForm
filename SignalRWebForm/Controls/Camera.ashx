<%@ WebHandler Language="C#" Class="Camera" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Text;
using System.Web.SessionState;
using Erun360.Model;
public class Camera : IHttpHandler, IReadOnlySessionState
{
    
    //protected const string Const_BaseDir = "/F/UserIcon/";
    
    public void ProcessRequest (HttpContext context) {
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            byte[] bytesurl = Encoding.ASCII.GetBytes(model.uId.ToString());
            byte[] hashValue = ((System.Security.Cryptography.HashAlgorithm)System.Security.Cryptography.CryptoConfig.CreateFromName("MD5")).ComputeHash(bytesurl);
            string hashurl = hashValue[0].ToString("x4");
            string pathFile = "/" + hashurl.Substring(0, 2) + "/" + hashurl.Substring(2, 2) + model.uId.ToString() + "/Head";
            string uid = context.Request.QueryString["input"];
            if (!string.IsNullOrEmpty(context.Request["Filename"]) && !string.IsNullOrEmpty(context.Request["Upload"]))
            {
                ResponseText(UploadTempAvatar(uid, pathFile));
            }
            if (!string.IsNullOrEmpty(context.Request["avatar1"]) && !string.IsNullOrEmpty(context.Request["avatar2"]) && !string.IsNullOrEmpty(context.Request["avatar3"]))
            {



                if (!(SaveAvatar("avatar1", pathFile) && SaveAvatar("avatar2", pathFile) && SaveAvatar("avatar3", pathFile)))
                {
                    //File.Delete(GetMapPath("images\\upload\\avatars\\" + uid + ".jpg"));
                    ResponseText("<?xml version=\"1.0\" ?><root><face success=\"0\"/></root>");
                    return;
                }
                return;
            }
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }



    private void ResponseText(string text)
    {
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.Write(text);
        HttpContext.Current.Response.End();
    }

    private string UploadTempAvatar(string uid, string BaseDir)
    {

        if (HttpContext.Current.Session["CurrentUser"] != null)
        {
            UserInfoModel model = HttpContext.Current.Session["CurrentUser"] as UserInfoModel;
            string filename = "/" + model.uId.ToString() + ".jpg";
            string uploadUrl = HostInfo.imgName + BaseDir;
            string uploadDir = GetMapPath(BaseDir);
            if (!Directory.Exists(uploadDir))
                Directory.CreateDirectory(uploadDir);

            if (HttpContext.Current.Request.Files.Count > 0)
            {
                HttpContext.Current.Request.Files[0].SaveAs(uploadDir + filename);
            }
       
        return uploadUrl + filename;
        }
        return "error";
    }
    private bool SaveAvatar(string avatar, string BaseDir)
    {
        
        byte[] b = FlashDataDecode(HttpContext.Current.Request[avatar]);
        if (b.Length == 0)
            return false;
        string size = "";
        if (avatar == "avatar1")
            size = "180";
        else if (avatar == "avatar2")
            size = "120";
        else
            size = "50";

        string sDir = GetMapPath(BaseDir);
        if (HttpContext.Current.Session["CurrentUser"] != null)
        {
            UserInfoModel model = HttpContext.Current.Session["CurrentUser"] as UserInfoModel;
            string sFileName = "/" + model.uId.ToString() + "_" + size + ".jpg";

            if (!Directory.Exists(sDir))
                Directory.CreateDirectory(sDir);


            string avatarFileName = sDir + sFileName;
            FileStream fs = new FileStream(avatarFileName, FileMode.Create);
            fs.Write(b, 0, b.Length);
            fs.Close();
            return true;
        }
        return false;
    }
    private byte[] FlashDataDecode(string s)
    {
        byte[] r = new byte[s.Length / 2];
        int l = s.Length;
        for (int i = 0; i < l; i = i + 2)
        {
            int k1 = ((int)s[i]) - 48;
            k1 -= k1 > 9 ? 7 : 0;
            int k2 = ((int)s[i + 1]) - 48;
            k2 -= k2 > 9 ? 7 : 0;
            r[i / 2] = (byte)(k1 << 4 | k2);
        }
        return r;
    }

    

    public static string GetRootUrl(string forumPath)
    {
        string ApplicationPath = HttpContext.Current.Request.ApplicationPath != "/" ? HttpContext.Current.Request.ApplicationPath : string.Empty;
        int port = HttpContext.Current.Request.Url.Port;
        return string.Format("{0}://{1}{2}{3}/{4}",
                             HttpContext.Current.Request.Url.Scheme,
                             HttpContext.Current.Request.Url.Host,
                             (port == 80 || port == 0) ? "" : ":" + port,
                             ApplicationPath,
                             forumPath);

    }

    public static string GetMapPath(string strPath)
    {
        if (HttpContext.Current != null)
        {
            return HttpContext.Current.Server.MapPath(strPath);
        }
        else //非web程序引用
        {
            strPath = strPath.Replace("/", "\\");
            if (strPath.StartsWith("\\"))
            {
                strPath = strPath.Substring(strPath.IndexOf('\\', 1)).TrimStart('\\');
            }
            return System.IO.Path.Combine(HostInfo.imgName , strPath);
        }
    }

}