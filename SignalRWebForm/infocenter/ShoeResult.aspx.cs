using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
public partial class infocenter_ShoeResult : System.Web.UI.Page
{
    public string Result = string.Empty;
    public int pageIndex = 1;
    public int RecordCount =0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            StringBuilder sb = new StringBuilder();
            int idGender = TypeChangeDefault.NullToInt(Request.QueryString["xb"], 0);//性别
            sb.Append(" idGender = " + idGender);

            string cBrand = TypeChangeDefault.NullToString(Request.QueryString["zzs"], "0");//制造商
            if (cBrand != "0")
            {
                sb.Append(" and cBrand ='" + cBrand + "'");
            }

            string cName = TypeChangeDefault.NullToString(Request.QueryString["mz"], "");//鞋的名字
            if (cName.Trim().Length > 0)
            {
                sb.Append(" and cName ='" + cName + "'");
            }
            string cType = TypeChangeDefault.NullToString(Request.QueryString["xx"], "0");//鞋型      
            if ("0" != cType)
            {
                switch (cType)
                {
                    case "1": sb.Append(" and  cType='公路'"); break;
                    case "2": sb.Append(" and  cType='越野'"); break;                   
                }
                //sb.Append(" and cSeries ='" + cSeries + "'");
            }
            //string cSeries = TypeChangeDefault.NullToString(Request.QueryString["xx"], "0");//鞋型      
            //if ("0" != cSeries)
            //{
            //    sb.Append(" and cSeries ='" + cSeries + "'");
            //}
            //int fPrice = TypeChangeDefault.NullToInt(Request.QueryString["sex"], 0);//价格
            string fPrice = TypeChangeDefault.NullToString(Request.QueryString["jg"], "0");//价格 
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
            string rHeel = TypeChangeDefault.NullToString(Request.QueryString["zghc"], "0");//足跟缓冲
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
            string rForefeet = TypeChangeDefault.NullToString(Request.QueryString["qjzhc"], "0");//前脚掌缓冲
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

            string rStiffness = TypeChangeDefault.NullToString(Request.QueryString["lhx"], "0");//灵活性
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

            string qhgc = TypeChangeDefault.NullToString(Request.QueryString["qhgc"], "0");//前后跟差
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

            string rStability = TypeChangeDefault.NullToString(Request.QueryString["wdx"], "0");// 稳定性 
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
            string rWeight = TypeChangeDefault.NullToString(Request.QueryString["zl"], "0");// 重量 
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

            string rHeight = TypeChangeDefault.NullToString(Request.QueryString["gd"], "0");// 重量 
            if ("0" != rHeight)
            {
                switch (rHeight)
                {
                    case "1": sb.Append(" and  rHeight < 20 "); break;
                    case "2": sb.Append(" and  rHeight between 20 and 40 "); break;
                    case "3": sb.Append(" and  rHeight between 40 and 60 "); break;
                    case "4": sb.Append(" and  rHeight between 60 and 80 "); break;
                    case "5": sb.Append(" and  rHeight >80 "); break;
                }
            }
            //具体的页面数     
            pageIndex = TypeChangeDefault.NullToInt(Request.QueryString["p"], 1);
            RecordCount = new DB5.tblShoes().GetRecordCount(sb.ToString());
            //页面显示条数
            int Pagesize = 20;
            DataTable dt = new DB5.tblShoes().GetListByPage(sb.ToString(), "id", pageIndex, Pagesize).Tables[0];

            //DBM5.tblShoes mshoe = new DB5.tblShoes().GetModel(idShoe);

            IsoDateTimeConverter iso = new IsoDateTimeConverter();
            iso.DateTimeFormat = "yyyy-MM-dd";
            Result = JsonConvert.SerializeObject(dt, iso);
        }
    }
}