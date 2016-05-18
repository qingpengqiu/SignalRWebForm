using Erun360.Pay.WxPayAPI;
using System;
using System.Data;
using Utils;

using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
public partial class weixinpay_payresult : PageBase
{
    public string idorder = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        idorder = TypeChangeDefault.NullToString(Request.QueryString["idorder"], "");
        if (!IsPostBack)
        {
            DataTable dt = new DB1.tblShopping().GetList("iType=2 and idOrder='" + idorder + "' and idUser=" + CurrentUser.uId).Tables[0];
            if (dt.Rows.Count > 0)
            {
                int idUser = TypeChangeDefault.NullToInt(dt.Rows[0]["idUser"].ToString().Trim(), 0);
                int idGood = TypeChangeDefault.NullToInt(dt.Rows[0]["idGood"].ToString().Trim(), 0);

                DBM1.tblGoods mGood = new DB1.tblGoods().GetModel(idGood);
                if (mGood == null)
                {
                    AlertHelper.JQAlertGo("该商品不存在！", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
                if (mGood.iState != 1)
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
               
                if (dt.Rows[0]["iState"].ToString() == "1")
                {
                    Log.Info("OrderQuery", "OrderQuery is processing...");

                    WxPayData data = new WxPayData();
                    if (!string.IsNullOrEmpty(idorder))//微信订单号不存在，才根据商户订单号去查单
                    {
                        data.SetValue("out_trade_no", idorder);
                    }

                    WxPayData result = WxPayApi.OrderQuery(data);//提交订单查询请求给API，接收返回数据
                    Log.Info("OrderQuery", "OrderQuery process complete, result : " + result.ToXml());
                    try
                    {
                        ltltrade_no.Text = result.GetValue("transaction_id").ToString();// result.ToPrintStr();
                        string idAlipay = dt.Rows[0]["idAlipay"].ToString().Trim();
                        int isuse = TypeChangeDefault.NullToInt(dt.Rows[0]["isuse"].ToString().Trim(), 0);//是否使用积分
                        decimal iCost = TypeChangeDefault.NullToDecimal(dt.Rows[0]["iCost"].ToString().Trim(), 0);//付款金额
                        if (string.IsNullOrEmpty(idAlipay))
                        {
                            DBM1.tblShopping mShop = new DBM1.tblShopping();
                            mShop.idAlipay = ltltrade_no.Text;
                            mShop.dPay = DateTime.Now;
                            mShop.iState = 2;
                            int idcode = 0;
                            if (mGood.iEntity == 0)
                            {
                                DataTable dtcode = new DB5.tblCode().GetList(1, "iValid=0", "id").Tables[0];
                                idcode = TypeChangeDefault.NullToInt(dtcode.Rows[0]["id"].ToString().Trim(), 0);
                                mShop.cMark4 = dtcode.Rows[0]["idCode"].ToString();
                            }
                            mShop.id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString().Trim(), 0);
                            if (new DB1.tblShopping().Update(mShop))
                            {
                                try
                                {
                                    DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                                    DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                                    disModel.cContent = "您在《<a target=\"_blank\" href=\"/infocenter/Rlist.aspx?uId=" + idUser + "&tablep=0\">" + mGood.cName + "</a>》中拼团成功！请您持续关注，谢谢！";
                                    disModel.idInfo = idUser;
                                    disModel.idUser = 100035871;
                                    disModel.cLoginname = "益跑客服";
                                    int imessage = disBll.Add(disModel);
                                    if (imessage > 0)
                                    {
                                        DBM3.tblMessage mMessage = new DBM3.tblMessage();
                                        mMessage.cId = 100035871;
                                        mMessage.uId = idUser;
                                        mMessage.itype = 31;
                                        mMessage.idcode = imessage;
                                        int test = new DB3.tblMessage().Add(mMessage);
                                    }
                                    DBM1.tblMEMBER model = new DB1.tblMEMBER().GetModel(idUser);
                                    if (model != null)
                                    {
                                        DBM2.tblActivity mActivity = new DBM2.tblActivity();
                                        mActivity.idUser = model.id;
                                        mActivity.cNickName = model.cNickName;
                                        mActivity.cAvatar = model.cAvatar;
                                        mActivity.idBlog = imessage;
                                        mActivity.idGroup = "44";
                                        mActivity.cTitle = "在《<a target=\"_blank\" href=\"/GroupBuy/Group.aspx?id=" + idGood + "\">" + mGood.cName + "</a>》中拼团成功！您也去看看呗<a target=\"_blank\" href=\"/GroupBuy/Group.aspx?id=" + idGood + "\">[查看]</a>！";
                                        mActivity.cBio = "";
                                        mActivity.dCreate = DateTime.Now;
                                        new DB2.tblActivity().Add(mActivity);
                                    }
                                }
                                catch (Exception ex)
                                {
                                    Log.Info("修改订单状态出错：", ex.Message.ToString());
                                   
                                }
                                //报名赛事最低送10积分
                                if (isuse == 0)
                                {
                                    new DB1.tblIntegral().InsertScore(idUser, 200850001, 5, iCost);
                                }
                                //积分兑换劵更新状态
                                if (idcode != 0)
                                {
                                    DBM5.tblCode mCode = new DBM5.tblCode();
                                    mCode.id = idcode;
                                    mCode.idGood = idGood;
                                    mCode.cGoodName = mGood.cName;
                                    mCode.cValue = mGood.fSellPrice;
                                    mCode.iValid = 1;
                                    mCode.dBuyTime = DateTime.Now;
                                    mCode.idUser = idUser;
                                    new DB5.tblCode().Update(mCode);
                                }
                            }

                        }
                        ltlresult.Text = " <a class=\"topay\"> 支付成功</a>";
                    }
                    catch (WxPayException ex)
                    {
                        //ltlsb.Text = "失败原因：支付失败";
                        ltlresult.Text = " <a class=\"topay\">支付失败</a>";
                    }
                    catch (Exception ex)
                    {
                        //ltlsb.Text = "失败原因：" + ex.ToString();
                        ltlresult.Text = " <a class=\"topay\">支付失败</a>";
                    }
                }
                else if (dt.Rows[0]["iState"].ToString() == "2")
                {
                    ltltrade_no.Text = dt.Rows[0]["idAlipay"].ToString();// result.ToPrintStr();
                    ltlresult.Text = " <a class=\"topay\"> 支付成功</a>";
                }
                else {
                    ltlresult.Text = " <a class=\"topay\">支付失败</a>";
                }
            }
            else
            {
                AlertHelper.JQAlertGo("您的订单不存在！", "/GroupBuy/GroupList.aspx", false);
                return;
            }
        }
    }
}