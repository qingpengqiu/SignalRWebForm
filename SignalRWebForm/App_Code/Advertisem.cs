using System;
using System.Web;
using System.Web.SessionState;
using Newtonsoft.Json;
using Erun360.Model;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using System.Data;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Collections;
using System.Text;
using Newtonsoft.Json.Converters;
using System.Web.Services;
using System.IO;

namespace ERUN360.Entity
{
    /// <summary>
    /// Advertisem 的摘要说明
    /// </summary>
    /// 
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class Advertisem
    {
        public string Advert(int id)
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
            StringBuilder sb = new StringBuilder();
            //Hashtable googd = new Hashtable();
            //List<Hashtable> gameList = new List<Hashtable>();
            string str = string.Empty;
            string sql = @"select cPosition,cHead,cLick from tblAdvert where begintime = ( SELECT     MIN(begintime) AS begintime FROM         tblAdvert WHERE cPosition =" + id + " and begintime < '" + DateTime.Now + "' and '" + DateTime.Now + "' < endtime and cState =2 )";
            if (id > 0)
            {
                DataTable ds = new DB6.tblAdvert().QueryByPage(sql, "cPosition =" + id + "", "cHead,cLick", 1, 10).Tables[0];
                //DataTable ds = new DB6.tblAdvert().QueryByPage(("begintime < '" + DateTime.Now + "' and '" + DateTime.Now + "' < endtime and cState =2 and cPosition =" + id).Tables[0];
                DBM6.tblAdvert_Nav_Config modl = new DB6.tblAdvert_Nav_Config().GetModel(id);
                
                    //for (int 0 = 0; 0 < ds.Rows.Count; 0++)
                    //{
                if (ds.Rows.Count > 0)
                {
                    str = ds.Rows[0]["cHead"].ToString().Substring(ds.Rows[0]["cHead"].ToString().LastIndexOf(".") + 1);

                    if (str != "swf")
                    {
                        sb.Append("<div class=\"gg\"><a href=\"" + ds.Rows[0]["cLick"].ToString() + "\" target=\"_blank\"><img src=\"" + ds.Rows[0]["cHead"].ToString() + "\"></a></div>");
                    }
                    else
                    {
                        if (modl != null)
                        {
                            sb.Append("<div class=\"gg\"><embed src=\"" + ds.Rows[0]["cHead"].ToString() + "\" width=\"" + modl.Width + "\" height=\"" + modl.Height + "\"></embed></div>");
                        }
                    }
                    //gameList.Add(googd);
                    //}

                    return sb.ToString();
                }
                else
                {
                    return "";
                }
            }
            else
            {
                return "";
            }
        }

        //[WebMethod(Description = "Web 服务提供的方法，返回是否文件上载成功与否。")]
        //public bool UploadFile(byte[] fs, string SavePath, string FileName)
        //{

        //    //string path = @"D:\test4\ueditor\net\";//System.Configuration.ConfigurationSettings.AppSettings["PicPath"].ToString();
        //    string path = System.Configuration.ConfigurationManager.AppSettings["imgPath"];
        //    try
        //    {
        //        //判断类型  
        //        string picName = FileName;
        //        string fileType = "";
        //        fileType = picName.Substring(picName.LastIndexOf("."), picName.Length - picName.LastIndexOf(".")).ToLower();
        //        if (fileType != ".jpg" && fileType != ".gif" && fileType != ".jpeg" && fileType != ".png")
        //        {
        //            if (fileType != ".swf")
        //            {
        //                return false;
        //            }
        //        }

        //        string fullPath = path + "\\" + SavePath;

        //        if (!System.IO.Directory.Exists(fullPath))
        //            System.IO.Directory.CreateDirectory(fullPath);


        //        ///定义并实例化一个内存流，以存放提交上来的字节数组。  
        //        MemoryStream m = new MemoryStream(fs);

        //        ///定义实际文件对象，保存上载的文件。  
        //        FileStream f = new FileStream(fullPath + "\\" + FileName, FileMode.Create);

        //        ///把内内存里的数据写入物理文件  
        //        m.WriteTo(f);
        //        m.Close();
        //        f.Close();
        //        f = null;
        //        m = null;
        //        return true;
        //    }
        //    catch
        //    {
        //        return false;
        //    }
        //}
    }
}