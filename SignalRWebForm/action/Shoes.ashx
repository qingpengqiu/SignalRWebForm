<%@ WebHandler Language="C#" Class="Shoes" %>

using System;
using System.Web;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json.Linq;
using System.Text;
using System.Data;
public class Shoes : IHttpHandler
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
    /// 获取单个鞋的详细信息
    /// </summary>
    /// <param name="context"></param>
    public void GetShoe(HttpContext context)
    {
        int idShoe = TypeChangeDefault.NullToInt(context.Request["id"], 0);
        DBM5.tblShoes mshoe = new DB5.tblShoes().GetModel(idShoe);
        IsoDateTimeConverter iso = new IsoDateTimeConverter();
        iso.DateTimeFormat = "yyyy-MM-dd";
        context.Response.Write(JsonConvert.SerializeObject(mshoe, iso));
    }
    /// <summary>
    /// 获取单个鞋的详细信息
    /// </summary>
    /// <param name="context"></param>
    public void Seach(HttpContext context)
    {
        StringBuilder sb = new StringBuilder();
        //sb.Append(" 1=1 ");
        int idGender = TypeChangeDefault.NullToInt(context.Request["xb"], 0);//性别
        sb.Append(" idGender = " + idGender);

        string cBrand = TypeChangeDefault.NullToString(context.Request["zzs"], "0");//制造商
        if (cBrand != "0")
        {
            sb.Append(" and cBrand ='" + cBrand + "'");
        }

        string cName = TypeChangeDefault.NullToString(context.Request["mz"], "");//鞋的名字
        if (cName.Trim().Length > 0)
        {
            sb.Append(" and cName ='" + cName + "'");
        }
        string cSeries = TypeChangeDefault.NullToString(context.Request["xx"], "0");//鞋型      
        if ("0" != cSeries)
        {
            sb.Append(" and cSeries ='" + cSeries + "'");
        }
        //int fPrice = TypeChangeDefault.NullToInt(context.Request["sex"], 0);//价格
        string fPrice = TypeChangeDefault.NullToString(context.Request["jg"], "0");//价格 
        if ("0" != fPrice)
        {
            switch (fPrice)
            {
                case "1": sb.Append(" and  fPrice < 400 "); break;
                case "2": sb.Append(" and  fPrice between 400 and 600 "); break;
                case "3": sb.Append(" and  fPrice between 600 and 1000 "); break;              
                case "4": sb.Append(" and  fPrice >1000 "); break;
            }
        }
        string rHeel = TypeChangeDefault.NullToString(context.Request["zghc"], "0");//足跟缓冲
        if ("0" != rHeel)
        {
            switch (rHeel)
            {
                case "1": sb.Append(" and  rHeel < 20 "); break;
                case "2": sb.Append(" and  rHeel between 20 and 40 "); break;
                case "3": sb.Append(" and  rHeel between 40 and 60 "); break;
                case "4": sb.Append(" and  rHeel between 60 and 80 "); break;
                case "5": sb.Append(" and  rHeel >80 "); break;
            }
        }
        string rForefeet = TypeChangeDefault.NullToString(context.Request["qjzhc"], "0");//前脚掌缓冲
        if ("0" != rForefeet)
        {
            switch (rForefeet)
            {
                case "1": sb.Append(" and  rForefeet < 20 "); break;
                case "2": sb.Append(" and  rForefeet between 20 and 40 "); break;
                case "3": sb.Append(" and  rForefeet between 40 and 60 "); break;
                case "4": sb.Append(" and  rForefeet between 60 and 80 "); break;
                case "5": sb.Append(" and  rForefeet >80 "); break;
            }
        }

        string rStiffness = TypeChangeDefault.NullToString(context.Request["lhx"], "0");//灵活性
        if ("0" != rStiffness)
        {
            switch (rStiffness)
            {
                case "1": sb.Append(" and  rStiffness < 20 "); break;
                case "2": sb.Append(" and  rStiffness between 20 and 40 "); break;
                case "3": sb.Append(" and  rStiffness between 40 and 60 "); break;
                case "4": sb.Append(" and  rStiffness between 60 and 80 "); break;
                case "5": sb.Append(" and  rStiffness >80 "); break;
            }
        }

        string qhgc = TypeChangeDefault.NullToString(context.Request["qhgc"], "0");//前后跟差
        if ("0" != qhgc)//fHeel-fForefeet=0
        {
            switch (qhgc)
            {
                case "1": sb.Append(" and  fHeel-fForefeet =0 "); break;
                case "2": sb.Append(" and  fHeel-fForefeet between 0 and 4 "); break;
                case "3": sb.Append(" and  fHeel-fForefeet between 4 and 8 "); break;
                case "4": sb.Append(" and  fHeel-fForefeet between 8 and 12 "); break;
                case "5": sb.Append(" and  fHeel-fForefeet >12 "); break;
            }
        }

        string rStability = TypeChangeDefault.NullToString(context.Request["wdx"], "0");// 稳定性 
        if ("0" != rStiffness)
        {
            switch (rStiffness)
            {
                case "1": sb.Append(" and  rStability < 20 "); break;
                case "2": sb.Append(" and  rStability between 20 and 40 "); break;
                case "3": sb.Append(" and  rStability between 40 and 60 "); break;
                case "4": sb.Append(" and  rStability between 60 and 80 "); break;
                case "5": sb.Append(" and  rStability >80 "); break;
            }
        }
        string rWeight = TypeChangeDefault.NullToString(context.Request["zl"], "0");// 重量 
        if ("0" != rWeight)
        {
            switch (rWeight)
            {
                case "1": sb.Append(" and  rWeight < 20 "); break;
                case "2": sb.Append(" and  rWeight between 20 and 40 "); break;
                case "3": sb.Append(" and  rWeight between 40 and 60 "); break;
                case "4": sb.Append(" and  rWeight between 60 and 80 "); break;
                case "5": sb.Append(" and  rWeight >80 "); break;
            }
        }

        string rHeight = TypeChangeDefault.NullToString(context.Request["gd"], "0");// 重量 
        if ("0" != rWeight)
        {
            switch (rWeight)
            {
                case "1": sb.Append(" and  rHeight < 20 "); break;
                case "2": sb.Append(" and  rHeight between 20 and 40 "); break;
                case "3": sb.Append(" and  rHeight between 40 and 60 "); break;
                case "4": sb.Append(" and  rHeight between 60 and 80 "); break;
                case "5": sb.Append(" and  rHeight >80 "); break;
            }
        }
        //具体的页面数     
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 1);
        //页面显示条数
        int Pagesize = 20;
        DataTable dt = new DB5.tblShoes().GetListByPage(sb.ToString(), "id", pageIndex, Pagesize).Tables[0];
      
        //DBM5.tblShoes mshoe = new DB5.tblShoes().GetModel(idShoe);

        IsoDateTimeConverter iso = new IsoDateTimeConverter();
        iso.DateTimeFormat = "yyyy-MM-dd";
        context.Response.Write(JsonConvert.SerializeObject(dt, iso));
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}