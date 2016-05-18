using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB3 = Erun360.BLL.DB3;

public partial class infocenter_Comments : PageBase
{
    public string pageCount = string.Empty; //总条目数   
    public int uId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.page_Title ="评论-益跑网个人中心-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
        
        if (CurrentUser == null)
        {
            Response.Redirect("/Member/Logout.aspx");
        }
        if (Request.QueryString["uId"] != null)
        {
            uId = int.Parse(Request.QueryString["uId"].ToString());
        }
        if (CurrentUser.uId != uId)
        {
            Response.Redirect(UrlHelper.MemberUrl(CurrentUser.uId));
        }
        if (!IsPostBack)
        {
            if (CurrentUser != null)
            {

                //pageCount = new DB3.tblMessage().GetRecordCount(" dCreate in (select max(dCreate)from tblMessage where  cId<>" + CurrentUser.uId + "  and uId =" + CurrentUser.uId + " and itype>31 group by bId) ").ToString();
            }
        }
    }
}