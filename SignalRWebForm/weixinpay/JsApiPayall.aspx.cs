using Erun360.Pay.WxPayAPI;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
public partial class weixinpay_JsApiPayall : PageBase
{
    public static string wxJsApiParam { get; set; } //H5调起JS API参数
    private int jpmin = 25;//机票过期时间（单位分钟）
    private int ssmin = 120;//赛事过期时间

    public int sid = 0;//订单id 
    public int id = 0;//订单id 
    public string title = string.Empty;
    public string OrderNo = string.Empty;//订单号
    public string openid = string.Empty;//订单号
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        OrderNo = TypeChangeDefault.NullToString(Request.QueryString["order"], "");
        openid = TypeChangeDefault.NullToString(Request.QueryString["openid"], "");
        Log.Info(this.GetType().ToString(), "调用统一支付jsapi 支付页面");
        if (!IsPostBack)
        {

            DBM6.tblRace_Competition modelrace = new DB6.tblRace_Competition().GetModel(sid);
            if (modelrace == null)
            {
                AlertHelper.JQAlertGo("请选择赛事！", "/Competetion/SearchEvent.aspx", false);
                return;
            }
            int idUser = 0;
            if (CurrentUser != null)
            {
                idUser = CurrentUser.uId;
            }
            if (modelrace.idUser != idUser || idUser != 100000002)
            {
                if (1 != modelrace.iStatus)
                {
                    AlertHelper.JQAlertGo("该赛事已关闭！", "/Competetion/SearchEvent.aspx", false);
                    return;
                }
            }
            DB6.tblOrder bll = new DB6.tblOrder();
            DBM6.tblOrder model = bll.GetModel(id);
            if (model == null)
            {
                AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
            if (model.iStatus != 1)
            {
                AlertHelper.JQAlertGo("该订单已付款或者已过期，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
            if (model.cOrder_no != OrderNo)
            {
                AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
            int min = 0;
            if (model.iFromTpye == 1)
            {
                DataTable dt = bll.GetList("cParentOrder='" + model.cOrder_no + "' and idUser=" + CurrentUser.uId + " and iStatus=1 ").Tables[0];
                int count = dt.Rows.Count;
                if (count == 0)
                {
                    AlertHelper.JQAlertGo("该订单已过期，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                    return;
                }
                int[] intArray = new int[count];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    int iFromTpye = TypeChangeDefault.NullToInt(dt.Rows[i]["iFromTpye"], 0);
                    //单位分钟
                    if (iFromTpye == 3)//机票业务
                    {
                        intArray[i] = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[i]["dConfirmTime"], bll.GetTime(0)), jpmin);

                    }
                    else
                    {
                        intArray[i] = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[i]["dConfirmTime"], bll.GetTime(0)), ssmin);
                    }
                }
                ArrayList list = new ArrayList(intArray);
                list.Sort();
                //int max = Convert.ToInt32(list[list.Count - 1]);//取最大值
                min = Convert.ToInt32(list[0]);//取最小值
            }
            else
            {
                //单位分钟
                if (model.iFromTpye == 3)//机票业务
                {
                    min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), jpmin);

                }
                else
                { min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), ssmin); }
            }
            if (min == 0)
            {
                AlertHelper.JQAlertGo("该订单已过期，请重新选择!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }

            ltlidOrder.Text = OrderNo;
            ltlTitle.Text = model.iTypeName + "-" + model.cItemName;
            ltlNum.Text = model.iBuyNum.ToString();
            if (model.iScore != 0)
            {
                ltlSocre.Text = "积分抵扣：" + model.iScore + "积分抵扣 <i>&yen;</i>" + model.iMoney + "<br>";
            }
            ltlPrice.Text = model.iCost.ToString();
            if (min > 60)
            {
                ltlMax.Text = Convert.ToString(Math.Floor(min / 60.0)) + "小时" + Convert.ToString(Math.Floor(min % 60.0)) + "分钟";
            }
            else
                ltlMax.Text = min.ToString() + "分钟";
            //string total_fee = Request.QueryString["total_fee"];
            double iCost = 0.00;
            iCost = TypeChangeDefault.NullToDouble(model.iCost, 0);
            string total_fee = (iCost * 100).ToString();
            Log.Info(this.GetType().ToString(), "调用jsapi 支付钱数：" + total_fee);
            //检测是否给当前页面传递了相关参数
            if (string.IsNullOrEmpty(openid))
            {
                //Response.Write("<span style='color:#FF0000;font-size:20px'>" + "页面传参出错,请返回重试" + "</span>");
                Log.Error(this.GetType().ToString(), "jsapi页面传参出错,请返回重试");
                //submit.Visible = false;
                return;
            }
            //若传递了相关参数，则调统一下单接口，获得后续相关接口的入口参数
            JsApiPay jsApiPay = new JsApiPay(this);
            jsApiPay.openid = openid;
            jsApiPay.total_fee = int.Parse(total_fee);
            //JSAPI支付预处理
            try
            {
                ////WxPayData unifiedOrderResult = jsApiPay.GetUnifiedOrderResult(ltlTitle.Text, ltlTitle.Text, OrderNo, min, "http://paytest.erun360.com/Competetion/payment/wxNotifyUrl.aspx");

                WxPayData unifiedOrderResult = jsApiPay.GetUnifiedOrderResult(ltlTitle.Text, ltlTitle.Text, OrderNo, min, "http://www.erun360.com/weixinpay/pallNotifyUrl.aspx");
                //WxPayData unifiedOrderResult = jsApiPay.GetUnifiedOrderResult();
                wxJsApiParam = jsApiPay.GetJsApiParameters();//获取H5调起JS API参数                    
                Log.Debug(this.GetType().ToString(), "wxJsApiParam : " + wxJsApiParam);
                //在页面上显示订单信息
            }
            catch (Exception ex)
            {
                //submit.Visible = false;
                AlertHelper.JQAlertGo("该订单已过期，请重新选择!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
        }
    }
    /// <summary>
    /// 过期时间
    /// </summary>
    /// <param name="date1"></param>
    /// <param name="max">默认过期最大值（单位分钟）</param>
    /// <returns></returns>
    protected int deadline(DateTime date1, int max)
    {
        //DateTime date1 = model.dConfirmTime ?? DateTime.Now;
        DateTime date2 = new DB6.tblOrder().GetTime(0);
        // todo: 时间初始化
        TimeSpan timeSpan = date2 - date1;
        double ts = Math.Floor(timeSpan.TotalMinutes);//取整数3.9=3;
        int mm = TypeChangeDefault.NullToInt(ts, 0);
        if (mm < 0 || mm > max)
        {
            return 0;
        }
        return max - mm;
    }
}