using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB6 = Erun360.BLL.DB6;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using Utils;
using Erun360.Pay.tenpayLib;
using System.Xml;
public partial class weixinpay_wxpay : PageBase
{
    public string parm = string.Empty;
    public string idorder = string.Empty;
    private int jpmin = 25;//机票过期时间（单位分钟）
    private int ssmin = 120;//赛事过期时间
    public int id = 0;//订单id  
    public int idGood = 0;//订单id  
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }        
        idorder = TypeChangeDefault.NullToString(Request.QueryString["order"], "");
        parm = TypeChangeDefault.NullToString(Request.QueryString["parm"], "");
        if (!IsPostBack)
        {
            DataTable dt = new DB1.tblShopping().GetList("iState=1 and iType=2 and idOrder='" + idorder + "' and idUser=" + CurrentUser.uId).Tables[0];
            if (dt.Rows.Count > 0)
            {
                id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString().Trim(), 0);
                idGood = TypeChangeDefault.NullToInt(dt.Rows[0]["idGood"].ToString().Trim(), 0);

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
                ltlTitle.Text = dt.Rows[0]["cGoodName"].ToString();
                ltlPrice.Text = dt.Rows[0]["iCost"].ToString();
                int min = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[0]["dConfirm"], CurrentTime()), ssmin);
                ltltime.Text = min.ToString();
                if (min <= 0)
                {
                    Erun360.Common.ErrorLogFile log = new Erun360.Common.ErrorLogFile();
                    log.SaveLogInfo(dt.Rows[0]["dConfirm"].ToString(), "订单已过期，请重新购买！" + ltltime.Text);
                    AlertHelper.JQAlertGo("订单已过期，请重新购买！", "/GroupBuy/GroupList.aspx", false);
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
        DateTime date2 = new DB6.tblOrder().GetTime(0);
        // todo: 时间初始化
        TimeSpan timeSpan = date2 - date1;
        double ts = Math.Floor(timeSpan.TotalMinutes);//取整数3.9=3;
        int mm = TypeChangeDefault.NullToInt(ts, 0);
        if (mm > max)
        {
            return 0;
        }
        return (max - mm) > 120 ? 120 : max - mm;
    }

}