using System;
using System.Data;
using System.Web.UI;
using Erun360.BLL;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DB2 = Erun360.BLL.DB2;
using DB3 = Erun360.BLL.DB3;
using DB4 = Erun360.BLL.DB4;
using DB5 = Erun360.BLL.DB5;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DBM4 = Erun360.Model.DB4;
using DBM5 = Erun360.Model.DB5;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using Utils;
using System.Collections;
using System.Collections.Generic;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json;
using System.Text;
using System.Web.UI.WebControls;

public partial class Competetion_tblAnnexAdd : PageBase
{

    public int sid = 0;
    public string portrait = string.Empty;
    public int id = 0;
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
            id = TypeChangeDefault.NullToInt(Request.QueryString["id"],0);
        }
        if (Request.QueryString["sid"] != null)
        {
            sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"],0);
        }
        if (!IsPostBack)
        {
            DBM6.tblRace_Competition comp = new DB6.tblRace_Competition().GetModel(TypeChangeDefault.NullToInt(sid, 0));
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
            this.page_Title = title+"附加项管理";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            BindDDLFriends();
            if (id != 0)
            {///Html/images/iscardr.png
                DBM6.tblAnnex cp = new DB6.tblAnnex().GetModel(id);
                Cname.Value = cp.cName;
                cLink.Value = cp.cLink;
                if (cp.cImg.ToString() == string.Empty)
                {
                    portrait = "/Html/images/iscardr.png";
                    avatarurl.Value = "/Html/images/iscardr.png";
                }
                else
                {
                    portrait = cp.cImg;
                    avatarurl.Value = cp.cImg;
                }
                fBuyPrice.Value = cp.iNum.ToString();
                Text1.Value = cp.fPrice.ToString();
                iState.Value = cp.iState.ToString();
                Text2.Value = cp.iBuyNum.ToString();
                dRaceBegin.Value = cp.dBegionTime.ToString();
                dRaceEnd.Value = cp.dEndTime.ToString();
            }
            else
            {
                portrait = "/Html/images/iscardr.png";
            }
        }
    }
    protected void BindDDLFriends()
    {
        //DataSet ds = new DB6.tblRace_Competition().GetList(" DATEDIFF([second], getdate() , dJoinEnd)>0");
        //idGood.DataSource = ds;
        //idGood.DataTextField = "cTitle";
        //idGood.DataValueField = "id";
        //idGood.DataBind();
        //idGood.Items.Insert(0, new ListItem("--所有--", "0"));
    }
    protected void but_save_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (Cname.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填商品名称！", false);
            return;
        }
        else if (Cname.Value.Trim().Length > 256)
        {
            AlertHelper.JQAlert("商品名称超出限制！", false);
            return;
        }
        DBM6.tblRace_Competition cmdol = new DB6.tblRace_Competition().GetModel(sid);
        
        if (dRaceBegin.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请选择开始报名时间！", false);
            return;
        }
        if (dRaceEnd.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请选择结束报名时间！", false);
            return;
        }
        if (Convert.ToDateTime(dRaceBegin.Value.Trim()) < cmdol.dJoinBegin)
        {
            AlertHelper.JQAlert("开始时间不能小于赛事报名开始时间！", false);
            return;
        }
        if (Convert.ToDateTime(dRaceEnd.Value.Trim()) > cmdol.dRaceBegin)
        {
            AlertHelper.JQAlert("结束时间不能大于赛事开始时间！", false);
            return;
        }
        DBM6.tblAnnex an = new DBM6.tblAnnex();
        //DBM6.tblRace_Item item = new DBM6.tblRace_Item();
        an.cImg = avatarurl.Value;
        an.cLink = cLink.Value;
        an.cName = Cname.Value;
        an.dCreate = DateTime.Now;
        an.fPrice = TypeChangeDefault.NullToDecimal(Text1.Value,0);
        an.iBuyNum = TypeChangeDefault.NullToInt(Text2.Value, 0);
        an.idCompete = sid;
        an.idUser = CurrentUser.uId;
        an.dBegionTime = TypeChangeDefault.NullToDateTime(dRaceBegin.Value, DateTime.Now);
        an.dEndTime = TypeChangeDefault.NullToDateTime(dRaceEnd.Value, DateTime.Now);
        //if (Select1.Value == "0")
        //{
        //    an.iGlobal = 0;
        //}
        //else
        //{
            an.iGlobal = 1;            
        //}
        an.iNum = TypeChangeDefault.NullToInt(fBuyPrice.Value,0);
        an.iState = TypeChangeDefault.NullToInt(iState.Value, 0);

        if (id != 0)
        {
            an.id = id;
            if (new DB6.tblAnnex().Update(an))
            {
                AlertHelper.JQAlertGo("修改成功！", "tblAnnex.aspx?sid="+ sid +"", true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            if (new DB6.tblAnnex().Add(an)>0)
            {
                
                //new DB6.tblRace_Item().Update();
                AlertHelper.JQAlertGo("添加成功！", "tblAnnex.aspx?sid="+ sid +"", true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
            }
        }
    }
}