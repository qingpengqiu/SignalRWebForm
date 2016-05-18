using Erun360.Pay.WxPayAPI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB6 = Erun360.BLL.DB6;
public partial class weixinpay_JsApiPayPage : PageBase
{
    public static string wxJsApiParam { get; set; } //H5调起JS API参数
    public string idorder = string.Empty;
    private int jpmin = 25;//机票过期时间（单位分钟）
    private int ssmin = 120;//赛事过期时间
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        Log.Info(this.GetType().ToString(), "调用jsapi 支付页面");
        idorder = TypeChangeDefault.NullToString(Request.QueryString["idorder"], "");
        if (!IsPostBack)
        {
            DataTable dt = new DB1.tblShopping().GetList("iState=1 and iType=2 and idOrder='" + idorder + "' and idUser=" + CurrentUser.uId).Tables[0];
            if (dt.Rows.Count > 0)
            {
                int idUser = TypeChangeDefault.NullToInt(dt.Rows[0]["idUser"].ToString().Trim(), 0);
                int idGood = TypeChangeDefault.NullToInt(dt.Rows[0]["idGood"].ToString().Trim(), 0);

                DBM1.tblGoods model = new DB1.tblGoods().GetModel(idGood);
                if (model == null)
                {
                    AlertHelper.JQAlertGo("该商品不存在！", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
                if (model.iState != 1)
                {
                    AlertHelper.JQAlertGo("该商品不存在！", "/GroupBuy/GroupList.aspx", false);
                    return;
                }

                ltlImg.Text = "<img src=\"" + dt.Rows[0]["cImage"].ToString() + "\" alt=\"\"/>";
                ltlTitle.Text = dt.Rows[0]["cGoodName"].ToString();
                ltlNum.Text = dt.Rows[0]["iBuyNum"].ToString();
                ltlColor.Text = dt.Rows[0]["cColor"].ToString() + "/" + dt.Rows[0]["cSize"].ToString();
                ltlSocre.Text = dt.Rows[0]["cScore"].ToString();
                ltlMoney.Text = dt.Rows[0]["fMoney"].ToString();
                ltlPrice.Text = dt.Rows[0]["iCost"].ToString();
                //int min = 0;
                int min = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[0]["dConfirm"], DateTime.Now), ssmin);
                if (min <= 0)
                {
                    AlertHelper.JQAlertGo("订单已过期，请重新购买！", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
                string openid = Request.QueryString["openid"];
                //string total_fee = Request.QueryString["total_fee"];
                double iCost = 0.00;
                iCost = TypeChangeDefault.NullToDouble(dt.Rows[0]["iCost"], 0);
              
                string  total_fee = (iCost * 100).ToString();
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

                    WxPayData unifiedOrderResult = jsApiPay.GetUnifiedOrderResult(ltlTitle.Text, ltlTitle.Text, idorder, min);
                    //WxPayData unifiedOrderResult = jsApiPay.GetUnifiedOrderResult();
                    wxJsApiParam = jsApiPay.GetJsApiParameters();//获取H5调起JS API参数                    
                    Log.Debug(this.GetType().ToString(), "wxJsApiParam : " + wxJsApiParam);
                    //在页面上显示订单信息
                }
                catch (Exception ex)
                {
                    //submit.Visible = false;
                    AlertHelper.JQAlertGo("下单失败，请返回重试！", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
            }
            else
            {
                AlertHelper.JQAlertGo("您的订单不存在！", "/GroupBuy/GroupList.aspx", false);
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
        //DateTime date2 = DateTime.Now;
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