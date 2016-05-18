using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Erun360.BLL;
using DB2 = Erun360.BLL.DB2;
using DB3 = Erun360.BLL.DB3;
using DBM1 = Erun360.Model.DB1;
using DB1 = Erun360.BLL.DB1;
using System.Text;

public partial class infocenter_Equip : PageBase
{
    public string ProductList = string.Empty;//装备列表
    public string FoucsProductList = string.Empty; //我关注的装备
    private int uId = 0;//通过参数传递过来的用户id
    public string Header = string.Empty;
    private int cId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["uId"] != null)
        {
            uId = int.Parse(Request.QueryString["uId"].ToString());
        }
        if (CurrentUser != null)
        {
            cId = CurrentUser.uId;
        }
        if (!IsPostBack)
        {
            if (CurrentUser != null)
            {
                cId = CurrentUser.uId;
                StringBuilder sb = new StringBuilder();
                DB2.tblBLOG uBlog = new DB2.tblBLOG();
                if (cId == uId)
                {
                    sb.Append("<div class=\"equip\">");
                    sb.Append("<span class=\"equip-ous\">我的装备<em></em></span><span><em></em>我关注的装备</span>");
                    sb.Append("<a class=\"photo-up\" href=\"../infocenter/PostEquip.aspx?uId=" + uId + "\">发布装备</a>");
                    sb.Append("</div>");

                    DB3.tblATTENTION uFocus = new DB3.tblATTENTION();
                    //page2.RecordCount = uBlog.GetRecordCount(" LEFT(idHref,1)=5 and id in(" + uFocus.GetAttentionIdList(uId, 2, 0) + ")");
                    BindFoucsBindProduct();
                }
                else
                {
                    sb.Append("<div class=\"equip\">");
                    sb.Append("<span class=\"equip-ous\"><em></em>TA的装备</span>");
                    sb.Append("</div>");
                }
                Header = sb.ToString();

                //pager.RecordCount = uBlog.GetRecordCount(" LEFT(idHref,1)=5 and idUser =" + uId);
                BindProduct();
        DBM1.tblMEMBER model = new DB1.tblMEMBER().GetModel(uId);
        if (model != null)
            this.page_Title = model.cNickName + "的装备-中国领先的跑步门户网站-ERUN360.COM";
        else
            this.page_Title ="装备-中国领先的跑步门户网站-ERUN360.COM";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";

            }
            else
            {
                DB2.tblBLOG uBlog = new DB2.tblBLOG();
                StringBuilder sb = new StringBuilder();                
                sb.Append("<div class=\"equip\">");
                sb.Append("<span class=\"equip-ous\"><em></em>TA的装备</span>");
                sb.Append("</div>");
                Header = sb.ToString();
                //pager.RecordCount = uBlog.GetRecordCount(" LEFT(idHref,1)=5 and idUser =" + uId);
                BindProduct();
            }
        }
    }
    protected void pager_PageChanged(object sender, EventArgs e)
    {
        BindProduct();
        BindFoucsBindProduct();       
    }
    //绑定我的装备
    private void BindProduct()
    {
        //int pagesize = pager.PageSize;
        //int pageindex = pager.CurrentPageIndex;
        BlogInfo bInfo = new BlogInfo();
        EquipInfo eInfo = new EquipInfo();
        //ProductList = eInfo.ProductList(cId, uId, "5", pageindex, pagesize);
    }
    //绑定我关注的装备
    private void BindFoucsBindProduct()
    {
        //int pagesize = page2.PageSize;
        //int pageindex = page2.CurrentPageIndex;
        BlogInfo bInfo = new BlogInfo();
        EquipInfo eInfo = new EquipInfo();
        //FoucsProductList = eInfo.FocusProductList(cId, uId, "5", pageindex, pagesize);
    }
    protected void page2_PageChanged(object sender, EventArgs e)
    {
        BindFoucsBindProduct();
        BindProduct();
    }
}