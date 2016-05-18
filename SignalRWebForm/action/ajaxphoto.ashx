<%@ WebHandler Language="C#" Class="ajaxphoto" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
using Newtonsoft.Json;
using Erun360.Model;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using System.Collections;
using System.Collections.Generic;
using Newtonsoft.Json.Converters;

public class ajaxphoto : IHttpHandler, IReadOnlySessionState
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        if (context.Request["op"] != null)
        {
            string command = context.Request["op"].ToString();
            System.Reflection.MethodInfo method = this.GetType().GetMethod(command);
            if (method != null)
            {
                method.Invoke(this, new object[] { context });
            }
        }
    }
    /// <summary>
    /// 获取我的相册
    /// </summary>
    /// <param name="context"></param>
    public void getphoto(HttpContext context)
    {
        string result = string.Empty;
        int cid = 0;
        if (context.Session["CurrentUser"] != null)
        {
             UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
             cid = user.uId;
        }
       
      
        DB3.tblIMAGES uImg = new DB3.tblIMAGES();
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 1);//当前页数        
        int Pagesize = 20;//显示条数
        DataTable dt = uImg.GetListByPage("idUser =" + cid, "dCreate desc", pageIndex, Pagesize).Tables[0];
        Hashtable item = null;
        List<Hashtable> items = new List<Hashtable>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            item = new Hashtable();
            item.Add("id", dt.Rows[i]["id"].ToString());
            item.Add("url", dt.Rows[i]["cImageUrl"].ToString());
            if (dt.Rows[i]["cThumbUrl"].ToString().Trim().Length > 0)
            {
                item.Add("thumb", dt.Rows[i]["cImageUrl"].ToString());
            }
            else
            {
                item.Add("thumb", dt.Rows[i]["cThumbUrl"].ToString());
            }
            item.Add("name", "");
            item.Add("type", "image");
            items.Add(item);
        }

        context.Response.Write(JsonConvert.SerializeObject(items));
    }
    /// <summary>
    /// 删除相册
    /// </summary>
    /// <param name="context"></param>
    public void delphoto(HttpContext context)
    {
        string result = string.Empty;
        int cid = 0;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
            cid = user.uId;
        }
        int id = TypeChangeDefault.NullToInt(context.Request["id"], 0);
        DB3.tblIMAGES bll = new DB3.tblIMAGES();
        int count = bll.GetRecordCount("idUser=" + cid + "  and id=" + id);
        if (count > 0)
        {
            bll.Delete(id);
            context.Response.Write("1");
        }
        else
        {
            context.Response.Write("0");
        }
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}