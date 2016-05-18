using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBM6 = Erun360.Model.DB6;
using DB6 = Erun360.BLL.DB6;
using System.Xml;
using Com.Alipay;
using Utils;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Text;
using Erun360.Model.DB6;
using System.Net;
using Newtonsoft.Json;
using System.Data;
using DBM4 = Erun360.Model.DB4;
using DB4 = Erun360.BLL.DB4;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
public partial class Competetion_OrderDetails : PageBase
{
    public int sid = 0;//赛事id
    public string Result = string.Empty;
    public string title = string.Empty;
    public string OrderNo = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
        OrderNo = TypeChangeDefault.NullToString(Request.QueryString["orderid"], "");
        if (!IsPostBack)
        {
            DBM6.tblRace_Competition model = new DB6.tblRace_Competition().GetModel(sid);
            if (model == null)
            {
                AlertHelper.JQAlertGo("请选择赛事！", "/Competetion/SearchEvent.aspx", false);
                return;
            }
            int idUser = 0;
            if (CurrentUser != null)
            {
                idUser = CurrentUser.uId;
            }
            if (model.idUser != idUser || idUser != 100000002)
            {
                if (1 != model.iStatus)
                {
                    AlertHelper.JQAlertGo("该赛事已关闭！", "/Competetion/SearchEvent.aspx", false);
                    return;
                }
            }
            title = model.cTitle;
            this.page_Title = title + "-赛事介绍-益跑网赛事报名";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            
            ltlbanner.Text = model.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + model.cBanner + "\" alt=\"\"/>";

            //DataTable dt = new DB6.tblOrder().GetList("cOrder_no='" + OrderNo + "' and idUser=" + CurrentUser.uId + " and iStatus=1 ").Tables[0];
            DataTable dt = new DB6.tblOrder().GetList("cOrder_no='" + OrderNo + "' and idUser=" + CurrentUser.uId).Tables[0];
            int count = dt.Rows.Count;
            if (count == 0)
            {
                AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
            if ("9" == dt.Rows[0]["iFromTpye"].ToString())
            {
                ltlItem.Text = dt.Rows[0]["iTypeName"].ToString();
            }
            else
            {
                ltlItem.Text = dt.Rows[0]["cItemName"].ToString();
            }
            ltlCost.Text = dt.Rows[0]["iCost"].ToString();
            if ("1" == dt.Rows[0]["iStatus"].ToString())
            {
                if (0 == TypeChangeDefault.NullToDecimal(dt.Rows[0]["iCost"], 0))
                {
                    DB6.tblOrder bll = new DB6.tblOrder();
                    int id = TypeChangeDefault.NullToInt(dt.Rows[0]["ID"], 0);
                    int iFromTpye = TypeChangeDefault.NullToInt(dt.Rows[0]["iFromTpye"], 2);
                    string cContent = dt.Rows[0]["iTypeName"].ToString() + "-" + dt.Rows[0]["cItemName"].ToString();
                   
                    DBM6.tblOrder mOrder = bll.GetModel(id);
                    if (mOrder != null)
                    {

                        mOrder.ID = id;
                        mOrder.iStatus = 2;
                        mOrder.dPayTime = bll.GetTime(0);
                        mOrder.cMake1 = "自动处理";
                        if (bll.Update(mOrder))
                        {
                            //付款成功处理
                            //父订单号置过期
                            if (mOrder.cParentOrder.Trim().Length != 0)
                            {
                                bll.UpdateStatusByOrder(mOrder.cParentOrder.Trim());
                            }
                            if (iFromTpye == 2)//赛事报名
                            {
                                string Content = "您在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1\">" + cContent + "</a>》中付款成功！请您持续关注，谢谢！";
                                string FeedContent = "在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1\">" + cContent + "</a>》中报名成功！邀请您<a target=\"_blank\" href=\"/Competetion/projects.aspx?sid=" + sid + "&nav=2\">[参加]</a>！";
                                AddDiscuss(idUser, Content);
                                AddFeed(idUser, id, "44", FeedContent, "");
                                GetEventDetail(mOrder.passenger, mOrder.cParentOrder);
                                //报名赛事最低送10积分

                                if (mOrder.iScore == 0)
                                {
                                    new DB1.tblIntegral().InsertScore(idUser, 200820001, 2, mOrder.iCost ?? 0);
                                }
                            }
                            else if (iFromTpye == 4)//酒店
                            {
                                string Content = "您在《" + cContent + "》中付款成功！请您持续关注，谢谢！";
                                string FeedContent = "在《" + cContent + "》中购买成功！邀请您<a target=\"_blank\" href=\"Competetion/hotel.aspx?sid=" + sid + "&nav=4\">[参加]</a>！";
                                AddDiscuss(idUser, Content);
                                AddFeed(idUser, id, "44", FeedContent, "");
                                GetHotelDetail(mOrder.passenger, mOrder.cParentOrder);
                                //报名赛事最低送10积分

                            }
                            else if (iFromTpye == 5)//旅游
                            {
                                string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                                string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/tour.aspx?sid=" + sid + "&nav=5\">[去看看]</a>！";
                                AddDiscuss(idUser, Content);
                                AddFeed(idUser, id, "44", FeedContent, "");
                                GetTourDetail(mOrder.passenger, mOrder.cParentOrder);
                            }
                            else if (iFromTpye == 8)//推荐装备
                            {
                                string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                                string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/equipment.aspx?sid=" + sid + "&nav=8\">[去看看]</a>！";
                                AddDiscuss(idUser, Content);
                                AddFeed(idUser, id, "44", FeedContent, "");
                                GetEquipmentDetail(mOrder.passenger, mOrder.cParentOrder);
                            }
                            else if (iFromTpye == 9)//附属产品
                            {

                                string Content = "您已成功购买了《" + cContent.TrimEnd('-') + "》产品！请您持续关注，谢谢！";
                                string FeedContent = "成功订购《" + cContent.TrimEnd('-') + "》产品！您也<a target=\"_blank\" href=\"/Competetion/annex.aspx?sid=" + sid + "&nav=9\">[去看看]</a>！";
                                AddDiscuss(idUser, Content);
                                AddFeed(idUser, id, "44", FeedContent, "");
                                GetAnnexDetail(mOrder.passenger, mOrder.cParentOrder);
                            }
                        }
                        ltlpay.Text = "<a class=\"fkbuttom\">已付款</a>";
                    }
                }
                else
                {
                    ltlpay.Text = "<a class=\"fkbuttom\" href=\"/Competetion/payoff.aspx?sid=" + sid + "&nav=2&id=" + dt.Rows[0]["ID"].ToString() + "&order=" + OrderNo + "\">立即付款</a>";
                }
            }
            else if ("2" == dt.Rows[0]["iStatus"].ToString())
            {
                int idItem = TypeChangeDefault.NullToInt(dt.Rows[0]["iItemID"], 0);
                DBM6.tblRace_Item modelItem = new DB6.tblRace_Item().GetModel(idItem);

                if (modelItem != null)
                {
                    if (modelItem.iType == 3)
                    {
                        ltlpay.Text = "<a href=\"/Competetion/Team.aspx?sid=" + modelItem.idCompete + "&p=" + idItem + "\" class=\"fkbuttom\" target=\"_blank\">去组队</a>";
                        //ltlpay.Text = "<a href=\"/Channels/Competetion/Team.aspx?id=" + modelItem.idCompete + "&p=" + idItem + "\" class=\"fkbuttom\" target=\"_blank\">加入团队</a>";
                    }
                    else
                    {
                        ltlpay.Text = "<a class=\"fkbuttom\">已付款</a>";
                    }
                }
                else
                {
                    ltlpay.Text = "<a class=\"fkbuttom\">已付款</a>";
                }
                if ("2" == dt.Rows[0]["iFromTpye"].ToString())
                {
                    var x = JsonConvert.DeserializeObject<DBM6.tblRace_Detail>(dt.Rows[0]["passenger"].ToString());
                    if (GetBib(sid, x.cFullname, x.IdNo).Length > 0)
                    {
                        ltlbibResult.Text = "<div class=\"ordercs\">" + GetBib(sid, x.cFullname, x.IdNo) + "</div>";
                    }
                }
            }
            else if ("0" == dt.Rows[0]["iStatus"].ToString())
            {
                ltlpay.Text = "<a class=\"fkbuttom\">待审核</a>";

            }
            else if ("3" == dt.Rows[0]["iStatus"].ToString())
            {
                int idItem = TypeChangeDefault.NullToInt(dt.Rows[0]["iItemID"], 0);
                DBM6.tblRace_Item modelItem = new DB6.tblRace_Item().GetModel(idItem);
                ltlpay.Text = "<a href=\"/Competetion/Team.aspx?sid=" + sid + "&p=" + idItem + "\" class=\"fkbuttom\" target=\"_blank\">已组队</a>";
                //ltlpay.Text = "<a class=\"fkbuttom\">已组队</a>";
                var x = JsonConvert.DeserializeObject<DBM6.tblRace_Detail>(dt.Rows[0]["passenger"].ToString());
                if (GetBib(sid, x.cFullname, x.IdNo).Length > 0)
                {
                    ltlbibResult.Text = "<div class=\"ordercs\">" + GetBib(sid, x.cFullname, x.IdNo) + "</div>";
                }
            }
            else
            {
                AlertHelper.JQAlertGo("该订单已过期！", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
            DB6.tblHotel blljd = new DB6.tblHotel();
            DataTable dtjd = blljd.GetList(1, "(iGlobal=0 or(iGlobal=1 and idCompete=" + sid + ")) and iStatus=1 ", "iSort desc").Tables[0];
            if (dtjd.Rows.Count > 0)
            {
                DB6.tblHotel_Item bllitem = new DB6.tblHotel_Item();
                int idHotel = TypeChangeDefault.NullToInt(dtjd.Rows[0]["id"], 0);
                int num = bllitem.GetRecordCount("idHotel=" + idHotel);
                if (num > 0)
                {
                    ltljd.Text += "<div class=\"otherlist minijd\"><a href=\"/Competetion/hotel.aspx?sid=" + sid + "&nav=4\" class=\"sptitle\">" + dtjd.Rows[0]["cName"].ToString() + "</a> 酒店价格：￥<i>" + bllitem.MinPrice(idHotel) + "</i><div class=\"hotelthumb\"><img src=\"" + dtjd.Rows[0]["cImage"].ToString() + "\">";
                    DataTable dtitem = bllitem.GetList(0, "len(cURL)>0 and idHotel=" + idHotel, "fSellPrice").Tables[0];
                    if (dtitem.Rows.Count > 0)
                    {
                        for (int j = 0; j < dtitem.Rows.Count; j++)
                        {
                            ltljd.Text += "<img src=\"" + dtitem.Rows[j]["cURL"].ToString() + "\">";
                        }
                    }
                    ltljd.Text += "</div><a class=\"othermore\" href=\"/Competetion/hotel.aspx?sid=" + sid + "&nav=4\" >查看全部>></a></div>";
                }
            }
            DB6.tblEquipment bllzb = new DB6.tblEquipment();
            DataTable dtzb = bllzb.GetList(1, "(iGlobal=0 or(iGlobal=1 and idCompete=" + sid + ")) and iStatus=1 ", "iSort desc").Tables[0];
            if (dtzb.Rows.Count > 0)
            {
                int idEquipment = TypeChangeDefault.NullToInt(dtzb.Rows[0]["id"], 0);
                DB6.tblEquipment_Item bllitem = new DB6.tblEquipment_Item();

                int num = bllitem.GetRecordCount("idEquipment=" + idEquipment);
                if (num > 0)
                {
                    ltlzb.Text += "<div class=\"otherlist minizb\"><a href=\"/Competetion/equipment.aspx?sid=" + sid + "&nav=4\" class=\"sptitle\">" + dtzb.Rows[0]["cName"].ToString() + "</a> 装备价格：￥<i>" + bllitem.MinPrice(idEquipment) + "</i><div class=\"hotelthumb\"><img src=\"" + dtzb.Rows[0]["cImage"].ToString() + "\">";
                    DataTable dtitem = bllitem.GetList(0, "len(cURL)>0 and idEquipment=" + idEquipment, "fSellPrice").Tables[0];
                    if (dtitem.Rows.Count > 0)
                    {
                        for (int j = 0; j < dtitem.Rows.Count; j++)
                        {
                            ltlzb.Text += "<img src=\"" + dtitem.Rows[j]["cURL"].ToString() + "\">";
                        }
                    }
                    ltlzb.Text += "</div><a class=\"othermore\" href=\"/Competetion/equipment.aspx?sid=" + sid + "&nav=4\" >查看全部>></a></div>";
                }
            }
        }
    }
    public string GetBib(int sid, string name, string idCart)
    {
        DB4.tblEventTotal bll = new DB4.tblEventTotal();
        DataTable dt = bll.GetList("idRace=" + sid + "  and iStatus=1 and cName='" + name + "' and idCart='" + idCart + "'").Tables[0];
        string result = string.Empty;
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["cBib"].ToString().Length > 0)
            {
                result = "参赛号码：" + dt.Rows[0]["cBib"].ToString();
            }
            if (dt.Rows[0]["cResult"].ToString().Length > 0)
            {
                result += "<br>比赛成绩：" + dt.Rows[0]["cResult"].ToString();
            }
        }

        return result;
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
            mActivity.dCreate = DateTime.Now;
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