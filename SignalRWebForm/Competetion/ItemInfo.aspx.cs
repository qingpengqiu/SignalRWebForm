using Erun360.Model.DB6;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
public partial class Competetion_ItemInfo : System.Web.UI.Page
{
    private double percentum = 0;//价格百分比erun360_admin360
    protected void Page_Load(object sender, EventArgs e)
    {
      
    }

    /// <summary>
    /// 得到一个对象实体，从缓存中
    /// </summary>
    public string  GetModelByCache()
    {

        string CacheKey = "re_earch_Value-";
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        if (objModel == null)
        {
            try
            {
                string strFilePath = @"D:\1益跑网\hkjson.txt";
                FileStream fs = new FileStream(strFilePath, FileMode.Open, FileAccess.Read, FileShare.None);
                StreamReader sr = new StreamReader(fs, System.Text.Encoding.Default);
                string strLine = sr.ReadToEnd();
                objModel = strLine;
                if (objModel != null)
                {
                    int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            catch { }
        }
        return (string)objModel;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string re_earch_Value = GetModelByCache();

        Return_Search_Value secrch_msg = JsonConvert.DeserializeObject<Return_Search_Value>(re_earch_Value);
        //List<Hashtable> flightInfoList = new List<Hashtable>();
        List<Items> itemsdetail = secrch_msg.items;
        List<flight_Item> items = new List<flight_Item>();
        foreach (Items item in itemsdetail)
        {
            flight_Item flightinfo = new flight_Item();
            flightinfo.Id = item.Id;
            string[] hb = item.Airline.Split('|');
            //航班信息（航空公司+编号） 南方航空CZ3152
            flightinfo.Airline_No = hb[1].ToString();
            flightinfo.Airline_Name = hb[0].ToString() + item.FlightNo;
            //起降时间
            flightinfo.from_Time = item.D_Time;
            flightinfo.to_Time = item.A_Time;
            //起降机场(机场+航站楼) 首都机场T2
            flightinfo.from_Airport = item.D_City.Split('|')[0] + item.PortD;
            flightinfo.to_Airport = item.A_City.Split('|')[0] + item.PortA;
            flightinfo.HippingSpace = item.HippingSpace;
            flightinfo.AircraftType = item.AircraftType;
            flightinfo.Discount = item.Discount;//折扣
            flightinfo.RemainingSeats = item.RemainingSeats;//余票
            double cost = TypeChangeDefault.NullToDouble(item.Price, 0);//SettlementPrice//机票价格待定
            flightinfo.Price = TypeChangeDefault.NullToInt(Math.Ceiling(cost * percentum), 0) + (int)cost;
            items.Add(flightinfo);
        }
        ////利用匿名委托方式对list排序  
        items.Sort(delegate(flight_Item x, flight_Item y)
        {
            return x.from_Time.CompareTo(y.from_Time);
        });
        Response.Write(JsonConvert.SerializeObject(items));
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        string re_earch_Value = GetModelByCache();

        Return_Search_Value secrch_msg = JsonConvert.DeserializeObject<Return_Search_Value>(re_earch_Value);
        //List<Hashtable> flightInfoList = new List<Hashtable>();
        List<Items> itemsdetail = secrch_msg.items;
        List<flight_Item> items = new List<flight_Item>();
        foreach (Items item in itemsdetail)
        {
            flight_Item flightinfo = new flight_Item();
            flightinfo.Id = item.Id;
            string[] hb = item.Airline.Split('|');
            //航班信息（航空公司+编号） 南方航空CZ3152
            flightinfo.Airline_No = hb[1].ToString();
            flightinfo.Airline_Name = hb[0].ToString() + item.FlightNo;
            //起降时间
            flightinfo.from_Time = item.D_Time;
            flightinfo.to_Time = item.A_Time;
            //起降机场(机场+航站楼) 首都机场T2
            flightinfo.from_Airport = item.D_City.Split('|')[0] + item.PortD;
            flightinfo.to_Airport = item.A_City.Split('|')[0] + item.PortA;
            flightinfo.HippingSpace = item.HippingSpace;
            flightinfo.AircraftType = item.AircraftType;
            flightinfo.Discount = item.Discount;//折扣
            flightinfo.RemainingSeats = item.RemainingSeats;//余票
            double cost = TypeChangeDefault.NullToDouble(item.Price, 0);//SettlementPrice//机票价格待定
            flightinfo.Price = TypeChangeDefault.NullToInt(Math.Ceiling(cost * percentum), 0) + (int)cost;
            items.Add(flightinfo);
        }
        ////利用匿名委托方式对list排序  
        items.Sort(delegate(flight_Item x, flight_Item y)
        {
            return x.Price.CompareTo(y.Price);
        });
        Response.Write(JsonConvert.SerializeObject(items));
    }
}