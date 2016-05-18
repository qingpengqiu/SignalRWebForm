
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;

public partial class Admin_Backstage_ExportUpState : PageBase
{
    public int id = 0;
    public int iditpe = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle != 99)
        {
            if (CurrentUser.uId != 100055041)
            {
                if (CurrentUser.uId != 100001183)
                {
                    AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
                    return;
                }
            }
        }
        if (id == 0)
        {
            id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        }
        if (iditpe == 0)
        {
            iditpe = TypeChangeDefault.NullToInt(Request.QueryString["iditype"], 0);
        }
        if (!IsPostBack)
        {
            if (id != 0)
            {
                DBM6.tblOrder ord = new DB6.tblOrder().GetModel(id);
                idcomp.Value = ord.iTypeName;
                iditem.Value = ord.cItemName;
                iStatus.Value = ord.iStatus.ToString();
                //cMack3.Value = ord.cMake3;
            }
        }
    }
    protected void Btnsubmit_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (id != 0)
        {
            DBM6.tblOrder mdol = new DBM6.tblOrder();
            
            mdol.ID = id;
            mdol.iStatus = TypeChangeDefault.NullToInt(iStatus.Value, 0);

            //mdol.cMake3 = cMack3.Value;
            mdol.dConfirmTime = DateTime.Now;
            bool i = new DB6.tblOrder().Update(mdol);
            if(i)
            {
                if (iStatus.Value == "2")
                {
                    DataTable dt = new DB6.tblOrder().GetList("id=" + id).Tables[0];
                    if (iditpe == 2)
                    {
                        GetEventDetail(dt.Rows[0]["passenger"].ToString(), dt.Rows[0]["cParentOrder"].ToString());
                    }
                    if (iditpe == 4)
                    {
                        GetHotelDetail(dt.Rows[0]["passenger"].ToString(), dt.Rows[0]["cParentOrder"].ToString());
                    }
                    if (iditpe == 5)
                    {
                        GetTourDetail(dt.Rows[0]["passenger"].ToString(), dt.Rows[0]["cParentOrder"].ToString());
                    }
                    if (iditpe == 8)
                    {
                        GetEquipmentDetail(dt.Rows[0]["passenger"].ToString(), dt.Rows[0]["cParentOrder"].ToString());
                    }
                    if (iditpe == 9)
                    {
                        GetAnnexDetail(dt.Rows[0]["passenger"].ToString(), dt.Rows[0]["cParentOrder"].ToString());
                    }
                    DBM6.tblOrder msignpu = new DB6.tblOrder().GetModel(id);
                    DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                    DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                    disModel.cContent = "您在《" + msignpu.cFromToName + "-"+msignpu.cItemName+"》中付款成功！请您持续关注，谢谢！";
                    disModel.idInfo = msignpu.idUser;
                    disModel.idUser = 100001183;
                    disModel.cLoginname = "益跑赛事";
                    // disModel.dCreate = DateTime.Now;
                    int imessage = disBll.Add(disModel);
                    if (imessage > 0)
                    {
                        DBM3.tblMessage mMessage = new DBM3.tblMessage();
                        mMessage.cId = 100001183;
                        mMessage.uId = msignpu.idUser;
                        mMessage.itype = 31;
                        mMessage.idcode = imessage;
                        int test = new DB3.tblMessage().Add(mMessage);
                    }
                }
                else if (iStatus.Value == "-1")
                {
                    DBM6.tblOrder order = new DB6.tblOrder().GetModel(id);
                    if (iditpe == 2)
                    {
                        DBM6.tblRace_Item race = new DBM6.tblRace_Item();
                        
                        race.id = int.Parse(order.iItemID);
                        DBM6.tblRace_Item item = new DB6.tblRace_Item().GetModel(race.id);

                        race.iLimit = int.Parse(item.iLimit.ToString()) + 1;
                        bool jf = new DB6.tblRace_Item().Update(race);
                        if (jf && order.iScore>0)
                        {
                            new DB1.tblIntegral().InsertScore(order.idUser ?? 0, 200830003, 3, order.iScore ?? 0, "没付款返还积分值订单号：" + order.cOrder_no);
                        }

                    }
                    if (iditpe == 4)
                    {
                        DBM6.tblHotel_Item race = new DBM6.tblHotel_Item();
                        race.id = int.Parse(order.iItemID);
                        DBM6.tblHotel_Item item = new DB6.tblHotel_Item().GetModel(race.id);
                        race.iLimit = item.iLimit + order.iBuyNum;
                        bool jf = new DB6.tblHotel_Item().Update(race);
                        if (jf && order.iScore > 0)
                        {
                            new DB1.tblIntegral().InsertScore(order.idUser ?? 0, 200830003, 3, order.iScore ?? 0, "没付款返还积分值订单号：" + order.cOrder_no);
                        }
                    }
                    if (iditpe == 5)
                    {
                        DBM6.tbltour_Item race = new DBM6.tbltour_Item();
                        race.id = int.Parse(order.iItemID);
                        DBM6.tbltour_Item item = new DB6.tbltour_Item().GetModel(race.id);
                        race.iLimit = int.Parse(item.iLimit.ToString()) + int.Parse(order.iBuyNum.ToString());
                        bool jf = new DB6.tbltour_Item().Update(race);
                        if (jf && order.iScore > 0)
                        {
                            new DB1.tblIntegral().InsertScore(order.idUser ?? 0, 200830003, 3, order.iScore ?? 0, "没付款返还积分值订单号：" + order.cOrder_no);
                        }
                    }
                    if (iditpe == 8)
                    {
                        DBM6.tblEquipment_Item race = new DBM6.tblEquipment_Item();
                        race.id = int.Parse(order.iItemID);
                        DBM6.tblEquipment_Item item = new DB6.tblEquipment_Item().GetModel(race.id);
                        race.iLimit = race.iLimit + order.iBuyNum;
                        bool jf = new DB6.tblEquipment_Item().Update(race);
                        if (jf && order.iScore > 0)
                        {
                            new DB1.tblIntegral().InsertScore(order.idUser ?? 0, 200830003, 3, order.iScore ?? 0, "没付款返还积分值订单号：" + order.cOrder_no);
                        }
                    }
                    if (iditpe == 9)
                    {
                        DBM6.tblAnnex race = new DBM6.tblAnnex();
                        race.id = int.Parse(order.iItemID);
                        DBM6.tblAnnex item = new DB6.tblAnnex().GetModel(race.id);
                        race.iNum = race.iNum + order.iBuyNum;
                        bool jf = new DB6.tblAnnex().Update(race);
                        if (jf && order.iScore > 0)
                        {
                            new DB1.tblIntegral().InsertScore(order.idUser ?? 0, 200830003, 3, order.iScore ?? 0, "没付款返还积分值订单号：" + order.cOrder_no);
                        }
                    }
                }
                AlertHelper.JQAlertGo("修改成功！", "/Admin/Backstage/ExportOrders.aspx", true);
            }
        }
    }

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
    #region 购买旅游产品详情
    private static void GetTourDetail(string passenger, string cParentOrder)
    {
        var x = JsonConvert.DeserializeObject<DBM6.tblRace_Detail>(passenger);
        DBM6.tbltour_Detail model = new DBM6.tbltour_Detail
        {
            idCompete = x.idCompete,
            cCompetitionName = x.cCompetitionName,
            idItem = x.idCompete,
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
    public  void GetEquipmentDetail(string passenger, string cParentOrder)
    {
        var x = JsonConvert.DeserializeObject<DBM6.tblRace_Detail>(passenger);
        DBM6.tblEquipment_Detail model = new DBM6.tblEquipment_Detail
        {
            idCompete = x.idCompete,
            cCompetitionName = x.cCompetitionName,
            idItem = x.idCompete,
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
        List<DBM6.tblRace_Detail> userlist = JsonConvert.DeserializeObject<List<DBM6.tblRace_Detail>>(passenger);
        foreach (DBM6.tblRace_Detail x in userlist)
        {
            DBM6.tblHotel_Detail model = new DBM6.tblHotel_Detail
            {
                idCompete = x.idCompete,
                cCompetitionName = x.cCompetitionName,
                idItem = x.idCompete,
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
        var x = JsonConvert.DeserializeObject<DBM6.tblRace_Detail>(passenger);
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

    public void updataKc(int type)
    {
        if (type == 4)
        {
 
        }
 
    }
}