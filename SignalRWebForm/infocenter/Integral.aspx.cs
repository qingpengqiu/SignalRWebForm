using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Erun360.BLL;
using DB1 = Erun360.BLL.DB1;
using System.Data;
using System.Text;
public partial class infocenter_Integral : PageBase
{
    public string IntegralList = string.Empty;
    public string num = string.Empty;
    private int uId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.page_Title ="积分-益跑网个人中心-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
        
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (Request.QueryString["uId"] != null)
        {
            uId = int.Parse(Request.QueryString["uId"].ToString());
        }
        if (CurrentUser.uId != uId)
        {
            Response.Redirect("/infocenter/Integral.aspx?uId=" + CurrentUser.uId + "&tablep=0");
            ///Response.Redirect(UrlHelper.MemberUrl(CurrentUser.uId));
        }
        if (!IsPostBack)
        {
            if (CurrentUser != null)
            {
                num = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + CurrentUser.uId, CurrentUser.uId).ToString();
                DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
                pager.RecordCount = uMember_History.GetRecordCount(" idUser =" + CurrentUser.uId, CurrentUser.uId);
                APager.RecordCount = new DB1.tblGoods().GetRecordCount("iState=1 and iType =1 and  dEndTime>GETDATE()");
                Bind();
                BindShop();
            }
        }
    }
    protected void pager_PageChanged(object sender, EventArgs e)
    {
        Bind();
        num = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + CurrentUser.uId, CurrentUser.uId).ToString();
    }
    private void Bind()
    {
        int pagesize = pager.PageSize;
        int pageindex = pager.CurrentPageIndex;
       
        IntegralList = GetIntegralList(CurrentUser.uId, CurrentUser.uId, pagesize, pageindex);
    }
    private void BindShop()
    {
        int pagesize = APager.PageSize;
        int pageindex = APager.CurrentPageIndex;
        DB1.tblGoods Bll = new DB1.tblGoods();
        //DataTable dttour = Bll.GetList("iState=1 and iType =1").Tables[0];
        DataTable dttour = Bll.GetListByPage("iState=1 and iType =1 and  dEndTime>GETDATE()", "iTotal desc", pageindex, pagesize).Tables[0];
        rptTour.DataSource = dttour;
        rptTour.DataBind();

    }
    protected void APager_PageChanged(object sender, EventArgs e)
    {
        BindShop();
        num = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + CurrentUser.uId, CurrentUser.uId).ToString();
    }
    /// <summary>
    /// 积分列表
    /// </summary>
    /// <param name="cId"></param>
    /// <param name="uId"></param>
    /// <param name="Pagesize"></param>
    /// <param name="pageIndex"></param>
    /// <returns></returns>
    public string GetIntegralList(int cId, int uId, int Pagesize, int pageIndex)
    {
        DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();

        DataTable dt = uMember_History.GetListByPage(" idUser=" + uId, " dCreate desc", pageIndex, Pagesize, uId).Tables[0];
        // DataTable dt = uMember_History.GetListByPage(" idUser=100002013", " dCreate desc", pageIndex, Pagesize, 100002013).Tables[0];
        StringBuilder sbtr1 = new StringBuilder();
        StringBuilder sbtr2 = new StringBuilder();
        DB1.tblGROUPS uGroup = new DB1.tblGROUPS();
        DB1.tblIntegral uIntegral = new DB1.tblIntegral();
        int rowcount = 20;
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < rowcount; i++)
            {
                //第一个table
                if (i < dt.Rows.Count && i < 10)
                {
                    sbtr1.Append(" <div class=\"tr\">");
                    sbtr1.Append("<div class=\"td\">" + Convert.ToDateTime(dt.Rows[i]["dCreate"]).ToString("yyyy-MM-dd HH:mm") + "</div>");
                    if (dt.Rows[i]["idGroup"].ToString().StartsWith("2008"))
                    {
                        sbtr1.Append("<div class=\"td\" title=\"" + dt.Rows[i]["cMark"].ToString() + "\">" + uIntegral.FindTitle(Convert.ToInt32(dt.Rows[i]["idGroup"].ToString())) + "</div>");
                    }
                    else
                    {
                        sbtr1.Append("<div class=\"td\" title=\"" + dt.Rows[i]["cMark"].ToString() + "\">" + uGroup.FindTitle(dt.Rows[i]["idGroup"].ToString()) + "</div>");
                    }
                    if (int.Parse(dt.Rows[i]["iScore"].ToString()) > 0)
                    {
                        sbtr1.Append("<div class=\"td\">+" + dt.Rows[i]["iScore"].ToString() + "</div>");//<span>-1</span>
                    }
                    else
                    {
                        sbtr1.Append("<div class=\"td\"><span>" + dt.Rows[i]["iScore"].ToString() + "</span></div>");//<span>-1</span>
                    }
                    sbtr1.Append("</div>");
                }
                else if (i < 10)
                {
                    sbtr1.Append(" <div class=\"tr\">");
                    sbtr1.Append("<div class=\"td\"></div>");
                    sbtr1.Append("<div class=\"td\"></div>");
                    sbtr1.Append("<div class=\"td\"></div>");
                    sbtr1.Append("</div>");
                }
                //第二个table
                if (i < dt.Rows.Count && i >= 10)
                {
                    sbtr2.Append(" <div class=\"tr\">");
                    sbtr2.Append("<div class=\"td\">" + Convert.ToDateTime(dt.Rows[i]["dCreate"]).ToString("yyyy-MM-dd HH:mm") + "</div>");
                    if (dt.Rows[i]["idGroup"].ToString().StartsWith("2008"))
                    {
                        sbtr2.Append("<div class=\"td\" title=\"" + dt.Rows[i]["cMark"].ToString() + "\">" + uIntegral.FindTitle(Convert.ToInt32(dt.Rows[i]["idGroup"].ToString())) + "</div>");
                    }
                    else
                    {
                        sbtr2.Append("<div class=\"td\" title=\"" + dt.Rows[i]["cMark"].ToString() + "\">" + uGroup.FindTitle(dt.Rows[i]["idGroup"].ToString()) + "</div>");
                    }
                    //sbtr2.Append("<td>" + uGroup.FindTitle(dt.Rows[i]["idGroup"].ToString()) + "</td>");
                    if (int.Parse(dt.Rows[i]["iScore"].ToString()) > 0)
                    {
                        sbtr2.Append("<div class=\"td\">+" + dt.Rows[i]["iScore"].ToString() + "</div>");//<span>-1</span>
                    }
                    else
                    {
                        sbtr2.Append("<div class=\"td\"><span>" + dt.Rows[i]["iScore"].ToString() + "</span></div>");//<span>-1</span>
                    }
                    sbtr2.Append("</div>");
                }
                else if (i >= 10)
                {
                    sbtr2.Append(" <div class=\"tr\">");
                    sbtr2.Append("<div class=\"td\"></div>");
                    sbtr2.Append("<div class=\"td\"></div>");
                    sbtr2.Append("<div class=\"td\"></div>");
                    sbtr2.Append("</div>");
                }
            }
        }
        else
        {
            for (int i = 0; i < rowcount; i++)
            {
                if (i < 10)
                {
                    sbtr1.Append(" <div class=\"tr\">");
                    sbtr1.Append("<div class=\"td\"></div>");
                    sbtr1.Append("<div class=\"td\"></div>");
                    sbtr1.Append("<div class=\"td\"></div>");
                    sbtr1.Append("</div>");
                }
                if (i > 10)
                {
                    sbtr2.Append(" <div class=\"tr\">");
                    sbtr2.Append("<div class=\"td\"></div>");
                    sbtr2.Append("<div class=\"td\"></div>");
                    sbtr2.Append("<div class=\"td\"></div>");
                    sbtr2.Append("</div>");
                }
            }
        }
        StringBuilder sb = new StringBuilder();

        sb.Append("<div class=\"table\">");
        sb.Append("<div class=\"tr\">");
        sb.Append("<div class=\"td\">时间</div>");
        sb.Append("<div class=\"td\">积分类型</div>");
        sb.Append("<div class=\"td\">积分</div>");
        sb.Append(" </div>");
        sb.Append(sbtr1.ToString());
        sb.Append("</div>");

        //
        sb.Append("<div class=\"table\">");
        sb.Append("<div class=\"tr\">");
        sb.Append("<div class=\"td\">时间</div>");
        sb.Append("<div class=\"td\">积分类型</div>");
        sb.Append("<div class=\"td\">积分</div>");
        sb.Append(" </div>");
        sb.Append(sbtr2.ToString());
        sb.Append("</div>");
        return sb.ToString();
    }
}