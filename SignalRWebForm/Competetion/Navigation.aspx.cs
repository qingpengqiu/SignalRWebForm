using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
public partial class Competetion_Navigation : PageBase
{
    public string xz = string.Empty;
    //public string race = string.Empty;
    public int id = 0;
    string items = string.Empty;
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
            sid = Convert.ToInt32(Request.QueryString["sid"].ToString());
        }
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if (!IsPostBack)
        {
            //if (id != 0)
            //{
                DataSet ds = new DB6.tblRace_Competition().GetList("iStatus =1 and id=" + sid + "");
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
                this.page_Title = title+"导航配置";
                this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
                this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
                DDLRace.DataSource = ds;
                DDLRace.DataTextField = "cTitle";
                DDLRace.DataValueField = "id";
                DDLRace.DataBind();
                BindFscp();
                DDLRace.Enabled = false;
                xgdfs();
            //}
            //else
            //{
            //    bangding();
            //    BindFscp();
            //}

        }
    }
    public void bangding()
    {//绑定赛事下拉框
        DataSet ds = new DB6.tblRace_Competition().GetList(" DATEDIFF([second], getdate() , dJoinEnd)>0 and iStatus =1");
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
    protected void BindFscp()
    {//绑定
        DataSet ds = new DB6.tblRace_Nav_Config().GetAllList();
        if (ds.Tables[0].Rows.Count > 0)
        {
            cbxFscp.DataSource = ds;
            cbxFscp.DataTextField = "cName";
            cbxFscp.DataValueField = "id";
            cbxFscp.DataBind();
        }
        else
        {
            cbxFscp.Visible = false;
        }
    }
    public void xgdfs()
    {//给复选框复制

        DataSet ds = new DB6.tblRace_Nav().GetList(" idCompete=" + sid);
        if (ds.Tables[0].Rows.Count > 0)
        {
            items = ds.Tables[0].Rows[0]["cRight"].ToString();
            string[] ca = items.Split(',');
            DataTable dt = new DB6.tblRace_Nav_Config().GetAllList().Tables[0];
            for (int i = 0; i < dt.Rows.Count; i++)//给CheckBoxList选中的复选框 赋值                  
            {
                for (int j = 0; j < ca.Length; j++)
                {
                    //cbxFscp.Items[i].Selected = false;
                    if (dt.Rows[i]["id"].ToString() == ca[j])
                    {
                        cbxFscp.Items[i].Selected = true;
                    }
                }
            }
        }
    }
    protected void but_save_Click(object sender, EventArgs e)
    {//保存
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (DDLRace.SelectedValue == "0")
        {
            AlertHelper.JQAlertGo("暂无赛事", "", false);
            return;
        }
        //if (cbxFscp.Visible == false)
        //{
        //    AlertHelper.JQAlertGo("无导航选择项", "", false);
        //    return;
        //}
        DBM6.tblRace_Nav nav = new DBM6.tblRace_Nav();

        string fscp = string.Empty;//附属产品
        foreach (ListItem li in cbxFscp.Items)
        {
            if (li.Selected)    //表示某一项被选中了
            {
                fscp += li.Value + ",";
            }
        }
        //string str = string.Empty;
        DataSet dt = new DataSet();
        if (fscp == string.Empty)
        {
            dt = new DB6.tblRace_Nav_Config().GetList("iAuto=1");
        }
        else
        {
            dt = new DB6.tblRace_Nav_Config().GetList("iAuto=1 and id not in (" + fscp.TrimEnd(',') + ")");
        }
        for (int i = 0; i < dt.Tables[0].Rows.Count; i++)
        {
            fscp += dt.Tables[0].Rows[i]["id"] + ",";
        }
        fscp = fscp.TrimEnd(',');
        nav.idCompete = TypeChangeDefault.NullToInt(DDLRace.SelectedValue, 0);
        nav.idUser = CurrentUser.uId;
        //nav.idUser = CurrentUser.uId;
        nav.cRight = fscp;
        DB6.tblRace_Nav navbll = new DB6.tblRace_Nav();
        if (!navbll.Exists(TypeChangeDefault.NullToInt(DDLRace.SelectedValue, 0)))
        {
            
            //if ()
            //{
            //    AlertHelper.JQAlertGo("您选择的赛事导航已存在，请重新选择赛事", "", false);
            //    return;
            //}
            nav.dCreateTime = DateTime.Now;
            nav.dModifyTime = nav.dCreateTime;
            bool i = new DB6.tblRace_Nav().Add(nav);
            if (i)
            {
                AlertHelper.JQAlertGo("添加成功！", "Navigationlb.aspx?sid="+ sid +"", true);
                //System.Web.HttpContext.Current.Response.Write(fscp);
                return;

            }
            else
            {
                AlertHelper.JQAlertGo("添加失败！", "", false);
                return;
            }
        }
        else
        {
            nav.dModifyTime = nav.dCreateTime;
            bool i = new DB6.tblRace_Nav().Update(nav);
            if (i)
            {
                AlertHelper.JQAlertGo("修改成功！", "Navigationlb.aspx?sid=" + sid + "", true);
                return;
            }
            else
            {
                AlertHelper.JQAlertGo("修改失败！", "", false);
                //System.Web.HttpContext.Current.Response.Write(nav.ToString());
                return;
            }
        }


    }
}