using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
public partial class Raceresult_RaceResult : PageBase
{

    public string name = string.Empty;
    public string RaceName = string.Empty;
    private int id = 0;
    private string vers = string.Empty;
    private int itype = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        //name = TypeChangeDefault.NullToString(unicode_1(Request.QueryString["n"]), "");
        //vers = TypeChangeDefault.NullToString(Request.QueryString["p"], "");
        itype = TypeChangeDefault.NullToInt(Request.QueryString["t"], 0);

        name = TypeChangeDefault.NullToString(unicode_js(Request.QueryString["name"]), "");

        //name = TypeChangeDefault.NullToString(unicode_js(HttpUtility.UrlDecode(Request.QueryString["name"])), "");

        if (TypeChangeDefault.NullToString(Request.QueryString["idcard"], "").Trim().Length != 0)
        {
            vers = TypeChangeDefault.NullToString(Request.QueryString["idcard"], "");
        }
        else if (TypeChangeDefault.NullToString(Request.QueryString["idBib"], "").Trim().Length != 0)
        {
            vers = TypeChangeDefault.NullToString(Request.QueryString["idBib"], "");
        }
        if (id == 0)
        {
            AlertHelper.JQAlertGo("请选择赛事！", "RaceQuery.aspx?id=" + id, false);
            return;
        }
        if (name.Trim().Length == 0)
        {
            AlertHelper.JQAlertGo("请填写名称！", "RaceQuery.aspx?id=" + id, false);
            return;
        }
        if (vers.Trim().Length == 0)
        {
            AlertHelper.JQAlertGo("请填写号码！", "RaceQuery.aspx?id=" + id, false);
            return;
        }
        if (!IsPostBack)
        {
            DBM4.tblEvent model = new DB4.tblEvent().GetModel(id);
            if (model == null)
            {
                AlertHelper.JQAlertGo("请选择赛事！", "RaceQuery.aspx", false);
                return;
            }
            itype = model.istyle ?? 0;
            //if (itype != model.istyle)
            //{
            //    AlertHelper.JQAlertGo("赛事不匹配，请重新选择！", "RaceQuery.aspx", false);
            //    return;
            //}
            if (model.cImage.Trim().Length != 0)
            {
                ltlTitle.Text = "成绩查询结果";
                ltlImg.Text = "<img src=\"" + model.cImage + "\"/>";
            }
            else
            {
                ltlTitle.Text = model.idRaceTitle + "成绩查询结果";
            }
            if (model.iDoc == 1)
            {
                lbtOK.Visible = true;
                pclook.Visible = true;
            }
            else
            {
                lbtOK.Visible = false;
                pclook.Visible = false;
            }
            DataTable dt = new DataTable();
            if (itype == 1)
            {
                dt = new DB4.tblEventTotal().GetCardResult(id, name, vers).Tables[0];
            }
            else if (itype == 2)
            {
                dt = new DB4.tblEventTotal().GetBibResult(id, name, vers).Tables[0];
            }
            if (dt.Rows.Count > 0)
            {
                RaceName = dt.Rows[0]["idRaceTitle"].ToString();
                ltlName.Text = dt.Rows[0]["cName"].ToString();
                ltlTime.Text = dt.Rows[0]["cResult"].ToString();
                ltlItem.Text = dt.Rows[0]["cGroupName"].ToString();
                ltlRank.Text = dt.Rows[0]["iRank"].ToString();
                ltlBib.Text = dt.Rows[0]["cBib"].ToString();
                ltlGroupRank.Text = dt.Rows[0]["iGroupRank"].ToString();
                if (dt.Rows[0]["cNetResult"].ToString().Trim().Length > 0)
                {
                    ltlNetTime.Text = "<span>净时间：<em>" + dt.Rows[0]["cNetResult"].ToString() + "</em></span>";
                }

                string result = dt.Rows[0]["cResult"].ToString();
                DataTable dtgroup = new DB4.tblEventPart().GetList(0, "idEvent=" + id + " and cBib='" + dt.Rows[0]["cBib"].ToString() + "' and cName='" + dt.Rows[0]["cName"].ToString().Replace("'", "''") + "'", "iNo").Tables[0];
                if (dtgroup.Rows.Count > 0)
                {
                    for (int i = 0; i < dtgroup.Rows.Count; i++)
                        ltlResult.Text += "<li>" + dtgroup.Rows[i]["Km"].ToString() + "</li><li>" + dtgroup.Rows[i]["cResult"].ToString() + "</li>";
                }
                ltlResult.Text += "<li>" + dt.Rows[0]["Km"].ToString() + "</li><li>" + dt.Rows[0]["cResult"].ToString() + "</li>";
            }
            else
            {
                AlertHelper.JQAlertGo("您查询的用户不存在！", "RaceQuery.aspx", false);
                return;
            }
        }
        this.page_Title = name+"-"+RaceName+"-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";

    }
    protected void lbtOK_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DBM4.tblEvent model = new DB4.tblEvent().GetModel(id);
        if (model == null)
        {
            AlertHelper.JQAlertGo("请选择赛事！", "RaceQuery.aspx", false);
            return;
        }
        if (model.idRace >= 300002000)
        {
            string url = "/Competetion/print.aspx?sid=" + model.idRace + "&nav=6&id=" + id + "&n=" + unicode_0(name) + "&p=" + vers + "&t=" + model.istyle;
            Response.Redirect(url, true);
        }
        else
        {
            string url = "RacePrint.aspx?id=" + id + "&n=" + unicode_0(name) + "&p=" + vers + "&t=" + model.istyle;
            Response.Redirect(url, true);
        }
    }

    /// <summary>
    /// unicode转中文
    /// </summary>
    /// <returns></returns>
    public static string unicode_js(string str)
    {
        string outStr = "";
        if (!string.IsNullOrEmpty(str))
        {
            string[] strlist = str.Replace(@"\", "").Split('u');
            try
            {
                for (int i = 1; i < strlist.Length; i++)
                {
                    //将unicode字符转为10进制整数，然后转为char中文字符  
                    outStr += (char)int.Parse(strlist[i], System.Globalization.NumberStyles.HexNumber);
                }
            }
            catch (FormatException ex)
            {
                outStr = ex.Message;
            }
        }
        return outStr;

    }
    // <summary>
    /// 中文转unicode
    /// </summary>
    /// <returns></returns>
    public static string unicode_0(string str)
    {
        string outStr = "";
        if (!string.IsNullOrEmpty(str))
        {
            for (int i = 0; i < str.Length; i++)
            {
                outStr += "/u" + ((int)str[i]).ToString("x");
            }
        }
        return outStr;
    }
    /// <summary>
    /// unicode转中文
    /// </summary>
    /// <returns></returns>
    public static string unicode_1(string str)
    {
        string outStr = "";
        if (!string.IsNullOrEmpty(str))
        {
            string[] strlist = str.Replace("/", "").Split('u');
            try
            {
                for (int i = 1; i < strlist.Length; i++)
                {
                    //将unicode字符转为10进制整数，然后转为char中文字符  
                    outStr += (char)int.Parse(strlist[i], System.Globalization.NumberStyles.HexNumber);
                }
            }
            catch (FormatException ex)
            {
                outStr = ex.Message;
            }
        }
        return outStr;

    }
}