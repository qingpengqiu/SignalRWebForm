﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using System.Data;
public partial class Competetion_gallery : PageBase
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
            this.page_Title = title+"-比赛图库-益跑网赛事报名";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            ltlbanner.Text = model.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + model.cBanner.Replace(HostInfo.imgName, HostInfo.imgCDN) + "\"  alt=\"\"/>";
            //--------------加载图库目录----------------//
            DataTable dt = new DB3.tblPhoto().GetList("idRace=" + sid + " and idparent=1").Tables[0];

            if (dt.Rows.Count == 0)
            {
                AlertHelper.JQAlert("该赛事暂无图片！", false);
                return;
            }
            int id = 0;
            id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"], 0);
            DataTable dtchild = new DB3.tblPhoto().GetList("idRace=" + sid + " and idparent=" + id + "").Tables[0];
            int count = dtchild.Rows.Count;
            if (count == 0)
            {
                Response.Redirect("/Competetion/Photo.aspx?sid=" + sid + "&nav=11&id=" + id, true);
            }
            //ltlImgList.Text = "";
            for (int i = 0; i < count; i++)
            {
                ltlImgList.Text += "<div class=\"plist\"><a href=\"/Competetion/Photo.aspx?sid=" + sid + "&nav=11&id=" + dtchild.Rows[i]["id"].ToString() + "\"><img src=\"" + dtchild.Rows[i]["cImg"].ToString().Replace(HostInfo.imgName,HostInfo.imgCDN) + "\">" + dtchild.Rows[i]["cName"].ToString() + "</a></div>";
            }
        }
    }
}