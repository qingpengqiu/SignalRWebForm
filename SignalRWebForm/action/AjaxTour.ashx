<%@ WebHandler Language="C#" Class="AjaxTour" %>

using System;
using System.Web;
using System.Web.SessionState;
using Erun360.BLL;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB5 = Erun360.BLL.DB5;
using DB6 = Erun360.BLL.DB6;
using System.Text;
using System.Data;
public class AjaxTour : IHttpHandler, IReadOnlySessionState
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
    //微信支付，同步获取订单状态
    public void wxpay(HttpContext context)
    {
        int id = TypeChangeDefault.NullToInt(context.Request["id"], 0);//订单id
        string idOrder = TypeChangeDefault.NullToString(context.Request["idOrder"], "0");//订单号
        int idGood = TypeChangeDefault.NullToInt(context.Request["idGood"], 0);//商品id
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;

        DBM1.tblShopping model = new DB1.tblShopping().GetModel(id);       
        if (model == null)
        {
            result = "{\"msg\":\"非法操作！\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        if (user.uId != model.idUser)
        {
            result = "{\"msg\":\"非法操作！\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        if (model.idGood != idGood)
        {
            result = "{\"msg\":\"非法操作！\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        if (model.idOrder != idOrder)
        {
            result = "{\"msg\":\"非法操作！\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        if (model.iState == 2)
        {
            result = "{\"msg\":\"支付成功！\",\"id\":\"" + id + "\",\"orderid\":\"" + idOrder + "\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"\",\"status\":\"2\"}";
            context.Response.Write(result);
            return;
        }

    }
    //提交订单积分兑换
    public void Submit(HttpContext context)
    {
        int idGood = TypeChangeDefault.NullToInt(context.Request["idGood"], 0);//商品id
        int idReserve = TypeChangeDefault.NullToInt(context.Request["idReserve"], 0);//库存id
        int iNum = TypeChangeDefault.NullToInt(context.Request["iNum"], 0);//购买数量
        int isAddress = TypeChangeDefault.NullToInt(context.Request["isAddress"], 0);//是否使用新地址       
        string contbox = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["contbox"]), "");//备注
        //-1未登录-2商品不存在，-3 库存不存在，-4超出用户最大限额-5团购价格不存在-6不是拼团-7积分使用不相符-8传入参数不符合要求-9该物品已卖光-10该商品不数量不足-11商品类型不匹配-12积分不足，0失败，成功返回订单号，
        //具体的页面数     
        if (context.Session["CurrentUser"] == null)
        {
            context.Response.Write("-1");//-1未登录
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
        DBM1.tblGoods good = new DB1.tblGoods().GetModel(idGood);
        if (good == null)
        {
            context.Response.Write("-2");//-2商品不存在
            return;
        }
        if (good.fScore == 0)
        {
            context.Response.Write("-7");//-7积分使用不相符
            return;
        }
        int jf = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + user.uId, user.uId);
        if (jf < good.iScore)
        {
            context.Response.Write("-12");//-10积分不足
            return;
        }
        if (good.iType != 1)
        {
            context.Response.Write("-11");//-11商品类型不匹配
            return;
        }
        if (good.iEntity == 0)
        {
            int codeCount = new DB5.tblCode().GetRecordCount("iValid=0");         
            if (codeCount == 0)
            {
                context.Response.Write("-13");//-13兑换卷已售完               
                return;
            } 
        }
        DBM1.tblReserve reserve = new DB1.tblReserve().GetModel(idReserve);
        if (reserve == null)
        {
            context.Response.Write("-3");//-2库存不存在
            return;
        }
        if (reserve.iReserve == 0)
        {
            context.Response.Write("-9");//-9该物品已卖光
            return;
        }
        if (iNum > reserve.iReserve)
        {
            context.Response.Write("-10");//-9该商品不数量不足
            return;
        }
        //int count = new DB1.tblShopping().GetBuyGoodNum("iState>0 and idUser=" + user.uId.ToString() + " and idGood=" + idGood.ToString()) + iNum;//购买总数量
        //if (count > good.iQuantity)
        //{
        //    context.Response.Write("-4");//-4超出用户最大限额
        //    return;
        //}
        DBM1.tblShopping model = new DBM1.tblShopping();
        model.idGood = idGood;
        model.cGoodName = good.cName;
        model.iType = good.iType;
        model.idReserve = idReserve;
        model.cSize = reserve.cSize;
        model.cColor = reserve.cColor;
        if (reserve.cImage.Trim().Length == 0)
        {
            model.cImage = good.cImage;
        }
        else
        {
            model.cImage = reserve.cImage;   
        }
        model.iBuyNum = iNum;
        model.fPrice = good.fSellPrice;//成交价格

        model.cScore = good.iScore;
        model.fMoney = good.iMoney;
        model.iCost = good.fSellPrice;
        model.isUse = good.fScore;
        if (isAddress == 1)
        {
            int idCity = TypeChangeDefault.NullToInt(context.Request["idCity"], 0);//城市id
            string cCityname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["Cityname"]), "");//城市名称
            string cAddress = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["newaddress"]), "");//地址
            string cZipcode = TypeChangeDefault.NullToString(context.Request["newzipcode"], "");//邮编
            string cMobile = TypeChangeDefault.NullToString(context.Request["newtel"], "");//电话
            string cName = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["newname"]), "");//姓名
            if (cCityname.Trim().Length == 0 || cCityname.Trim().Length > 64 || cAddress.Trim().Length == 0 || cAddress.Trim().Length > 256 || cZipcode.Trim().Length == 0 || cZipcode.Trim().Length > 6 || cMobile.Trim().Length == 0 || cMobile.Trim().Length > 32 || cName.Trim().Length == 0 || cName.Trim().Length > 64)
            {
                context.Response.Write("-8");//-8传入参数不符合要求
                return;
            }
            model.idCity = idCity;
            model.cCityname = cCityname;
            model.cAddress = cAddress;
            model.cZipcode = cZipcode;
            model.cMobile = cMobile;
            model.cName = cName;
            model.cMail = user.cMail;
        }
        else
        {
            if (user.cCityname.Length == 0 || user.cCityname.Length > 64 || user.cAddress.Length == 0 || user.cAddress.Length > 128 || user.cZipcode.Length == 0 || user.cZipcode.Length > 6 || user.cMobile.Length == 0 || user.cMobile.Length > 32 || user.cName.Length == 0 || user.cName.Length > 64)
            {
                context.Response.Write("-8");//-8传入参数不符合要求
                return;
            }
            model.idCity = user.idCity;
            model.cCityname = user.cCityname;
            model.cAddress = user.cAddress;
            model.cZipcode = user.cZipcode;
            model.cMobile = user.cMobile;
            model.cName = user.cName;
            model.cMail = user.cMail;
        }
        model.cMark1 = contbox;
        string orderid = new DB1.tblShopping().GetMaxOrderId("JF");
        if (orderid == "")
        {
            orderid = "JF" + DateTime.Now.ToString("yyyyMMdd") + "000001";
        }

        else
        {
            orderid = "JF" + DateTime.Now.ToString("yyyyMMdd") + (Convert.ToInt32(orderid.Substring(orderid.Length - 6, 6)) + 1).ToString().PadLeft(6, '0');
        }
        model.idOrder = orderid;
        model.idUser = user.uId;
        model.iState = 1;
        model.dConfirm = new DB6.tblOrder().GetTime(0);
        int idShop = new DB1.tblShopping().Add(model);
        if (idShop > 0)
        {
            DBM1.tblReserve mReserve = new DBM1.tblReserve();
            mReserve.id = idReserve;
            mReserve.iReserve = reserve.iReserve - iNum;
            new DB1.tblReserve().Update(mReserve);
            DBM1.tblGoods mGood = new DBM1.tblGoods();
            mGood.id = idGood;
            mGood.iReserve = good.iReserve + iNum;
            mGood.iBuyNum = good.iBuyNum + iNum;
            new DB1.tblGoods().Update(mGood);
            DBM1.tblShopping mShop = new DB1.tblShopping().GetModel(idShop);          
            new DB1.tblIntegral().InsertScore(user.uId, 200840004, 4, mShop.cScore ?? 0, "兑换商品，商品" + mShop.idGood.ToString());
            context.Response.Write(mShop.idOrder);//成功
            //context.Response.Write(idShop);
        }
        else
        {
            context.Response.Write("0");//失败
        }
    }
    //提交订单拼团
    public void SubmitTour(HttpContext context)
    {
        int idGood = TypeChangeDefault.NullToInt(context.Request["idGood"], 0);//商品id
        int idReserve = TypeChangeDefault.NullToInt(context.Request["idReserve"], 0);//库存id
        int iNum = TypeChangeDefault.NullToInt(context.Request["iNum"], 0);//购买数量
        int fScore = TypeChangeDefault.NullToInt(context.Request["fScore"], 0);//是否使用积分

        int isAddress = TypeChangeDefault.NullToInt(context.Request["isAddress"], 0);//是否使用新地址
        int idCity = TypeChangeDefault.NullToInt(context.Request["idCity"], 0);//城市id
        string cCityname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["Cityname"]), "");//城市名称
        string cAddress = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["newaddress"]), "");//地址
        string cZipcode = TypeChangeDefault.NullToString(context.Request["newzipcode"], "");//邮编
        string cMobile = TypeChangeDefault.NullToString(context.Request["newtel"], "");//电话
        string cName = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["newname"]), "");//姓名
        string contbox = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["contbox"]), "");//备注
        //-1未登录-2商品不存在，-3 库存不存在，-4超出用户最大限额-5团购价格不存在-6不是拼团-7积分使用不相符-8传入参数不符合要求-9该物品已卖光-10该商品不数量不足-11商品类型不匹配-12积分不足-13兑换卷已售完，0失败，成功返回订单号，
        //具体的页面数     
        if (context.Session["CurrentUser"] == null)
        {
            context.Response.Write("-1");//-1未登录
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
        if (isAddress == 1)
        {
            if (cCityname.Trim().Length == 0 || cCityname.Trim().Length > 64 || cAddress.Trim().Length == 0 || cAddress.Trim().Length > 256 || cZipcode.Trim().Length == 0 || cZipcode.Trim().Length > 6 || cMobile.Trim().Length == 0 || cMobile.Trim().Length > 32 || cName.Trim().Length == 0 || cName.Trim().Length > 64)
            {
                context.Response.Write("-8");//-8传入参数不符合要求
                return;
            }
        }
        else
        {
            if (user.cCityname.Length == 0 || user.cCityname.Length > 64 || user.cAddress.Length == 0 || user.cAddress.Length > 128 || user.cZipcode.Length == 0 || user.cZipcode.Length > 6 || user.cMobile.Length == 0 || user.cMobile.Length > 32 || user.cName.Length == 0 || user.cName.Length > 64)
            {
                context.Response.Write("-8");//-8传入参数不符合要求
                return;
            }
        }

        DBM1.tblGoods good = new DB1.tblGoods().GetModel(idGood);
        if (good == null)
        {
            context.Response.Write("-2");//-2商品不存在
            return;
        }
        if (good.iType != 2)
        {
            context.Response.Write("-11");//-11商品类型不匹配
            return;
        }
        if (good.iEntity == 0)
        {
            int codeCount = new DB5.tblCode().GetRecordCount("iValid=0");
            if (codeCount == 0)
            {
                context.Response.Write("-13");//-13兑换卷已售完               
                return;
            }
        }
        DBM1.tblReserve reserve = new DB1.tblReserve().GetModel(idReserve);
        if (reserve == null)
        {
            context.Response.Write("-3");//-2库存不存在
            return;
        }
        if (reserve.iReserve == 0)
        {
            context.Response.Write("-9");//-9该物品已卖光
            return;
        }
        if (iNum == 0)
        {
            context.Response.Write("-9");//-9该物品已卖光
            return;
        }
        if (iNum > reserve.iReserve)
        {
            context.Response.Write("-10");//-10该商品不数量不足
            return;
        }

        int count = new DB1.tblShopping().GetBuyGoodNum("iState>0 and idUser=" + user.uId.ToString() + " and idGood=" + idGood.ToString()) + iNum;//购买总数量
        if (count > good.iQuantity)
        {
            context.Response.Write("-4");//-4超出用户最大限额
            return;
        }
        decimal iCost = 0;//总金额       
        if (good.idTour == 1)
        {
            DataTable dt = new DB1.tblTour().GetList(1, "idGood=" + idGood.ToString() + "and iBuyNum<=" + good.iBuyNum, " iBuyNum desc ").Tables[0];
            if (dt.Rows.Count > 0)
            {
                iCost = TypeChangeDefault.NullToDecimal(dt.Rows[0]["fBuyPrice"].ToString(), 0);
            }
            else
            {
                context.Response.Write("-5");//团购价格不存在
                return;
            }
        }
        else
        {
            context.Response.Write("-6");//不是拼团
            return;
        }

        DBM1.tblShopping model = new DBM1.tblShopping();
        model.idGood = idGood;
        model.cGoodName = good.cName;
        model.iType = good.iType;
        model.idReserve = idReserve;
        model.cSize = reserve.cSize;
        model.cColor = reserve.cColor;
        if (reserve.cImage.Trim().Length == 0)
        {
            model.cImage = good.cImage;
        }
        else
        {
            model.cImage = reserve.cImage;
        }
        //model.cImage = reserve.cImage;
        model.iBuyNum = iNum;
        model.fPrice = iCost * iNum;//成交价格

        //是否使用积分
        if (fScore == 1)
        {
            if (fScore != good.fScore)
            {
                context.Response.Write("-7");//-7积分使用不相符
                return;
            }
            int jf = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + user.uId, user.uId);
            if (jf < good.iScore)
            {
                context.Response.Write("-12");//-12积分不足
                return;
            }
            model.cScore = good.iScore;
            model.fMoney = good.iMoney;
            model.iCost = model.fPrice - good.iMoney;
        }
        else
        {
            model.cScore = 0;
            model.fMoney = 0;
            model.iCost = model.fPrice;
        }
        model.isUse = fScore;

        if (isAddress == 1)
        {
            model.idCity = idCity;
            model.cCityname = cCityname;
            model.cAddress = cAddress;
            model.cZipcode = cZipcode;
            model.cMobile = cMobile;
            model.cName = cName;
            model.cMail = user.cMail;
        }
        else
        {
            model.idCity = user.idCity;
            model.cCityname = user.cCityname;
            model.cAddress = user.cAddress;
            model.cZipcode = user.cZipcode;
            model.cMobile = user.cMobile;
            model.cName = user.cName;
            model.cMail = user.cMail;
        }
        model.cMark1 = contbox;
        string orderid = new DB1.tblShopping().GetMaxOrderId("PT");
        if (orderid == "")
        {
            orderid = "PT" + DateTime.Now.ToString("yyyyMMdd") + "000001";
        }

        else
        {
            orderid = "PT" + DateTime.Now.ToString("yyyyMMdd") + (Convert.ToInt32(orderid.Substring(orderid.Length - 6, 6)) + 1).ToString().PadLeft(6, '0');
        }
        model.idOrder = orderid;
        model.idUser = user.uId;
        model.iState = 1;
        model.dConfirm = new DB6.tblOrder().GetTime(0);
        int idShop = new DB1.tblShopping().Add(model);
        if (idShop > 0)
        {
            DBM1.tblReserve mReserve = new DBM1.tblReserve();
            mReserve.id = idReserve;
            mReserve.iReserve = reserve.iReserve - iNum;
            new DB1.tblReserve().Update(mReserve);
            DBM1.tblGoods mGood = new DBM1.tblGoods();
            mGood.id = idGood;
            mGood.iReserve = good.iReserve + iNum;
            mGood.iBuyNum = good.iBuyNum + iNum;
            new DB1.tblGoods().Update(mGood);
            DBM1.tblShopping mShop = new DB1.tblShopping().GetModel(idShop);
            if (fScore == 1)//扣积分
            {
                new DB1.tblIntegral().InsertScore(user.uId, 200840004, 4, mShop.cScore ?? 0, "拼团商品，商品" + mShop.idGood.ToString());
            }
            context.Response.Write(mShop.idOrder);//成功
            //context.Response.Write(idShop);
        }
        else
        {
            context.Response.Write("0");//失败
        }
    }


    //提交订单众筹
    public void SubmitTour_zc(HttpContext context)
    {
        int idGood = TypeChangeDefault.NullToInt(context.Request["idGood"], 0);//商品id
        int idReserve = TypeChangeDefault.NullToInt(context.Request["idReserve"], 0);//库存id
        int iNum = TypeChangeDefault.NullToInt(context.Request["iNum"], 0);//购买数量
        int fScore = TypeChangeDefault.NullToInt(context.Request["fScore"], 0);//是否使用积分

        int isAddress = TypeChangeDefault.NullToInt(context.Request["isAddress"], 0);//是否使用新地址
        int idCity = TypeChangeDefault.NullToInt(context.Request["idCity"], 0);//城市id
        string cCityname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["Cityname"]), "");//城市名称
        string cAddress = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["newaddress"]), "");//地址
        string cZipcode = TypeChangeDefault.NullToString(context.Request["newzipcode"], "");//邮编
        string cMobile = TypeChangeDefault.NullToString(context.Request["newtel"], "");//电话
        string cName = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["newname"]), "");//姓名
        string contbox = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["contbox"]), "");//备注
        //-1未登录-2商品不存在，-3 库存不存在，-4超出用户最大限额-5团购价格不存在-6不是拼团-7积分使用不相符-8传入参数不符合要求-9该物品已卖光-10该商品不数量不足-11商品类型不匹配-12积分不足-13兑换卷已售完，0失败，成功返回订单号，
        //具体的页面数     
        if (context.Session["CurrentUser"] == null)
        {
            context.Response.Write("-1");//-1未登录
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
        if (isAddress == 1)
        {
            if (cCityname.Trim().Length == 0 || cCityname.Trim().Length > 64 || cAddress.Trim().Length == 0 || cAddress.Trim().Length > 256 || cZipcode.Trim().Length == 0 || cZipcode.Trim().Length > 6 || cMobile.Trim().Length == 0 || cMobile.Trim().Length > 32 || cName.Trim().Length == 0 || cName.Trim().Length > 64)
            {
                context.Response.Write("-8");//-8传入参数不符合要求
                return;
            }
        }
        else
        {
            if (user.cCityname.Length == 0 || user.cCityname.Length > 64 || user.cAddress.Length == 0 || user.cAddress.Length > 128 || user.cZipcode.Length == 0 || user.cZipcode.Length > 6 || user.cMobile.Length == 0 || user.cMobile.Length > 32 || user.cName.Length == 0 || user.cName.Length > 64)
            {
                context.Response.Write("-8");//-8传入参数不符合要求
                return;
            }
        }

        DBM1.tblGoods good = new DB1.tblGoods().GetModel(idGood);
        if (good == null)
        {
            context.Response.Write("-2");//-2商品不存在
            return;
        }
        if (good.iType != 3)
        {
            context.Response.Write("-11");//-11商品类型不匹配
            return;
        }
        if (good.iEntity == 0)
        {
            int codeCount = new DB5.tblCode().GetRecordCount("iValid=0");
            if (codeCount == 0)
            {
                context.Response.Write("-13");//-13兑换卷已售完               
                return;
            }
        }
        DBM1.tblReserve reserve = new DB1.tblReserve().GetModel(idReserve);
        if (reserve == null)
        {
            context.Response.Write("-3");//-2库存不存在
            return;
        }
        if (reserve.iReserve == 0)
        {
            context.Response.Write("-9");//-9该物品已卖光
            return;
        }
        if (iNum == 0)
        {
            context.Response.Write("-9");//-9该物品已卖光
            return;
        }
        if (iNum > reserve.iReserve)
        {
            context.Response.Write("-10");//-10该商品不数量不足
            return;
        }

        int count = new DB1.tblShopping().GetBuyGoodNum("iState>0 and idUser=" + user.uId.ToString() + " and idGood=" + idGood.ToString()) + iNum;//购买总数量
        if (count > good.iQuantity)
        {
            context.Response.Write("-4");//-4超出用户最大限额
            return;
        }
        decimal iCost = 0;//总金额       
        if (good.idTour == 1)
        {
            DataTable dt = new DB1.tblTour().GetList(1, "idGood=" + idGood.ToString() + "and iBuyNum<=" + good.iBuyNum, " iBuyNum desc ").Tables[0];
            if (dt.Rows.Count > 0)
            {
                iCost = TypeChangeDefault.NullToDecimal(dt.Rows[0]["fBuyPrice"].ToString(), 0);
            }
            else
            {
                context.Response.Write("-5");//众筹价格不存在
                return;
            }
        }
        else
        {
            context.Response.Write("-6");//不是众筹
            return;
        }

        DBM1.tblShopping model = new DBM1.tblShopping();
        model.idGood = idGood;
        model.cGoodName = good.cName;
        model.iType = good.iType;
        model.idReserve = idReserve;
        model.cSize = reserve.cSize;
        model.cColor = reserve.cColor;
        if (reserve.cImage.Trim().Length == 0)
        {
            model.cImage = good.cImage;
        }
        else
        {
            model.cImage = reserve.cImage;
        }
        //model.cImage = reserve.cImage;
        model.iBuyNum = iNum;
        model.fPrice = iCost * iNum;//成交价格

        //是否使用积分
        if (fScore == 1)
        {
            if (fScore != good.fScore)
            {
                context.Response.Write("-7");//-7积分使用不相符
                return;
            }
            int jf = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + user.uId, user.uId);
            if (jf < good.iScore)
            {
                context.Response.Write("-12");//-12积分不足
                return;
            }
            model.cScore = good.iScore;
            model.fMoney = good.iMoney;
            model.iCost = model.fPrice - good.iMoney;
        }
        else
        {
            model.cScore = 0;
            model.fMoney = 0;
            model.iCost = model.fPrice;
        }
        model.isUse = fScore;

        if (isAddress == 1)
        {
            model.idCity = idCity;
            model.cCityname = cCityname;
            model.cAddress = cAddress;
            model.cZipcode = cZipcode;
            model.cMobile = cMobile;
            model.cName = cName;
            model.cMail = user.cMail;
        }
        else
        {
            model.idCity = user.idCity;
            model.cCityname = user.cCityname;
            model.cAddress = user.cAddress;
            model.cZipcode = user.cZipcode;
            model.cMobile = user.cMobile;
            model.cName = user.cName;
            model.cMail = user.cMail;
        }
        model.cMark1 = contbox;
        string orderid = new DB1.tblShopping().GetMaxOrderId("ZC");
        if (orderid == "")
        {
            orderid = "ZC" + DateTime.Now.ToString("yyyyMMdd") + "000001";
        }

        else
        {
            orderid = "ZC" + DateTime.Now.ToString("yyyyMMdd") + (Convert.ToInt32(orderid.Substring(orderid.Length - 6, 6)) + 1).ToString().PadLeft(6, '0');
        }
        model.idOrder = orderid;
        model.idUser = user.uId;
        model.iState = 1;
        model.dConfirm = new DB6.tblOrder().GetTime(0);
        int idShop = new DB1.tblShopping().Add(model);
        if (idShop > 0)
        {
            DBM1.tblReserve mReserve = new DBM1.tblReserve();
            mReserve.id = idReserve;
            mReserve.iReserve = reserve.iReserve - iNum;
            new DB1.tblReserve().Update(mReserve);
            DBM1.tblGoods mGood = new DBM1.tblGoods();
            mGood.id = idGood;
            mGood.iReserve = good.iReserve + iNum;
            mGood.iBuyNum = good.iBuyNum + iNum;
            new DB1.tblGoods().Update(mGood);
            DBM1.tblShopping mShop = new DB1.tblShopping().GetModel(idShop);
            if (fScore == 1)//扣积分
            {
                new DB1.tblIntegral().InsertScore(user.uId, 200840004, 4, mShop.cScore ?? 0, "众筹商品，商品" + mShop.idGood.ToString());
            }
            context.Response.Write(mShop.idOrder);//成功
            //context.Response.Write(idShop);
        }
        else
        {
            context.Response.Write("0");//失败
        }
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}