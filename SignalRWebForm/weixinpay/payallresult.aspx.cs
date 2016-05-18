using Erun360.Model.DB6;
using Erun360.Pay.WxPayAPI;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web.UI;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DB2 = Erun360.BLL.DB2;
using DB3 = Erun360.BLL.DB3;
using DB6 = Erun360.BLL.DB6;
using DBM1 = Erun360.Model.DB1;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DBM6 = Erun360.Model.DB6;

public partial class weixinpay_payallresult : PageBase
{
    public string idorder = string.Empty;
    public int sid = 0;//赛事id 
    public int id = 0;//订单id 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        idorder = TypeChangeDefault.NullToString(Request.QueryString["idorder"], "");
        if (!IsPostBack)
        {
            DBM6.tblRace_Competition modelrace = new DB6.tblRace_Competition().GetModel(sid);
            if (modelrace == null)
            {
                AlertHelper.JQAlertGo("请选择赛事！", "/Competetion/SearchEvent.aspx", false);
                return;
            }
            DB6.tblOrder bll = new DB6.tblOrder();
            DBM6.tblOrder modelorder = bll.GetModel(id);
            if (modelorder == null)
            {
                AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/SearchEvent.aspx", false);
                return;
            }           
            if (modelorder.cOrder_no != idorder)
            {
                AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/SearchEvent.aspx", false);
                return;
            }
            ltlTitle.Text = modelorder.iTypeName+"-"+modelorder.cItemName;
            ltlNum.Text = modelorder.iBuyNum.ToString();
           
            ltlSocre.Text = modelorder.iScore.ToString();
            ltlMoney.Text = modelorder.iMoney.ToString();
            ltlPrice.Text = modelorder.iCost.ToString();
            if (modelorder.iStatus == 1)
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
                    if (string.IsNullOrEmpty(ltltrade_no.Text))
                    {
                        DataTable dtOrder = bll.GetList(1, "cOrder_no='" + idorder + "'", "ID desc").Tables[0];
                        if (dtOrder.Rows.Count == 1)
                        {
                            int ID = TypeChangeDefault.NullToInt(dtOrder.Rows[0]["ID"], 0);
                            int idRace = TypeChangeDefault.NullToInt(dtOrder.Rows[0]["iTypeID"], 0);
                            string iStatus = dtOrder.Rows[0]["iStatus"].ToString();

                            int idUser = TypeChangeDefault.NullToInt(dtOrder.Rows[0]["idUser"], 0);
                            string passenger = dtOrder.Rows[0]["passenger"].ToString();
                            string cParentOrder = dtOrder.Rows[0]["cParentOrder"].ToString();
                            int iFromTpye = TypeChangeDefault.NullToInt(dtOrder.Rows[0]["iFromTpye"], 0);
                            string cContent = dtOrder.Rows[0]["iTypeName"].ToString() + "-" + dtOrder.Rows[0]["cItemName"].ToString();
                            if ("1" == iStatus)
                            {
                                DBM6.tblOrder model = new DBM6.tblOrder();
                                model.ID = ID;                               
                                model.iStatus = 2;                                
                                model.dPayTime = bll.GetTime(0);
                                model.cTrade_no = ltltrade_no.Text;
                                if (bll.Update(model))
                                {
                                    if (iFromTpye == 1)//合并付款
                                    {
                                        if (bll.UpdateList("select ID from tblOrder where cParentOrder='" + idorder + "'"))
                                        {
                                            DataTable dt = bll.GetList("cParentOrder='" + idorder + "'").Tables[0];
                                            if (dt.Rows.Count > 0)
                                            {
                                                for (int j = 0; j < dt.Rows.Count; j++)
                                                {
                                                    passenger = dt.Rows[j]["passenger"].ToString();
                                                    cParentOrder = dt.Rows[j]["cParentOrder"].ToString();
                                                    iFromTpye = TypeChangeDefault.NullToInt(dt.Rows[j]["iFromTpye"], 0);
                                                    idRace = TypeChangeDefault.NullToInt(dt.Rows[j]["iTypeID"], 0);
                                                    idUser = TypeChangeDefault.NullToInt(dt.Rows[j]["idUser"], 0);
                                                    ID = TypeChangeDefault.NullToInt(dt.Rows[j]["ID"], 0);
                                                    cContent = dt.Rows[j]["iTypeName"].ToString() + "-" + dt.Rows[j]["cItemName"].ToString();
                                                    if (iFromTpye == 2)//赛事报名
                                                    {
                                                        if (cParentOrder.Trim().Length != 0)
                                                        {
                                                            bll.UpdateStatusByOrder(cParentOrder.Trim());
                                                        }
                                                        string Content = "您在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》中付款成功！请您持续关注，谢谢！";
                                                        string FeedContent = "在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》中报名成功！邀请您<a target=\"_blank\" href=\"/Competetion/projects.aspx?sid=" + idRace + "&nav=2\">[参加]</a>！";
                                                        AddDiscuss(idUser, Content, 100001183);
                                                        AddFeed(idUser, ID, "44", FeedContent, "");
                                                        GetEventDetail(passenger, cParentOrder);
                                                        //报名赛事最低送10积分
                                                        int iScore = TypeChangeDefault.NullToInt(dtOrder.Rows[0]["iScore"], 99);
                                                        if (iScore == 0)
                                                        {
                                                            new DB1.tblIntegral().InsertScore(TypeChangeDefault.NullToInt(dtOrder.Rows[0]["idUser"].ToString().Trim(), 0), 200820001, 2, TypeChangeDefault.NullToDecimal(dtOrder.Rows[0]["iCost"].ToString().Trim(), 0));
                                                        }
                                                    }
                                                    else if (iFromTpye == 3)//机票
                                                    {
                                                        if (cParentOrder.Trim().Length != 0)
                                                        {
                                                            bll.UpdateStatusByOrder(cParentOrder.Trim());
                                                        }
                                                        string Content = "您已成功购买了" + dtOrder.Rows[0]["FlightDate"].ToString().Trim() + dtOrder.Rows[0]["cItemName"].ToString().Trim() + "《" + dtOrder.Rows[0]["iItemID"].ToString().Trim() + "》航班机票！请您持续关注，谢谢！";
                                                        string FeedContent = "成功订购" + dtOrder.Rows[0]["FlightDate"].ToString().Trim() + dtOrder.Rows[0]["cItemName"].ToString().Trim() + "的" + dtOrder.Rows[0]["iItemID"].ToString().Trim() + "航班机票！<a target=\"_blank\" href=\"/Flight/flightgroom.aspx\">[查看]</a>！";
                                                        AddDiscuss(idUser, Content, 100001183);
                                                        AddFeed(idUser, ID, "44", FeedContent, "");
                                                        GetFlightDetail(ID);
                                                    }
                                                    else if (iFromTpye == 4)//酒店
                                                    {
                                                        if (cParentOrder.Trim().Length != 0)
                                                        {
                                                            bll.UpdateStatusByOrder(cParentOrder.Trim());
                                                        }
                                                        string Content = "您在《" + cContent + "》中付款成功！请您持续关注，谢谢！";
                                                        string FeedContent = "在《" + cContent + "》中购买成功！邀请您<a target=\"_blank\" href=\"Competetion/hotel.aspx?sid=" + idRace + "&nav=4\">[参加]</a>！";
                                                        AddDiscuss(idUser, Content, 100001183);
                                                        AddFeed(idUser, ID, "44", FeedContent, "");
                                                        GetHotelDetail(passenger, cParentOrder);
                                                        //报名赛事最低送10积分

                                                    }
                                                    else if (iFromTpye == 5)//旅游
                                                    {
                                                        if (cParentOrder.Trim().Length != 0)
                                                        {
                                                            bll.UpdateStatusByOrder(cParentOrder.Trim());
                                                        }
                                                        string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                                                        string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/tour.aspx?sid=" + idRace + "&nav=5\">[去看看]</a>！";
                                                        AddDiscuss(idUser, Content, 100001183);
                                                        AddFeed(idUser, ID, "44", FeedContent, "");
                                                        GetTourDetail(passenger, cParentOrder);
                                                    }
                                                    else if (iFromTpye == 8)//推荐装备
                                                    {
                                                        if (cParentOrder.Trim().Length != 0)
                                                        {
                                                            bll.UpdateStatusByOrder(cParentOrder.Trim());
                                                        }
                                                        string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                                                        string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/equipment.aspx?sid=" + idRace + "&nav=8\">[去看看]</a>！";
                                                        AddDiscuss(idUser, Content, 100001183);
                                                        AddFeed(idUser, ID, "44", FeedContent, "");
                                                        GetEquipmentDetail(passenger, cParentOrder);
                                                    }
                                                    else if (iFromTpye == 9)//附属产品
                                                    {
                                                        if (cParentOrder.Trim().Length != 0)
                                                        {
                                                            bll.UpdateStatusByOrder(cParentOrder.Trim());
                                                        }
                                                        string Content = "您已成功购买了《" + cContent.TrimEnd('-') + "》产品！请您持续关注，谢谢！";
                                                        string FeedContent = "成功订购《" + cContent.TrimEnd('-') + "》产品！您也<a target=\"_blank\" href=\"/Competetion/annex.aspx?sid=" + idRace + "&nav=9\">[去看看]</a>！";
                                                        AddDiscuss(idUser, Content, 100001183);
                                                        AddFeed(idUser, ID, "44", FeedContent, "");
                                                        GetAnnexDetail(passenger, cParentOrder);
                                                    }
                                                }
                                            }
                                        }

                                    }
                                    else if (iFromTpye == 2)//赛事报名
                                    {
                                        if (cParentOrder.Trim().Length != 0)
                                        {
                                            bll.UpdateStatusByOrder(cParentOrder.Trim());
                                        }
                                        string Content = "您在《" + cContent + "》中付款成功！请您持续关注，谢谢！";
                                        string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">[去看看]</a>！";
                                        AddDiscuss(idUser, Content, 100001183);
                                        AddFeed(idUser, ID, "44", FeedContent, "");
                                        GetEventDetail(passenger, cParentOrder);
                                        //报名赛事最低送10积分
                                        int iScore = TypeChangeDefault.NullToInt(dtOrder.Rows[0]["iScore"], 99);
                                        if (iScore == 0)
                                        {
                                            new DB1.tblIntegral().InsertScore(TypeChangeDefault.NullToInt(dtOrder.Rows[0]["idUser"].ToString().Trim(), 0), 200820001, 2, TypeChangeDefault.NullToDecimal(dtOrder.Rows[0]["iCost"].ToString().Trim(), 0));
                                        }
                                    }
                                    else if (iFromTpye == 3)//机票
                                    {
                                        if (cParentOrder.Trim().Length != 0)
                                        {
                                            bll.UpdateStatusByOrder(cParentOrder.Trim());
                                        }
                                        string Content = "您已成功购买了" + dtOrder.Rows[0]["FlightDate"].ToString().Trim() + dtOrder.Rows[0]["cItemName"].ToString().Trim() + "《" + dtOrder.Rows[0]["iItemID"].ToString().Trim() + "》航班机票！请您持续关注，谢谢！";
                                        string FeedContent = "成功订购" + dtOrder.Rows[0]["FlightDate"].ToString().Trim() + dtOrder.Rows[0]["cItemName"].ToString().Trim() + "的" + dtOrder.Rows[0]["iItemID"].ToString().Trim() + "航班机票！<a target=\"_blank\" href=\"/Flight/flightgroom.aspx\">[查看]</a>！";
                                        AddDiscuss(idUser, Content, 100001183);
                                        AddFeed(idUser, ID, "44", FeedContent, "");
                                        GetFlightDetail(ID);
                                    }
                                    else if (iFromTpye == 4)//酒店
                                    {
                                        if (cParentOrder.Trim().Length != 0)
                                        {
                                            bll.UpdateStatusByOrder(cParentOrder.Trim());
                                        }
                                        string Content = "您在《" + cContent + "》中付款成功！请您持续关注，谢谢！";
                                        string FeedContent = "在《" + cContent + "》中购买成功！邀请您<a target=\"_blank\" href=\"Competetion/hotel.aspx?sid=" + idRace + "&nav=4\">[参加]</a>！";
                                        AddDiscuss(idUser, Content, 100001183);
                                        AddFeed(idUser, ID, "44", FeedContent, "");
                                        GetHotelDetail(passenger, cParentOrder);
                                        //报名赛事最低送10积分

                                    }
                                    else if (iFromTpye == 5)//旅游
                                    {
                                        if (cParentOrder.Trim().Length != 0)
                                        {
                                            bll.UpdateStatusByOrder(cParentOrder.Trim());
                                        }
                                        string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                                        string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/tour.aspx?sid=" + idRace + "&nav=5\">[去看看]</a>！";
                                        AddDiscuss(idUser, Content, 100001183);
                                        AddFeed(idUser, ID, "44", FeedContent, "");
                                        GetTourDetail(passenger, cParentOrder);
                                    }
                                    else if (iFromTpye == 8)//推荐装备
                                    {
                                        if (cParentOrder.Trim().Length != 0)
                                        {
                                            bll.UpdateStatusByOrder(cParentOrder.Trim());
                                        }
                                        string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                                        string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/equipment.aspx?sid=" + idRace + "&nav=8\">[去看看]</a>！";
                                        AddDiscuss(idUser, Content, 100001183);
                                        AddFeed(idUser, ID, "44", FeedContent, "");
                                        GetEquipmentDetail(passenger, cParentOrder);
                                    }
                                    else if (iFromTpye == 9)//附属产品
                                    {
                                        if (cParentOrder.Trim().Length != 0)
                                        {
                                            bll.UpdateStatusByOrder(cParentOrder.Trim());
                                        }
                                        string Content = "您已成功购买了《" + cContent.TrimEnd('-') + "》产品！请您持续关注，谢谢！";
                                        string FeedContent = "成功订购《" + cContent.TrimEnd('-') + "》产品！您也<a target=\"_blank\" href=\"/Competetion/annex.aspx?sid=" + idRace + "&nav=9\">[去看看]</a>！";
                                        AddDiscuss(idUser, Content, 100001183);
                                        AddFeed(idUser, ID, "44", FeedContent, "");
                                        GetAnnexDetail(passenger, cParentOrder);
                                    }
                                }

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
        }
    }

    #region 购买旅游产品详情
    private static void GetTourDetail(string passenger, string cParentOrder)
    {
        var x = JsonConvert.DeserializeObject<DBM6.tbltour_Detail>(passenger);
        DBM6.tbltour_Detail model = new DBM6.tbltour_Detail
        {
            idCompete = x.idCompete,
            cCompetitionName = x.cCompetitionName,
            idItem = x.idItem,
            cItemName = x.cItemName,
            idUser = x.idUser,
            cFullname = x.cFullname,
            cGender = x.cGender,
            idBlood = x.idBlood,
            dBirthday = x.dBirthday,
            IdType = x.IdType,
            IdNo = x.IdNo,
            cNational = x.cNational,
            cMobile = x.cMobile,
            cMail = x.cMail,
            idCity = x.idCity,
            cCityname = x.cCityname,
            cAddress = x.cAddress,
            cZipcode = x.cZipcode,
            dCreate = new DB6.tblOrder().GetTime(0),
            //cParentOrder = x.cParentOrder,
            cOrder_no = x.cOrder_no,
            cMake = x.cMake,
            cMake1 = x.cMake1,
            cMake2 = x.cMake2,
            cMake3 = x.cMake3
        };
        model.cParentOrder = cParentOrder;
        new DB6.tbltour_Detail().Add(model);
    }
    #endregion
    #region 购买装备产品详情
    private static void GetEquipmentDetail(string passenger, string cParentOrder)
    {
        var x = JsonConvert.DeserializeObject<DBM6.tblEquipment_Detail>(passenger);
        DBM6.tblEquipment_Detail model = new DBM6.tblEquipment_Detail
        {
            idCompete = x.idCompete,
            cCompetitionName = x.cCompetitionName,
            idItem = x.idItem,
            cItemName = x.cItemName,
            idUser = x.idUser,
            cFullname = x.cFullname,
            cGender = x.cGender,
            idBlood = x.idBlood,
            dBirthday = x.dBirthday,
            IdType = x.IdType,
            IdNo = x.IdNo,
            cNational = x.cNational,
            cMobile = x.cMobile,
            cMail = x.cMail,
            idCity = x.idCity,
            cCityname = x.cCityname,
            cAddress = x.cAddress,
            cZipcode = x.cZipcode,
            dCreate = new DB6.tblOrder().GetTime(0),
            //cParentOrder = x.cParentOrder,
            cOrder_no = x.cOrder_no,
            cMake = x.cMake,
            cMake1 = x.cMake1,
            cMake2 = x.cMake2,
            cMake3 = x.cMake3
        };
        model.cParentOrder = cParentOrder;
        new DB6.tblEquipment_Detail().Add(model);
    }
    #endregion
    #region 购买酒店产品详情
    private static void GetHotelDetail(string passenger, string cParentOrder)
    {
        List<DBM6.tblHotel_Detail> userlist = JsonConvert.DeserializeObject<List<DBM6.tblHotel_Detail>>(passenger);
        foreach (DBM6.tblHotel_Detail x in userlist)
        {
            DBM6.tblHotel_Detail model = new DBM6.tblHotel_Detail
            {
                idCompete = x.idCompete,
                cCompetitionName = x.cCompetitionName,
                idItem = x.idItem,
                cItemName = x.cItemName,
                idUser = x.idUser,
                cFullname = x.cFullname,
                cGender = x.cGender,
                idBlood = x.idBlood,
                dBirthday = x.dBirthday,
                IdType = x.IdType,
                IdNo = x.IdNo,
                cNational = x.cNational,
                cMobile = x.cMobile,
                cMail = x.cMail,
                idCity = x.idCity,
                cCityname = x.cCityname,
                cAddress = x.cAddress,
                cZipcode = x.cZipcode,
                dCreate = new DB6.tblOrder().GetTime(0),
                //cParentOrder = x.cParentOrder,
                cOrder_no = x.cOrder_no,
                cMake = x.cMake,
                cMake1 = x.cMake1,
                cMake2 = x.cMake2,
                cMake3 = x.cMake3
            };
            model.cParentOrder = cParentOrder;
            new DB6.tblHotel_Detail().Add(model);
        }
    }
    #endregion
    #region 购买附属产品详情
    private static void GetAnnexDetail(string passenger, string cParentOrder)
    {
        var x = JsonConvert.DeserializeObject<DBM6.tblAnnex_Detail>(passenger);
        DBM6.tblAnnex_Detail model = new DBM6.tblAnnex_Detail
        {
            idCompete = x.idCompete,
            cCompetitionName = x.cCompetitionName,
            idItem = x.idItem,
            cItemName = x.cItemName,
            idUser = x.idUser,
            cFullname = x.cFullname,
            cGender = x.cGender,
            idBlood = x.idBlood,
            dBirthday = x.dBirthday,
            IdType = x.IdType,
            IdNo = x.IdNo,
            cNational = x.cNational,
            cMobile = x.cMobile,
            cMail = x.cMail,
            idCity = x.idCity,
            cCityname = x.cCityname,
            cAddress = x.cAddress,
            cZipcode = x.cZipcode,
            dCreate = new DB6.tblOrder().GetTime(0),
            //cParentOrder = x.cParentOrder,
            cOrder_no = x.cOrder_no,
            cMake = x.cMake,
            cMake1 = x.cMake1,
            cMake2 = x.cMake2,
            cMake3 = x.cMake3
        };
        model.cParentOrder = cParentOrder;
        new DB6.tblAnnex_Detail().Add(model);
    }
    #endregion
    #region 购买赛事详情
    private static void GetEventDetail(string passenger, string cParentOrder)
    {
        var x = JsonConvert.DeserializeObject<DBM6.tblRace_Detail>(passenger);
        DBM6.tblRace_Detail model = new DBM6.tblRace_Detail
        {
            idCompete = x.idCompete,
            cCompetitionName = x.cCompetitionName,
            idItem = x.idItem,
            cItemName = x.cItemName,
            idUser = x.idUser,
            csurname = x.csurname,
            cname = x.cname,
            cFullname = x.cFullname,
            cGender = x.cGender,
            idBlood = x.idBlood,
            dBirthday = x.dBirthday,
            IdType = x.IdType,
            IdNo = x.IdNo,
            cNational = x.cNational,
            cMobile = x.cMobile,
            cMail = x.cMail,
            idCity = x.idCity,
            cCityname = x.cCityname,
            cAddress = x.cAddress,
            cZipcode = x.cZipcode,
            idEducation = x.idEducation,
            idOccupation = x.idOccupation,
            cEmergerContact = x.cEmergerContact,
            cPlace = x.cPlace,
            dIssue = x.dIssue,
            dExpiry = x.dExpiry,
            cFirst = x.cFirst,
            cresult = x.cresult,
            dCreate = new DB6.tblOrder().GetTime(0),
            cCloth = x.cCloth,
            cShoe = x.cShoe,
            cHealthUrl = x.cHealthUrl,
            cECG = x.cECG,
            cFinished = x.cFinished,
            cMake = x.cMake,
            //cParentOrder = x.cParentOrder,
            cOrder_no = x.cOrder_no,
            cMake1 = x.cMake1,
            cMake2 = x.cMake2,
            cMake3 = x.cMake3,
            cMake4 = x.cMake4
        };
        model.cParentOrder = cParentOrder;
        new DB6.tblRace_Detail().Add(model);
    }
    #endregion
    #region 购买机票详情表(插入更买成功的人的信息)
    private void GetFlightDetail(int IdFlight)
    {
        DBM6.tblOrder model = new DB6.tblOrder().GetModel(IdFlight);
        Flight_User erunuser = new Flight_User();
        erunuser.userName = "erun360";
        erunuser.password = "erun_360_admin";
        erunuser.cdKey = "3nv40T4zChc=e360";
        string jsonPerson = JsonSerializer<Flight_User>(erunuser);
        string re_login_Value = PostWebRequest(@"http://cs.10lx.com:8081/OAFlight_Token.aspx", jsonPerson, Encoding.UTF8);
        Return_Login_Value login = JsonDeserialize<Return_Login_Value>(re_login_Value);
        if (login.status == "0")
        {
            Flight_Pay pay = new Flight_Pay();
            pay.token = login.token;
            pay.oid = model.cOid;
            pay.info = model.cInfo;
            string jsonPay = JsonSerializer<Flight_Pay>(pay);
            string AesPay = AESHelper.Encrypt(jsonPay, "3nv40T4zChc=e360");
            string returnPayValue = PostWebRequest(@"http://cs.10lx.com:8081/OAFlight_Pay.aspx", AesPay, Encoding.UTF8);
            string resultPay = AESHelper.Decrypt(returnPayValue, "3nv40T4zChc=e360");
            Return_Pay_Value re_pay = JsonDeserialize<Return_Pay_Value>(resultPay);
            if (re_pay.status == "0")
            {
                List<LinkMan> userlist = JsonDeserialize<List<LinkMan>>(model.passenger); //乘客信息集合json 格式   
                foreach (LinkMan p in userlist)
                {
                    tblFlight_Detail detail = new tblFlight_Detail();
                    detail.OrderId = model.cInfo;
                    detail.Segment = model.cItems;
                    detail.ContactPeople = model.cName;
                    detail.ContactPhoneNumber = model.cMobile;
                    detail.ContactAddress = model.cAddress;
                    detail.cOrder_no = model.cOrder_no;
                    detail.idUser = model.idUser;
                    detail.cNickName = model.cNickName;
                    detail.FlightDate = model.FlightDate;
                    detail.cname = p.Name;
                    detail.cPhone = p.Phone;
                    detail.IdType = p.IdType;
                    detail.IdNo = p.IdNo;
                    detail.cInsurance = TypeChangeDefault.NullToInt(p.Insurance, 0);
                    detail.dCreateTime = new DB6.tblOrder().GetTime(0);
                    new DB6.tblFlight_Detail().Add(detail);
                }
            }
        }
    }
    private string PostWebRequest(string postUrl, string paramData, Encoding dataEncode)
    {
        string ret = string.Empty;
        System.Net.WebClient WebClientObj = new System.Net.WebClient();
        try
        {
            byte[] byteArray = dataEncode.GetBytes(paramData); //转化
            HttpWebRequest webReq = (HttpWebRequest)WebRequest.Create(new Uri(postUrl));
            webReq.Method = "POST";
            webReq.ContentType = "application/x-www-form-urlencoded";

            webReq.ContentLength = byteArray.Length;
            Stream newStream = webReq.GetRequestStream();
            newStream.Write(byteArray, 0, byteArray.Length);//写入参数
            newStream.Close();
            HttpWebResponse response = (HttpWebResponse)webReq.GetResponse();
            StreamReader sr = new StreamReader(response.GetResponseStream(), Encoding.Default);
            ret = sr.ReadToEnd();
            sr.Close();
            response.Close();
            newStream.Close();
        }
        catch (Exception ex)
        {
            return string.Empty;
        }
        return ret;
    }
    #endregion
    #region 插入评论
    /// <summary>
    /// 插入评论
    /// </summary>
    /// <param name="idUser">接受消息人</param>
    /// <param name="IdCritic">发送消息人（一般是益跑赛事，100001183）</param>
    /// <param name="Content">评论内容（消息内容）</param>
    private static void AddDiscuss(int idUser, string Content, int IdCritic = 100001183)
    {
        DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
        DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
        DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(IdCritic);
        disModel.cContent = Content;//"您在《" + model.iTypeName + "-" + model.cItemName + "》中付款成功！请您持续关注！";
        disModel.idInfo = idUser;
        disModel.idUser = IdCritic;
        disModel.cLoginname = user.cNickName;
        disModel.dCreate = new DB6.tblOrder().GetTime(0);
        int imessage = disBll.Add(disModel);
        if (imessage > 0)
        {
            DBM3.tblMessage mMessage = new DBM3.tblMessage();
            mMessage.cId = IdCritic;
            mMessage.uId = idUser;
            mMessage.itype = 31;
            mMessage.idcode = imessage;
            new DB3.tblMessage().Add(mMessage);
        }
    }
    #endregion
    #region 插入活动记录表
    /// <summary>
    /// 插入活动记录表
    /// </summary>
    /// <param name="idUser">用户id</param>
    /// <param name="idBlog">对应记录id</param>
    /// <param name="idGroup">分类id</param>
    /// <param name="Content">内容</param>
    /// <param name="Bio">简介</param>
    private static void AddFeed(int idUser, int idBlog, string idGroup, string Content, string Bio)
    {
        DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(idUser);
        if (user != null)
        {
            DBM2.tblActivity mActivity = new DBM2.tblActivity();
            mActivity.idUser = user.id;
            mActivity.cNickName = user.cNickName;
            mActivity.cAvatar = user.cAvatar;
            mActivity.idBlog = idBlog;
            mActivity.idGroup = idGroup;
            mActivity.cTitle = Content;
            mActivity.cBio = Bio;
            mActivity.dCreate = new DB6.tblOrder().GetTime(0);
            new DB2.tblActivity().Add(mActivity);
        }
    }
    #endregion
    #region 序列化JSON序列化和反序列化辅助类
    /// <summary>
    /// JSON序列化
    /// </summary>
    public static string JsonSerializer<T>(T t)
    {
        DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(T));
        MemoryStream ms = new MemoryStream();
        ser.WriteObject(ms, t);
        string jsonString = Encoding.UTF8.GetString(ms.ToArray());
        ms.Close();
        return jsonString;
    }
    /// <summary>
    /// JSON反序列化
    /// </summary>
    public static T JsonDeserialize<T>(string jsonString)
    {
        DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(T));
        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(jsonString));
        T obj = (T)ser.ReadObject(ms);
        return obj;
    }
    #endregion
}