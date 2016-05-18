using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;

public partial class GroupBuy_Group : PageBase
{
    public string Result = string.Empty;
    private int id = 0;
    public string cname = string.Empty;
    public int idUser = 100035871;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] != null)
        {
            id = TypeChangeDefault.NullToInt(Request.QueryString["id"].ToString(), 0);
        }
        //if (CurrentUser == null)
        //{
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
        //    return;
        //}
        if (!IsPostBack)
        {
            DBM1.tblGoods model = new DB1.tblGoods().GetModel(id);
            Hashtable good = new Hashtable();
            List<Hashtable> goodInfo = new List<Hashtable>();
            if (model != null)
            {
                if (100015102 != model.idUser)
                {
                    idUser = model.idUser ?? 100035871;
                }
               
                cname = model.cName;
                if (model.iType != 2)
                {
                    AlertHelper.JQAlertGo("当前商品不存在", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
                if (model.iState != 1)
                {
                    AlertHelper.JQAlertGo("当前商品不存在", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
                good.Add("id", model.id);
                good.Add("Name", model.cName);
                good.Add("MarketPrice", model.fMarketPrice);
                good.Add("ErunPrice", model.fSellPrice);
                good.Add("Image", model.cImage);
                if (model.dBeginTime > DateTime.Now)
                {
                    good.Add("BuyNum", 0);
                }
                else
                {
                    if (model.iTotal >= model.iBuyNum)
                    {
                        good.Add("BuyNum", model.iTotal);
                    }
                    else
                    {
                        good.Add("BuyNum", model.iBuyNum);
                    }
                }
                
                good.Add("BeginTime", model.dBeginTime);
                good.Add("EndTime", model.dEndTime);
                good.Add("Bio", model.cBio);
                good.Add("Norm", model.cNorm);

                good.Add("Total", model.iTotal);
                good.Add("iReserve", model.iReserve);
                good.Add("fScore", model.fScore);
                if (model.fReserve == 1)
                {
                    good.Add("Reserve", new DB1.tblReserve().GetGoodReserve("idGood=" + id).Tables[0]);
                }
                if (model.idTour == 1)
                {
                    DataTable dt = new DB1.tblTour().GetList(1, "idGood=" + id + "and iBuyNum<=" + model.iBuyNum, " iBuyNum desc").Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        good.Add("TourPrice", dt.Rows[0]["fBuyPrice"].ToString());
                    }
                    else
                        good.Add("TourPrice","");
                    good.Add("Tour", new DB1.tblTour().GetTourList("idGood=" + id, "iBuyNum desc ").Tables[0]);
                }
                good.Add("Current", ConvertDateTimeInt(DateTime.Now));
                good.Add("Begin", ConvertDateTimeInt(model.dBeginTime ?? DateTime.Now));
                good.Add("End", ConvertDateTimeInt(model.dEndTime ?? DateTime.Now));
                good.Add("state", model.iState);
                int ReserveCount=new DB1.tblReserve().GetReserveCount("idGood=" + id);//卖光
                if (ReserveCount ==0)
                {
                    good.Add("myend", "0");
                }
                else
                {
                    good.Add("myend", "1");
                }
                
                goodInfo.Add(good);
                IsoDateTimeConverter iso = new IsoDateTimeConverter();
                iso.DateTimeFormat = "yyyy-MM-dd HH:mm";
                Result = JsonConvert.SerializeObject(goodInfo, iso);
            }            
            else
            {
                AlertHelper.JQAlertGo("当前商品不存在", "/GroupBuy/GroupList.aspx", false);
                    return;
            }
        }
    }
    /// <summary>
    /// DateTime时间格式转换为Unix时间戳格式
    /// </summary>
    /// <param name="time"> DateTime时间格式</param>
    /// <returns>Unix时间戳格式</returns>
    public static int ConvertDateTimeInt(System.DateTime time)
    {
        System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1));
        return (int)(time - startTime).TotalSeconds;
    }
    /// <summary>
    /// 时间戳转为C#格式时间
    /// </summary>
    /// <param name="timeStamp">Unix时间戳格式</param>
    /// <returns>C#格式时间</returns>
    public static DateTime GetTime(string timeStamp)
    {
        DateTime dtStart = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));
        long lTime = long.Parse(timeStamp + "0000000");
        TimeSpan toNow = new TimeSpan(lTime);
        return dtStart.Add(toNow);
    }
}