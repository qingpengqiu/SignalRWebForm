﻿using Erun360.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB1 = Erun360.BLL.DB1;
using DB3 = Erun360.BLL.DB3;
public partial class infocenter_findpeople : PageBase
{
    public int uId = 0;
    private string searchname = string.Empty;
    public string UserList = string.Empty;
    public string strWhere = string.Empty;
    public string searchTip = string.Empty;
    public string searchCss = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.page_Title ="查找好友-益跑网个人中心-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
       
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        uId = CurrentUser.uId;
        if (Request.QueryString["searchname"] != null)
        {

            searchname = Request.QueryString["searchname"].ToString();
            strWhere = " cNickName like '%" + searchname + "%'";
        }
        pager.RecordCount = new DB1.tblMEMBER().GetRecordCount(strWhere);
        if (searchname.Trim().Length > 0 && "人名" != searchname.Trim())
        {
            searchTip = "搜索到“<span>" + searchname + "</span>”相关的用户 " + pager.RecordCount + "条 结果";
            searchCss = "ffinds";      
        }
        Bind();
    }
    protected void pager_PageChanged(object sender, EventArgs e)
    {
        Bind();
    }
   
    private void Bind()
    {
        int pagesize = pager.PageSize;
        int pageindex = pager.CurrentPageIndex;
        if (searchname.Trim().Length > 0&&"人名" != searchname.Trim())
        {
            UserList = new Homeland().FindUser(0,CurrentUser.uId, strWhere, " id ", pageindex,pagesize );
        }
        else
        {
            //推荐好友，随即12个人new DB3.tblRecom().GetList(12,""," NEWID()")
            //UserList = new Homeland().FindUser(12,CurrentUser.uId, strWhere, " newid() ", pageindex,pagesize );
            DataTable dt =new DB1.tblMEMBER().GetPerson(" id in(SELECT top 12 [idUser] FROM [YP_DB_3].[dbo].[tblRecom] where idUser!=" + uId + " order by NEWID())", uId);
            StringBuilder sb = new StringBuilder();
            sb.Append("<ul class=\"\">");
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    sb.Append("<li>");
                    sb.Append("<a href=\"/user/" + dt.Rows[i]["id"].ToString() + ".aspx\" target=\"_blank\" >");
                    if (dt.Rows[i]["cAvatar"].ToString().Trim().Length > 0)
                        sb.Append("<img src=\"" + dt.Rows[i]["cAvatar"].ToString() + "\">");
                    else
                        sb.Append("<img src=\"../Html/images/wl/2.png\">");

                    sb.Append(XString.Trunc(dt.Rows[i]["cNickName"].ToString(), 12) + " </a>");
                    sb.Append("<p>" + XString.ContentTrunc(HTMLHelper.NoHTML(dt.Rows[i]["cBio"].ToString()), 30) + "</p>");
                    if ("2" == dt.Rows[i]["gz"].ToString())
                    {
                        sb.Append("<a class=\"focus-txh\">相互关注</a>");
                    }
                    else if ("1" == dt.Rows[i]["gz"].ToString())
                    {
                        sb.Append("<a class=\"focus-tygz\">已关注</a>");
                    }
                    else
                    {
                        sb.Append("<a href=\"javascript:\" class=\"focus-tgz  focus" + i.ToString() + "\" onclick=\"iFocus(" + dt.Rows[i]["id"].ToString() + ",'focus" + i.ToString() + "')\">关注TA</a>");
                    }
                    sb.Append("<a href=\"/infocenter/PostMessage.aspx?uId=" + dt.Rows[i]["id"].ToString() + "\" class=\"focus-tly\">给TA留言</a>");
                    sb.Append("</li>");
                }
            }
            sb.Append("</ul>");
            UserList = sb.ToString();
            pager.Visible = false;
        }
    }
}