using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB5 = Erun360.BLL.DB5;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System.Data;
using System.Collections;
using Utils;
public partial class GroupBuy_Cart : PageBase
{
    public string Result = string.Empty;
    private int id = 0;
    private string idfrom = string.Empty;
    public string Ishow = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] != null)
        {
            id = TypeChangeDefault.NullToInt(Request.QueryString["id"].ToString(), 0);
        }
        if (Request.QueryString["from"] != null)
        {
            idfrom = TypeChangeDefault.NullToString(Request.QueryString["from"].ToString(), "");
        }
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            Result = "'nologin'";
            return;
        }
        if (!IsPostBack)
        {
            DBM1.tblGoods model = new DB1.tblGoods().GetModel(id);
            List<Hashtable> goodInfo = new List<Hashtable>();
            Hashtable good = new Hashtable();
            if (model != null)
            {
                int ReserveCount = new DB1.tblReserve().GetReserveCount("idGood =" + id);
                if (ReserveCount == 0)
                {
                    AlertHelper.JQAlertGo("该商品库存不足，谢谢关注！", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
                if (model.iType !=2)
                {
                    AlertHelper.JQAlertGo("该商品不符合要求！", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
                if (model.iState != 1)
                {
                    AlertHelper.JQAlertGo("该商品不存在或已过期！", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
                if (DateTime.Now < model.dBeginTime)
                {
                    AlertHelper.JQAlertGo(Convert.ToDateTime(model.dBeginTime).ToString("MM-dd HH: mm") + "开始,敬请关注！", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
                if (DateTime.Now > model.dEndTime)
                {
                    AlertHelper.JQAlertGo("拼团已结束，看看其他商品吧！", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
                if (model.iEntity != 1)
                {
                    idsboxt.Visible = false;
                    idaddress.Visible = false;
                }
                if (model.iEntity == 0)
                {
                    int codeCount = new DB5.tblCode().GetRecordCount("iValid=0");
                    if (codeCount == 0)
                    {
                        AlertHelper.JQAlertGo("兑换码已售完，看看其他的！", "/GroupBuy/GroupList.aspx", false);
                        return;
                    }
                }
                good.Add("id", model.id);
                good.Add("Image", model.cImage);
                good.Add("Title", model.cName);
                good.Add("type", model.iType);               
                if (model.iType == 1)
                {
                    if (model.fSellPrice.ToString() == "0.00")
                    {
                        Ishow = "<div class=\"paym\">您需要支付：" + model.iScore + "<em>积分</em></div>";
                    }
                    else
                    {
                        Ishow = "<div class=\"paym\">您需要支付：<span>" + model.fSellPrice + "</span>元＋" + model.iScore + "<em>积分</em></div>";
                    }
                }
                else if (model.iType == 2)
                {
                    Ishow = "<div class=\"paym\">您需要支付：<span>"+model.fSellPrice+"</span>元</div>";
                }
                good.Add("Reserve", new DB1.tblReserve().GetGoodReserve("iReserve>0 and idGood=" + id).Tables[0]);
                good.Add("Quantity", model.iQuantity);
                if (model.idTour == 1)
                {
                    DataTable dt = new DB1.tblTour().GetList(1, "idGood=" + id + "and iBuyNum<=" + model.iBuyNum, " iBuyNum desc ").Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        good.Add("Price", dt.Rows[0]["fBuyPrice"].ToString());
                    }
                    else
                        good.Add("Price", 0);
                }
                else
                    good.Add("Price", model.fSellPrice);
                good.Add("fScore", model.fScore);
                if (model.fScore == 1)
                {
                    good.Add("Score", model.iScore);
                    good.Add("Money", model.iMoney);
                }
                good.Add("TotalScore", new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + CurrentUser.uId, CurrentUser.uId));
                if (!string.IsNullOrEmpty(idfrom))
                {
                    DataTable dt = new DB1.tblShopping().GetList("idOrder='" + idfrom + "' and idUser=" + CurrentUser.uId).Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        good.Add("Name", dt.Rows[0]["cName"].ToString());
                        good.Add("Mobile", dt.Rows[0]["cMobile"].ToString());
                        good.Add("idCity", dt.Rows[0]["idCity"].ToString());
                        good.Add("Cityname", dt.Rows[0]["cCityname"].ToString());
                        good.Add("Address", dt.Rows[0]["cAddress"].ToString());
                        good.Add("Zipcode", dt.Rows[0]["cZipcode"].ToString());
                        good.Add("Mark", dt.Rows[0]["cMark1"].ToString());
                        if (dt.Rows[0]["iState"].ToString() == "1")
                        {
                            int iNum = TypeChangeDefault.NullToInt(dt.Rows[0]["iBuyNum"].ToString(), 0);
                            //购买状态置过期-1
                            DBM1.tblShopping mShop = new DBM1.tblShopping();
                            mShop.id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString(), 0);
                            mShop.iState = -1;
                            new DB1.tblShopping().Update(mShop);
                            int isuse = TypeChangeDefault.NullToInt(dt.Rows[0]["isuse"].ToString().Trim(), 0);//是否使用积分 
                            int Score = TypeChangeDefault.NullToInt(dt.Rows[0]["cScore"].ToString().Trim(), 0);//积分值 
                            int idUser = TypeChangeDefault.NullToInt(dt.Rows[0]["idUser"].ToString().Trim(), 0);
                            //未付款退还积分
                            if (isuse == 1)
                            {
                                new DB1.tblIntegral().InsertScore(idUser, 200830003, 3, Score, "团购没付款返还积分值,商品" + id.ToString());
                                //new DB1.tblIntegral().InsertScore(idUser, 200830003, 3, Score);
                            }
                            //减去库存数量                    
                            int idReserve = TypeChangeDefault.NullToInt(dt.Rows[0]["idReserve"].ToString(), 0);
                            DBM1.tblReserve m_Reserve = new DB1.tblReserve().GetModel(idReserve);
                            DBM1.tblReserve mReserve = new DBM1.tblReserve();
                            mReserve.id = TypeChangeDefault.NullToInt(dt.Rows[0]["idReserve"].ToString(), 0);
                            mReserve.iReserve = m_Reserve.iReserve + iNum;
                            new DB1.tblReserve().Update(mReserve);
                            //减去商品数量
                            DBM1.tblGoods m_Good = new DB1.tblGoods().GetModel(id);
                            DBM1.tblGoods mGood = new DBM1.tblGoods();
                            mGood.id = TypeChangeDefault.NullToInt(dt.Rows[0]["idGood"].ToString(), 0); ;
                            mGood.iReserve = m_Good.iReserve - iNum;
                            mGood.iBuyNum = m_Good.iReserve - iNum;                           
                            new DB1.tblGoods().Update(mGood);                           
                        }
                    }
                    else
                    {
                        good.Add("Name", CurrentUser.cName);
                        good.Add("Mobile", CurrentUser.cMobile);
                        good.Add("idCity", CurrentUser.idCity);
                        good.Add("Cityname", CurrentUser.cCityname);
                        good.Add("Address", CurrentUser.cAddress);
                        good.Add("Zipcode", CurrentUser.cZipcode);
                        good.Add("Mark", "");
                    }
                }
                else
                {
                    good.Add("Name", CurrentUser.cName);
                    good.Add("Mobile", CurrentUser.cMobile);
                    good.Add("idCity", CurrentUser.idCity);
                    good.Add("Cityname", CurrentUser.cCityname);
                    good.Add("Address", CurrentUser.cAddress);
                    good.Add("Zipcode", CurrentUser.cZipcode);
                    good.Add("Mark", "");
                }
            }
            goodInfo.Add(good);
            Result = JsonConvert.SerializeObject(goodInfo);

        }
    }
}