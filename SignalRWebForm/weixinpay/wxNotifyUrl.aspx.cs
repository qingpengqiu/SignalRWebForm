using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
public partial class weixinpay_wxNotifyUrl : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string wxNotifyXml = "";

        byte[] bytes = Request.BinaryRead(Request.ContentLength);
        wxNotifyXml = System.Text.Encoding.UTF8.GetString(bytes);

        if (wxNotifyXml.Length == 0)
        {
            return;
        }

        XmlDocument xmldoc = new XmlDocument();

        xmldoc.LoadXml(wxNotifyXml);

        string ResultCode = xmldoc.SelectSingleNode("/xml/result_code").InnerText;
        string ReturnCode = xmldoc.SelectSingleNode("/xml/return_code").InnerText;

        if (ReturnCode == "SUCCESS" && ResultCode == "SUCCESS")
        {
            //验证成功
            //取结果参数做业务处理
            string out_trade_no = xmldoc.SelectSingleNode("/xml/out_trade_no").InnerText;
            //财付通订单号
            string trade_no = xmldoc.SelectSingleNode("/xml/transaction_id").InnerText;
            //金额,以分为单位
            string total_fee = xmldoc.SelectSingleNode("/xml/total_fee").InnerText;

            /********************************
             * 
             * 自己业务处理
             * 
            *********************************/
            DB1.tblShopping Bll = new DB1.tblShopping();
            DataTable dt = Bll.GetList(" idOrder='" + out_trade_no + "'").Tables[0];
            if (dt.Rows.Count > 0)
            {
                string idAlipay = dt.Rows[0]["idAlipay"].ToString().Trim();
                int idGood = TypeChangeDefault.NullToInt(dt.Rows[0]["idGood"].ToString().Trim(), 0);//商品id
                int idUser = TypeChangeDefault.NullToInt(dt.Rows[0]["idUser"].ToString().Trim(), 0);//购买用户id
                int isuse = TypeChangeDefault.NullToInt(dt.Rows[0]["isuse"].ToString().Trim(), 0);//是否使用积分
                decimal iCost = TypeChangeDefault.NullToDecimal(dt.Rows[0]["iCost"].ToString().Trim(), 0);//付款金额
                DBM1.tblGoods mGood = new DB1.tblGoods().GetModel(idGood);
                if (mGood == null)
                {
                    return;
                }
                int iState = TypeChangeDefault.NullToInt(dt.Rows[0]["iState"], -1);//支付状态
                if (iState == 1)
                {
                    if (string.IsNullOrEmpty(idAlipay))
                    {
                        DBM1.tblShopping mShop = new DBM1.tblShopping();
                        mShop.idAlipay = trade_no;
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
                }
               
            }
        }
    }
}