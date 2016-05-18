<%@ WebHandler Language="C#" Class="AD" %>

using System;
using System.Web;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Collections;
using Erun360.Common;
public class AD : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        int idBlog = TypeChangeDefault.NullToInt(context.Request["b"], 0);
        //int classify = TypeChangeDefault.NullToInt(context.Request["t"], 99);
        DBM2.tblBLOG mBlog = new DB2.tblBLOG().GetModel(idBlog);
        Hashtable RaceInfo = null;
        List<Hashtable> RaceInfoList = new List<Hashtable>();
        Dictionary<DBM2.tblAD, string[]> singleWord = GetAD();
        if (mBlog != null)
        {
            string classify = mBlog.idHref.ToString().Substring(0, 1);
            if ("0" == classify || "5" == classify)
            {
                foreach (var item in singleWord)
                {
                    if (item.Value.Length > 0)
                    {
                        for (int i = 0; i < item.Value.Length; i++)
                        {
                            //item.Value[i].ToLower().Trim();
                            Regex r = new Regex(item.Value[i].Trim(),RegexOptions.IgnoreCase); // 定义一个Regex对象实例 

                            Match m = r.Match(HTMLHelper.NoHTML(HTMLHelper.NoHTML(mBlog.cContent))); // 在字符串中匹配 
                            
                            if (m.Success)
                            {
                                RaceInfo = new Hashtable();
                                RaceInfo.Add("name", item.Key.cName);//类型
                                RaceInfo.Add("Img", item.Key.cImageUrl);//类型
                                RaceInfo.Add("Url", item.Key.cLink);//类型
                                //Console.WriteLine("Found match at position " + m.Index); //输入匹配字符的位置 
                                RaceInfoList.Add(RaceInfo);
                                break;
                            } 
                        }
                    }
                }

                //List<DBM2.tblAD> adList = new DB2.tblAD().GetModelList(" and iState>0");
                //foreach (DBM2.tblAD mAD in adList)
                //{
                //    Regex regex = new Regex(@"|", RegexOptions.None);
                //    string[] result = regex.Split(mAD.cWord);
                //    if(result.Length>0)
                //    {
                //        for (int i = 0; i < result.Length; i++)
                //        {
                //            result[0].ToLower().Trim()

                //        }   
                //    }
                //    singleWord.Add(mAD, result);
                //}
                //mBlog.cContent

            }
        }
        
        string rusoult = Newtonsoft.Json.JsonConvert.SerializeObject(RaceInfoList);
        context.Response.Write(rusoult.Replace("[", "{\"ds\":[").Replace("]", "]}"));
        //if (RaceInfo != null)
        //{
        //    context.Response.Write(rusoult.Replace("[", "{\"ds\":["));
        //}
        //else
        //    context.Response.Write(rusoult);
        //context.Response.Write("Hello World");
    }
    /// <summary>
    /// 获取广告
    /// </summary>
    public static Dictionary<DBM2.tblAD, string[]> GetAD()
    {
        string CacheKey = "tblAD";
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        //objModel = null;
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
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}