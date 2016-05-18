<%@ WebHandler Language="C#" Class="GetPhoto" %>

using System;
using System.Web;
using System.Web.SessionState;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
public class GetPhoto : IHttpHandler, IReadOnlySessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        if (context.Request["m"] != null)
        {
            string command = context.Request["m"].ToString();
            System.Reflection.MethodInfo method = this.GetType().GetMethod(command);
            if (method != null)
            {
                method.Invoke(this, new object[] { context });
            }
        }
    }
    /// <summary>
    /// 相册首页
    /// </summary>
    /// <param name="context"></param>
    public void photo(HttpContext context)
    {
        //具体的页面数（索引）
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 0);
        //页面显示条数
        int Pagesize = 20;// TypeChangeDefault.NullToInt(context.Request["pz"], 20);      
        int recordCount = 0;
        if (pageIndex == 0)
        {
            pageIndex = 1;
        }
        System.Data.DataSet ds = null;
        ds = new DB3.tblPhoto().GetListByPage(" idparent=0 ", " idNo desc ", pageIndex, Pagesize, out recordCount);
        if (ds.Tables[0].Rows.Count > 0)
        {
            context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "],\"count\":" + recordCount + "}"));
        }
        else
        {
            //return ConvertJson.ToJson(ds).Replace("]}", "[],\"count\":" + recordCount + "}");
            context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "[],\"count\":" + recordCount + "}"));
        }
    }
    /// <summary>
    /// 第二级目录相册首页
    /// </summary>
    /// <param name="context"></param>
    public void photo2(HttpContext context)
    {
        //具体的页面数（索引）
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 0);
        //页面显示条数
        int Pagesize = 20;//TypeChangeDefault.NullToInt(context.Request["pz"], 20);
        //父节点 id
        int idNode = TypeChangeDefault.NullToInt(context.Request["f"], 20);
        int recordCount = 0;
        if (pageIndex == 0)
        {
            pageIndex = 1;
        }
        System.Data.DataSet ds = null;
        ds = new DB3.tblPhoto().GetListByPage(" idparent=" + idNode + " ", " idNo desc ", pageIndex, Pagesize, out recordCount);
        ds.Tables[0].Columns.Add("tag", typeof(string));
        int fid = 0;
        string fName = "赛事相册";
        string pName = "0";
        DBM3.tblPhoto mphoto= new DB3.tblPhoto().GetModel(idNode);
        if (mphoto != null)
        {
            fName = mphoto.cName;
            fid = mphoto.idparent??0;
            DBM3.tblPhoto fphoto = new DB3.tblPhoto().GetModel(fid);
            if (fphoto != null)
            {
                pName = fphoto.cName;
            }
        }
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < recordCount; i++)
            {
                int count = new DB3.tblPhoto().GetRecordCount("idparent=" + ds.Tables[0].Rows[i]["id"].ToString());
                if (count > 0)
                {
                    ds.Tables[0].Rows[i]["tag"] = "True";
                }
                //ds.Tables[0].Rows[i]["tag"] = new DB3.tblPhoto().f(Convert.ToInt32(ds.Tables[0].Rows[i]["id"]));
            }
               
            context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "],\"parent\":" + fid + ",\"pname\":\"" + pName + "\",\"name\":\"" + fName + "\",\"count\":" + recordCount + "}"));
        }
        else
        {
            //return ConvertJson.ToJson(ds).Replace("]}", "[],\"count\":" + recordCount + "}");
            context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "[],\"parent\":" + fid + ",\"pname\":\"" + pName + "\",\"name\":\"" + fName + "\",\"count\":" + recordCount + "}"));
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