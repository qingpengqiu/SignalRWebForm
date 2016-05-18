using System;
using System.Data;
using System.Web.UI;
using Erun360.BLL;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DB2 = Erun360.BLL.DB2;
using DB3 = Erun360.BLL.DB3;
using DB5 = Erun360.BLL.DB5;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DBM5 = Erun360.Model.DB5;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using Utils;
using System.Web.UI.WebControls;
using System.Text;
using System.Web;
using System.IO;

public partial class Competetion_ItemsjbAdd : PageBase
{
    public int id = 0;//装备id
    public int itemid = 0;//商品id
    public string portrait = string.Empty;
    public int idcompete = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle < 12)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (Request.QueryString["id"] != null)
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
        }
        if (Request.QueryString["itemid"] != null)
        {
            itemid = Convert.ToInt32(Request.QueryString["itemid"].ToString());
            DBM6.tblHotel idmt = new DB6.tblHotel().GetModel(itemid);
            idcompete = TypeChangeDefault.NullToInt(idmt.idCompete, 0);
        }

        if (!IsPostBack)
        {
            DBM6.tblHotel_Item model = new DB6.tblHotel_Item().GetModel(id);
            if (model != null)
            {
                //cColor.Value = model.cColor.ToString();
                cHotelName.Value = model.cHotelName.ToString();
                dRaceBegin.Value = Convert.ToDateTime(model.dBeginTime).ToString("yyyy-MM-dd");
                dRaceEnd.Value = Convert.ToDateTime(model.dEndTime).ToString("yyyy-MM-dd");
                //portrait = model.cURL.ToString();
                iLimit.Value = model.iLimit.ToString();
                fMarketPrice.Value = model.fMarketPrice.ToString();
                fSellPrice.Value = model.fSellPrice.ToString();
                iScore.Value = model.iScore.ToString();
                iMoney.Value = model.iMoney.ToString();
                portrait = model.cURL;
            }
        }
    }
    protected void but_save_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle < 12)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        DBM6.tblHotel hotel = new DB6.tblHotel().GetModel(itemid);
        DataSet ds = new DB6.tblHotel_Item().GetList("idEquipment='" + itemid + "'");
        int isum = 0;
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            isum = isum + TypeChangeDefault.NullToInt(ds.Tables[0].Rows[i]["iLimit"].ToString(), 0);
        }
        if (hotel.iTotal < (isum + TypeChangeDefault.NullToInt(iLimit.Value, 0)))
        {
            AlertHelper.JQAlertGo("超出库存量了！", "", false);
            return;
        }
        DBM6.tblHotel_Item modl = new DBM6.tblHotel_Item();
        modl.idHotel = TypeChangeDefault.NullToInt(itemid, 0);
        modl.cItemName = hotel.cName;
        modl.cHotelName = hotel.cName;
        modl.fMarketPrice = TypeChangeDefault.NullToInt(fMarketPrice.Value, 0);
        modl.fSellPrice = TypeChangeDefault.NullToInt(fSellPrice.Value, 0);
        modl.dBeginTime = TypeChangeDefault.NullToDateTime(dRaceBegin.Value, DateTime.Now);
        modl.dEndTime = TypeChangeDefault.NullToDateTime(dRaceEnd.Value, DateTime.Now);
        modl.iScore = TypeChangeDefault.NullToInt(iScore.Value, 0);
        modl.iMoney = TypeChangeDefault.NullToInt(iMoney.Value, 0);
        modl.cURL = avatarurl.Value;
        modl.dCreate = DateTime.Now;
        modl.idUser = CurrentUser.uId;
        //modl.cSize = TypeChangeDefault.NullToString(cSize.Value, "");
        //modl.cColor = TypeChangeDefault.NullToString(cColor.Value, "");
        modl.iLimit = TypeChangeDefault.NullToInt(iLimit.Value, 0);

        if (modl.dBeginTime > modl.dEndTime)
        {
            AlertHelper.JQAlertGo("开始时间不能大于结束时间！", "", false);
            return;
        }
        modl.id = id;
        bool cout = new DB6.tblHotel_Item().Update(modl);
        if (cout)
        {
            AlertHelper.JQAlertGo("修改成功！", "", true);
            return;
        }
        else
        {
            AlertHelper.JQAlertGo("修改失败！", "", false);
            return;
        }
    }
}