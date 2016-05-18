using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using Newtonsoft.Json;
using System.Text;
using Utils;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using Erun360.Model.DB6;
public partial class Admin_RaceJionEdit : PageBase
{
    public int id = 0;//记录id
    private int idRace = 0;//赛事id
    private int idItem = 0;//项目id
    public int iFromTpye = 2;//订单类型
    public int idUser = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if ((CurrentUser.uId != 100001183 && CurrentUser.uId != 100055041) && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        idRace = TypeChangeDefault.NullToInt(Request.QueryString["idRace"], 0);
        idItem = TypeChangeDefault.NullToInt(Request.QueryString["idItem"], 0);
        iFromTpye = TypeChangeDefault.NullToInt(Request.QueryString["iFromTpye"], 2);
        if (!IsPostBack)
        {
            BindOccupation();
            DB6.tblOrder bll = new DB6.tblOrder();
            DBM6.tblOrder mOrder = bll.GetModel(id);
            if (mOrder != null)
            {
                idUser = mOrder.idUser ?? 0;
                int count = new DB6.tblRace_Detail().GetRecordCount("cOrder_no='" + mOrder.cOrder_no + "'");
                if (count == 0)
                {
                    GetEventDetail(mOrder.passenger, mOrder.cParentOrder);
                }
                DataTable dt = new DB6.tblRace_Detail().GetList("cOrder_no='" + mOrder.cOrder_no + "'").Tables[0];
                if (dt.Rows.Count > 0)
                {
                    name.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cFullname"], "");
                    idgender.SelectedValue = TypeChangeDefault.NullToString(dt.Rows[0]["cGender"], "");
                    idBlood.SelectedValue = TypeChangeDefault.NullToString(dt.Rows[0]["idBlood"], "");
                    birday.Value = TypeChangeDefault.NullToDateTime(dt.Rows[0]["dBirthday"].ToString(), DateTime.Now).ToString("yyyy-MM-dd");
                    ddlEducation.SelectedValue = TypeChangeDefault.NullToString(dt.Rows[0]["idEducation"].ToString(), "0");
                    idOccupation.SelectedValue = TypeChangeDefault.NullToString(dt.Rows[0]["idOccupation"].ToString(), "0");
                    ddlCard.SelectedValue = TypeChangeDefault.NullToString(dt.Rows[0]["IdType"].ToString(), "1");
                    idCard.Value = TypeChangeDefault.NullToString(dt.Rows[0]["IdNo"].ToString(), "");
                    mobile.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cMobile"].ToString(), "");
                    email.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cMail"].ToString(), "");
                    cCityname.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cCityname"].ToString(), "");
                    size.SelectedValue = TypeChangeDefault.NullToString(dt.Rows[0]["cCloth"].ToString(), "");
                    address.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cAddress"].ToString(), "");
                    zipcode.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cZipcode"].ToString(), "");
                    idgj.Value = TypeChangeDefault.NullToString(dt.Rows[0]["cNational"].ToString(), "");
                    string[] Contact = TypeChangeDefault.NullToString(dt.Rows[0]["cEmergerContact"], "").Trim().Split('|');
                    if (Contact.Length > 1)
                    {
                        emerger.Value = Contact[0];
                        emermobile.Value = Contact[1];
                    }
                    //附件
                    /*
                     <asp:ListItem Value="cECG" Selected="True">位置1</asp:ListItem>
                                                <asp:ListItem Value="cFinished">位置2</asp:ListItem>
                                                <asp:ListItem Value="cMake">位置3</asp:ListItem>
                                                <asp:ListItem Value="cMake1">位置4</asp:ListItem>
                                                <asp:ListItem Value="cMake2">位置5</asp:ListItem>
                     */
                    string cHealthUrl = TypeChangeDefault.NullToString(dt.Rows[0]["cHealthUrl"].ToString(), "");
                    string cECG = TypeChangeDefault.NullToString(dt.Rows[0]["cECG"].ToString(), "");
                    string cFinished = TypeChangeDefault.NullToString(dt.Rows[0]["cFinished"].ToString(), "");
                    string cMake = TypeChangeDefault.NullToString(dt.Rows[0]["cMake"].ToString(), "");
                    string cMake1 = TypeChangeDefault.NullToString(dt.Rows[0]["cMake1"].ToString(), "");
                    string cMake2 = TypeChangeDefault.NullToString(dt.Rows[0]["cMake2"].ToString(), "");
                    StringBuilder sbFileup = new StringBuilder();
                    if (dt.Rows[0]["cHealthUrl"] != null)
                    {
                        if (cHealthUrl.Contains(GetDir(mOrder.iTypeID.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + cHealthUrl + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                    }
                    if (cECG != null)
                    {
                        if (cECG.Contains(GetDir(mOrder.iTypeID.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + cECG + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                        else
                        {
                            bz1.Value = cECG;
                        }
                    }
                    if (cFinished != null)
                    {
                        if (cFinished.Contains(GetDir(mOrder.iTypeID.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + cFinished + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                        else
                        {
                            bz2.Value = cFinished;
                        }
                    }
                    if (cMake != null)
                    {
                        if (cMake.Contains(GetDir(mOrder.iTypeID.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + cMake + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                        else
                        {
                            bz3.Value = cMake;
                        }
                    }
                    if (cMake1 != null)
                    {
                        if (cMake1.Contains(GetDir(mOrder.iTypeID.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + cMake1 + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                        else
                        {
                            bz4.Value = cMake1;
                        }
                    }
                    if (cMake2 != null)
                    {
                        if (cMake2.Contains(GetDir(mOrder.iTypeID.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + cMake2 + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                        else
                        {
                            bz5.Value = cMake2;
                        }
                    }
                    ltlImg.Text = sbFileup.ToString();
                }

                cRemark1.Value = mOrder.cMake3;
                ltlorder.Text = mOrder.cOrder_no;
                ltlpay.Text = mOrder.cTrade_no;
                ltljifen.Text = mOrder.iScore > 0 ? "是" : "否";
            }
        }
    }
    ///绑定职业
    protected void BindOccupation()
    {
        string CacheKey = "idOccupation";
        //string CacheKey = "idOccupation-" + la;
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        if (objModel == null)
        {
            try
            {
                string path = Server.MapPath("/XML/Strings.xml");
                DataSet ds = new DataSet();
                ds.ReadXml(path);
                objModel = ds;
                if (objModel != null)
                {
                    int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            catch { }
        }
        idOccupation.DataSource = ((DataSet)objModel).Tables["idOccupation"];
        idOccupation.DataTextField = "TextField";
        idOccupation.DataValueField = "ValueField";
        idOccupation.DataBind();
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if ((CurrentUser.uId != 100001183 && CurrentUser.uId != 100055041) && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        int idRow = 0;
        DB6.tblOrder bll = new DB6.tblOrder();
        DBM6.tblOrder mOrder = bll.GetModel(id);
        if (mOrder != null)
        {
            DataTable dt = new DB6.tblRace_Detail().GetList("cOrder_no='" + mOrder.cOrder_no + "'").Tables[0];
            if (dt.Rows.Count > 0)
            {
                idRow = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString(), 0);
            }
            DBM6.tblRace_Detail model = new DBM6.tblRace_Detail();
            if (name.Value.Trim().Length <= 0 || name.Value.Trim().Length > 32)
            {
                AlertHelper.JQAlert("姓名为空或超过限制！", false);
                return;
            }
            model.cFullname = name.Value;
            model.cGender = TypeChange.NullToString(idgender.SelectedValue, "0");//性别
            model.idBlood = TypeChange.NullToString(idBlood.SelectedValue, "");//血型
            if (birday.Value.Trim().Length <= 0)
            {
                AlertHelper.JQAlert("请选择生日！", false);
                return;
            }
            model.dBirthday = TypeChangeDefault.NullToDateTime(birday.Value.Trim(), DateTime.Now);//生日

            model.idEducation = TypeChange.NullToInt(ddlEducation.SelectedValue, 0);//学历
            model.idOccupation = Convert.ToInt32(idOccupation.SelectedValue);//职业       
            model.IdType = TypeChange.NullToString(ddlCard.SelectedValue, "1");//证件类型       
            if (ddlCard.SelectedValue == "1")
            {
                if (idCard.Value.Trim().Length != 18)
                {
                    AlertHelper.JQAlert("身份证格式错误！", false);
                    return;
                }
                else
                {
                    if (!Erun360.Common.PageValidate.IsNumber(idCard.Value.Trim().Substring(0, 17)))
                    {
                        AlertHelper.JQAlert("身份证格式错误！", false);
                        return;
                    }
                }
            }
            model.IdNo = idCard.Value.Trim();
            if (mobile.Value.Trim().Length <= 0)
            {
                AlertHelper.JQAlert("请填写手机号吗！", false);
                return;
            }
            else if (!Erun360.Common.PageValidate.IsPhone(mobile.Value.Trim()))
            {
                AlertHelper.JQAlert("电话格式错误！", false);
                return;
            }
            model.cMobile = mobile.Value.Trim();
            if (email.Value.Trim().Length <= 0)
            {
                AlertHelper.JQAlert("请填写邮箱！", false);
                return;
            }
            else
            {
                if (!Erun360.Common.PageValidate.IsEmail(email.Value.Trim()))
                {
                    AlertHelper.JQAlert("邮箱格式错误！", false);
                    return;
                }
            }
            model.cMail = email.Value.Trim();
            if (idgj.Value.Trim().Length <= 0)
            {
                AlertHelper.JQAlert("请填写国籍！", false);
                return;
            }
            model.cNational = idgj.Value.Trim();
            if (address.Value.Trim().Length <= 0)
            {
                AlertHelper.JQAlert("请填写地址！", false);
                return;
            }
            model.cAddress = address.Value.Trim();
            if (zipcode.Value.Trim().Length <= 0)
            {
                AlertHelper.JQAlert("请填写邮编！", false);
                return;
            }
            model.cZipcode = zipcode.Value.Trim();
            if (emerger.Value.Trim().Length <= 0 || emermobile.Value.Trim().Length <= 0)
            {
                AlertHelper.JQAlert("请填写紧急联系人及联系电话！", false);
                return;
            }
            model.cEmergerContact = emerger.Value.Trim() + "|" + emermobile.Value.Trim();
            model.cCloth = size.SelectedValue;
            model.cECG = bz1.Value.Trim();
            model.cFinished = bz2.Value.Trim();
            model.cMake = bz3.Value.Trim();
            model.cMake1 = bz4.Value.Trim();
            model.cMake2 = bz5.Value.Trim();

            if (idRow > 0)
            {
                model.id = idRow;
                new DB6.tblRace_Detail().Update(model);
            }
            if (cRemark1.Value.Trim().Length > 0)
            {
                mOrder.ID = id;
                mOrder.cMake3 = cRemark1.Value.Trim();
                bll.Update(mOrder);
            }
        }
        Response.Redirect("RaceJion.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye + "&idItem=" + idItem + "#a" + id, true);
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("RaceJion.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye + "&idItem=" + idItem + "#a" + id, true);
    }

    //过期处理
    protected void expire(int id)
    {
        DB6.tblOrder bll = new DB6.tblOrder();
        DBM6.tblOrder model = bll.GetModel(id);
        if (model.iFromTpye == 2)
        {
            DBM6.tblRace_Item racemodel = new DB6.tblRace_Item().GetModel(TypeChangeDefault.NullToInt(model.iItemID, 0));
            racemodel.iLimit = racemodel.iLimit + model.iBuyNum;
            new DB6.tblRace_Item().Update(racemodel);
        }
        else if (model.iFromTpye == 4)
        {
            DBM6.tblHotel_Item racemodel = new DB6.tblHotel_Item().GetModel(TypeChangeDefault.NullToInt(model.iItemID, 0));
            racemodel.iLimit = racemodel.iLimit + model.iBuyNum;
            new DB6.tblHotel_Item().Update(racemodel);
        }
        else if (model.iFromTpye == 8)
        {
            DBM6.tblEquipment_Item racemodel = new DB6.tblEquipment_Item().GetModel(TypeChangeDefault.NullToInt(model.iItemID, 0));
            racemodel.iLimit = racemodel.iLimit + model.iBuyNum;
            new DB6.tblEquipment_Item().Update(racemodel);
        }
        else if (model.iFromTpye == 9)
        {
            DBM6.tblAnnex racemodel = new DB6.tblAnnex().GetModel(TypeChangeDefault.NullToInt(model.iItemID, 0));
            racemodel.iNum = racemodel.iNum + model.iBuyNum;
            new DB6.tblAnnex().Update(racemodel);
        }
        //未付款退还积分
        if (model.iScore > 0)
        {
            new DB1.tblIntegral().InsertScore(model.idUser ?? 0, 200830003, 3, model.iScore ?? 0, "没付款返还积分值订单号：" + model.cOrder_no);
        }
        DBM6.tblOrder child = bll.GetModel(TypeChangeDefault.NullToInt(id, 0));
        if (child != null)
        {
            if (child.cParentOrder.Trim().Length != 0)
            {
                bll.UpdateStatusByOrder(child.cParentOrder);
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
            DBM6.tblHotel_Detail model = new tblHotel_Detail
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
}