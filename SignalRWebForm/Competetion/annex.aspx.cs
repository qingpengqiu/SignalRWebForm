using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using System.Data;
using System.Text;
public partial class Competetion_annex : PageBase
{

    public int sid = 0;
    public string title = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {

        sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
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
            this.page_Title = title+"-附加项-益跑网赛事报名";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            
            ltlbanner.Text = model.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + model.cBanner + "\" alt=\"\"/>";
            DataTable dt = new DB6.tblAnnex().GetList("((idCompete = " + sid + " and iGlobal=1 )or iGlobal=0 )and iState =2").Tables[0];
            if (dt.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    // //20150708 更改库存数量（有从订单查询改为从库存中判断）edit
                    //int count = new DB6.tblOrder().GetRecordCount(" iStatus>-1 and iFromTpye=9 and iItemID=" + dt.Rows[i]["id"].ToString() + " and iTypeID=" + sid);
                    sb.AppendLine("<li>");
                    sb.AppendLine("<label><input type=\"checkbox\" {0} name=\"annex" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\" >" + dt.Rows[i]["cName"].ToString() + "</label>");
                    if (dt.Rows[i]["cLink"].ToString().Trim().Length > 0)
                    {
                        sb.AppendLine("<a target=\"_blank\" href=\"" + dt.Rows[i]["cLink"].ToString() + "\">(查看详情)</a>");
                    }
                    sb.AppendLine("<br>数量：<input type=\"number\" {0} name=\"annexnum" + i + "\" data-p=\"" + dt.Rows[i]["fPrice"].ToString() + "\" class=\"fen\" value=\"1\" min=\"1\" max=\"" + dt.Rows[i]["iBuyNum"].ToString() + "\">份 <br>价格：￥<i>" + dt.Rows[i]["fPrice"].ToString() + "</i>");
                    if (TypeChangeDefault.NullToDateTime(dt.Rows[i]["dBegionTime"], DateTime.Now) > DateTime.Now)
                    {
                        //报名未开始
                        sb.AppendLine("<span>（活动未开始）</span>");
                        sb = sb.Replace("{0}", "disabled");
                    }
                    else if (DateTime.Now > TypeChangeDefault.NullToDateTime(dt.Rows[i]["dEndTime"], DateTime.Now))
                    {
                        //报名截止
                        sb.AppendLine("<span>（活动已截止）</span>");
                        sb = sb.Replace("{0}", "disabled");
                    }
                    else
                    {
                        // //20150708 更改库存数量（有从订单查询改为从库存中判断）edit
                        //if (count >= TypeChangeDefault.NullToInt(dt.Rows[i]["iNum"], 0))
                        if (TypeChangeDefault.NullToInt(dt.Rows[i]["iNum"], 0)<=0)
                        {
                            sb.AppendLine("<span>（已售完）</span>");
                            sb = sb.Replace("{0}", "disabled");
                        }
                        else
                        {
                            sb = sb.Replace("{0}", "");
                        }
                    }
                    sb.AppendLine("</li>");
                }
                ltlannex.Text = sb.ToString();
            }
            if (CurrentUser == null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
                return;
            }
        }
    }
}