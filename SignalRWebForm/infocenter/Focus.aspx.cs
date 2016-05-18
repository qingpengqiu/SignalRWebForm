using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using Erun360.BLL;
using System.Text;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Collections;
public partial class infocenter_Focus : PageBase
{
    public string pageCount = string.Empty; //总条目数
    public int uId = 0;//通过参数传递过来的用户id
    public string FocusList = string.Empty;
    private static Hashtable hash = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.page_Title ="关注-益跑网个人中心-中国领先的跑步门户网站-ERUN360.COM";
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
            Response.Redirect(UrlHelper.MemberUrl(CurrentUser.uId));
        }
        if (!IsPostBack)
        {
            if (CurrentUser!=null)
            {                
                DB3.tblATTENTION uAttention = new DB3.tblATTENTION();
                pager.RecordCount = uAttention.GetRecordCount(" LEFT(idInfo,1)=1 and idUser=" + CurrentUser.uId);                
                Bind();
            }           
        }
        
    }
    protected void pager_PageChanged(object sender, EventArgs e)
    {
        Bind();
    }
    private void Bind()
    {
        int pagesize = pager.PageSize;
        int pageindex = pager.CurrentPageIndex;
      
        FocusList = Focuslist(CurrentUser.uId, pagesize, pageindex);
    }
    /// <summary>
    /// 获取我关注的人
    /// </summary>
    /// <param name="cId">当前用户id</param>
    /// <param name="uId">传入id</param>
    /// <param name="Pagesize">每页显示数</param>
    /// <param name="pageIndex">页面所以</param>
    /// <returns></returns>
    public string Focuslist(int cId, int Pagesize, int pageIndex)
    {

        DB3.tblATTENTION uAttention = new DB3.tblATTENTION();
        DataTable dt = uAttention.GetListByPage(" LEFT(idInfo,1)=1 and idUser=" + cId, " dCreate desc", pageIndex, Pagesize).Tables[0];
        StringBuilder sb = new StringBuilder();
        sb.Append("<ul class=\"\">");
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                int id = TypeChange.NullToInt(dt.Rows[i]["idInfo"].ToString(), 0);
                DBM1.tblMEMBER model = new DB1.tblMEMBER().GetModelByCache(id);
                if (model != null)
                {
                    sb.Append("<li>");
                    //sb.Append("<a href=\"" + UrlHelper.MemberUrl(id) + "\" target=\"_blank\">");
                    sb.Append("<a href=\"/user/" + id + ".aspx\" target=\"_blank\">");

                    if (model.cAvatar.Trim().Length > 0)
                        sb.Append("<img src=\"" + model.cAvatar + "\">");
                    else
                        sb.Append("<img src=\"../Html/images/wl/2.png\">");
                    sb.Append(" " + model.cNickName);
                    sb.Append("</a>");
                    sb.Append("<p>" + XString.ContentTrunc(model.cBio, 30) + "</p>");
                    sb.Append("\t<td><a href=\"javascript:\"  class=\"focus-a focusgz focusa" + i.ToString() + "\"  onclick=\"cFocus(" + id + ",'focusa" + i.ToString() + "')\">取消关注</a></td>");
                    sb.Append("<a class=\"focus-b article-up-iframe\" href=\"/infocenter/PostMessage.aspx?uId=" + id + "\">给TA留言</a>");
                    sb.Append("</li>");
                }
            }
        }
        else
        {
            sb.Append("<li><p>亲，你还没有关注好友，赶紧关注吧！</p></li>");
        }
        sb.Append("</ul>");
        return sb.ToString();
    }
}