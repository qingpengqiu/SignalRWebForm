using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using System.Text.RegularExpressions;

public partial class Competetion_insertbook : PageBase
{
    public int sid = 0;
    public string title = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (Request.QueryString["sid"] != null)
        {
            sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
        }
        if (!IsPostBack)
        {
            DBM6.tblRace_Competition comp = new DB6.tblRace_Competition().GetModel(TypeChangeDefault.NullToInt(sid, 0));
            if (CurrentUser.idMemberStyle != 99)
            {
                if (CurrentUser.uId != comp.idUser)
                {
                    AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
                    return;
                }
            }
            ltlbanner.Text = comp.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + comp.cBanner + "\" height=\"256\" width=\"1200\" alt=\"\"/>";
            title = comp.cTitle;
            this.page_Title = title+"赛季列表";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            
            bangding();
        }
    }
    public void bangding()
    {
        DataSet ds = new DB6.tblRace_Competition().GetList(" DATEDIFF([second], getdate() , dJoinEnd)>0 and iStatus =1 and id="+ sid +"");
        if (ds.Tables[0].Rows.Count < 1)
        {
            DDLRace.DataSource = ds;
            DDLRace.DataTextField = "cTitle";
            DDLRace.DataValueField = "id";
            DDLRace.DataBind();
            DDLRace.Items.Insert(0, new ListItem("--暂无赛事--", "0"));
        }
        else
        {
            DDLRace.DataSource = ds;
            DDLRace.DataTextField = "cTitle";
            DDLRace.DataValueField = "id";
            DDLRace.DataBind();
        }
    }
    protected void but_save_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.uId != 100055041 && CurrentUser.uId != 100001183 && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
            return;
        }
        if (DDLRace.SelectedValue == "0")
        {
            AlertHelper.JQAlertGo("暂无赛事", "", false);
            return;
        }
        DBM2.tblBLOG_LINKS mod = new DBM2.tblBLOG_LINKS();
        mod.dCreate = DateTime.Now;

        mod.idBlog = TypeChangeDefault.NullToInt(DDLRace.SelectedValue, 0);
        Regex digitregex = new Regex(@"^[0-9]\d*[.]?\d*$");//初始化正则表达式
        if (txt_book.Value.Length == 0)
        {
            AlertHelper.JQAlertGo("博客id不能为空！", "", false);
            return;
        }
        if (txt_book.Value.Length > 9)
        {
            AlertHelper.JQAlertGo("博客id超出限制！", "", false);
            return;
        }
        if (digitregex.IsMatch(txt_book.Value.ToString()) == true)
        {
            mod.idInfo = TypeChangeDefault.NullToInt(txt_book.Value.Trim().ToString(), 0);
        }
        else
        {
            AlertHelper.JQAlertGo("只能输入0-9数字", "", false);
            return;
        }
        int i = new DB2.tblBLOG_LINKS().Add(mod);
        if (i > 0)
        {
            AlertHelper.JQAlertGo("保存成功", "insertbooklb.aspx?sid=" + sid + "", true);
            return;
        }
        else
        {
            AlertHelper.JQAlertGo("保存失败", "", false);
            return;
        }
    }
}