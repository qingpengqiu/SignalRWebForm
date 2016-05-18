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

public partial class Competetion_ItemsZbAdd : PageBase
{
    public int id = 0;//装备id
    public int itemid = 0;//商品id
    public string portrait = string.Empty;
    public int idcompete = 0; 
    public string title = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        
        if (Request.QueryString["id"] != null)
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
        }
        if (Request.QueryString["itemid"] != null)
        {
            itemid = Convert.ToInt32(Request.QueryString["itemid"].ToString());
            DBM6.tblEquipment idmt = new DB6.tblEquipment().GetModel(itemid);
            idcompete = TypeChangeDefault.NullToInt(idmt.idCompete, 0);
        }
        
        if (!IsPostBack)
        {
            DBM6.tblRace_Competition comp = new DB6.tblRace_Competition().GetModel(TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0));
            if (CurrentUser.idMemberStyle != 99)
            {
                if (CurrentUser.uId != comp.idUser)
                {
                    AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
                    return;
                }
            }
            ltlbanner.Text = comp.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + comp.cBanner + "\" height=\"256\" width=\"1200\" alt=\"\"/>";
            title = comp.cTitle;
            this.page_Title = title+"-附加项-益跑网赛事报名";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            
            DBM6.tblEquipment_Item model = new DB6.tblEquipment_Item().GetModel(id);
            if (model != null)
            {
                
                cColor.Value = model.cColor.ToString();
                cSize.Value = model.cSize.ToString();
                dRaceBegin.Value = Convert.ToDateTime(model.dBeginTime).ToString("yyyy-MM-dd");
                dRaceEnd.Value = Convert.ToDateTime(model.dEndTime).ToString("yyyy-MM-dd");
                //portrait = model.cURL.ToString();
                iLimit.Value = model.iLimit.ToString();
                fMarketPrice.Value = model.fMarketPrice.ToString();
                fSellPrice.Value = model.fSellPrice.ToString();
                iScore.Value = model.iScore.ToString();
                iMoney.Value = model.iMoney.ToString();
                if (model.cURL.ToString() == string.Empty)
                {
                    portrait = "/Html/images/iscardr.png";
                    avatarurl.Value = "/Html/images/iscardr.png";
                }
                else
                {
                    portrait = model.cURL;
                    avatarurl.Value = model.cURL;
                }
            }
            else
            {
                
                portrait = "/Html/images/iscardr.png";
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
        if (CurrentUser.uId != 100055041 && CurrentUser.uId != 100001183 && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
            return;
        }
        DBM6.tblEquipment hotel = new DB6.tblEquipment().GetModel(itemid);
       
        DBM6.tblEquipment_Item modl = new DBM6.tblEquipment_Item();
        modl.idEquipment = TypeChangeDefault.NullToInt(itemid, 0);
        modl.cItemName = TypeChangeDefault.NullToString(cColor.Value, "")+TypeChangeDefault.NullToString(cSize.Value, "");
        modl.cEquipmentName = hotel.cName;
        modl.fMarketPrice = TypeChangeDefault.NullToDecimal(fMarketPrice.Value, 0);
        modl.fSellPrice = TypeChangeDefault.NullToDecimal(fSellPrice.Value, 0);
        modl.dBeginTime = TypeChangeDefault.NullToDateTime(dRaceBegin.Value, DateTime.Now);
        modl.dEndTime = TypeChangeDefault.NullToDateTime(dRaceEnd.Value, DateTime.Now);
        modl.iScore = TypeChangeDefault.NullToInt(iScore.Value, 0);
        modl.iMoney = TypeChangeDefault.NullToInt(iMoney.Value, 0);
        modl.cURL = avatarurl.Value;
        modl.dCreate = DateTime.Now;
        modl.idUser = CurrentUser.uId;
        modl.cSize = TypeChangeDefault.NullToString(cSize.Value, "");
        modl.cColor = TypeChangeDefault.NullToString(cColor.Value, "");
        modl.iLimit = TypeChangeDefault.NullToInt(iLimit.Value, 0);

        if (modl.dBeginTime > modl.dEndTime)
        {
            AlertHelper.JQAlertGo("开始时间不能大于结束时间！", "", false);
            return;
        }
        modl.id = id;
        int isum = 0;
        bool cout = new DB6.tblEquipment_Item().Update(modl);
        if (cout)
        {
            DataSet ds = new DB6.tblEquipment_Item().GetList("idEquipment='" + itemid + "'");
            for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
            {
                isum = isum + TypeChangeDefault.NullToInt(ds.Tables[0].Rows[j]["iLimit"].ToString(), 0);
            }
            if (isum != 0)
            {
                DBM6.tblEquipment ddmodl = new DBM6.tblEquipment();
                ddmodl.id = itemid;
                ddmodl.iTotal = isum;
                new DB6.tblEquipment().Update(ddmodl);
            }
            AlertHelper.JQAlertGo("修改成功！", "ItemsZb.aspx?id=" + itemid + "&sid=" + idcompete + "", true);
            return;
        }
        else
        {
            AlertHelper.JQAlertGo("修改失败！", "", false);
            return;
        }
    }
}