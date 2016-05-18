using System;
using System.Data;
using System.Text;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using DB4 = Erun360.BLL.DB4;
using Utils;

public partial class Competetion_EventDetails : PageBase
{
    public int sid = 0;//赛事id  
    public string Result = string.Empty;
    public string title = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
        if (sid == 0)
        {
            AlertHelper.JQAlertGo("请选择赛事！", "/Competetion/SearchEvent.aspx", false);
            return;
        }
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
            this.page_Title = title+"-赛事介绍-益跑网赛事报名";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";

            ltlbanner.Text = model.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + model.cBanner.Replace(HostInfo.imgName, HostInfo.imgCDN) + "\"  alt=\"\"/>";
            ltljdt.Text = model.cPictures.Trim().Length == 0 ? "" : "<img src=\"" + model.cPictures.Replace(HostInfo.imgName, HostInfo.imgCDN) + "\"  alt=\"\"/>";
            ltlRace.Text = "<div class=\"manuet\">所在城市：" + model.cCityname + " <br>竞赛类型：" + CompeteStyle(model.idCompeteStyle ?? 5) + " <br>赛事时间：" + Convert.ToDateTime(model.dRaceBegin).ToString("yyyy-MM-dd") + " <br>报名时间(开始)：" + Convert.ToDateTime(model.dJoinBegin).ToString("yyyy-MM-dd HH:mm") + " <br>报名时间(结束)：" + Convert.ToDateTime(model.dJoinEnd).ToString("yyyy-MM-dd HH:mm") + " <br></div>";



            DataTable dt = new DB6.tblRace_Item().GetList(0, "idCompete=" + sid, " iType,id ").Tables[0];
            ltlRace.Text += "<div class=\"manueb\"><div class=\"openm\">展开全部<i></i></div><div ></div><em>报名费用</em> <br>";
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                sb.AppendLine(dt.Rows[i]["cItemName"] + ":" + "<i>￥" + dt.Rows[i]["iCost"] + "</i>" + "<br>");
            }
            ltlRace.Text += sb.ToString();
            if (model.iType == 2)
            {
                ltlRace.Text += "</div><div class=\"manuetip\">益跑网为本团的线上招募平台 <br>如不使用积分抵扣，付款成功后即可获赠益跑积分<br>您可在屏幕上方“我的益跑”-“积分”页面下查看积分记录（<a href=\"http://www.erun360.com/blog/200016255.aspx\" target=\"_blank\" >积分说明</a>）<br>报名流程可参考：<a href=\"http://www.erun360.com/blog/200016255.aspx\">教你在益跑网报名赛事（含组队攻略）</a><br>平台报名支付咨询电话：010-84374449（工作日9:30-17:30）<br>工作邮箱：<a href=\"mailto:liujn@erun360.com\">liujn@erun360.com</a></div>";
            }
            else
            {
                ltlRace.Text += "</div><div class=\"manuetip\">如不使用积分抵扣，付款成功后即可获赠益跑积分<br>您可在屏幕上方“我的益跑”-“积分”页面下查看积分记录（<a href=\"http://www.erun360.com/blog/200016255.aspx\" target=\"_blank\" >积分说明</a>）<br>报名流程可参考：<a target=\"_blank\" href=\"http://www.erun360.com/blog/200011064.aspx\">教你在益跑网报名赛事（含组队攻略）</a><br>平台报名支付咨询电话：010-84374449（工作日9:30-17:30）<br>工作邮箱：<a href=\"mailto:wangxi@erun360.com\">wangxi@erun360.com</a><br>益跑网机票购买服务平台：<a target=\"_blank\" href=\" http://www.erun360.com/Flight/flightgroom.aspx\">点击购买</a></div>";
            }
            ltlContent.Text = model.cContent.Replace(HostInfo.imgName, HostInfo.imgCDN);

            DB4.tblRACE_JOIN uRace_Join = new DB4.tblRACE_JOIN();
            int uid = 0;
            if (CurrentUser != null)
            {
                uid = CurrentUser.uId;
            }
            //关注
            if (uid == 0)
            {
                ltlgz.Text = " <a href=\"javascript:void(0)\" class=\"gz \" onclick=\"JoinCreate(" + sid + ")\">立即关注</a>";
                ltlgz1.Text = " <a href=\"javascript:void(0)\" class=\"gz \" onclick=\"JoinCreate(" + sid + ")\">立即关注</a>";
            }
            else
            {
                if (uRace_Join.Exists(sid, uid))
                {
                    ltlgz.Text = " <a href=\"javascript:void(0)\" class=\"gz gzcg\">已关注</a>";
                    ltlgz1.Text = " <a href=\"javascript:void(0)\" class=\"gz gzcg\">已关注</a>";
                }
                else
                {
                    ltlgz.Text = " <a href=\"javascript:void(0)\" class=\"gz \" onclick=\"JoinCreate(" + sid + ")\">立即关注</a>";
                    ltlgz1.Text = " <a href=\"javascript:void(0)\" class=\"gz \" onclick=\"JoinCreate(" + sid + ")\">立即关注</a>";
                    //ltlgz.Text = " <a href=\"javascript:void(0)\" class=\"gz \">立即关注</a>";
                }
            }
            //赛事报名
            if (model.dJoinBegin > DateTime.Now)
            {
                ltlbm.Text = "<a href=\"javascript:void(0)\" class=\"bmwks\">报名未开始</a>";
                ltlbm1.Text = "<a href=\"javascript:void(0)\" class=\"bmwks\">报名未开始</a>";
            }
            else if (DateTime.Now > Convert.ToDateTime(model.dJoinEnd.ToString()))
            {
                ltlbm.Text = "<a href=\"javascript:void(0)\" class=\"bmjz\">报名截止</a>";
                ltlbm1.Text = "<a href=\"javascript:void(0)\" class=\"bmjz\">报名截止</a>";
            }
            else
            {
                DataTable dtbm = new DB6.tblOrder().GetList("cFromToID=" + sid + " and iTypeID=" + sid + " and idUser =" + uid + " and iFromTpye =2 and iStatus>=0").Tables[0];
                if (dtbm.Rows.Count == 0)
                {
                    ltlbm.Text = "<a class=\"bmyfk\" href=\"/Competetion/projects.aspx?sid=" + sid + "&nav=2\">立即报名</a>";
                    ltlbm1.Text = "<a class=\"bmyfk\" href=\"/Competetion/projects.aspx?sid=" + sid + "&nav=2\">立即报名</a>";
                }
                else
                {
                    int iItemID = TypeChangeDefault.NullToInt(dtbm.Rows[0]["iItemID"], 0);
                    if (dtbm.Rows[0]["iStatus"].ToString() == "0")
                    {
                        ltlbm.Text = "<a href=\"javascript:void(0)\" class=\"bmwfk\">待审核</a>";
                        ltlbm1.Text = "<a href=\"javascript:void(0)\" class=\"bmwfk\">待审核</a>";
                    }
                    else if (dtbm.Rows[0]["iStatus"].ToString() == "1")
                    {
                        ltlbm.Text = "<a class=\"bmwfk\" href=\"/Competetion/payoff.aspx?sid=" + sid + "&id=" + dtbm.Rows[0]["ID"] + "&nav=2&order=" + TypeChangeDefault.NullToString(dtbm.Rows[0]["cOrder_no"], "") + "\">去付款</a>";
                        ltlbm1.Text = "<a class=\"bmwfk\" href=\"/Competetion/payoff.aspx?sid=" + sid + "&id=" + dtbm.Rows[0]["ID"] + "&nav=2&order=" + TypeChangeDefault.NullToString(dtbm.Rows[0]["cOrder_no"], "") + "\">去付款</a>";
                        ///Competetion/payoff.aspx?sid=300000003&id=53&order=BM20150619000005
                        //ltlbm.Text = "<a class=\"bm bmqfk\" href=\"/Competetion/OrderDetails.aspx?sid=" + sid + "&nav=2&orderid=" + TypeChangeDefault.NullToString(dtbm.Rows[0]["cOrder_no"], "") + "\">去付款</a>";
                        //ltlbm1.Text = "<a class=\"bm bmqfk\" href=\"/Competetion/OrderDetails.aspx?sid=" + sid + "&nav=2&orderid=" + TypeChangeDefault.NullToString(dtbm.Rows[0]["cOrder_no"], "") + "\">去付款</a>";
                    }
                    else if (dtbm.Rows[0]["iStatus"].ToString() == "2")
                    {

                        DBM6.tblRace_Item modelItem = new DB6.tblRace_Item().GetModel(iItemID);
                        if (modelItem != null)
                        {
                            if (modelItem.iType == 3)
                            {
                                ltlbm.Text = "<a class=\"bmwfk\" href=\"/Competetion/Team.aspx?sid=" + sid + "&p=" + iItemID + "\">去组队</a>";
                                ltlbm1.Text = "<a class=\"bmwfk\" href=\"/Competetion/Team.aspx?sid=" + sid + "&p=" + iItemID + "\">去组队</a>";
                            }
                            else
                            {
                                ltlbm.Text = "<a href=\"javascript:void(0)\" class=\"bmy\">已报名</a>";
                                ltlbm1.Text = "<a href=\"javascript:void(0)\" class=\"bmy\">已报名</a>";
                            }
                        }
                        else
                        {
                            ltlbm.Text = "<a href=\"javascript:void(0)\" class=\"bmy\">已报名</a>";
                            ltlbm1.Text = "<a href=\"javascript:void(0)\" class=\"bmy\">已报名</a>";
                            //ltlbm.Text = "<a class=\"bm bmybm\" href=\"/infocenter/Competition.aspx?uId=100000002\">已报名</a>";
                            //ltlbm1.Text = "<a class=\"bm bmybm\" href=\"/infocenter/Competition.aspx?uId=100000002\">已报名</a>";
                        }
                    }
                    else if (dtbm.Rows[0]["iStatus"].ToString() == "3")
                    {
                        ltlbm.Text = "<a class=\"bmy\" href=\"/Competetion/Team.aspx?sid=" + sid + "&p=" + iItemID + "\">已组队</a>";
                        ltlbm1.Text = "<a class=\"bmy\" href=\"/Competetion/Team.aspx?sid=" + sid + "&p=" + iItemID + "\">已组队</a>";
                    }
                    else
                    {
                        ltlbm.Text = "<a class=\"bmyfk\" href=\"/Competetion/projects.aspx?sid=" + sid + "&nav=2\">立即报名</a>";
                        ltlbm1.Text = "<a class=\"bmyfk\" href=\"/Competetion/projects.aspx?sid=" + sid + "&nav=2\">立即报名</a>";
                    }
                }
            }
        }
    }

    private string CompeteStyle(int idCompeteStyle)
    {
        string Style = string.Empty;
        switch (idCompeteStyle)
        {
            case 0: Style = "U超级马拉松"; break;
            case 1: Style = "M全程马拉松"; break;
            case 2: Style = "H半程马拉松"; break;
            case 3: Style = "R路跑"; break;
            case 4: Style = "C越野跑"; break;
            case 5: Style = "T其它"; break;
        }
        return Style;
    }
}