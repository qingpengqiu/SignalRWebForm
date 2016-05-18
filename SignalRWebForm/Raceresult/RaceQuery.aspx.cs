using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;

public partial class Raceresult_RaceQuery :PageBase
{
    private int id = 0;
    public string cmark = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.page_Title ="证书打印-益跑网个人中心-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";

        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if (!IsPostBack)
        {
            BindRace();
            if (id != 0)
            {
                DBM4.tblEvent model = new DB4.tblEvent().GetModel(id);
                if (model != null)
                {
                    match.Items.FindByValue(id.ToString()).Selected = true;
                    if (model.istyle == 1)
                    {
                        lbNo.InnerText = "证件号码:";
                        idcard.Visible = true;
                        idBib.Visible = false;
                    }
                    else if (model.istyle == 2)
                    {
                        lbNo.InnerText = "参赛号码:";
                        idcard.Visible = false;
                        idBib.Visible = true;
                    }
                    if(model.cMark.Trim().Length!=0){
                            cmark = "<div class=\"td\"><i>TIPS:</i></div><div class=\"td\">"+model.cMark+"</div>";
                        }else{
                            cmark = "<div class=\"td\"></div><div class=\"td\"></div>";

                        }
                }
            }
            else
            {
                DBM4.tblEvent model = new DB4.tblEvent().GetModel(TypeChangeDefault.NullToInt(match.SelectedValue, 0));
                if (model != null)
                {
                    if (model.istyle == 1)
                    {
                        lbNo.InnerText = "证件号码:";
                        idcard.Visible = true;
                        idBib.Visible = false;
                    }
                    else if (model.istyle == 2)
                    {
                        lbNo.InnerText = "参赛号码:";
                        idcard.Visible = false;
                        idBib.Visible = true;
                    }
                    if(model.cMark.Trim().Length!=0){
                            cmark = "<div class=\"td\"><i>TIPS:</i></div><div class=\"td\">"+model.cMark+"</div>";
                        }else{
                            cmark = "<div class=\"td\"></div><div class=\"td\"></div>";

                        }
                }
            }
        }
    }
    protected void BindRace()
    {
        DataSet ds = new DB4.tblEvent().GetList(0, " iStatus>0 ", "id desc");
        match.DataSource = ds.Tables[0];
        match.DataTextField = "idRaceTitle";
        match.DataValueField = "id";
        match.DataBind();
    }
    protected void match_SelectedIndexChanged(object sender, EventArgs e)
    {
        int idr = TypeChangeDefault.NullToInt(match.SelectedValue, 0);
        DBM4.tblEvent model = new DB4.tblEvent().GetModel(idr);
        if (model != null)
        {
            if (model.istyle == 1)
            {
                lbNo.InnerText = "证件号码:";
                idcard.Visible = true;
                idBib.Visible = false;
            }
            else if (model.istyle == 2)
            {
                lbNo.InnerText = "参赛号码:";
                idcard.Visible = false;
                idBib.Visible = true;
            }
                    if(model.cMark.Trim().Length!=0){
                            cmark = "<div class=\"td\"><i>TIPS:</i></div><div class=\"td\">"+model.cMark+"</div>";
                        }else{
                            cmark = "<div class=\"td\"></div><div class=\"td\"></div>";

                        }
        }
    }
    protected void lbtOK_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        int itype = 0;
        string str=string.Empty;
        if (name.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填姓名！", false);
            return;
        }
        if (idcard.Visible)
        {
            if (idcard.Value.Trim().Length <= 0)
            {
                AlertHelper.JQAlert("请填身份证号码！", false);
                return;
            }
            itype = 1;
            str=idcard.Value.Trim();
        }
        if (idBib.Visible)
        {
            if (idBib.Value.Trim().Length <= 0)
            {
                AlertHelper.JQAlert("请填参赛号码！", false);
                return;
            }
            itype = 2;
            str = idBib.Value.Trim();
        }
        string url = "RaceResult.aspx?id=" + match.SelectedValue + "&n=" + unicode_0(name.Value.Trim()) + "&p=" + str + "&t=" + itype;
        Response.Redirect(url, true);
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "raceQuery", "<script language='javascript'>window.open('RaceResult.aspx?id=" + match.SelectedValue + "&n=" + unicode_0(name.Value.Trim()) + "&p=" + str + "&t=" + itype + "');</script>");
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


    /// <summary>
    /// unicode转中文（符合js规则的）
    /// </summary>
    /// <returns></returns>
    public static string unicode_js_1(string str)
    {
        string outStr = "";
        Regex reg = new Regex(@"(?i)\\u([0-9a-f]{4})");
        outStr = reg.Replace(str, delegate(Match m1)
        {
            return ((char)Convert.ToInt32(m1.Groups[1].Value, 16)).ToString();
        });
        return outStr;
    }
    /// <summary>
    /// 中文转unicode（符合js规则的）
    /// </summary>
    /// <returns></returns>
    public static string unicode_js_0(string str)
    {
        string outStr = "";
        if (!string.IsNullOrEmpty(str))
        {
            for (int i = 0; i < str.Length; i++)
            {
                if (Regex.IsMatch(str[i].ToString(), @"[\u4e00-\u9fa5]")) { outStr += "\\u" + ((int)str[i]).ToString("x"); }
                else { outStr += str[i]; }
            }
        }
        return outStr;
    }

}