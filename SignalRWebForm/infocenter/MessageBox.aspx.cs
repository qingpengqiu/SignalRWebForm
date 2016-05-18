using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB3 = Erun360.BLL.DB3;
using DBM1 = Erun360.Model.DB1;
using DB1 = Erun360.BLL.DB1;
using System.Text;

public partial class infocenter_MessageBox : PageBase
{
    public int pageCount = 0; //总条目数

    private int idInfo = 0;
    private int uId = 0;
    public string strMsg = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.page_Title ="留言-益跑网个人中心-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
        
        if (!string.IsNullOrEmpty(Request.QueryString["uId"]))
        {
            uId = int.Parse(Request.QueryString["uId"].ToString());
        }
        if (!string.IsNullOrEmpty(Request.QueryString["idInfo"]))
        {
            idInfo = int.Parse(Request.QueryString["idInfo"].ToString());
        }
        if (CurrentUser != null)
        {
            new DB3.tblMessage().DeleteMsg(" cId="+idInfo+" and uId="+uId+" and itype=31 ");
        }
        if (!IsPostBack)
        {
            if (CurrentUser!=null)
            {
                DB3.tblDISCUSS discuss = new DB3.tblDISCUSS();
                StringBuilder sb = new StringBuilder();
                //获取个人留言                
                string strWhereidUser = " idInfo=" + CurrentUser.uId + " and idUser=" + idInfo;
                pageCount = discuss.GetRecordCount(strWhereidUser, CurrentUser.uId);


                //好友留言
                string strWhereidInfo = " idInfo=" + idInfo + " and idUser=" + CurrentUser.uId;
                pageCount += discuss.GetRecordCount(strWhereidInfo, idInfo);

                DB1.tblMEMBER menmber = new DB1.tblMEMBER();
                DBM1.tblMEMBER sModel = menmber.GetModel(idInfo);

                strMsg = "发给" + sModel.cNickName + "的留言";
            }
        }
    }
}