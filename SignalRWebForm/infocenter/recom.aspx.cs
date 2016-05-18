using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB1 = Erun360.BLL.DB1;
using DB2 = Erun360.BLL.DB2;
using DB3 = Erun360.BLL.DB3;
using System.Text;
public partial class infocenter_recom : PageBase
{
    public string DV1 = string.Empty;
    public string DV2 = string.Empty;
    public string DV3 = string.Empty;
    public string DV4 = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.page_Title ="编辑推荐-益跑网个人中心-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
       
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        string where = " SELECT  r.idUser, r.cBio, r.cType, r.dUpdate, r.cLoginname, r.cState, m.cNickName, m.cAvatar, r.id FROM  YP_DB_3.dbo.tblRecom AS r INNER JOIN YP_DB_1.dbo.tblMEMBER AS m ON r.idUser = m.id ";
        DataTable dt = new DB2.ViewHomeList().QueryBySql(where).Tables[0];
        //dt.Columns.Add("gz", typeof(string));//关注状态，1，已关注，0未关注
        StringBuilder sb1 = new StringBuilder();
        StringBuilder sb2 = new StringBuilder();
        StringBuilder sb3 = new StringBuilder();
        StringBuilder sb4 = new StringBuilder();
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["cType"].ToString() == "1")
                {
                    sb1.Append("<li>");
                    sb1.Append("<a href=\"/user/" + dt.Rows[i]["idUser"].ToString() + ".aspx\" target=\"_blank\">");
                    sb1.Append("<img src=\"" + dt.Rows[i]["cAvatar"].ToString() + "\">");
                    sb1.Append(dt.Rows[i]["cNickName"].ToString());
                    sb1.Append("</a>");
                    sb1.Append("<p>" + dt.Rows[i]["cBio"].ToString() + "</p>");
                    if (new DB3.tblATTENTION().Exists("idInfo=" + dt.Rows[i]["idUser"].ToString() + " and idUser=" + CurrentUser.uId))
                    {
                        if (new DB3.tblATTENTION().Exists("idInfo=" + CurrentUser.uId + " and idUser=" + dt.Rows[i]["idUser"].ToString()))
                        {
                            sb1.Append("<a class=\"focus-txh\">相互关注</a>");
                        }
                        else
                        {
                            sb1.Append("<a class=\"focus-tygz\">已关注</a>");
                        }
                    }
                    else
                    {
                        sb1.Append("<a href=\"javascript:\" class=\"focus-tgz  focus" + i.ToString() + "\" onclick=\"iFocus(" + dt.Rows[i]["idUser"].ToString() + ",'focus" + i.ToString() + "')\">关注TA</a>");
                    }
                    sb1.Append("<a href=\"/infocenter/PostMessage.aspx?uId=" + dt.Rows[i]["idUser"].ToString() + "\" class=\"focus-tly\">给TA留言</a>");
                    sb1.Append("</li>");
                }
                else if (dt.Rows[i]["cType"].ToString() == "2")
                {
                    sb2.Append("<li>");
                    sb2.Append("<a href=\"/user/" + dt.Rows[i]["idUser"].ToString() + ".aspx\" target=\"_blank\">");
                    sb2.Append("<img src=\"" + dt.Rows[i]["cAvatar"].ToString() + "\">");
                    sb2.Append(dt.Rows[i]["cNickName"].ToString());
                    sb2.Append("</a>");
                    sb2.Append("<p>" + dt.Rows[i]["cBio"].ToString() + "</p>");
                    if (new DB3.tblATTENTION().Exists("idInfo=" + dt.Rows[i]["idUser"].ToString() + " and idUser=" + CurrentUser.uId))
                    {
                        if (new DB3.tblATTENTION().Exists("idInfo=" + CurrentUser.uId + " and idUser=" + dt.Rows[i]["idUser"].ToString()))
                        {
                            sb2.Append("<a class=\"focus-txh\">相互关注</a>");
                        }
                        else
                        {
                            sb2.Append("<a class=\"focus-tygz\">已关注</a>");
                        }
                    }
                    else
                    {
                        sb2.Append("<a href=\"javascript:\" class=\"focus-tgz  focus" + i.ToString() + "\" onclick=\"iFocus(" + dt.Rows[i]["idUser"].ToString() + ",'focus" + i.ToString() + "')\">关注TA</a>");
                    }
                    sb2.Append("<a href=\"/infocenter/PostMessage.aspx?uId=" + dt.Rows[i]["idUser"].ToString() + "\" class=\"focus-tly\">给TA留言</a>");
                    sb2.Append("</li>");
                }
                else if (dt.Rows[i]["cType"].ToString() == "3")
                {
                    sb3.Append("<li>");
                    sb3.Append("<a href=\"/user/" + dt.Rows[i]["idUser"].ToString() + ".aspx\" target=\"_blank\">");
                    sb3.Append("<img src=\"" + dt.Rows[i]["cAvatar"].ToString() + "\">");
                    sb3.Append(dt.Rows[i]["cNickName"].ToString());
                    sb3.Append("</a>");
                    sb3.Append("<p>" + dt.Rows[i]["cBio"].ToString() + "</p>");
                    if (new DB3.tblATTENTION().Exists("idInfo=" + dt.Rows[i]["idUser"].ToString() + " and idUser=" + CurrentUser.uId))
                    {
                        if (new DB3.tblATTENTION().Exists("idInfo=" + CurrentUser.uId + " and idUser=" + dt.Rows[i]["idUser"].ToString()))
                        {
                            sb3.Append("<a class=\"focus-txh\">相互关注</a>");
                        }
                        else
                        {
                            sb3.Append("<a class=\"focus-tygz\">已关注</a>");
                        }
                    }
                    else
                    {
                        sb3.Append("<a href=\"javascript:\" class=\"focus-tgz  focus" + i.ToString() + "\" onclick=\"iFocus(" + dt.Rows[i]["idUser"].ToString() + ",'focus" + i.ToString() + "')\">关注TA</a>");
                    }
                    sb3.Append("<a href=\"/infocenter/PostMessage.aspx?uId=" + dt.Rows[i]["idUser"].ToString() + "\" class=\"focus-tly\">给TA留言</a>");
                    sb3.Append("</li>");
                }
                else if (dt.Rows[i]["cType"].ToString() == "4")
                {
                    sb4.Append("<li>");
                    sb4.Append("<a href=\"/user/" + dt.Rows[i]["idUser"].ToString() + ".aspx\" target=\"_blank\">");
                    sb4.Append("<img src=\"" + dt.Rows[i]["cAvatar"].ToString() + "\">");
                    sb4.Append(dt.Rows[i]["cNickName"].ToString());
                    sb4.Append("</a>");
                    sb4.Append("<p>" + dt.Rows[i]["cBio"].ToString() + "</p>");
                    if (new DB3.tblATTENTION().Exists("idInfo=" + dt.Rows[i]["idUser"].ToString() + " and idUser=" + CurrentUser.uId))
                    {
                        if (new DB3.tblATTENTION().Exists("idInfo=" + CurrentUser.uId + " and idUser=" + dt.Rows[i]["idUser"].ToString()))
                        {
                            sb4.Append("<a class=\"focus-txh\">相互关注</a>");
                        }
                        else
                        {
                            sb4.Append("<a class=\"focus-tygz\">已关注</a>");
                        }
                    }
                    else
                    {
                        sb4.Append("<a href=\"javascript:\" class=\"focus-tgz  focus" + i.ToString() + "\" onclick=\"iFocus(" + dt.Rows[i]["idUser"].ToString() + ",'focus" + i.ToString() + "')\">关注TA</a>");
                    }
                    sb4.Append("<a href=\"/infocenter/PostMessage.aspx?uId=" + dt.Rows[i]["idUser"].ToString() + "\" class=\"focus-tly\">给TA留言</a>");
                    sb4.Append("</li>");
                }
            }
        }
        DV1 = sb1.ToString();
        DV2 = sb2.ToString();
        DV3 = sb3.ToString();
        DV4 = sb4.ToString();
    }
}