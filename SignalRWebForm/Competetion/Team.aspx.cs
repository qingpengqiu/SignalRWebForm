using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBM4 = Erun360.Model.DB4;
using DB4 = Erun360.BLL.DB4;
using System.Data;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;

public partial class Channels_Competetion_Team : PageBase
{
    public int sid = 0;//赛事id
    public string title = string.Empty;
    public int idItem = 0;//项目id   
    public int id = 0;//赛事id
    public int isShow = 0;//0 不显示加入团队，1显示加入团队（是否报名，是否创建退伍，是否登陆 ）
    protected void Page_Load(object sender, EventArgs e)
    {
       sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
       id = sid;
       idItem = TypeChangeDefault.NullToInt(Request.QueryString["p"], 0);
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
           this.page_Title = title+"-组队-益跑网赛事报名";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            ltlbanner.Text = model.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + model.cBanner + "\" height=\"256\" width=\"1200\" alt=\"\"/>";

           
          
           //DBM6.tblRace_Competition mSign = new DB6.tblRace_Competition().GetModel(id);
           DBM6.tblRace_Item mSign = new DB6.tblRace_Item().GetModel(idItem);
           if (mSign != null)
           {
               //判断是否过期
               if (DateTime.Now.AddDays(-3) > mSign.dJoinEnd)//报名截止3天以后不允许组队
               {
                   isShow = 0;
                   //AlertHelper.JQAlertGo("赛事已过期！", "/Channels/Competetion/RaceList.aspx", true);
               }
               ltlTitle.Text = mSign.cTitle + "(" + mSign.cItemName + ")";

               if (CurrentUser == null)
               {
                   isShow = 0;
                   ltlTeam.Text = "<div class=\"ktime\" onclick=\"PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();\">我要组队</div>";
               }
               else
               {
                   isShow = 1;
                   int Resoult = new DB6.tblOrder().GetRecordCount("iItemID=" + idItem + " and IdUser=" + CurrentUser.uId + " and iStatus>1");
                   if (Resoult == 0)
                   {
                       isShow = 0;
                       //Response.Redirect("/");
                       //AlertHelper.JQAlertGo("您没报名！", "/Channels/Competetion/RaceList.aspx", true);
                   }
                   else
                   {
                       isShow = 1;
                   }
                   DataTable dt = new DB6.tblTeam_Group().GetList("idUser=" + CurrentUser.uId + " and idItem=" + idItem).Tables[0];
                   if (dt.Rows.Count > 0)
                   {
                       isShow = 0;
                       if (dt.Rows[0]["isOpen"].ToString() == "0")
                       {
                           ltlTeam.Text = "<div class=\"mypasswd\" >您是[" + dt.Rows[0]["iSNo"].ToString() + "]队队长，队伍密码是：" + dt.Rows[0]["cPsd"].ToString() + "</div>";
                       }
                       else
                       {
                           ltlTeam.Text = "<div class=\"mypasswd\" >您是[" + dt.Rows[0]["iSNo"].ToString() + "]队队长</div>";
                       }
                   }
                   else
                   {
                       isShow = 1;
                       DataTable dtteam = new DB6.tblTeam().GetList("idItem=" + idItem + " and IdUser=" + CurrentUser.uId + " and iState=1").Tables[0];
                       if (dtteam.Rows.Count > 0)
                       {
                           isShow = 0;
                           ltlTeam.Text = "<div class=\"mypasswd\" >已加入[" + dtteam.Rows[0]["iSNo"].ToString() + "]队</div>";
                       }
                       else
                       {
                           isShow = 1;
                           ltlTeam.Text = "<div class=\"ktime\" onclick=\"newteam();\">我要组队</div>";
                       }
                   }
               }
           }
       }
       
    }
}