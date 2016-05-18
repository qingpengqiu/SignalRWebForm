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
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using System.Text;
public partial class Competetion_result : PageBase
{
    public int sid = 0;
    public string title = string.Empty;
    public string cmark = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
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
            this.page_Title = title+"-成绩查询-益跑网赛事报名";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            ltlbanner.Text = model.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + model.cBanner + "\"  alt=\"\"/>";
        }
        DataTable dt = new DB4.tblEvent().GetList("iStatus=1 and idRace=" + sid).Tables[0];
        if (dt.Rows.Count == 0)
        {
            AlertHelper.JQAlert("暂不提供成绩查询！", false);
            return;
        }
        int id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"], 0);
        DBM4.tblEvent modelEvent = new DB4.tblEvent().GetModel(id);
        if (modelEvent != null)
        {
            if (modelEvent.istyle == 1)
            {
                lbNo.InnerText = "请输入证件号码:";
                //idcard.Visible = true;
                //idBib.Visible = false;
            }
            else if (modelEvent.istyle == 2)
            {
                lbNo.InnerText = "请输入参赛号码:";
                //idcard.Visible = false;
                //idBib.Visible = true;
            }
            cmark = modelEvent.cMark;
            if (modelEvent.iDoc == 1)
            {
                lbtOK.Visible = true;
                pclook.Visible = true;
            }
        }
        lbtOK.Visible = false;
    }

    protected void lbtOK_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DataTable dt = new DB4.tblEvent().GetList("idRace=" + sid).Tables[0];
        if (dt.Rows.Count == 0)
        {
            AlertHelper.JQAlertGo("暂不提供成绩查询！", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        int id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"], 0);
        DBM4.tblEvent model = new DB4.tblEvent().GetModel(id);
        if (model == null)
        {
            AlertHelper.JQAlertGo("请选择赛事！", "/Competetion/SearchEvent.aspx", false);
            return;
        }

        string url = "print.aspx?sid=" + sid + "&nav=6&id=" + id + "&n=" + unicode_0(tbname.Text.Trim()) + "&p=" + idNo.Text.Trim() + "&t=" + model.istyle;
        Response.Redirect(url, true);
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
    protected void Imgbtn_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DBM6.tblRace_Competition modelRace = new DB6.tblRace_Competition().GetModel(sid);
        if (modelRace == null)
        {
            AlertHelper.JQAlertGo("请选择赛事！", "/Competetion/SearchEvent.aspx", false);
            return;
        }
        title = modelRace.cTitle;
        if (tbname.Text.Trim().Length == 0)
        {
            AlertHelper.JQAlert("请输入参赛姓名！", false);
            return;
        }
        if (idNo.Text.Trim().Length == 0)
        {
            AlertHelper.JQAlert("请输入号码！", false);
            return;
        }
        DataTable dt = new DB4.tblEvent().GetList("iStatus=1 and idRace=" + sid).Tables[0];
        if (dt.Rows.Count == 0)
        {
            AlertHelper.JQAlert("暂不提供成绩查询！", false);
            return;
        }
        int id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"], 0);
        DBM4.tblEvent model = new DB4.tblEvent().GetModel(id);
        if (model != null)
        {
            if (model.istyle == 1)
            {
                dt = new DB4.tblEventTotal().GetCardResult(id, tbname.Text.Trim(), idNo.Text.Trim()).Tables[0];
            }
            else if (model.istyle == 2)
            {
                dt = new DB4.tblEventTotal().GetBibResult(id, tbname.Text.Trim(), idNo.Text.Trim()).Tables[0];
            }
            ltlResult.Text = string.Empty;
            if (dt.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.AppendLine("<span>参赛号码：<em>" + dt.Rows[0]["cBib"].ToString() + " </em></span><span>姓名：<em>" + dt.Rows[0]["cName"].ToString() + " </em></span><span>组别：<em>" + dt.Rows[0]["cGroupName"].ToString() + " </em></span><span>完赛时间：<em>" + dt.Rows[0]["cResult"].ToString() + "</em></span>");
                sb.AppendLine("<span>净时间：<em>" + dt.Rows[0]["cNetResult"].ToString() + "</em></span>");
                sb.AppendLine("<span>本组名次：<em>" + dt.Rows[0]["iGroupRank"].ToString() + " </em></span><span>总名次：<em>" + dt.Rows[0]["iRank"].ToString() + "  </em></span>");
                //ltlInfo.Text = "<span>参赛号码：<em>" + dt.Rows[0]["cBib"].ToString() + " </em></span><span>姓名：<em>" + dt.Rows[0]["cName"].ToString() + " </em></span><span>组别：<em>" + dt.Rows[0]["cGroupName"].ToString() + " </em></span><span>完赛时间：<em>" + dt.Rows[0]["cResult"].ToString() + "</em></span><span>本组名次：<em>" + dt.Rows[0]["iGroupRank"].ToString() + " </em></span><span>总名次：<em>" + dt.Rows[0]["iRank"].ToString() + "  </em></span>";

                ltlInfo.Text = sb.ToString();
                string result = dt.Rows[0]["cResult"].ToString();
                DataTable dtgroup = new DB4.tblEventPart().GetList(0, "idEvent=" + id + " and cBib='" + dt.Rows[0]["cBib"].ToString() + "' and cName='" + dt.Rows[0]["cName"].ToString().Replace("'", "''") + "'", "iNo").Tables[0];
                int count = dtgroup.Rows.Count;
                if (count > 0)
                {
                    ltlPart.Text = "<div class=\"rtimefd\">分段成绩<i></i></div>";
                    for (int i = 0; i < count; i++)
                    {
                        if (i == 0)
                        {
                            ltlResult.Text += "<li>" + dtgroup.Rows[i]["Km"].ToString() + "</li><li>" + dtgroup.Rows[i]["cResult"].ToString() + "</li><li>" + dtgroup.Rows[i]["cResult"].ToString() + "</li>";
                            continue;
                        }
                        //if (i == count-1)
                        //{
                        //    ltlResult.Text += "<li>" + dtgroup.Rows[i]["Km"].ToString() + "</li><li>" + dtgroup.Rows[i]["cResult"].ToString() + "</li><li></li>";
                        //    continue;
                        //}
                        
                        DateTime dtone = TypeChangeDefault.NullToDateTime("2015-08-08 " + dtgroup.Rows[i - 1]["cResult"], DateTime.Now);// Convert.ToDateTime("2010-11-1 03:00:00");
                        DateTime dttwo = TypeChangeDefault.NullToDateTime("2015-08-08 " + dtgroup.Rows[i]["cResult"], DateTime.Now);//Convert.ToDateTime("2010-12-5 04:04:01");
                        TimeSpan ts = dttwo - dtone;
                        //这样就能得到天数、小时、分差
                        //string str1 = ts.Days + "天" + ts.Hours + "小时" + ts.Minutes + "分" + ts.Seconds + "秒<br>";
                        if ((dtgroup.Rows[i - 1]["cResult"].ToString() == "--") || (dtgroup.Rows[i]["cResult"].ToString() == "--"))
                        {
                            ltlResult.Text += "<li>" + dtgroup.Rows[i]["Km"].ToString() + "</li><li>" + dtgroup.Rows[i]["cResult"].ToString() + "</li><li>--</li>";
                        }
                       else
                            ltlResult.Text += "<li>" + dtgroup.Rows[i]["Km"].ToString() + "</li><li>" + dtgroup.Rows[i]["cResult"].ToString() + "</li><li>" + ts.Hours + ":" + ts.Minutes.ToString().PadLeft(2, '0') + ":" + ts.Seconds.ToString().PadLeft(2, '0') + "</li>";
                    }
                }
                ltlResult.Text += "<li><i>终点Finish</i></li><li>" + dt.Rows[0]["cResult"].ToString() + "</li><li></li>";
                cmarkbz.Visible = false;
                if (model.iDoc == 1)
                {
                    lbtOK.Visible = true;
                }
                else
                {
                    lbtOK.Visible = false;
                    
                }
                //lbtOK.Visible = true;
            }
            else
            {
                AlertHelper.JQAlert("暂无成绩,请重新输入！", false);
                return;
            }
        }
        else
        {
            AlertHelper.JQAlertGo("请选择赛事！", "/Competetion/SearchEvent.aspx", false);
            return;
        }
    }
}